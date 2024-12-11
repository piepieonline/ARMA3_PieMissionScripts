Pie_fnc_ZeusTemplate_OpenMissionPlanning_Mission_CSAR = {
	_display = createDialog ['ZeusMissionSetupMissionCSARDialog', true];

	// Objective type (RTB vs destroy in place)
	(_display displayCtrl 10) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;
		_previousObjective = ctrlText (_displayParent displayCtrl 11);
		(_displayParent displayCtrl 11) ctrlSetText (if (_previousObjective == "Yes") then { "No" } else { "Yes" });
	}];
	(_display displayCtrl 11) ctrlSetText (if(missionNamespace getVariable ["Pie_Mis_Zeus_Mission_CSAR_KnownCrashSite", true] == true) then { "Yes" } else { "No" } );

	// Save and close
	(_display displayCtrl 100) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;

		missionNamespace setVariable ["Pie_Mis_Zeus_Mission_CSAR_KnownCrashSite", (if (ctrlText (_displayParent displayCtrl 11) == "Yes") then { true } else { false }), true];

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

