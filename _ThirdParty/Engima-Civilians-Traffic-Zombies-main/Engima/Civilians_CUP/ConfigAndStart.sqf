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
	// CUP
	"CUP_C_C_Pilot_01","CUP_C_C_Citizen_01","CUP_C_C_Citizen_02","CUP_C_C_Citizen_03","CUP_C_C_Citizen_04","CUP_C_C_Worker_01",
	"CUP_C_C_Worker_02","CUP_C_C_Worker_03","CUP_C_C_Worker_04","CUP_C_C_Profiteer_01","CUP_C_C_Profiteer_02","CUP_C_C_Profiteer_03",
	"CUP_C_C_Profiteer_04","CUP_C_C_Woodlander_01","CUP_C_C_Woodlander_02","CUP_C_C_Woodlander_03","CUP_C_C_Woodlander_04",
	"CUP_C_C_Villager_01","CUP_C_C_Villager_02","CUP_C_C_Villager_03","CUP_C_C_Villager_04","CUP_C_C_Priest_01",
	"CUP_C_C_Policeman_01","CUP_C_C_Policeman_02","CUP_C_C_Functionary_01","CUP_C_C_Functionary_02","CUP_C_C_Doctor_01",
	"CUP_C_C_Schoolteacher_01","CUP_C_C_Assistant_01","CUP_C_C_Rocker_01","CUP_C_C_Rocker_02","CUP_C_C_Rocker_03",
	"CUP_C_C_Rocker_04","CUP_C_C_Mechanic_01","CUP_C_C_Mechanic_02","CUP_C_C_Mechanic_03","CUP_C_C_Worker_05","CUP_C_C_Fireman_01",
	"CUP_C_C_Rescuer_01"
	]],
	["UNITS_PER_BUILDING", 0.2],
	["MAX_GROUPS_COUNT", 5],
	["MIN_SPAWN_DISTANCE", 200],
	["MAX_SPAWN_DISTANCE", 800],
	["BLACKLIST_MARKERS", []],
	["HIDE_BLACKLIST_MARKERS", true],
	["ON_UNIT_SPAWNED_CALLBACK", {}],
	["ON_UNIT_REMOVE_CALLBACK", { true }],
	["DEBUG", false]	//false true
];

// Start the script
_parameters spawn ENGIMA_CIVILIANS_StartCivilians;
