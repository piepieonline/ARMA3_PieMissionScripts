Pie_fnc_ZeusTemplate_OpenMissionPlanning_Civi = {
	_display = createDialog ['ZeusMissionSetupCiviDialog', true];

	(_display displayCtrl 10) ctrlSetText format["%1", missionNamespace getVariable ["Pie_Mis_Zeus_Civ_UnitsPerBuilding", 1.1]];
	(_display displayCtrl 20) ctrlSetText format["%1", missionNamespace getVariable ["Pie_Mis_Zeus_Civ_MaxGroups", 10]];
	(_display displayCtrl 30) ctrlSetText "(Not Implemented)";

	// Save and close
	(_display displayCtrl 100) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;

		missionNamespace setVariable ["Pie_Mis_Zeus_Civ_UnitsPerBuilding", parseNumber (ctrlText (_displayParent displayCtrl 10)), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Civ_MaxGroups", parseNumber (ctrlText (_displayParent displayCtrl 20)), true];

		closeDialog 1;
		[] call Pie_fnc_ZeusTemplate_OpenMissionPlanning;
	}];

	// Close without saving
	(_display displayCtrl 101) ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
		[] call Pie_fnc_ZeusTemplate_OpenMissionPlanning;
	}];
};