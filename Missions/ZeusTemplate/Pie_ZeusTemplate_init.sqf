/*
	Mission Ideas:
		- Find arty, call in air strikes to destroy it
		- Find a downed drone by tracking signals

	TODO:
		- If specific equipment is required for the mission, add to the loadoutBox

	How to add a new mission template:
		- Add to 'Preset Missions' below
		- If using a config UI:
			- Export to ./UI/
			- Add to 'Specific mission setup UI screens' below
			- Add dialog hpp file to description.ext
			- Add to 'Open mission specific settings' switch in `.\UI\Pie_ZeusTemplate_ZeusMissionSetupDialog.sqf`
*/

[false] execVM "globalScripts\Pie_RespawnHelper.sqf";
[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";
[setupLaptop] execVM "globalScripts\Pie_Shoothouse_CQC.sqf";

// Functions used by preset missions
[] execVM "globalScripts\Pie_Helper_OccupyTowns.sqf";
[] execVM "globalScripts\Missions\ZeusTemplate\Helpers\Pie_ZeusTemplate_SelectLocationOnMap.sqf";
[] execVM "globalScripts\Missions\ZeusTemplate\Helpers\Pie_ZeusTemplate_AssignEnemyFaction.sqf";

// UI for the preset missions
[] execVM "globalScripts\Missions\ZeusTemplate\UI\Pie_ZeusTemplate_ZeusMissionSetupDialog.sqf";
// Specific mission setup UI screens
[] execVM "globalScripts\Missions\ZeusTemplate\UI\Pie_ZeusTemplate_ZeusMissionSetupMissionCacheHuntDialog.sqf";
[] execVM "globalScripts\Missions\ZeusTemplate\UI\Pie_ZeusTemplate_ZeusMissionSetupMissionCSARDialog.sqf";

// Preset missions
[] execVM "globalScripts\Missions\ZeusTemplate\MissionTypes\Pie_ZeusTemplate_CacheHunt.sqf";
[] execVM "globalScripts\Missions\ZeusTemplate\MissionTypes\Pie_ZeusTemplate_CSAR.sqf";
[] execVM "globalScripts\Missions\ZeusTemplate\MissionTypes\Pie_ZeusTemplate_OccupyTowns.sqf";

// Make vehicles react to downed gunners better
_handle_AIGunnerDownReaction = [] execVM "globalScripts\Pie_Helper_AIGunnerDownReaction.sqf";
waitUntil { scriptDone _handle_AIGunnerDownReaction };
[] call Pie_fnc_WatchAllVehicleGunners;

clearItemCargoGlobal loadoutBox;
clearMagazineCargoGlobal loadoutBox;
clearWeaponCargoGlobal loadoutBox;
clearBackpackCargoGlobal loadoutBox;

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