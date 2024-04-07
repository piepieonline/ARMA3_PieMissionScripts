[false] execVM "globalScripts\Pie_RespawnHelper.sqf";
[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";
[setupLaptop] execVM "globalScripts\Pie_Shoothouse_CQC.sqf";

if(isServer) then
{
	[
		setupLaptop, ["Heal all players", {
			[] call Pie_fnc_ZeusTemplate_HealPlayers;
		},
		nil, 1.5, true, true, "", "true", 5]
	] remoteExec ["addAction", 0, true];

	[
		setupLaptop, ["Start RIS (Random Infantry Skirmish)", {
			[] call Pie_fnc_ZeusTemplate_StartRIS;
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