/*
    TODO:
        - Mines?
        - Ambushes/Spiderholes
        - Cache objectives not counted as dead?
    
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
    _debugMode = false;
    _towns = missionNamespace getVariable ["Pie_NamPatrol_Towns", []];
    _playerCount = count allPlayers;
    _moduleGroup = createGroup sideLogic;
    _minimumPatrolsPerTown = ["minimumPatrolsPerTown", 1] call BIS_fnc_getParamValue;
    _maximumPatrolsPerTown = ["maximumPatrolsPerTown", 2] call BIS_fnc_getParamValue;
    _minimumObjectivesPerTown = ["minimumObjectivesPerTown", 1] call BIS_fnc_getParamValue;
    _maximumObjectivesPerTown = ["maximumObjectivesPerTown", 2] call BIS_fnc_getParamValue;
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

    _cacheObject = "Land_vn_pavn_weapons_stack1";
    _intelObject = "Land_Map_F";

    _possibleObjectiveHouses = [
        "Land_vn_hut_01",
        "Land_vn_hut_02",
        "Land_vn_hut_05",
        "Land_vn_hut_06",
        "Land_vn_hut_07",
        "Land_vn_hut_village_01",
        "Land_vn_hut_village_02"
    ];

    _spawnedUnits = [];

    if(_debugMode) then { 
        [format ["Accounting for %1 players", _playerCount]] remoteExec ["systemChat"];
    };

    {
        _currentTown = _x;
        _currentTownPosition = getPos _currentTown;
        _currentTownPosition = [_currentTownPosition select 0, _currentTownPosition select 1, getTerrainHeight _currentTownPosition];
        _townHasCache = false;

        _housesInTown = nearestTerrainObjects [_currentTownPosition, ["House"], 200, false, true];
        _bikeChancePerHouse = 1;

        if (count _housesInTown > _playerCount) then {
            _bikeChancePerHouse = 0.75;
        };
        if (count _housesInTown > _playerCount * 2) then {
            _bikeChancePerHouse = 0.5;
        };
        if (count _housesInTown > _playerCount * 4) then {
            _bikeChancePerHouse = 0.25;
        };

        _objectivesToSpawn = [_minimumObjectivesPerTown, _maximumObjectivesPerTown] call BIS_fnc_randomInt;
        if(_debugMode) then { 
            [format ["Spawning %1 objectives in %2", _objectivesToSpawn, text _currentTown]] remoteExec ["systemChat"];
        };
        {
            if(_objectivesToSpawn > 0 && _possibleObjectiveHouses find (typeOf _x) != -1) then
            {
                _objectivePos = _x buildingPos 2;

                if(!_townHasCache && random 1 < 0.3) then
                {
                    _objective = createVehicle [_cacheObject, _objectivePos];
                    _townHasCache = true;
                    _spawnedUnits pushBack _objective;
                    [format ["Spawned %1 in %2", _cacheObject, text _currentTown]] remoteExec ["systemChat"];
                }
                else
                {
                    _table = createVehicle ["Land_vn_us_common_table_01", _objectivePos];
                    _objective = createVehicle [_intelObject, [_objectivePos select 0, _objectivePos select 1, ((getPos _table) select 2) + 3]];
                    [
                        _objective,
                        "Aquire Intel",
                        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
                        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
                        "_this distance _target < 6",
                        "_caller distance _target < 6",
                        {},
                        {},
                        { params ["_target"]; deleteVehicle _target; },
                        {},
                        [],
                        8,
                        0,
                        true,
                        false
                    ] remoteExec ["BIS_fnc_holdActionAdd", 0, _objective];
                    _spawnedUnits pushBack _table;
                    _spawnedUnits pushBack _objective;
                    [format ["Spawned %1 in %2", _intelObject, text _currentTown]] remoteExec ["systemChat"];
                };

                _objectivesToSpawn = _objectivesToSpawn - 1;
            };

            // Chance to spawn a bike
            if(random 1 > _bikeChancePerHouse) then
            {
                _foundPos = (getPos _x) findEmptyPosition [0, 20, "vn_c_bicycle_01"];
                if(count _foundPos > 0) then
                {
                    _newBike = createVehicle ["vn_c_bicycle_01", _foundPos];
                    [_newBike, [random 360]] call BIS_fnc_setObjectRotation;
                    _spawnedUnits pushBack _newBike;
                };
            };
        } forEach _housesInTown;

        // Spawn hostiles in town
        _groupsToSpawn = [_minimumPatrolsPerTown, _maximumPatrolsPerTown] call BIS_fnc_randomInt;
        if(_debugMode) then { 
            [format ["Spawning %1 groups in %2", _groupsToSpawn, text _currentTown]] remoteExec ["systemChat"];
        };
        for "_i" from 1 to (_groupsToSpawn) do
        {
            _hostileTownGroup = [_currentTownPosition, east, selectRandom _possibleCampGroups] call BIS_fnc_spawnGroup;
            _hostileTownGroup deleteGroupWhenEmpty true;
            _spawnedUnits append units _hostileTownGroup;
            if(_i == 1) then 
            {
                [_hostileTownGroup, _currentTownPosition, 150, [100, 100, 0, false], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
            }
            else
            {
                [_hostileTownGroup, _currentTownPosition, 200, [], true, true] call lambs_wp_fnc_taskCamp;
            };
        };

        // Spawn patrolling hostiles
        if(_spawnPatrolsBetween && _forEachIndex > 0) then
        {
            if(_debugMode) then { 
                [format ["Spawning a patrol group in %1", text _currentTown]] remoteExec ["systemChat"];
            };

            _hostileTownGroup = [_currentTownPosition, east, selectRandom _possiblePatrolGroups] call BIS_fnc_spawnGroup;
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

    [[west, "Base"], format ["Priority assignment: Patrol through %1 and RTB.", _towns apply { text _x  } joinString ", "]] remoteExec ["commandChat"];
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
    _cacheAliveCount = 0;
    _intelAliveCount = 0;
	{
        if(_x isKindOf "Man" && alive _x) then {
            _aliveCount = _aliveCount + 1;
        };
        if(typeof _x == "Land_vn_pavn_weapons_stack1") then {
            _cacheAliveCount = _cacheAliveCount + 1;
        };
        if(typeof _x == "Land_Map_F") then {
            _intelAliveCount = _intelAliveCount + 1;
        };
		deleteVehicle _x;
	}
	forEach _units;

    [[west, "Base"], format ["Patrol completed. Intel reports that %1 VC, %2 caches and %3 documents were missed.", str _aliveCount, str _cacheAliveCount, str _intelAliveCount]] remoteExec ["commandChat"];

    missionNamespace setVariable ["Pie_NamPatrol_Markers", [], true];
    missionNamespace setVariable ["Pie_NamPatrol_Towns", [], true];
    missionNamespace setVariable ['Pie_NamPatrol_Started', false, true];
    missionNamespace setVariable ['Pie_NamPatrol_SpawnedUnits', [], true];
};