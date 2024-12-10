Pie_fnc_ZeusTemplate_AssignEnemyFaction = {
    _enemyFactionVehicles = [];
    _enemyFactionInf = [];

    // Collect all spawned units by zeus
    _unitsToCollect = groups east;
    if(count _unitsToCollect == 0) then
    {
        _unitsToCollect = groups independent;
    };

    // Group based
    {
        _x deleteGroupWhenEmpty true;
        _unitVehicle = vehicle leader _x;
        if (_unitVehicle != leader _x) then 
        {
            _enemyFactionVehicles pushBack [typeOf _unitVehicle, crew _unitVehicle apply { typeOf _x }];

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

    // Update the label if it's visible
    try
    {
        [(findDisplay 1994) displayCtrl 31] call Pie_fnc_UpdateEnemyLabel;
    }
    catch { };
};