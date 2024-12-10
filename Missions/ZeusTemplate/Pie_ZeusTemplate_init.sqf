[false] execVM "globalScripts\Pie_RespawnHelper.sqf";
[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";
[setupLaptop] execVM "globalScripts\Pie_Shoothouse_CQC.sqf";

// Functions used by preset missions
[] execVM "globalScripts\Pie_Helper_OccupyTown.sqf";
[] execVM "globalScripts\Missions\ZeusTemplate\Helpers\Pie_ZeusTemplate_SelectLocationOnMap.sqf";
[] execVM "globalScripts\Missions\ZeusTemplate\Helpers\Pie_ZeusTemplate_AssignEnemyFaction.sqf";

// Preset missions
[setupLaptop] execVM "globalScripts\Missions\ZeusTemplate\MissionTypes\Pie_ZeusTemplate_CacheHunt.sqf";

if(isServer) then
{
	[
		setupLaptop, ["Heal all players", {
			[] call Pie_fnc_ZeusTemplate_HealPlayers;
		},
		nil, 1.5, true, true, "", "true", 5]
	] remoteExec ["addAction", 0, true];

	[
		setupLaptop, ["Open Mission Planning", {
			[] call Pie_fnc_ZeusTemplate_OpenMissionPlanning;
		},
		nil, 1.5, true, true, "", "call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player) || !isMultiplayer", 5]
	] remoteExec ["addAction", 0, true];

	[
		setupLaptop, ["Start RIS (Random Infantry Skirmish)", {
			[] call Pie_fnc_ZeusTemplate_StartRIS;
		},
		nil, 1.5, true, true, "", "call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player) || !isMultiplayer", 5]
	] remoteExec ["addAction", 0, true];

	[
		setupLaptop, ["Enable Civilian spawns (Don't use if using mission setup!)", {
			[] call Pie_fnc_ZeusTemplate_EnableCivilians;
		},
		nil, 1.5, true, true, "", "call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player) || !isMultiplayer", 5]
	] remoteExec ["addAction", 0, true];
};

Pie_fnc_ZeusTemplate_HealPlayers = {
	{
		_x setDamage 0;
		[_x] remoteExec ["ACE_medical_treatment_fnc_fullHealLocal"];
	} forEach allPlayers;
};


Pie_fnc_ZeusTemplate_OpenMissionPlanning = {
	createDialog 'ZeusMissionSetupDialog';
	_display = findDisplay 1994;

	_missionTypeDropdown = _display displayCtrl 10;
	_missionTypeDropdown lbAdd "Cache Hunt";
	_missionTypeDropdown lbAdd "CSAR";

	_openMapButton = _display displayCtrl 20;
	_openMapButton ctrlAddEventHandler ["ButtonClick",
	{
		[-1, _display displayCtrl 21] remoteExec ["Pie_fnc_ZeusTemplate_SelectLocationOnMap", owner player];
		closeDialog 1;
		[] spawn
		{
			sleep 0.5;
			waitUntil { !visibleMap };
			[] call Pie_fnc_ZeusTemplate_OpenMissionPlanning;
		};
	}];
	_assignedLocationsText = _display displayCtrl 21;
	_assignedLocationsText ctrlSetText format ["Selected Locations: %1", (missionNamespace getVariable "Pie_ZeusTemplate_Towns") apply { text _x } joinString ", "];

	_assignEnemyFactionButton = _display displayCtrl 30;
	_assignEnemyFactionButton ctrlAddEventHandler ["ButtonClick",
	{
		[owner player] remoteExec ["Pie_fnc_ZeusTemplate_AssignEnemyFaction", 2];
	}];
	[] call Pie_fnc_UpdateEnemyLabel;

	_startMissionButton = _display displayCtrl 40;
	_startMissionButton ctrlAddEventHandler ["ButtonClick",
	{
		_dropdownControl = ((findDisplay 1994) displayCtrl 10);
		_missionTypeString = _dropdownControl lbText (lbCurSel _dropdownControl);
		switch (_missionTypeString) do
		{
			case "Cache Hunt": { [owner player] remoteExec ["Pie_fnc_ZeusTemplate_StartCacheHunt", 2] };
			case "CSAR": { systemChat "Starting CSAR"; };
			default { systemChat format ["Unknown mission type: %1", _missionTypeString] };
		};
		
		closeDialog 1;
	}];
};

Pie_fnc_UpdateEnemyLabel = {
	_assignedEnemiesText = (findDisplay 1994) displayCtrl 31;

	_assignedInfCount = count (missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []]);
    _assignedVicCount = count (missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyVic", []]);

	_assignedEnemiesText ctrlSetText format ["Selected Enemies: %1 infantry groups, %2 vehicles", _assignedInfCount, _assignedVicCount];
};

Pie_fnc_ZeusTemplate_StartRIS = {
	_display = createDialog ["RscDisplayEmpty", true];

	_instructionLabel = _display ctrlCreate ["RscText", -1];
	_instructionLabel ctrlSetPosition [0, 0, 1, 0.04];
	_instructionLabel ctrlSetText "Confirm: Starting RIS";
	_instructionLabel ctrlCommit 0;

	_shoothouseStartButton = _display ctrlCreate ["RscButton", 103];
	_shoothouseStartButton ctrlSetPosition [0, 0.5, 0.35, 0.04];
	_shoothouseStartButton ctrlCommit 0;
	_shoothouseStartButton ctrlSetText "Start";
	_shoothouseStartButton ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
		0 spawn RSTFM_fnc_missionInit;
	}];

	_factionCloseButton = _display ctrlCreate ["RscButton", 104];
	_factionCloseButton ctrlSetPosition [0.5, 0.5, 0.35, 0.04];
	_factionCloseButton ctrlCommit 0;
	_factionCloseButton ctrlSetText "Cancel";
	_factionCloseButton ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
	}];
};

Pie_fnc_ZeusTemplate_EnableCivilians = {
	_display = createDialog ["RscDisplayEmpty", true];

	_instructionLabel = _display ctrlCreate ["RscText", -1];
	_instructionLabel ctrlSetPosition [0, 0, 1, 0.04];
	_instructionLabel ctrlSetText "Confirm: Enabling civilians";
	_instructionLabel ctrlCommit 0;

	_shoothouseStartButton = _display ctrlCreate ["RscButton", 103];
	_shoothouseStartButton ctrlSetPosition [0, 0.5, 0.35, 0.04];
	_shoothouseStartButton ctrlCommit 0;
	_shoothouseStartButton ctrlSetText "Start";
	_shoothouseStartButton ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
		call compile preprocessFileLineNumbers "globalScripts\Missions\ZeusTemplate\Helpers\EngimaCiviConfig.sqf";
	}];

	_factionCloseButton = _display ctrlCreate ["RscButton", 104];
	_factionCloseButton ctrlSetPosition [0.5, 0.5, 0.35, 0.04];
	_factionCloseButton ctrlCommit 0;
	_factionCloseButton ctrlSetText "Cancel";
	_factionCloseButton ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
	}];
};