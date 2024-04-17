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
	"CUP_B_MTVR_USA","CUP_B_HMMWV_TOW_USA","CUP_B_HMMWV_SOV_USA","CUP_B_HMMWV_MK19_USA","CUP_B_HMMWV_M2_GPK_USA",
"CUP_B_HMMWV_Crows_M2_USA","CUP_B_M1135_ATGMV_Desert_Slat","CUP_B_M1130_CV_M2_Desert_Slat","CUP_B_M1129_MC_MK19_Desert_Slat",
"CUP_B_M1128_MGS_Desert_Slat","CUP_B_M1126_ICV_MK19_Desert_Slat","CUP_B_M1126_ICV_M2_Desert_Slat",	
	// tracked
"CUP_B_M113_USA","CUP_B_M163_USA","CUP_B_M7Bradley_USA_D","CUP_B_M6LineBacker_USA_D","CUP_B_M2Bradley_USA_D",
"CUP_B_M2A3Bradley_USA_D","CUP_B_M270_HE_USA","CUP_B_M1A2_TUSK_MG_DES_US_Army","CUP_B_M1A1_DES_US_Army"
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
