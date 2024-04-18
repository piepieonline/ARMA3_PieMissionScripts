/*
    TODO:
        - Mines?
        - Intel or cache objectives?
    
    Required objects:
        setupRadio - The radio to attach the planning actions to
        transportHeli - the helicopter the players can fly in on

    Dependencies:
        - lambs AI
*/

call compile preprocessFileLineNumbers "globalScripts\_ThirdParty\Engima-Civilians-Traffic-Zombies-main\Engima\Civilians\Init.sqf";
call compile preprocessFileLineNumbers "globalScripts\Missions\NamVillagePatrol\EngimaCiviConfig.sqf";
Pie_Helper_RemoteControl = compileFinal preprocessFileLineNumbers "globalScripts\Pie_Helper_RemoteControl.sqf";
[false] execVM "globalScripts\Pie_RespawnHelper.sqf";

if(isServer) then
{
    [
        setupRadio, ["Plan Patrol", {
            [] call Pie_fnc_NamPatrol_StartPlanning;
        },
        nil, 1.5, true, true, "", "!(missionNamespace getVariable ['Pie_NamPatrol_Started', false])", 5]
    ] remoteExec ["addAction", 0, true];

    [
        setupRadio, ["Start Patrol", {
            [] call Pie_fnc_NamPatrol_StartPatrol;
        },
        nil, 1.5, true, true, "", "((count (missionNamespace getVariable ['Pie_NamPatrol_Towns', []])) >= 1) && !(missionNamespace getVariable ['Pie_NamPatrol_Started', false])", 5]
    ] remoteExec ["addAction", 0, true];
    
    [
        setupRadio, ["End Patrol", {
            [] call Pie_fnc_NamPatrol_EndPatrol;
        },
        nil, 1.5, true, true, "", "missionNamespace getVariable ['Pie_NamPatrol_Started', false]", 5]
    ] remoteExec ["addAction", 0, true];

};

[transportHeli, driver transportHeli, "true", "Take pilot controls"] call Pie_Helper_RemoteControl;

Pie_fnc_NamPatrol_StartPlanning = {
    openMap [true, false];
    
    onMapSingleClick {
        _towns = missionNamespace getVariable ["Pie_NamPatrol_Towns", []];
        // _pos, _shift, _alt

        _newTown = (nearestLocations [_pos, ["NameCity", "NameCityCapital", "NameLocal", "NameMarine", "NameVillage"], worldSize]) select 0;

        _townCount = count _towns;

        // Shift deletes
        _townIndex = _towns find _newTown;
        if(_shift) then
        {
            if(_townIndex >= 0) then {
                _towns deleteAt _townIndex;
            };
        }
        else
        {
            if(_townIndex == -1) then {
                _towns pushBack _newTown;
            };
        };

        missionNamespace setVariable ["Pie_NamPatrol_Towns", _towns, true];

        [] call Pie_fnc_NamPatrol_RedrawMarkers;

        true;
    };
};

Pie_fnc_NamPatrol_RedrawMarkers = {
    _towns = missionNamespace getVariable ["Pie_NamPatrol_Towns", []];
    _markers = missionNamespace getVariable ["Pie_NamPatrol_Markers", []];

    {
        deleteMarker _x;
    } forEach _markers;

    {
        _markerName = format ["Pie_NamPatrol_%1", _forEachIndex];
        _dotmarkerstr = createMarker [_markerName, [(getPos _x select 0) - 35, (getPos _x select 1)]];

        if(_forEachIndex == 0 || _forEachIndex == (count _towns) - 1) then
        {
            _dotmarkerstr setMarkerType (if(_forEachIndex == 0) then { "hd_start" } else { "hd_end" });
        }
        else
        {
            _dotmarkerstr setMarkerType "hd_objective";
            // _dotmarkerstr setMarkerText str (_forEachIndex);
        };
        
        _markers pushBack _markerName;
    } forEach _towns;

    missionNamespace setVariable ["Pie_NamPatrol_Markers", _markers, true];
};

Pie_fnc_NamPatrol_StartPatrol = {
    _debugMode = (["debugMode", 0] call BIS_fnc_getParamValue) == 1;
    _towns = missionNamespace getVariable ["Pie_NamPatrol_Towns", []];
    _playerCount = count allPlayers;
    _moduleGroup = createGroup sideLogic;
    _minimumPatrolsPerTown = ["minimumPatrolsPerTown", 1] call BIS_fnc_getParamValue;
    _maximumPatrolsPerTown = ["maximumPatrolsPerTown", 1] call BIS_fnc_getParamValue;
    _spawnPatrolsBetween = true;

    _possibleCampGroups = [
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc" >> "vn_o_group_men_vc_01"),
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc" >> "vn_o_group_men_vc_02"),
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_01"),
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_02"),
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_03"),
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_regional" >> "vn_o_group_men_vc_regional_01"),
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_regional" >> "vn_o_group_men_vc_regional_02")
    ];

    _possiblePatrolGroups = [
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_03"),
        (configFile >> "CfgGroups" >> "East" >> "VN_VC" >> "vn_o_group_men_vc_local" >> "vn_o_group_men_vc_local_04")
    ];

    _spawnedUnits = [];

    {
        _currentTown = _x;
        _currentTownPosition = getPos _currentTown;

        // Spawn a bike per person per town
        for "_i" from 0 to _playerCount max 4 do
        {
            _foundPos = _currentTownPosition findEmptyPosition [[0, 10] call BIS_fnc_randomInt, 300, "vn_c_bicycle_01"];
            if(count _foundPos > 0) then
            {
                _newBike = createVehicle ["vn_c_bicycle_01", _foundPos];
                [_newBike, [random 360]] call BIS_fnc_setObjectRotation;
                _spawnedUnits pushBack _newBike;
            };
        };

        // Spawn hostiles in town
        _groupsToSpawn = [_minimumPatrolsPerTown, _maximumPatrolsPerTown] call BIS_fnc_randomInt;
        if(_debugMode) then { 
            [format ["Spawning %1 groups in %2", _groupsToSpawn, text _currentTown]] remoteExec ["systemChat"];
        };
        for "i" from 0 to (_groupsToSpawn) do
        {
            _hostileTownGroup = [_currentTownPosition, east, selectRandom _possibleCampGroups] call BIS_fnc_spawnGroup;
            _hostileTownGroup deleteGroupWhenEmpty true;
            _spawnedUnits append units _hostileTownGroup;
            [_hostileTownGroup, _currentTownPosition, 200, [], true, true] call lambs_wp_fnc_taskCamp;
        };

        // Spawn patrolling hostiles
        if(_spawnPatrolsBetween && _forEachIndex > 0) then
        {
            _hostileTownGroup = [_currentTownPosition, east, selectRandom _possibleCampGroups] call BIS_fnc_spawnGroup;
            _hostileTownGroup deleteGroupWhenEmpty true;
            _spawnedUnits append units _hostileTownGroup;

            _hostileTownGroup setSpeedMode "LIMITED";
            _hostileTownGroup setBehaviour "SAFE";

            _hostileTownGroup addWaypoint [(getPos (_towns select (_forEachIndex - 1))), 0];
            (_hostileTownGroup addWaypoint [_currentTownPosition, 0]) setWaypointType "CYCLE";
        };
    } forEach _towns;

    [transportHeli, true] remoteExec ["engineOn", 0, true];

    missionNamespace setVariable ['Pie_NamPatrol_Started', true, true];
    missionNamespace setVariable ['Pie_NamPatrol_SpawnedUnits', _spawnedUnits, true];
};

Pie_fnc_NamPatrol_EndPatrol = {
    transportHeli setFuel 1;
    transportHeli setDamage 0;

    _markers = missionNamespace getVariable ["Pie_NamPatrol_Markers", []];
    {
        deleteMarker _x;
    } forEach _markers;

    _units = missionNamespace getVariable ['Pie_NamPatrol_SpawnedUnits', []];
    _aliveCount = 0;
	{
        if(vehicle _x == _x && alive _x) then {
            _aliveCount = _aliveCount + 1;
        };
		deleteVehicle _x;
	}
	forEach _units;

    [[west, "Base"], format ["Patrol completed. Intel reports that %1 VC remained.", str _aliveCount]] remoteExec ["commandChat"];

    missionNamespace setVariable ["Pie_NamPatrol_Markers", [], true];
    missionNamespace setVariable ["Pie_NamPatrol_Towns", [], true];
    missionNamespace setVariable ['Pie_NamPatrol_Started', false, true];
    missionNamespace setVariable ['Pie_NamPatrol_SpawnedUnits', [], true];
};