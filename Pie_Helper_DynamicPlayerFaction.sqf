if(isServer) then
{
	_missionSetupInteractionPoint = _this param [0, objNull];
	_supplySetup = _this param [1, objNull];
	_addArsenal = _this param [2, true];

	if(_addArsenal) then
	{
		[_supplySetup, true] remoteExec ["ace_arsenal_fnc_initBox", 0, true];
		["AmmoboxInit", [_supplySetup, true]] remoteExec ["BIS_fnc_arsenal", 0, true];
	};

	missionNamespace setVariable ["Pie_Mis_SelectedFaction", configFile >> "cfgFactionClasses" >> faction player, true];

	[
		_missionSetupInteractionPoint, ["Choose player faction", {
			[] call Pie_fnc_DynPlayerFaction_ChooseFaction;
		},
		nil, 1.5, true, true, "", "true", 5]
	] remoteExec ["addAction", 0, true];

	[
		_supplySetup, ["Choose loadout", {
			[] call Pie_fnc_DynPlayerFaction_ChooseLoadout;
		},
		nil, 1.5, true, true, "", format ["missionNamespace getVariable ['Pie_Mis_SelectedPlayerFaction', ''] != ''"], 5]
	] remoteExec ["addAction", 0, true];
};

Pie_fnc_DynPlayerFaction_ChooseFaction = {
	if (!isMultiplayer || call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player)) then {
		_display = createDialog ["RscDisplayEmpty", true];

		_instructionLabel = _display ctrlCreate ["RscText", -1];
		_instructionLabel ctrlSetPosition [0, 0, 1, 0.04];
		_instructionLabel ctrlSetText "Select a faction";
		_instructionLabel ctrlCommit 0;

		_factionDropdown = _display ctrlCreate ["RscCombo", 100];
		_factionDropdown ctrlSetPosition [0, 0.08, 1, 0.04];
		_factionDropdown ctrlCommit 0;

		_factionColours = [
			[1, 0, 0, 1],
			[0, 0, 1, 1],
			[0, 1, 0, 1]
		];

		_factionList = [];

		{
			_displayName = getText (_x >> 'displayName');
			if(_displayName != "" && _displayName != 'Other') then
			{
				_factionList pushBack [_displayName, _x];
			};
		} forEach (configProperties [configFile >> "cfgFactionClasses", "isClass _x && (getNumber (_x >> 'side')) <= 2", true]);

		_factionList sort true;

		{
			_displayName = _x select 0;
			_configEntry = _x select 1;

			_item = _factionDropdown lbAdd _displayName;
			_factionDropdown lbSetColor [_item, _factionColours select (getNumber (_configEntry >> 'side'))];
			_factionDropdown lbSetData [_item, configName _configEntry];
		} forEach _factionList;

		_factionDropdown ctrlAddEventHandler ["LBSelChanged",
		{
			params ["_control", "_selectedIndex"];
			_selection = _control lbData (lbCurSel _control);

			if(_selection != "") then
			{
				_factionName = getText (configFile >> "cfgFactionClasses" >> _selection >> "displayName");
				[formatText ["Faction selected: %1 %2 %3", _factionName, lineBreak, "Please choose a new loadout to match."]] remoteExec ["hintSilent"];
				missionNamespace setVariable ["Pie_Mis_SelectedPlayerFaction", _selection, true];
			};
		}];

		_factionCloseButton = _display ctrlCreate ["RscButton", -1];
		_factionCloseButton ctrlSetPosition [0.25, 0.5, 0.35, 0.04];
		_factionCloseButton ctrlCommit 0;
		_factionCloseButton ctrlSetText "Close";
		_factionCloseButton ctrlAddEventHandler ["ButtonClick",
		{
			closeDialog 1;
		}];
	}
};

Pie_fnc_DynPlayerFaction_ChooseLoadout = {
	_display = createDialog ["RscDisplayEmpty", true];

	_instructionLabel = _display ctrlCreate ["RscText", 101];
	_instructionLabel ctrlSetPosition [0, 0, 1, 0.04];
	_instructionLabel ctrlSetText "Select a loadout";
	_instructionLabel ctrlCommit 0;

	_factionLabel = _display ctrlCreate ["RscText", 102];
	_factionLabel ctrlSetPosition [0, 0.08, 1, 0.04];
	_factionLabel ctrlSetText getText (configFile >> "cfgFactionClasses" >> (missionNamespace getVariable "Pie_Mis_SelectedPlayerFaction") >> "displayName");
	_factionLabel ctrlCommit 0;

	_loadoutDropdown = _display ctrlCreate ["RscCombo", 100];
	_loadoutDropdown ctrlSetPosition [0, 0.16, 1, 0.04];
	_loadoutDropdown ctrlCommit 0;

	_loadoutList = [];

	{
		_loadoutList pushBack [getText (_x >> 'displayName'), _x];
	} forEach (configProperties [configFile >> "CfgVehicles", format ["isClass _x && (getText (_x >> 'unitinfotype') == 'rscunitinfosoldier') and (getText (_x >> 'faction') == '%1')", missionNamespace getVariable "Pie_Mis_SelectedPlayerFaction"], true]);

	_loadoutList sort true;

	{
		_displayName = _x select 0;
		_configEntry = _x select 1;

		_item = _loadoutDropdown lbAdd format ["%1 - %2", _displayName, configName _configEntry];
		_loadoutDropdown lbSetData [_item, configName _configEntry];
	} forEach _loadoutList;

	_loadoutDropdown ctrlAddEventHandler ["LBSelChanged",
	{
		params ["_control", "_selectedIndex"];
		_selection = _control lbData (lbCurSel _control);

		if(_selection != "") then
		{
			player setUnitLoadout _selection;

			// UK3CB don't actually add items, do that now
			if (missionNamespace getVariable "Pie_Mis_SelectedPlayerFaction" find "UK3CB" == 0) then
			{
				// We can't use the actual function because it uses typeOf -.-
				// [player] call UK3CB_factions_Common_fnc_unit_loadout;
				[player, null, _selection] execVM "globalScripts\_ThirdParty\Pie_UK3CB_LoadoutAssigner.sqf";

			};
			
			player setUnitTrait ["engineer", if (getNumber (configFile >> "cfgVehicles" >> _selection >> "engineer") == 1) then { true } else { false }, true];
			player setUnitTrait ["explosiveSpecialist", if (getNumber (configFile >> "cfgVehicles" >> _selection >> "canDeactivateMines") == 1) then { true } else { false }, true];
			player setUnitTrait ["medic", if (getNumber (configFile >> "cfgVehicles" >> _selection >> "attendant") == 1) then { true } else { false }, true];
			player setUnitTrait ["UAVHacker", if (getNumber (configFile >> "cfgVehicles" >> _selection >> "uavHacker") == 1) then { true } else { false }, true];
		};
	}];

	_factionCloseButton = _display ctrlCreate ["RscButton", 103];
	_factionCloseButton ctrlSetPosition [0.25, 0.5, 0.35, 0.04];
	_factionCloseButton ctrlCommit 0;
	_factionCloseButton ctrlSetText "Close";
	_factionCloseButton ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
	}];
};