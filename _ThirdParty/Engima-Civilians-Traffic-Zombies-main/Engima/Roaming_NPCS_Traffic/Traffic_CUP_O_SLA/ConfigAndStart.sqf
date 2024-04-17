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
	"CUP_O_UAZ_Militia_SLA","CUP_O_UAZ_Open_SLA","CUP_O_UAZ_MG_SLA","CUP_O_UAZ_AGS30_SLA","CUP_O_UAZ_SPG9_SLA","CUP_O_UAZ_METIS_SLA",
"CUP_O_Ural_SLA","CUP_O_Ural_Refuel_SLA","CUP_O_Ural_Repair_SLA","CUP_O_Ural_Reammo_SLA","CUP_O_Ural_Empty_SLA",
"CUP_O_Ural_ZU23_SLA","CUP_O_BM21_SLA",	
	// tracked
"CUP_O_BMP2_SLA","CUP_O_BMP_HQ_sla","CUP_O_BMP2_AMB_sla","CUP_O_BRDM2_SLA","CUP_O_BRDM2_ATGM_SLA","CUP_O_BRDM2_HQ_SLA",
"CUP_O_BTR60_SLA","CUP_O_ZSU23_SLA","CUP_O_T72_SLA","CUP_I_T55_TK_GUE"
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
