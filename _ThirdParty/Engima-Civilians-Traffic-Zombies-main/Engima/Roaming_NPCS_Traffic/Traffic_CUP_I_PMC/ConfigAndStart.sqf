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
	"CUP_I_SUV_Armored_ION","CUP_I_SUV_Armored_ION","CUP_I_SUV_Armored_ION","CUP_B_LR_MG_GB_W","CUP_B_LR_Ambulance_GB_W",
"CUP_B_LR_Special_M2_GB_W","CUP_B_LR_Special_GMG_GB_W","CUP_B_BAF_Coyote_GMG_W","CUP_B_BAF_Coyote_L2A1_W","CUP_B_Jackal2_GMG_GB_W",
"CUP_B_Jackal2_L2A1_GB_W","CUP_B_Mastiff_HMG_GB_W","CUP_B_Mastiff_GMG_GB_W","CUP_B_Mastiff_LMG_GB_W","CUP_B_Ridgback_HMG_GB_W",
"CUP_B_Ridgback_GMG_GB_W","CUP_B_Ridgback_LMG_GB_W","CUP_B_Wolfhound_HMG_GB_W",
"CUP_B_Wolfhound_GMG_GB_W","CUP_B_Wolfhound_LMG_GB_W",	
	// tracked
	"CUP_B_FV432_Bulldog_GB_W","CUP_B_FV510_GB_W","CUP_B_MCV80_GB_W","CUP_B_Ridgback_GMG_GB_W","CUP_B_Wolfhound_LMG_GB_W"
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
