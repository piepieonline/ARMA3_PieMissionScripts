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
	// dog
	"Fin_sand_F","Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Fin_random_F","Alsatian_Sand_F","Alsatian_Black_F",
	"Alsatian_Sandblack_F","Alsatian_Random_F",
	// other
	"Hen_random_F","Cock_random_F","Cock_white_F",
	"Goat_random_F","Sheep_random_F",
	// other x2
	"Hen_random_F","Cock_random_F","Cock_white_F",
	"Goat_random_F","Sheep_random_F"
	]],
	["UNITS_PER_BUILDING", 0.1],
	["MAX_GROUPS_COUNT", 5],
	["MIN_SPAWN_DISTANCE", 100],
	["MAX_SPAWN_DISTANCE", 800],
	["BLACKLIST_MARKERS", []],
	["HIDE_BLACKLIST_MARKERS", true],
	["ON_UNIT_SPAWNED_CALLBACK", {}],
	["ON_UNIT_REMOVE_CALLBACK", { true }],
	["DEBUG", false]	//false true
];

// Start the script
_parameters spawn ENGIMA_CIVILIANS_StartCivilians;
