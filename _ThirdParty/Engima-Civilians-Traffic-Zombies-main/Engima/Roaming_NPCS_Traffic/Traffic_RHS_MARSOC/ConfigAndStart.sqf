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
	"rhsusf_mrzr4_d","rhsusf_m998_w_s_4dr_halftop","rhsusf_m998_w_s_2dr_fulltop","rhsusf_m998_w_s_2dr_halftop",
"rhsusf_m1025_w_s_Mk19","rhsusf_m998_w_s_4dr","rhsusf_m1025_w_s_m2","rhsusf_m1025_w_s","rhsusf_m998_w_s_4dr_fulltop",
"rhsusf_rg33_m2_usmc_wd","rhsusf_rg33_usmc_wd",	
	// tracked
	"rhsusf_m113_usarmy_unarmed","rhsusf_m113_usarmy_MK19","rhsusf_m113_usarmy_medical","rhsusf_m113_usarmy_M240","rhsusf_m113_usarmy",
"rhsusf_m113_usarmy_supply","rhsusf_m109_usarmy","rhsusf_M1232_usarmy_wd","rhsusf_M1232_MK19_usarmy_wd","rhsusf_M1232_M2_usarmy_wd",
"rhsusf_M1237_M2_usarmy_wd","rhsusf_M1237_MK19_usarmy_wd","rhsusf_M1117_W","rhsusf_m1a2sep1tuskiiwd_usarmy","rhsusf_m1a1fep_od",
"rhsusf_m1a1fep_wd","rhsusf_m1a1hc_wd"
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
