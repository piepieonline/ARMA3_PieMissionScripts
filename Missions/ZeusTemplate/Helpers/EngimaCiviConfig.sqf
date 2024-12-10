private ["_parameters"];

// Set civilian parameters.
_parameters = [
	["UNIT_CLASSES", call compile preprocessFileLineNumbers "globalScripts\Pie_Helper_GetCiviTypePerMap.sqf"],
	["UNITS_PER_BUILDING", 1.1],
	["MAX_GROUPS_COUNT", 10],
	["MIN_SPAWN_DISTANCE", 100],
	["MAX_SPAWN_DISTANCE", 400],
	["BLACKLIST_MARKERS", []],
	["HIDE_BLACKLIST_MARKERS", true],
	["ON_UNIT_SPAWNED_CALLBACK", {
		_civiUnit = _this select 0;
		_civiUnit disableAI "PATH";
		// TODO: Closer, not through walls
		[
			_civiUnit, ["Ask for intel", {
					params ["_target", "_caller", "_actionId", "_arguments"];
					// missionNamespace setVariable ['Pie_Mis_Zeus_CacheIntelFound', true, true];
					[_target] call Pie_fnc_DoNPCTalkIntel;
				},
				nil, 1.5, true, true, "",
				"!(missionNamespace getVariable 'Pie_Mis_Zeus_CacheIntelFound')",
				5
			]
		] remoteExec ["addAction", 0, true];
	}],
	["ON_UNIT_REMOVE_CALLBACK", { true }],
	["DEBUG", false]	//false true
];

// Start the script
_parameters spawn ENGIMA_CIVILIANS_StartCivilians;