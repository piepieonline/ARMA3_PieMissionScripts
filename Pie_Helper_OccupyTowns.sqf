Pie_fnc_OccupyTowns = {
    private ["_towns", "_markOccupiedTownAOs", "_occupationParams"];
    _towns = _this param [0, []];
    _markOccupiedTownAOs = _this param [1, true];

    _occupationParams = _this param [2, [
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Patrols", "[2,3]"],
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Garrisons", "2"],
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Vehicles", "2"],
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_VehiclePatrols", "0"],
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Helicopters", "[0, 1]"],
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Emplacements", "[0, 1]"]
    ]];

    _enemyFactionInf = missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []];
    _enemyFactionVehicles = missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyVic", []];
    _enemyFactionHelicopters = [];
    _enemyFactionEmplacements = [];

    // Split helicopters and emplacements from the list of vehicles
    for [{_i = count _enemyFactionVehicles - 1}, {_i >= 0}, {_i = _i - 1}] do {
        private _veh = (_enemyFactionVehicles select _i) select 0;
        if (_veh isKindOf "Helicopter") then {
            _enemyFactionHelicopters pushBack (_enemyFactionVehicles select _i);
            _enemyFactionVehicles deleteAt _i;
            continue;
        };
        if (_veh isKindOf "StaticWeapon") then {
            _enemyFactionEmplacements pushBack (_enemyFactionVehicles select _i);
            _enemyFactionVehicles deleteAt _i;
            continue;
        };
    };

    // Pause vehicle gunner reactions while the spawning is happening
    missionNamespace setVariable ["Pie_GunnerReplacement_Paused", true, true];

    {
        _town = _x select 0;
        _occupyCenter = _x select 1;

        _patrols = [_occupationParams select 0] call Pie_fnc_GetRandomFromInput;
        _garrisons = [_occupationParams select 1] call Pie_fnc_GetRandomFromInput;
        _vehicleCount = [_occupationParams select 2] call Pie_fnc_GetRandomFromInput;
        _vehiclePatrolCount = [_occupationParams select 3] call Pie_fnc_GetRandomFromInput;
        _helicopterCount = [_occupationParams select 4] call Pie_fnc_GetRandomFromInput;
        _emplacementCount = [_occupationParams select 5] call Pie_fnc_GetRandomFromInput;

        _townPos = getPos _town;

        // Spawn inf
        if(count _enemyFactionInf > 0) then
        {
            // Patrols
            for "_i" from 1 to _patrols do
            {
                _grp = [_townPos, east, selectRandom _enemyFactionInf] call BIS_fnc_spawnGroup;
                [_grp, _townPos, 250, 4, [], true] call lambs_wp_fnc_taskPatrol;
            };

            // Garrisons
            for "_i" from 1 to _garrisons do
            {
                _grp = [_townPos, east, selectRandom _enemyFactionInf] call BIS_fnc_spawnGroup;
                [_townPos, units _grp, 250, true, false, false, false] call Zen_OccupyHouse;
            };
        };

        // Spawn vics
        if(count _enemyFactionVehicles > 0) then
        {
            // Static
            for "_i" from 1 to _vehicleCount do
            {
                _vehicleToSpawn = selectRandom _enemyFactionVehicles;
                _vic = [_vehicleToSpawn, _townPos] call Pie_fnc_SpawnVicWithCrew;
            };

            // Patrolling between selected towns
            for "_i" from 1 to _vehiclePatrolCount do
            {
                _vehicleToSpawn = selectRandom _enemyFactionVehicles;
                _vic = [_vehicleToSpawn, _townPos] call Pie_fnc_SpawnVicWithCrew;

                private _otherTownIndex = floor random (count _towns - 1);
                if (_otherTownIndex == _forEachIndex) then
                {
                    _otherTownIndex = (_otherTownIndex + 1) % count _towns;
                };
                
                // TODO: Sometimes ends up driving to the corner of the map??
                _otherTownRandomRoad = [(getPos ((_towns select _otherTownIndex) select 0)) getPos [random 250, random 360], 250] call BIS_fnc_nearestRoad;

                private _group = group (driver _vic);
                private _wp1 = _group addWaypoint [getPosATL (_otherTownRandomRoad), 0];
                _wp1 setWaypointType "MOVE";
                _wp1 setWaypointSpeed "LIMITED";
                private _wp2 = _group addWaypoint [getPosATL _vic, 0];
                _wp2 setWaypointType "MOVE";
                private _wp3 = _group addWaypoint [getPosATL _vic, 0];
                _wp3 setWaypointType "CYCLE";
            };
        };

        // Helicopters
        if(count _enemyFactionHelicopters > 0 and _helicopterCount > 0) then
        {
            for "_i" from 1 to _helicopterCount do
            {
                _vehicleToSpawn = selectRandom _enemyFactionHelicopters;
                _spawnedVic = [_vehicleToSpawn, _townPos] call Pie_fnc_SpawnVicWithCrew;

                // SAD is enough to keep the helis moving around a lot
                private _group = group (driver _spawnedVic);
                private _wp1 = _group addWaypoint [getPosATL _spawnedVic, 0];
                _wp1 setWaypointType "SAD";  // Search and Destroy
                _wp1 setWaypointBehaviour "COMBAT"; // Aggressive AI
                _wp1 setWaypointCombatMode "RED"; // Engage at will
                _wp1 setWaypointSpeed "FULL"; // Full speed

                // Second Search and Destroy Waypoint
                private _wp2 = _group addWaypoint [getPosATL _spawnedVic, 0];
                _wp2 setWaypointType "SAD"; 

                // Cycle Waypoint (Loops between waypoints)
                private _wp3 = _group addWaypoint [getPosATL _spawnedVic, 0];
                _wp3 setWaypointType "CYCLE"; // Loops back to the first waypoint
            };
        };

        // Emplacements
        // TODO: Don't (only) spawn emplacements on the road
        if(count _enemyFactionEmplacements > 0 and _emplacementCount > 0) then
        {
            for "_i" from 1 to _emplacementCount do
            {
                _vehicleToSpawn = selectRandom _enemyFactionEmplacements;
                _vic = [_vehicleToSpawn, _townPos] call Pie_fnc_SpawnVicWithCrew;
            };
        };

        if(_markOccupiedTownAOs) then
        {
            _markerstr = createMarker [("aoTown_" + text _town), position _town];
            _markerstr setMarkerShape "ELLIPSE";
            _markerstr setMarkerSize [500, 500];
            _markerstr setMarkerColor "ColorRed";
            _markerstr setMarkerAlpha 0.5;
            _markerstr setMarkerBrush "BDiagonal";
        };
    } forEach _towns;

    
    // Resume vehicle gunner reactions now we are ready
    missionNamespace setVariable ["Pie_GunnerReplacement_Paused", false, true];
};

// Takes a stringified number, or a number range - either "1" or "[1,2]" and returns a random number in that range  
Pie_fnc_GetRandomFromInput = {
    _string = _this param [0, ""];

    if !(((_string splitString "") select 0)=="[") then { _string = format["[%1]",_string] };
    _arr = (parseSimpleArray _string);

    if(count _arr == 1) then
    {
        _arr pushBack (_arr select 0);
    };

    [_arr select 0, _arr select 1] call BIS_fnc_randomInt;
};

Pie_fnc_SpawnVicWithCrew = {
    _vehicleToSpawn = _this param [0];
    _townPos = _this param [1];

    _isLandVic = !((_vehicleToSpawn select 0) isKindOf "Helicopter");

    // _vicCrew = [_townPos, east, _vehicleToSpawn select 1] call BIS_fnc_spawnGroup;
    _randomRoad = [_townPos getPos [random 250, random 360], 250] call BIS_fnc_nearestRoad;

    _vehicleSpawnPosition = getPosATL (_randomRoad) vectorAdd [0, 0, 1];
    _vehicleSpawnSpecial = "NONE";
    if !_isLandVic then
    {
        _vehicleSpawnSpecial = "FLY";
    };
    private _spawnedVic = createVehicle [(_vehicleToSpawn select 0), _vehicleSpawnPosition, [], 0, _vehicleSpawnSpecial];
    private _vicCrew = createVehicleCrew _spawnedVic; // AI Crew

    // Face the road direction (random forward or backwards)
    private _roadInfo = getRoadInfo _randomRoad;
    _roadInfo params ["_roadMapType", "_roadWidth", "_roadIsPedestrian", "_roadTexture", "_roadTextureEnd", "_roadMaterial", "_roadBegPos", "_roadEndPos", "_roadIsBridge"];
    private _roadDirection = _roadBegPos getDir _roadEndPos;

    _spawnedVic setDir (if (random 100 > 50) then [{_roadDirection}, {_roadDirection + 180}]);

    // Set position again to force direction to update
    _spawnedVic setPosATL (getPosATL _spawnedVic);
    
    // {
    //    _x moveInAny _spawnedVic;
    // } forEach units _vicCrew;

    _spawnedVic setVehicleLock "LOCKEDPLAYER";

    _spawnedVic
};
