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
	"CUP_I_PMC_Bodyguard_AA12","CUP_I_PMC_Bodyguard_M4","CUP_I_PMC_Contractor1","CUP_I_PMC_Contractor2","CUP_I_PMC_Sniper",
	"CUP_I_PMC_Medic","CUP_I_PMC_Soldier_MG","CUP_I_PMC_Soldier_MG_PKM","CUP_I_PMC_Soldier_AT","CUP_I_PMC_Engineer",
	"CUP_I_PMC_Soldier_M4A3","CUP_I_PMC_Soldier","CUP_I_PMC_Soldier_GL","CUP_I_PMC_Soldier_GL_M16A2","CUP_I_PMC_Crew",
	"CUP_I_PMC_Pilot","CUP_I_PMC_Sniper_KSVK","CUP_I_PMC_Soldier_AA","CUP_I_PMC_Soldier_TL"
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
