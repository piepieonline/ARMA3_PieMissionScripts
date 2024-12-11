Pie_fnc_ZeusTemplate_OpenMissionPlanning_Occupy = {
	_display = createDialog ['ZeusMissionSetupOccupyDialog', true];

	(_display displayCtrl 10) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Patrols", "[2,3]"]);
	(_display displayCtrl 30) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Garrisons", "2"]);
	(_display displayCtrl 40) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Vehicles", "2"]);
	(_display displayCtrl 50) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_VehiclePatrols", "0"]);

	// Save and close
	(_display displayCtrl 100) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;

		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_Patrols", ctrlText (_displayParent displayCtrl 10), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_Garrisons", ctrlText (_displayParent displayCtrl 30), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_Vehicles", ctrlText (_displayParent displayCtrl 40), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_VehiclePatrols", ctrlText (_displayParent displayCtrl 50), true];

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