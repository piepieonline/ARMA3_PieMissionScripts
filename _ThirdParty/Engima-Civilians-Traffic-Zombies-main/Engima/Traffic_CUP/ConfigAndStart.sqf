/* 
 * This file contains parameters to config and function call to start an instance of
 * traffic in the mission. The file is edited by the mission developer.
 *
 * See file Engima\Traffic\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Traffic.
 */
 
 private ["_parameters"];

// Set traffic parameters.
_parameters = [
	["SIDE", civilian],
	["VEHICLES", 
	[
	// CUP
	"CUP_C_Octavia_CIV","CUP_C_Datsun_4seat","CUP_C_Datsun_Plain","CUP_C_Datsun_Covered","CUP_C_Datsun_Tubeframe",
	"CUP_C_Golf4_random_Civ","CUP_C_Golf4_kitty_Civ","CUP_C_SUV_TK","CUP_C_SUV_CIV","CUP_C_LR_Transport_CTK","CUP_C_Skoda_White_CIV",
	"CUP_C_Skoda_Red_CIV","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_UAZ_Unarmed_TK_CIV","CUP_C_UAZ_Open_TK_CIV",
	"CUP_C_Ural_Civ_01","CUP_C_Ural_Civ_02","CUP_C_Ural_Civ_03","CUP_C_Ural_Open_Civ_01","CUP_C_Ural_Open_Civ_02",
	"CUP_C_Ural_Open_Civ_03","CUP_C_V3S_Open_TKC","CUP_C_V3S_Covered_TKC","CUP_O_UAZ_Unarmed_RU","CUP_O_Ural_CHDKZ","CUP_O_Ural_RU",
	"CUP_O_UAZ_Unarmed_CHDKZ", "C_Hatchback_01_sport_F", "C_Offroad_01_F", "C_SUV_01_F", "C_Van_01_transport_F", "C_Van_01_box_F", 
	"C_Van_01_fuel_F", "C_Quadbike_01_F" 
	]],
	["VEHICLES_COUNT", 1],
	["MIN_SPAWN_DISTANCE", 700],
	["MAX_SPAWN_DISTANCE", 1200],
	["MIN_SKILL", 1],
	["MAX_SKILL", 1],
	["DEBUG", false]	//false true
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
