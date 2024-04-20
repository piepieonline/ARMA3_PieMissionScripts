private ["_parameters"];

// Set civilian parameters.
_parameters = [
	["UNIT_CLASSES", 
	[
		"vn_c_men_01",
		"vn_c_men_02",
		"vn_c_men_03",
		"vn_c_men_04",
		"vn_c_men_05",
		"vn_c_men_06",
		"vn_c_men_07",
		"vn_c_men_08",
		"vn_c_men_09",
		"vn_c_men_10",
		"vn_c_men_11",
		"vn_c_men_12",
		"vn_c_men_13",
		"vn_c_men_14",
		"vn_c_men_15",
		"vn_c_men_16",
		"vn_c_men_17",
		"vn_c_men_18",
		"vn_c_men_19",
		"vn_c_men_20",
		"vn_c_men_21",
		"vn_c_men_22",
		"vn_c_men_23",
		"vn_c_men_24",
		"vn_c_men_25",
		"vn_c_men_26",
		"vn_c_men_27",
		"vn_c_men_28",
		"vn_c_men_29",
		"vn_c_men_30",
		"vn_c_men_31",
		"vn_c_men_32"
	]],
	["UNITS_PER_BUILDING", 1.1],
	["MAX_GROUPS_COUNT", 10],
	["MIN_SPAWN_DISTANCE", 100],
	["MAX_SPAWN_DISTANCE", 400],
	["BLACKLIST_MARKERS", [
		"civi_blacklist_1",
		"civi_blacklist_2",
		"civi_blacklist_3",
		"civi_blacklist_4",
		"civi_blacklist_5",
		"civi_blacklist_6"
	]],
	["HIDE_BLACKLIST_MARKERS", true],
	["ON_UNIT_SPAWNED_CALLBACK", {
		_civiUnit = _this select 0;
		_civiUnit addEventHandler ["Killed", {
			missionNamespace setVariable ["Pie_NamPatrol_CiviDeathCount", (missionNamespace getVariable ["Pie_NamPatrol_CiviDeathCount", 0]) + 1, true];
		}];
	}],
	["ON_UNIT_REMOVE_CALLBACK", { true }],
	["DEBUG", false]	//false true
];

// Start the script
_parameters spawn ENGIMA_CIVILIANS_StartCivilians;