Pie_fnc_AmbientCombat = {
    private ["_towns"];
    _towns = _this param [0, []];

    {
        _town = _x select 0;
        _occupyCenter = _x select 1;

        _townPos = getPos _town;

        _enemyFactionInf = missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []];
        _enemyFactionVehicles = missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyVic", []];

        _friendlySpawnedUnits = [];
        _enemySpawnedUnits = [];

        // Spawn inf
        if(count _enemyFactionInf > 0) then
        {
            _enemyGroup = [];
            {
                if(count _x > count _enemyGroup) then
                {
                    _enemyGroup = _x;
                }
            } forEach _enemyFactionInf;

            // Enemy Patrols
            for "_i" from 1 to 1 do
            {
                _enemySpawnedUnits pushBack ([_townPos, east, _enemyGroup] call BIS_fnc_spawnGroup);
            };


            _friendlyGroup = allPlayers apply { typeOf _x };

            while { count _friendlyGroup < count _enemyGroup } do {
                _friendlyGroup pushBack (typeOf (selectRandom allPlayers));
            };

            // Friendly Patrols
            for "_i" from 1 to 1 do
            {
                _friendlySpawnedUnits pushBack ([_townPos, west, _friendlyGroup] call BIS_fnc_spawnGroup);
            };
        };

        {
            {
                _x allowDamage false;
            } forEach units _x;
        } forEach (_friendlySpawnedUnits + _enemySpawnedUnits);

        [_friendlySpawnedUnits, _enemySpawnedUnits, _x] spawn {
            params ["_friendlySpawnedUnits", "_enemySpawnedUnits", "_town"];
            while { true } do
            {
                sleep 30;
                // Move units around every so often, and rearm them
                _friendlyLocation = [getPos _town, 100, 200] call BIS_fnc_findSafePos;
                _enemyLocation = [getPos _town, 100, 200] call BIS_fnc_findSafePos;

                {
                    _x setPos _friendlyLocation;
                } forEach units _friendlySpawnedUnits;

                {
                    _x setPos _enemyLocation;
                } forEach units _enemySpawnedUnits;
            };
        };
    } forEach _towns;
};