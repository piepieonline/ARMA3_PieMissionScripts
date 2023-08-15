/*
Script to create a set of DMP factions based on a configuration hashmap

Usage:
	[arrayOfDMPFactionDefinitionHashMaps] execVM "globalScripts\DynamicFactions\Pie_DynamicDMPFactionSpawner.sqf";

Real example:
	[
		[
			createHashMapFromArray [
				["Pie_Units_Def", [["I_E_Officer_F", "SERGEANT"], ["I_E_Soldier_F"], ["I_G_Offroad_01_armed_F"], ["I_G_Quadbike_01_F"]]],
				["dmpFactionName", "DMPFactionName"],
				["dmpFactionPatrols", "4,4"],
				["dmpFactionVehiclePatrols", "3,3"],
				["dmpFactionDebugFaction", "TRUE"]
			]
		]
	] execVM "globalScripts\DynamicFactions\Pie_DynamicDMPFactionSpawner.sqf";
*/

// Defaults, not DMP defaults, but simple defaults to reduce the amount of changes that are generally needed
DMP_DEFAULTS = createHashMapFromArray [
	["dmpFactionName", "UNAMED FACTION"],
	["dmpFactionSide", "RESISTANCE"],
	["dmpFactionUseAI", "TRUE"],
	["dmpFactionChancePresent", 100],
	["dmpFactionChanceDead", 0],
	["dmpFactionChanceDeadGroup", 0],
	["dmpFactionScriptMen", ""],
	["dmpFactionScriptVehicles", ""],
	["dmpFactionSquadSize", "6,8"],
	["dmpFactionVehicleSize", "1,1"],
	["dmpFactionPatrols", "0,0"],
	["dmpFactionPatrolsDeep", "0,0"],
	["dmpFactionVehiclePatrols", "0,0"],
	["dmpFactionRoadblocks", "0,0"],
	["dmpFactionGarrisons", "0,0"],
	["dmpFactionStatics", "0,0"],
	["dmpFactionCamps", "0,0"],
	["dmpFactionHelos", "0,0"],
	["dmpFactionPlanes", "0,0"],
	["dmpFactionDrones", "0,0"],
	["dmpFactionCompounds", "0,0"],
	["dmpFactionHunters", "0,0"],
	["dmpFactionHuntersVehicle", "0,0"],
	["dmpFactionOccupiedTowns", "0,0"],
	["dmpFactionOccupiedTownPatrols", "0,0"],
	["dmpFactionOccupiedTownGarrisons", "0,0"],
	["dmpFactionOccupiedTownVehicles", "0,0"],
	["dmpFactionOccupiedTownStatics", "0,0"],
	["dmpFactionOccupiedTownHVTchance", 0],
	["dmpFactionPassengerChance", 0],
	["dmpFactionPassengerCount", "0,0"],
	["dmpFactionPassengerJoin", "FALSE"],
	["dmpFactionSpawnDelay", 0],
	["dmpFactionSecondsBetweenSpawns", 0],
	["dmpFactionDebugFaction", "FALSE"],
	["dmpFactionGoCode", ""]
];

// Default, do nothing
private _factionDefinition = _this param [0, [createHashMapFromArray [["DMPModules", []]]]];

if(isServer) then
{
	missionNamespace setVariable ["Pie_DynFac_Ready", false, true];
	missionNamespace setVariable ["Pie_DynFac_SelectedFaction", _factionDefinition, true];
	Pie_DynFac_FactionDef = _factionDefinition get "DMPModules";
	[] spawn {
		_droSideLogicGroup = createGroup sideLogic;

		{
			private _modulePosition = [300 * (_forEachIndex + 1), 0, 0];
			// Need to be added to a global list to be initalised properly
			"DMP_DefineFaction" createUnit [
				_modulePosition,
				_droSideLogicGroup,
				format ["this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; (Pie_DynFac_FactionDef select %1) set ['Pie_Module_DMP_DefineFaction', this];", _forEachIndex]
			];

			private _grp = createGroup resistance;

			{
				// First element is unit class list
				_unitList = _x select 0;
				_unitRank = "PRIVATE";
				// Second is rank, if existing
				if(count _x > 1) then
				{
					_unitRank = _x select 1;
				};

				{
					_unit = _grp createUnit [_x, [_modulePosition select 0, (_modulePosition select 1) + 10, _modulePosition select 2], [], 0, "NONE"];
					_unit setUnitRank _unitRank;
					_unit enableSimulation false;
					_unit allowDamage false;
				} forEach _unitList;
			} forEach (_x get 'Pie_Units_Def');

			{
				_unit = createVehicle [_x, [_modulePosition select 0, (_modulePosition select 1) + 10, _modulePosition select 2], [], 0, "NONE"];
				_unit enableSimulation false;
				_unit allowDamage false;
			} forEach (_x get 'Pie_Vehicles_Def');

			waitUntil { ('Pie_Module_DMP_DefineFaction' in _x) };
		} forEach Pie_DynFac_FactionDef;

		// Setup the faction defs
		[] call Pie_fnc_InitDefineFactions;

		// Force the modules to init
		private _modules = [];
		{
			_modules pushBack (_x get 'Pie_Module_DMP_DefineFaction');
		} forEach Pie_DynFac_FactionDef;
		_modules call BIS_fnc_initModules;

		missionNamespace setVariable ["Pie_DynFac_Ready", true, true];
	};
};

Pie_fnc_InitDefineFactions = {
	{
		_factionDefMap = _x;
		_dmpFactionDef = _x get 'Pie_Module_DMP_DefineFaction';
		{
			// Has issues if the value comes through as not an object, so check for that
			_isNull = false;
			_value = _factionDefMap getOrDefault [_x, objNull];
			if(typename _value == "OBJECT") then
			{
				_isNull = isNull _value;
			};

			// DMP doesn't set defaults in code, so we need to
			if(_isNull) then
			{
				_dmpFactionDef setVariable [_x, DMP_DEFAULTS get _x];
			}
			else
			{
				_dmpFactionDef setVariable [_x, _value];
			};
		} forEach DMP_DEFAULTS;
	} forEach Pie_DynFac_FactionDef;
};