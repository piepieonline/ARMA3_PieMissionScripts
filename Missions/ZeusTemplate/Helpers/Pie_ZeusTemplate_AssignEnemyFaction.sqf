Pie_fnc_ZeusTemplate_AssignEnemyFaction = {
    _enemyFactionVehicles = [];
    _enemyFactionInf = [];

    // Collect all spawned units by zeus
    _unitsToCollect = groups east;
    if(count _unitsToCollect == 0) then
    {
        _unitsToCollect = groups independent;
    };

    /*
    // Unit based
    {
        if(!alive _x) then { continue };

        _unitVehicle = vehicle _x;
        if (_unitVehicle != _x) then 
        {
            _enemyFactionVehicles pushBack [typeOf _unitVehicle, crew _unitVehicle apply { typeOf _x }];

            {
                _x setVariable ["Pie_ZeusMis_Spawning_AlreadyCounted", true];
            } forEach crew _unitVehicle;

            deleteVehicleCrew _unitVehicle;
            deleteVehicle _unitVehicle;
        }
        else 
        {
            if(!(_x getVariable ["Pie_ZeusMis_Spawning_AlreadyCounted", false])) then
            {
                _enemyFactionInf pushBack (typeOf _x);
                deleteVehicle _x;
            };
        };
    } forEach _unitsToCollect;
    */

    // Group based
    {
        _x deleteGroupWhenEmpty true;
        _unitVehicle = vehicle leader _x;
        if (_unitVehicle != leader _x) then 
        {
            _enemyFactionVehicles pushBack [typeOf _unitVehicle, crew _unitVehicle apply { typeOf _x }];

            {
                _x setVariable ["Pie_ZeusMis_Spawning_AlreadyCounted", true];
            } forEach crew _unitVehicle;

            deleteVehicleCrew _unitVehicle;
            deleteVehicle _unitVehicle;
        }
        else 
        {
            _enemyFactionInf pushBack (units _x apply { typeOf _x });
            {
                deleteVehicle _x;
            } forEach units _x;
        };
    } forEach _unitsToCollect;


    missionNamespace setVariable ["Pie_ZeusMis_SelectedEnemyInf", _enemyFactionInf, true];
    missionNamespace setVariable ["Pie_ZeusMis_SelectedEnemyVic", _enemyFactionVehicles, true];

    /*
    {
        _testGroup = [getPos player, west, _x] call BIS_fnc_spawnGroup;
    } forEach _enemyFactionInf;

    {
        _vicCrew = [getPos player, west, _x select 1] call BIS_fnc_spawnGroup;
        _spawnedVic = createVehicle [_x select 0, [getPos player] call BIS_fnc_findSafePos];
        {
            _x moveInAny _spawnedVic;
        } forEach units _vicCrew;
    } forEach _enemyFactionVehicles;
    */
};