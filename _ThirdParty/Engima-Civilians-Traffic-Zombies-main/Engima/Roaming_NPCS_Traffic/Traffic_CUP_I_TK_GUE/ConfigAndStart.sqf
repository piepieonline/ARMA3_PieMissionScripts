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
	"CUP_I_Datsun_PK_TK","CUP_I_Datsun_PK_TK_Random","CUP_I_Ural_ZU23_TK_Gue","CUP_I_V3S_Open_TKG","CUP_I_V3S_Covered_TKG",
"CUP_I_V3S_Refuel_TKG","CUP_I_V3S_Repair_TKG","CUP_C_LR_Transport_CTK","CUP_C_V3S_Covered_TKC","CUP_C_Datsun","CUP_C_Datsun_4seat",
"CUP_C_Datsun_Plain","CUP_C_Datsun_Covered","CUP_C_Datsun_Tubeframe","CUP_C_SUV_TK","CUP_C_SUV_CIV","CUP_I_SUV_Armored_ION",	
	// tracked
	"CUP_I_BTR40_MG_TKG","CUP_I_BTR40_TKG","CUP_I_BMP1_TK_GUE","CUP_I_BRDM2_TK_Gue","CUP_I_BRDM2_ATGM_TK_Gue","CUP_I_BRDM2_HQ_TK_Gue",
"CUP_I_T34_TK_GUE","CUP_I_T55_TK_GUE"
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
