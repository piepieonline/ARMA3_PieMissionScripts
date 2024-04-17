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
	"CUP_O_Datsun_PK","CUP_O_Datsun_PK_Random","CUP_O_UAZ_MG_CHDKZ","CUP_O_UAZ_AGS30_CHDKZ","CUP_O_UAZ_SPG9_CHDKZ",
"CUP_O_UAZ_METIS_CHDKZ","CUP_O_Ural_CHDKZ","CUP_O_Ural_ZU23_CHDKZ","CUP_O_BM21_CHDKZ",	
	// tracked
"CUP_O_BMP2_CHDKZ","CUP_O_BMP_HQ_CHDKZ","CUP_O_BMP2_AMB_CHDKZ","CUP_O_BRDM2_CHDKZ","CUP_O_BRDM2_ATGM_CHDKZ","CUP_O_BRDM2_HQ_CHDKZ",
"CUP_O_T72_CHDKZ"
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
