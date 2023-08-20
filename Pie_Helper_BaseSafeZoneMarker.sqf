[] spawn {
	while { true } do
	{
		_currentSavedUnitList = missionNamespace getVariable ["Pie_SafeSpawn_UnitList", []];

		_currentInAreaUnits = allUnits inAreaArray "safezonemarker";

		{
			[_x, true] remoteExec ["setCaptive", 0, true];
		} forEach (_currentInAreaUnits - _currentSavedUnitList);

		{
			[_x, false] remoteExec ["setCaptive", 0, true];
		} forEach (_currentSavedUnitList - _currentInAreaUnits);

		missionNamespace setVariable ["Pie_SafeSpawn_UnitList", _currentInAreaUnits];

		sleep 1;
	};
};