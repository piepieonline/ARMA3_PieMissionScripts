// Sub-UI screens
[] execVM "globalScripts\Missions\ZeusTemplate\UI\Pie_ZeusTemplate_ZeusMissionSetupCiviDialog.sqf";
[] execVM "globalScripts\Missions\ZeusTemplate\UI\Pie_ZeusTemplate_ZeusMissionSetupOccupyDialog.sqf";

Pie_fnc_ZeusTemplate_OpenMissionPlanning = {
    _display = createDialog ['ZeusMissionSetupDialog', true];

	_missionTypeDropdown = _display displayCtrl 10;
	_missionTypeDropdown lbAdd "Occupy (No objectives)";
	_missionTypeDropdown lbAdd "Cache Hunt";
	_missionTypeDropdown lbAdd "CSAR";

	_missionTypeDropdown ctrlAddEventHandler ["LBSelChanged",
	{
		params ["_control", "_lbCurSel"];
		_displayParent = ctrlParent _control;
		
		missionNamespace setVariable ["Pie_ZeusTemplate_MissionType", _lbCurSel, true];
		(_displayParent displayCtrl 10) lbSetCurSel (missionNamespace getVariable ["Pie_ZeusTemplate_MissionType", -1]);
	}];
	_missionTypeDropdown lbSetCurSel (missionNamespace getVariable ["Pie_ZeusTemplate_MissionType", -1]);

    // Select locations
	_openMapButton = _display displayCtrl 20;
	_openMapButton ctrlAddEventHandler ["ButtonClick",
	{
		[-1, _display displayCtrl 21, false] remoteExec ["Pie_fnc_ZeusTemplate_SelectLocationOnMap", owner player];
		closeDialog 1;
		[] spawn
		{
			sleep 0.5;
			waitUntil { !visibleMap };
			[] call Pie_fnc_ZeusTemplate_OpenMissionPlanning;
			[] call Pie_fnc_ZeusTemplate_ClearTownMarkers;
		};
	}];
	_assignedLocationsText = _display displayCtrl 21;
	_assignedLocationsText ctrlSetText (["Towns"] call Pie_fnc_ZeusTemplate_CreateTownLabel);

    // Assigned spawned enemies
	_assignEnemyFactionButton = _display displayCtrl 30;
	_assignEnemyFactionButton ctrlAddEventHandler ["ButtonClick",
	{
		[owner player] remoteExec ["Pie_fnc_ZeusTemplate_AssignEnemyFaction", 2];
	}];
	[] call Pie_fnc_UpdateEnemyLabel;

    // Open occupation settings
	(_display displayCtrl 70) ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
        [] call Pie_fnc_ZeusTemplate_OpenMissionPlanning_Occupy;
	}];

    // Open civi settings
	(_display displayCtrl 50) ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
        [] call Pie_fnc_ZeusTemplate_OpenMissionPlanning_Civi;
	}];

    // Open mission specific settings
	(_display displayCtrl 60) ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];
		_displayParent = ctrlParent _control;
		_dropdownControl = (_displayParent displayCtrl 10);
		_missionTypeString = _dropdownControl lbText (lbCurSel _dropdownControl);
		switch (_missionTypeString) do
		{
			case "Cache Hunt": { closeDialog 1; [] call Pie_fnc_ZeusTemplate_OpenMissionPlanning_Mission_CacheHunt; };
			case "CSAR": { closeDialog 1; [] call Pie_fnc_ZeusTemplate_OpenMissionPlanning_Mission_CSAR; };
			case "Occupy (No objectives)": { };
			default {  };
		};
	}];

    // Build mission
	_startMissionButton = _display displayCtrl 40;
	_startMissionButton ctrlAddEventHandler ["ButtonClick",
	{
		params ["_control"];

		if (count (missionNamespace getVariable ["Pie_ZeusTemplate_Towns", []]) == 0) exitWith
		{
			systemChat "ERROR: No towns selected, no mission built";
		};
		if (count (missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []]) == 0 && count (missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyVic", []]) == 0) exitWith
		{
			systemChat "ERROR: No units assigned, no mission built";
		};

		_displayParent = ctrlParent _control;
		_dropdownControl = (_displayParent displayCtrl 10);
		_missionTypeString = _dropdownControl lbText (lbCurSel _dropdownControl);
		switch (_missionTypeString) do
		{
			case "Cache Hunt": { [owner player] remoteExec ["Pie_fnc_ZeusTemplate_StartCacheHunt", 2] };
			case "CSAR": { [owner player] remoteExec ["Pie_fnc_ZeusTemplate_StartCSAR", 2] };
			case "Occupy (No objectives)": { [owner player] remoteExec ["Pie_fnc_ZeusTemplate_StartOccupyTowns", 2] };
			default { systemChat format ["Unknown mission type: %1", _missionTypeString] };
		};

		[missionNamespace getVariable ["Pie_ZeusMis_AmbientTowns", []]] call Pie_fnc_AmbientCombat;
		
		closeDialog 1;
	}];
};