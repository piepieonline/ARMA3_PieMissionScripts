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
	"CUP_B_Ridgback_HMG_GB_D","CUP_B_BAF_Coyote_GMG_W","CUP_B_HMMWV_Avenger_USA","CUP_B_Dingo_GER_Wdl","CUP_B_Dingo_GL_GER_Wdl",
"CUP_B_HMMWV_SOV_USA","CUP_B_LR_Special_Des_CZ_D","CUP_B_LR_Special_GMG_GB_D","CUP_C_Datsun_4seat","CUP_C_SUV_TK",
"CUP_I_SUV_Armored_ION","CUP_B_Ridgback_GMG_GB_W","CUP_B_Mastiff_HMG_GB_W",	
	// tracked
	"CUP_B_M1A1_Woodland_US_Army","CUP_B_M1A2_TUSK_MG_US_Army","CUP_B_M113_USA","CUP_B_Ridgback_HMG_GB_D","CUP_B_M6LineBacker_USA_D",
"CUP_B_BAF_Coyote_GMG_D","CUP_B_HMMWV_Avenger_USA","CUP_B_M163_USA","CUP_B_MCV80_GB_W_SLAT"
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
