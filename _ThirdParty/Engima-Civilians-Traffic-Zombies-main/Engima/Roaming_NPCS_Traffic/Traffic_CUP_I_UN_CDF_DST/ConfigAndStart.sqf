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
	["SIDE", INDEPENDENT],
	["VEHICLES", 
	[
	// wheelled
	"CUP_I_UAZ_Unarmed_UN","CUP_I_UAZ_Open_UN","CUP_I_UAZ_MG_UN","CUP_I_UAZ_AGS30_UN","CUP_I_UAZ_SPG9_UN","CUP_I_Ural_UN",
"CUP_I_Ural_Repair_UN","CUP_I_Ural_Reammo_UN","CUP_I_Ural_Empty_UN","CUP_I_SUV_UNO","CUP_I_SUV_UNO",	
	// tracked
"CUP_I_BMP2_UN","CUP_I_BMP_HQ_UN","CUP_I_BMP2_AMB_UN","CUP_I_BRDM2_UN","CUP_I_BRDM2_HQ_UN","CUP_I_BTR60_UN","CUP_I_M113_UN",
"CUP_I_M113_Med_UN","CUP_B_M1A2_TUSK_MG_DES_US_Army","CUP_I_M163_RACS"
	]],
	["VEHICLES_COUNT", 1],
	["MIN_SPAWN_DISTANCE", 1000],
	["MAX_SPAWN_DISTANCE", 1500],
	["MIN_SKILL", 0.5],
	["MAX_SKILL", 1],
	["DEBUG", false]	//false true
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
