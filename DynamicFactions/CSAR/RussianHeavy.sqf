createHashMapFromArray [
	[
		"FactionClass",
		"CUP_O_RU"
	],
	[
		"DMPModules",
		[
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["CUP_O_RU_Soldier_SL_Ratnik_Summer"], "SERGEANT"],
					[["CUP_O_RU_Crew_EMR"], "CAPTAIN"],
					[["CUP_O_RU_Pilot_EMR"], "MAJOR"],
					[["CUP_O_RU_Soldier_AT_Ratnik_Summer","CUP_O_RU_Soldier_Ratnik_Summer","CUP_O_RU_Soldier_AR_Ratnik_Summer","CUP_O_RU_Soldier_Medic_Ratnik_Summer","CUP_O_RU_Soldier_GL_Ratnik_Summer","CUP_O_RU_Soldier_MG_Ratnik_Summer","CUP_O_RU_Soldier_Marksman_Ratnik_Summer","CUP_O_RU_Soldier_AA_Ratnik_Summer"]]
				]],
				["Pie_Vehicles_Def", [
					"rhs_t90_tv",
					"rhs_t80uk",
					"rhs_bmp2k_tv",
					"rhs_bmp2d_tv",
					"rhs_bmp2_tv",
					"rhs_bmp1k_tv",
					"rhs_bmp1p_tv",
					"rhs_btr80_vv"
				]],
				["dmpFactionName", "Resistance"],
				["dmpFactionSide", "EAST"],
				["dmpFactionSquadSize", "6,8"],
				["dmpFactionVehicleSize", "1,1"],
				["dmpFactionPatrolsDeep", "5,5"],
				["dmpFactionVehiclePatrols", "10,20"],
				["dmpFactionOccupiedTownPatrols", "3,6"],
				["dmpFactionOccupiedTownGarrisons", "3,4"],
				["dmpFactionOccupiedTownVehicles", "2,3"]
			],
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["CUP_O_RU_Crew_EMR"], "CAPTAIN"],
					[["CUP_O_RU_Pilot_EMR"], "MAJOR"]
				]],
				["Pie_Vehicles_Def", [
					"rhs_t90_tv",
					"rhs_t80uk",
					"rhs_bmp2k_tv",
					"rhs_bmp2d_tv"
				]],
				["dmpFactionName", "ResistanceArmourGlobal"],
				["dmpFactionSide", "EAST"],
				["dmpFactionVehicleSize", "1,1"],
				["dmpFactionVehiclePatrols", "5,10"]
			]
		]
	],
	[
		"GarrisonSquadComposition",
		["CUP_O_RU_Soldier_SL_Ratnik_Summer","CUP_O_RU_Soldier_Medic_Ratnik_Summer", "CUP_O_RU_Soldier_AR_Ratnik_Summer", "CUP_O_RU_Soldier_Ratnik_Summer", "CUP_O_RU_Soldier_AT_Ratnik_Summer"]
	],
	[
		"WreckGuardSquadComposition",
		["CUP_O_RU_Crew_EMR", "CUP_O_RU_Crew_EMR", "CUP_O_RU_Soldier_SL_Ratnik_Summer","CUP_O_RU_Soldier_Medic_Ratnik_Summer", "CUP_O_RU_Soldier_AR_Ratnik_Summer", "CUP_O_RU_Soldier_Ratnik_Summer"]
	],
	[
		"WreckGuardVehicle",
		"rhs_bmp2_tv"
	]
];