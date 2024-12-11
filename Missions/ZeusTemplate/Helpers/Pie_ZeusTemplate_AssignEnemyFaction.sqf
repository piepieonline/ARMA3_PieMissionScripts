Pie_fnc_ZeusTemplate_AssignEnemyFaction = {
    _callingPlayerOwner = _this param [0, 0];

    _enemyFactionVehicles = [];
    _enemyFactionInf = [];

    // Collect all spawned units by zeus
    // TODO: Keep them assigned to their factions for future use?
    _unitsToCollect = groups east;
    if(count _unitsToCollect == 0) then
    {
        _unitsToCollect = groups independent;
    };

    if(count _unitsToCollect == 0) then
    {
        ["ERROR: No units found to be assigned"] remoteExec ["systemChat", _callingPlayerOwner];
    }
    else
    {
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
            [] remoteExec ["Pie_fnc_UpdateEnemyLabel", _callingPlayerOwner];
        }
        catch { };
    };
};