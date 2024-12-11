Pie_fnc_OccupyTown = {
    _town = _this param [0, objNull];
    _occupyCenter = _this param [1, objNull];
    
    _occupationParams = _this param [2, [
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Patrols", "[2,3]"],
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Garrisons", "2"],
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Vehicles", "2"],
        missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_VehiclePatrols", "0"]
    ]];
    _patrols = [_occupationParams select 0] call Pie_fnc_GetRandomFromInput;
    _garrisons = [_occupationParams select 1] call Pie_fnc_GetRandomFromInput;
    _vehicleCount = [_occupationParams select 2] call Pie_fnc_GetRandomFromInput;
    _vehiclePatrolCount = [_occupationParams select 3] call Pie_fnc_GetRandomFromInput;

    _townPos = getPos _town;

    _enemyFactionInf = missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []];
    _enemyFactionVehicles = missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyVic", []];

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
       for "_i" from 1 to _vehicleCount do
        {
            _vehicleToSpawn = selectRandom _enemyFactionVehicles;
            _vicCrew = [_townPos, east, _vehicleToSpawn select 1] call BIS_fnc_spawnGroup;
            _randomRoad = [_townPos getPos [random 250, random 360], 250] call BIS_fnc_nearestRoad;
            _spawnedVic = createVehicle [(_vehicleToSpawn select 0), getPosASL (_randomRoad)];

            // Face the road direction (random forward or backwards)
            private _roadInfo = getRoadInfo _randomRoad;
            _roadInfo params ["_roadMapType", "_roadWidth", "_roadIsPedestrian", "_roadTexture", "_roadTextureEnd", "_roadMaterial", "_roadBegPos", "_roadEndPos", "_roadIsBridge"];
            private _roadDirection = _roadBegPos getDir _roadEndPos;

            _spawnedVic setDir (if (random 100 > 50) then [{_roadDirection}, {_roadDirection + 180}]);

            // Set position again to force direction to update
            _spawnedVic setPosASL (getPosASL _spawnedVic);
            {
                _x moveInAny _spawnedVic;
            } forEach units _vicCrew;
        };

        // TODO: Vehicles patrolling between selected towns
    };
    
    // TODO: Emplacements?
    // TODO: Air vehicles?
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
}