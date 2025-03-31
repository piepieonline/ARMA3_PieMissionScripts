// TODO: Option to scale based on town size?

Pie_fnc_ZeusTemplate_OpenMissionPlanning_Occupy = {
	_display = createDialog ['ZeusMissionSetupOccupyDialog', true];

	(_display displayCtrl 10) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Patrols", "[2,3]"]);
	(_display displayCtrl 30) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Garrisons", "[3,4]"]);
	(_display displayCtrl 40) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Vehicles", "[1,2]"]);
	(_display displayCtrl 50) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_VehiclePatrols", "[0,2]"]);
	(_display displayCtrl 60) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Helicopters", "[0,1]"]);
	(_display displayCtrl 70) ctrlSetText (missionNamespace getVariable ["Pie_Mis_Zeus_Occupy_Emplacements", "[0,3]"]);

	_openMapButton = _display displayCtrl 80;
	_openMapButton ctrlAddEventHandler ["ButtonClick",
	{
		[-1, _display displayCtrl 81, true] remoteExec ["Pie_fnc_ZeusTemplate_SelectLocationOnMap", owner player];
		closeDialog 1;
		[] spawn
		{
			sleep 0.5;
			waitUntil { !visibleMap };
			[] call Pie_fnc_ZeusTemplate_OpenMissionPlanning_Occupy;
			[] call Pie_fnc_ZeusTemplate_ClearTownMarkers;
		};
	}];
	_assignedLocationsText = _display displayCtrl 81;
	_assignedLocationsText ctrlSetText (["AmbientTowns"] call Pie_fnc_ZeusTemplate_CreateTownLabel);

	// Save and close
	(_display displayCtrl 100) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;

		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_Patrols", ctrlText (_displayParent displayCtrl 10), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_Garrisons", ctrlText (_displayParent displayCtrl 30), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_Vehicles", ctrlText (_displayParent displayCtrl 40), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_VehiclePatrols", ctrlText (_displayParent displayCtrl 50), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_Helicopters", ctrlText (_displayParent displayCtrl 60), true];
		missionNamespace setVariable ["Pie_Mis_Zeus_Occupy_Emplacements", ctrlText (_displayParent displayCtrl 70), true];

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