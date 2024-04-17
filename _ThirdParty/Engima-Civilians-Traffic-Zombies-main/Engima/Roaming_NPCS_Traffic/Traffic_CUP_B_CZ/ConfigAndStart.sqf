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
	"CUP_B_Dingo_GL_CZ_Wdl","CUP_B_Dingo_CZ_Wdl","CUP_B_LR_Ambulance_CZ_W","CUP_B_LR_MG_CZ_W","CUP_B_LR_Special_Des_CZ_D",
"CUP_B_LR_MG_CZ_W","CUP_B_LR_Special_CZ_W","CUP_B_LR_Transport_CZ_W","CUP_B_T810_Reammo_CZ_WDL","CUP_B_T810_Unarmed_CZ_WDL",
"CUP_B_T810_Refuel_CZ_WDL","CUP_B_T810_Armed_CZ_WDL","CUP_B_T810_Repair_CZ_WDL","CUP_B_UAZ_Unarmed_ACR","CUP_B_UAZ_AGS30_ACR",
"CUP_B_UAZ_MG_ACR","CUP_B_UAZ_METIS_ACR","CUP_B_UAZ_Open_ACR","CUP_B_Dingo_GL_CZ_Des","CUP_B_Dingo_CZ_Des",
"CUP_B_HMMWV_Ambulance_ACR","CUP_B_HMMWV_AGS_GPK_ACR","CUP_B_HMMWV_DSHKM_GPK_ACR","CUP_B_HMMWV_M2_GPK_ACR",
	// tracked
	"CUP_B_T72_CZ","CUP_B_BMP2_CZ","CUP_B_BMP_HQ_CZ","CUP_B_BMP2_AMB_CZ","CUP_B_BRDM2_CZ","CUP_B_BRDM2_HQ_CZ"
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
