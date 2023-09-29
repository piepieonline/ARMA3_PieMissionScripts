createHashMapFromArray [
	[
		"FactionClass",
		"IND_G_F"
	],
	[
		"DMPModules",
		[
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["I_G_Soldier_SL_F"], "SERGEANT"],
					[["I_G_Soldier_lite_F"], "CAPTAIN"],
					[["I_G_Soldier_AR_F", "I_G_medic_F", "I_G_medic_F", "I_G_Soldier_GL_F", "I_G_Soldier_M_F", "I_G_Soldier_F", "I_G_Soldier_LAT2_F", "I_G_Soldier_F", "I_G_Soldier_F"]]
				]],
				["Pie_Vehicles_Def", [
					"I_G_Offroad_01_armed_F"
				]],
				["dmpFactionName", "Resistance"],
				["dmpFactionSquadSize", "4,8"],
				["dmpFactionVehicleSize", "1,1"],
				["dmpFactionPatrols", "0,0"],
				["dmpFactionPatrolsDeep", "5,5"],
				["dmpFactionVehiclePatrols", "10,15"],
				["dmpFactionOccupiedTownPatrols", "3,6"],
				["dmpFactionOccupiedTownGarrisons", "3,4"],
				["dmpFactionOccupiedTownVehicles", "1,3"]
			],
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["I_G_Soldier_lite_F"], "CAPTAIN"]
				]],
				["Pie_Vehicles_Def", [
					"I_LT_01_cannon_F"
				]],
				["dmpFactionName", "ResistanceArmour"],
				["dmpFactionVehicleSize", "1,1"],
				["dmpFactionVehiclePatrols", "2,5"]
			]
		]
	],
	[
		"GarrisonSquadComposition",
		["I_G_Soldier_SL_F", "I_G_medic_F", "I_G_Soldier_AR_F", "I_G_Soldier_LAT2_F", "I_G_Soldier_F", "I_G_medic_F", "I_G_Soldier_GL_F"]
	],
	[
		"WreckGuardSquadComposition",
		["I_G_Soldier_SL_F", "I_G_medic_F", "I_G_Soldier_AR_F", "I_G_Soldier_F","I_G_Soldier_F"]
	],
	[
		"WreckGuardVehicle",
		"I_G_Offroad_01_armed_F"
	],
	[
		"QRF",
		[
			createHashMapFromArray [
				["Vehicle", "I_G_Offroad_01_F"],
				["Crew", ["I_G_Soldier_F"]],
				["Dismounts", ["I_G_Soldier_lite_F", "I_G_medic_F", "I_G_medic_F", "I_G_Soldier_GL_F", "I_G_Soldier_LAT2_F"]],
				["VicShouldAssault", false]
			]
		]
	]
];