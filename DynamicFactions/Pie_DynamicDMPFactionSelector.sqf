/*
	Script to allow selection of the opfor faction dynamically in mission
*/

if(isServer) then
{
	_interactionPoint = _this param [0, objNull];
	_factionFileList = _this param [1, [["FIA", "CacheHunt\FIA", "IND_G_F"]]];

	missionNamespace setVariable ["Pie_Mis_OPFORFactions", _factionFileList, true];
	missionNamespace setVariable ["Pie_Mis_SelectedOPFORFaction", missionNamespace getVariable "Pie_Mis_OPFORFactions" select 0, true];

	[
		_interactionPoint, ["Choose OPFOR faction", {
			[] call Pie_fnc_DynFaction_ChooseFaction;
		},
		nil, 1.5, true, true, "", "true", 5]
	] remoteExec ["addAction", 0, true];
};

Pie_fnc_DynFaction_ChooseFaction = {
	if (!isMultiplayer || call BIS_fnc_admin != 0 || clientOwner == 2) then {
		_display = createDialog ["RscDisplayEmpty", true];

		_instructionLabel = _display ctrlCreate ["RscText", 101];
		_instructionLabel ctrlSetPosition [0, 0, 1, 0.04];
		_instructionLabel ctrlSetText "Select the OPFOR faction";
		_instructionLabel ctrlCommit 0;

		_factionDropdown = _display ctrlCreate ["RscCombo", 100];
		_factionDropdown ctrlSetPosition [0, 0.08, 1, 0.04];
		_factionDropdown ctrlCommit 0;

		{
			_displayName = _x select 0;
			_fileName = _x select 1;
			_className = _x select 2;
			if(isClass (configFile >> "cfgFactionClasses" >> _className)) then
			{
				_item = _factionDropdown lbAdd _displayName;
				_factionDropdown lbSetData [_item, _fileName];
			};
		} forEach (missionNamespace getVariable "Pie_Mis_OPFORFactions");

		_factionDropdown ctrlAddEventHandler ["LBSelChanged",
		{
			params ["_control", "_selectedIndex"];
			_selection = _control lbData (lbCurSel _control);

			if(_selection != "") then
			{
				missionNamespace setVariable ["Pie_Mis_SelectedOPFORFaction", _selection, true];
			};
		}];

		_factionGoButton = _display ctrlCreate ["RscButton", 102];
		_factionGoButton ctrlSetPosition [0, 0.5, 0.25, 0.04];
		_factionGoButton ctrlCommit 0;
		_factionGoButton ctrlSetText "Go";
		_factionGoButton ctrlAddEventHandler ["ButtonClick",
		{
			[
				[] call compile preprocessFileLineNumbers (format ["globalScripts\DynamicFactions\%1.sqf", missionNamespace getVariable "Pie_Mis_SelectedOPFORFaction"]),
				"globalScripts\DynamicFactions\Pie_DynamicDMPFactionSpawner.sqf"
			] remoteExec ["execVM", 2];
			closeDialog 1;
		}];

		_factionCancelButton = _display ctrlCreate ["RscButton", 103];
		_factionCancelButton ctrlSetPosition [0.75, 0.5, 0.25, 0.04];
		_factionCancelButton ctrlCommit 0;
		_factionCancelButton ctrlSetText "Close";
		_factionCancelButton ctrlAddEventHandler ["ButtonClick",
		{
			closeDialog 2;
		}];
	}
};