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
	"CUP_I_RACS_Crew","CUP_I_RACS_Pilot","CUP_I_RACS_Sniper","CUP_I_RACS_Soldier","CUP_I_RACS_Officer","CUP_I_RACS_Medic",
	"CUP_I_RACS_SL","CUP_I_RACS_GL","CUP_I_RACS_MMG","CUP_I_RACS_Crew","CUP_I_RACS_Soldier_AA","CUP_I_RACS_Soldier_MAT",
	"CUP_I_RACS_Soldier_HAT","CUP_I_RACS_Sniper","CUP_I_RACS_Engineer","CUP_I_RACS_Pilot","CUP_I_RACS_RoyalCommando",
	"CUP_I_RACS_RoyalGuard","CUP_I_RACS_RoyalMarksman","CUP_I_RACS_Urban_Soldier","CUP_I_RACS_wdl_Soldier","CUP_I_RACS_Mech_Soldier"
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
