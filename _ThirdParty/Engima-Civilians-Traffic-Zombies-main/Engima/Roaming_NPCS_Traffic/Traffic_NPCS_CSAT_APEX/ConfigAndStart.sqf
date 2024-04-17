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
	"O_LSV_02_armed_F","O_LSV_02_unarmed_F","O_T_LSV_02_armed_F","O_T_LSV_02_unarmed_F","O_G_Offroad_01_armed_F",
	"O_G_Van_01_transport_F","I_G_Offroad_01_armed_F","I_G_Van_01_transport_F","I_C_Offroad_02_unarmed_F","O_Quadbike_01_F",
	"O_T_Truck_03_transport_ghex_F","O_Truck_02_transport_F","O_T_MRAP_02_hmg_ghex_F","O_Truck_03_covered_F",
	"O_T_MRAP_02_gmg_ghex_F","O_APC_Wheeled_02_rcws_F",
	// tracked
	"O_T_APC_Tracked_02_AA_ghex_F""O_T_APC_Wheeled_02_rcws_ghex_F","O_T_MBT_02_cannon_ghex_F","O_T_MBT_02_arty_ghex_F",
	"O_T_APC_Tracked_02_cannon_ghex_F"
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
