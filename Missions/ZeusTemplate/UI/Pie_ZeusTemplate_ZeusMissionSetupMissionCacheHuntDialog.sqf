Pie_fnc_ZeusTemplate_OpenMissionPlanning_Mission_CacheHunt = {
	_display = createDialog ['ZeusMissionSetupMissionCacheHuntDialog', true];

	// Objective type (RTB vs destroy in place)
	(_display displayCtrl 10) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;
		_previousObjective = ctrlText (_displayParent displayCtrl 11);
		(_displayParent displayCtrl 11) ctrlSetText (if (_previousObjective == "Destroy in Place") then { "Return to Base" } else { "Destroy in Place" });
	}];
	(_display displayCtrl 11) ctrlSetText (if(missionNamespace getVariable ["Pie_Mis_Zeus_Mission_CacheHunt_Objective", "destroy"] == "destroy") then { "Destroy in Place" } else { "Return to Base" } );

	// Objective model (Conventional vs Insurgent)
	(_display displayCtrl 20) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;
		_previousObjective = ctrlText (_displayParent displayCtrl 21);
		(_displayParent displayCtrl 21) ctrlSetText (if (_previousObjective == "Conventional") then { "Insurgent" } else { "Conventional" });
	}];
	(_display displayCtrl 21) ctrlSetText (if(missionNamespace getVariable ["Pie_Mis_Zeus_Mission_CacheHunt_ObjectiveModel", "IG_supplyCrate_F"] == "IG_supplyCrate_F") then { "Conventional" } else { "Insurgent" } );

	// Save and close
	(_display displayCtrl 100) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;

		missionNamespace setVariable ["Pie_Mis_Zeus_Mission_CacheHunt_Objective", (if (ctrlText (_displayParent displayCtrl 11) == "Destroy in Place") then { "destroy" } else { "rtb" }), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Mission_CacheHunt_ObjectiveModel", (if (ctrlText (_displayParent displayCtrl 21) == "Conventional") then { "IG_supplyCrate_F" } else { "Box_FIA_Support_F" }), true];

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

