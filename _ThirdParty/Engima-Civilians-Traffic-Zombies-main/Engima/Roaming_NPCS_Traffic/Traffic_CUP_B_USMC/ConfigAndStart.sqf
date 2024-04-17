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
	"CUP_B_MTVR_USMC","CUP_B_MTVR_Ammo_USMC","CUP_B_MTVR_Refuel_USMC","CUP_B_MTVR_Repair_USMC","CUP_B_HMMWV_Unarmed_USMC",
"CUP_B_HMMWV_M2_USMC","CUP_B_HMMWV_MK19_USMC","CUP_B_HMMWV_TOW_USMC","CUP_B_HMMWV_M1114_USMC","CUP_B_HMMWV_Avenger_USMC",
"CUP_B_HMMWV_Ambulance_USMC","CUP_B_RG31_M2_USMC","CUP_B_RG31_M2_OD_USMC","CUP_B_RG31_M2_GC_USMC","CUP_B_RG31_Mk19_USMC",
"CUP_B_RG31_Mk19_OD_USMC","CUP_B_RG31E_M2_USMC","CUP_B_LAV25_USMC","CUP_B_LAV25M240_USMC","CUP_B_LAV25_HQ_USMC","CUP_B_M1030",
"CUP_I_SUV_Armored_ION",	
	// tracked
	"CUP_B_AAV_USMC","CUP_B_LAV25_USMC","CUP_B_LAV25M240_USMC","CUP_B_LAV25_HQ_USMC","CUP_B_M270_HE_USMC","CUP_B_M270_DPICM_USMC",
"CUP_B_M1A1_Woodland_USMC","CUP_B_M1A1_DES_USMC","CUP_B_M1A2_TUSK_MG_USMC","CUP_B_M1A2_TUSK_MG_DES_USMC"
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
