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
	"OPTRE_m1015_mule_ins","OPTRE_M12_FAV_APC","OPTRE_M12_FAV_ins","OPTRE_M12_LRV_ins","OPTRE_M12A1_LRV_ins","OPTRE_M12R_AA_ins",	
	// tracked
	"OPTRE_m1015_mule_ins","OPTRE_M12_FAV_APC","OPTRE_M12_FAV_ins","OPTRE_M12_LRV_ins","OPTRE_M12A1_LRV_ins","OPTRE_M12R_AA_ins"
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
