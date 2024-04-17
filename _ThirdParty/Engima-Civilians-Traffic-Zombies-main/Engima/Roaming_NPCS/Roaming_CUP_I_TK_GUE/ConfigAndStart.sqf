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
	"CUP_I_TK_GUE_Soldier_GL","CUP_I_TK_GUE_Commander","CUP_I_TK_GUE_Sniper","CUP_I_TK_GUE_Soldier","CUP_I_TK_GUE_Soldier_AAT",
	"CUP_I_TK_GUE_Soldier_AK_47S","CUP_I_TK_GUE_Soldier_M16A2","CUP_I_TK_GUE_Soldier_GL","CUP_I_TK_GUE_Guerilla_Enfield",
	"CUP_I_TK_GUE_Soldier_AA","CUP_I_TK_GUE_Soldier_AT","CUP_I_TK_GUE_Soldier_HAT","CUP_I_TK_GUE_Soldier_TL","CUP_I_TK_GUE_Sniper",
	"CUP_I_TK_GUE_Soldier_AR","CUP_I_TK_GUE_Soldier_MG","CUP_I_TK_GUE_Guerilla_Medic","CUP_I_TK_GUE_Commander",
	"CUP_I_TK_GUE_Mechanic","CUP_I_TK_GUE_Demo"
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
