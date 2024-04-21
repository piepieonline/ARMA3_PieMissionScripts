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

debugMode = false;

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

    _mineTypes = [
        // Not instant uncon, legs
        "vn_mine_punji_02",
        "vn_mine_punji_05"
        // Instant uncon, legs and chest
        // "vn_mine_punji_01",
        // "vn_mine_punji_03",
    ];

    // Instant uncon, head and chest
    _doorwayMineType = "vn_mine_punji_04";

    _campFireObjects = [
        "Land_vn_c_prop_pot_fire_01",
        "vn_fireplace_burning_f"
    ];

    _spawnedUnits = [];

    missionNamespace setVariable ["Pie_NamPatrol_CiviDeathCount", 0, true];

    if(debugMode) then { 
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
        if(debugMode) then { 
            [format ["Spawning %1 objectives in %2", _objectivesToSpawn, text _currentTown]] remoteExec ["systemChat"];
        };

        {
            if(_objectivesToSpawn > 0 && _possibleObjectiveHouses find (typeOf _x) != -1) then
            {
                _objectivePos = _x buildingPos 2;

                if(!_townHasCache && random 1 < 0.3) then
                {
                    // Create the weapons cache objective
                    _objective = createVehicle [_cacheObject, _objectivePos];
                    _townHasCache = true;
                    _spawnedUnits pushBack _objective;
                    if(debugMode) then { 
                        [format ["Spawned %1 in %2", _cacheObject, text _currentTown]] remoteExec ["systemChat"];
                    };
                }
                else
                {
                    // Create the table and document objective
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
                    if(debugMode) then {
                        [format ["Spawned %1 in %2", _intelObject, text _currentTown]] remoteExec ["systemChat"];
                    };
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
        if(debugMode) then { 
            [format ["Spawning %1 groups in %2", _groupsToSpawn, text _currentTown]] remoteExec ["systemChat"];
        };
        for "_i" from 1 to (_groupsToSpawn) do
        {
            _hostileTownGroup = [_currentTownPosition, east, selectRandom _possibleCampGroups] call BIS_fnc_spawnGroup;
            _hostileTownGroup deleteGroupWhenEmpty true;
            _hostileTownGroup setGroupIdGlobal [format ["%1 - Town: %2", str(count groups east), text _currentTown]];
            _spawnedUnits append units _hostileTownGroup;
            if(_i == 1) then
            {
                [_hostileTownGroup, _currentTownPosition, 150, [100, 100, 0, false], true, false, -2, true] call lambs_wp_fnc_taskGarrison;
            }
            else
            {
                [_hostileTownGroup, _currentTownPosition, 200, [], true, true] call lambs_wp_fnc_taskCamp;
                _spawnedUnits pushBack createVehicle [selectRandom _campFireObjects, [_currentTownPosition select 0, _currentTownPosition select 1, 0]];
            };
        };

        // Spawn patrolling hostiles
        if(_spawnPatrolsBetween && (count _towns) > 1) then
        {
            if(_forEachIndex > 0) then
            {
                _spawnedUnits append (units ([[_towns select (_forEachIndex - 1), _towns select (_forEachIndex)], selectRandom _possiblePatrolGroups] call Pie_fnc_NamPatrol_SpawnWanderingPatrol));
            };

            if(_forEachIndex < (count _towns) - 1) then
            {
                _spawnedUnits append (units ([[_towns select (_forEachIndex + 1), _towns select (_forEachIndex)], selectRandom _possiblePatrolGroups] call Pie_fnc_NamPatrol_SpawnWanderingPatrol));
            };
        };

        // Spawn mines
        _mineSpawnRate = ["punjiTraps", 0.5] call BIS_fnc_getParamValue;
        if(_mineSpawnRate > 0 && (count _towns) > 1 && _forEachIndex > 0) then
        {
            if(random 1 < _mineSpawnRate) then
            {
                [_towns select (_forEachIndex - 1), _x] call Pie_fnc_NamPatrol_Minefield;
            };
        };
    } forEach _towns;

    [transportHeli, true] remoteExec ["engineOn", 0, true];

    missionNamespace setVariable ['Pie_NamPatrol_Started', true, true];
    missionNamespace setVariable ['Pie_NamPatrol_SpawnedUnits', _spawnedUnits, true];

    [[west, "Base"], format ["Priority assignment: Patrol through %1 and RTB.", _towns apply { text _x  } joinString ", "]] remoteExec ["commandChat"];
};

Pie_fnc_NamPatrol_SpawnWanderingPatrol = {
    params ["_wanderingTowns", "_patrolGroupClass"];
    private ["_firstTownPosition", "_hostileTownGroup", "_patrolRouteText"];

    _patrolRouteText = _wanderingTowns apply { text _x } joinString ", ";

     if(debugMode) then { 
        [format ["Spawning a patrol group between %1", _patrolRouteText]] remoteExec ["systemChat"];
    };

    _firstTownPosition = getPos (_wanderingTowns select 0);

    _hostileTownGroup = [_firstTownPosition, east, _patrolGroupClass] call BIS_fnc_spawnGroup;
    _hostileTownGroup deleteGroupWhenEmpty true;
    _hostileTownGroup setGroupIdGlobal [format ["%1 - Patrol: %2", str (count groups east), _patrolRouteText]];

    _hostileTownGroup setSpeedMode "LIMITED";
    _hostileTownGroup setBehaviour "SAFE";

    {
        _hostileTownGroup addWaypoint [(getPos _x), 0];
    } forEach (_wanderingTowns select [1]);

    (_hostileTownGroup addWaypoint [_firstTownPosition, 0]) setWaypointType "CYCLE";

    _hostileTownGroup
};

Pie_fnc_NamPatrol_Minefield = {
    params ["_town1", "_town2"];
    private ["_mineClassNames", "_mines", "_timeout"];

    _mineClassNames = ["vn_mine_punji_05"];
    _minDistance = 4;
    _amount = ["punjiTrapDensity", 100] call BIS_fnc_getParamValue;
    _mines = [];

    // Find minefield position
    _pos1 = getpos _town1;
    _pos2 = getpos _town2;

    _depth = 50;
    _width = 300;

    _angle = ((_pos1 getDir _pos2) + 90);
    _distance =  _pos1 distance2D _pos2;
    _distanceAway = random [_depth, _distance / 2, _distance - _depth];
    _center = _pos1 getPos [_distanceAway, (_pos1 getDir _pos2)];

    _placementRect = [_center, [_depth, _width, _angle, true]];

    if(debugMode) then
    {
        _marker = createMarker [format["minemarker %1 %2", str _pos1, str _pos2], _center];
        _marker setMarkerShape "RECTANGLE";
        _marker setMarkerColor "ColorRed";
        _marker setMarkerSize [_depth, _width];
        _marker setMarkerDir _angle;
    };

    _timeout = 0;
    while {count _mines < _amount} do
    {
        // Get a random position in the area
        private _pos = _placementRect call BIS_fnc_randomPosTrigger;

        // Check the position is not too close to any other mines and not too steep
        scopeName "closeCheck";

        private _validMinePlacement = (count (_pos isFlatEmpty [-1, -1, 0.1]) > 0);
        if(_validMinePlacement) then
        {
            {
                if (_pos distance _x < _minDistance) exitWith
                {
                    _validMinePlacement = true;
                };
            } forEach _mines;
        };

        if (!_validMinePlacement) then
        {
            private _mine = createMine [selectRandom _mineClassNames, _pos, [], 0];
            east revealMine _mine;
            _mines pushBack _mine;
        };

        // Increment the timeout
        _timeout = _timeout + 1;

        // If the timeout is reached, break out of the loop
        if (_timeout > _amount*2) exitWith {false};
    };

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
        if(typeof _x == "Land_vn_pavn_weapons_stack1" && alive _x) then {
            _cacheAliveCount = _cacheAliveCount + 1;
        };
        if(typeof _x == "Land_Map_F") then {
            _intelAliveCount = _intelAliveCount + 1;
        };
		deleteVehicle _x;
	}
	forEach _units;

    [[west, "Base"], format ["Patrol completed. Intel reports that %1 VC, %2 caches and %3 documents were missed. %4 civilians were killed.", str _aliveCount, str _cacheAliveCount, str _intelAliveCount, str (missionNamespace getVariable ["Pie_NamPatrol_CiviDeathCount", 0])]] remoteExec ["commandChat"];

    missionNamespace setVariable ["Pie_NamPatrol_Markers", [], true];
    missionNamespace setVariable ["Pie_NamPatrol_Towns", [], true];
    missionNamespace setVariable ['Pie_NamPatrol_Started', false, true];
    missionNamespace setVariable ['Pie_NamPatrol_SpawnedUnits', [], true];
};