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
	"CUP_O_SUV_TKA","CUP_O_LR_Transport_TKM","CUP_O_LR_MG_TKM","CUP_O_LR_SPG9_TKM","CUP_O_Ural_ZU23_TKM","CUP_O_V3S_Open_TKM",
"CUP_O_V3S_Covered_TKM","CUP_O_V3S_Refuel_TKM","CUP_O_V3S_Repair_TKM","CUP_C_LR_Transport_CTK","CUP_I_Datsun_PK_TK_Random",
"CUP_I_Datsun_PK_TK","CUP_C_V3S_Covered_TKC","CUP_C_Datsun_4seat","CUP_C_Datsun_Covered","CUP_C_Datsun_Tubeframe",
"CUP_C_SUV_TK","B_G_Offroad_01_armed_F","CUP_I_SUV_Armored_ION",	
	// tracked
	"CUP_I_T55_TK_GUE","CUP_I_T34_TK_GUE","CUP_I_BMP1_TK_GUE","CUP_I_BRDM2_HQ_TK_Gue","CUP_O_BMP2_AMB_TKA","CUP_O_BTR40_MG_TKM",
"CUP_O_BTR60_TK","CUP_O_M113_TKA","CUP_O_M113_Med_TKA","CUP_O_T34_TKA","CUP_O_T55_TK","CUP_O_T72_TKA","CUP_O_ZSU23_TK"
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
