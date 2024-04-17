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
	"CUP_O_SUV_TKA","CUP_O_V3S_Open_TKA","CUP_O_BM21_TKA","CUP_O_Ural_ZU23_TKA","CUP_O_Ural_Open_TKA","CUP_O_UAZ_METIS_TKA",
"CUP_O_UAZ_SPG9_TKA","CUP_O_UAZ_AGS30_TKA","CUP_O_UAZ_MG_TKA","CUP_O_LR_SPG9_TKA","CUP_O_LR_Ambulance_TKA","CUP_O_LR_MG_TKA",
"CUP_O_LR_Transport_TKA","CUP_O_V3S_Covered_TKA","CUP_I_SUV_Armored_ION",	
	// tracked
	"CUP_O_BMP1_TKA","CUP_O_BMP1P_TKA","CUP_O_BMP2_TKA","CUP_O_BMP_HQ_TKA","CUP_O_BMP2_AMB_TKA","CUP_O_BMP2_ZU_TKA","CUP_O_BRDM2_TKA",
"CUP_O_BRDM2_ATGM_TKA","CUP_O_BRDM2_HQ_TKA","CUP_O_BTR40_MG_TKA","CUP_O_BTR60_TK","CUP_O_M113_TKA","CUP_O_M113_Med_TKA",
"CUP_O_T34_TKA","CUP_O_T55_TK","CUP_O_T72_TKA"
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
