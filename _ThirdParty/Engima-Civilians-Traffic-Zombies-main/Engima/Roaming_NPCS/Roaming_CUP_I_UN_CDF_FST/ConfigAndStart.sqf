/* 
 * This file contains config parameters and a function call to start the civilian script.
 * The parameters in this file may be edited by the mission developer.
 *
 * See file Engima\Civilians\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Civilians.
 */
 
private ["_parameters"];

// Set civilian parameters.
_parameters = [
	["UNIT_CLASSES", 
	[
	"CUP_I_UN_CDF_Soldier_AAT_FST","CUP_I_UN_CDF_Soldier_AMG_FST","CUP_I_UN_CDF_Crew_FST","CUP_I_UN_CDF_Guard_FST",
	"CUP_I_UN_CDF_Soldier_MG_FST","CUP_I_UN_CDF_Officer_FST","CUP_I_UN_CDF_Pilot_FST","CUP_I_UN_CDF_Soldier_FST",
	"CUP_I_UN_CDF_Soldier_Backpack_FST","CUP_I_UN_CDF_Soldier_AT_FST","CUP_I_UN_CDF_Soldier_Light_FST","CUP_I_UN_CDF_Soldier_SL_FST"
	]],
	["UNITS_PER_BUILDING", 0.2],
	["MAX_GROUPS_COUNT", 10],
	["MIN_SPAWN_DISTANCE", 500],
	["MAX_SPAWN_DISTANCE", 800],
	["BLACKLIST_MARKERS", []],
	["HIDE_BLACKLIST_MARKERS", true],
	["ON_UNIT_SPAWNED_CALLBACK", {}],
	["ON_UNIT_REMOVE_CALLBACK", { true }],
	["DEBUG", false]	//false true
];

// Start the script
_parameters spawn ENGIMA_CIVILIANS_StartCivilians;
