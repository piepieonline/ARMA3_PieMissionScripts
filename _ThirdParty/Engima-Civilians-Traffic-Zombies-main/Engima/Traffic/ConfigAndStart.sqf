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
	["SIDE", civilian],
	["VEHICLES", ["C_IDAP_Offroad_02_unarmed_F",
"C_IDAP_Offroad_01_F",
"C_IDAP_Van_02_medevac_F",
"C_IDAP_Van_02_vehicle_F",
"C_IDAP_Truck_02_transport_F",
"C_IDAP_Truck_02_F",
"C_IDAP_Truck_02_water_F",
"C_Van_01_fuel_F",
"C_Hatchback_01_F",
"C_Hatchback_01_sport_F",
"C_Offroad_02_unarmed_F",
"C_Offroad_01_F",
"C_Offroad_01_repair_F",
"C_Quadbike_01_F",
"C_SUV_01_F",
"C_Van_01_transport_F",
"C_Van_01_box_F",
"C_Van_02_medevac_F",
"C_Van_02_vehicle_F",
"C_Van_02_service_F",
"C_Van_02_transport_F",
"C_Truck_02_fuel_F",
"C_Truck_02_box_F",
"C_Truck_02_covered_F"]],
	["VEHICLES_COUNT", 10],
	["MIN_SPAWN_DISTANCE", 800],
	["MAX_SPAWN_DISTANCE", 1200],
	["MIN_SKILL", 0.4],
	["MAX_SKILL", 0.6],
	["DEBUG", false]
];

// Start an instance of the traffic
_parameters spawn ENGIMA_TRAFFIC_StartTraffic;
