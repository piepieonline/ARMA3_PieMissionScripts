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
	"rhs_gaz66_zu23_msv","RHS_BM21_MSV_01","RHS_Ural_Zu23_MSV_01","rhs_kamaz5350_msv","rhs_tigr_3camo_vv","rhs_tigr_vv",
"rhs_tigr_sts_vv","rhs_tigr_sts_3camo_vv","rhs_tigr_m_vv","rhs_tigr_m_3camo_vv","rhs_uaz_vv","rhs_uaz_open_vv","rhs_btr60_vv",
"rhs_btr70_vv","rhs_btr80_vv","rhs_btr80a_vv",	
	// tracked
	"rhs_2s3_tv","rhs_sprut_vdv","rhs_prp3_tv","rhs_zsu234_aa","rhs_Ob_681_2","rhs_brm1k_msv","rhs_bmp3mera_msv","rhs_bmp3m_msv",
"rhs_bmp3_msv","rhs_bmp2k_msv","rhs_bmp2_msv","rhs_bmp1p_msv","rhs_bmp1d_msv","rhs_bmd4ma_vdv","rhs_bmd4m_vdv","rhs_bmd2m",
"rhs_bmd1pk","rhs_bmd1"
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
