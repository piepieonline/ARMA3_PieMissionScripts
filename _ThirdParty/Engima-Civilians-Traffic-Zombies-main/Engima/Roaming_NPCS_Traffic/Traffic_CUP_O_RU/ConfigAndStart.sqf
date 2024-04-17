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
	"CUP_O_GAZ_Vodnik_PK_RU","CUP_O_GAZ_Vodnik_BPPU_RU","CUP_O_GAZ_Vodnik_MedEvac_RU","CUP_O_GAZ_Vodnik_AGS_RU","CUP_O_BTR90_HQ_RU",
"CUP_O_UAZ_MG_RU","CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_SPG9_RU","CUP_O_UAZ_METIS_RU","CUP_O_UAZ_AMB_RU","CUP_O_Ural_Empty_RU",
"CUP_O_Ural_ZU23_RU","CUP_O_BM21_RU","CUP_O_BTR90_RU","CUP_O_BTR90_HQ_RU",	
	// tracked
"CUP_O_2S6M_RU","CUP_O_BTR90_RU","CUP_O_BMP3_RU","CUP_O_BMP2_RU","CUP_O_BMP2_AMB_RU","CUP_O_BRDM2_RUS","CUP_O_BRDM2_ATGM_RUS",
"CUP_O_BRDM2_HQ_RUS","CUP_O_T72_RU","CUP_O_GAZ_Vodnik_PK_RU","CUP_O_GAZ_Vodnik_BPPU_RU","CUP_O_GAZ_Vodnik_MedEvac_RU",
"CUP_O_GAZ_Vodnik_AGS_RU","CUP_O_BTR90_HQ_RU"
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
