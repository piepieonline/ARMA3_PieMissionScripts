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
	"B_CTRG_LSV_01_light_F","B_T_MRAP_01_hmg_F","B_T_Quadbike_01_F","B_T_MRAP_01_gmg_F","B_T_MRAP_01_F",
"B_T_LSV_01_unarmed_F","B_T_LSV_01_armed_F","B_T_APC_Wheeled_01_cannon_F","B_T_APC_Tracked_01_rcws_F","B_T_APC_Tracked_01_CRV_F",
"B_T_APC_Tracked_01_AA_F",	
	// tracked
	"B_MBT_01_cannon_F","B_MBT_01_TUSK_F","B_T_MBT_01_cannon_F","B_T_MBT_01_TUSK_F","B_T_MBT_01_mlrs_F","B_T_MBT_01_arty_F",
"B_MBT_01_mlrs_F","B_MBT_01_arty_F"
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
