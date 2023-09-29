createHashMapFromArray [
	[
		"FactionClass",
		"CUP_I_UN"
	],
	[
		"DMPModules",
		[
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["CUP_I_UN_CDF_Officer_MNT"], "SERGEANT"],
					[["CUP_I_UN_CDF_Crew_MNT"], "CAPTAIN"],
					[["CUP_I_UN_CDF_Soldier_MG_MNT", "CUP_I_UN_CDF_Soldier_GL_MNT", "CUP_I_UN_CDF_Soldier_MNT", "CUP_I_UN_CDF_Soldier_LAT_MNT", "CUP_I_UN_CDF_Soldier_AT_MNT", "CUP_I_UN_CDF_Soldier_MNT", "CUP_I_UN_CDF_Soldier_MNT"]]
				]],
				["Pie_Vehicles_Def", [
					"CUP_I_UAZ_MG_UN"
				]],
				["dmpFactionName", "Resistance"],
				["dmpFactionSquadSize", "4,8"],
				["dmpFactionVehicleSize", "1,1"],
				["dmpFactionPatrols", "0,0"],
				["dmpFactionPatrolsDeep", "0,0"],
				["dmpFactionVehiclePatrols", "0,0"],
				["dmpFactionOccupiedTownPatrols", "3,10"],
				["dmpFactionOccupiedTownGarrisons", "3,4"],
				["dmpFactionOccupiedTownVehicles", "1,3"]
			],
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["CUP_I_UN_CDF_Crew_MNT"], "CAPTAIN"],
					[["CUP_I_UN_CDF_Pilot_MNT"], "MAJOR"]
				]],
				["Pie_Vehicles_Def", [
					"rhs_uh1h_un"
				]],
				["dmpFactionName", "ResistanceArmour"],
				["dmpFactionVehicleSize", "1,1"],
				["dmpFactionHelos", "1,5"]
			]
		]
	],
	[
		"ConvoyUnits",
		[
			["CUP_I_M113A3_UN", "CUP_I_UN_CDF_Crew_MNT", "CUP_I_UN_CDF_Crew_MNT"], 
			["CUP_I_UAZ_Unarmed_UN", "CUP_I_UN_CDF_Soldier_MNT", "CUP_I_UN_CDF_Soldier_MNT", "CUP_I_UN_CDF_Soldier_MNT", "CUP_I_UN_CDF_Officer_DST"], 
			["CUP_I_M113A3_UN", "CUP_I_UN_CDF_Crew_MNT", "CUP_I_UN_CDF_Crew_MNT"]
		]
	],
	[
		"HVTClass",
		"CUP_I_UN_CDF_Officer_DST"
	],
	[
		"QRF",
		[
			createHashMapFromArray [
				["Vehicle", "rhs_uh1h_un"],
				["Crew", ["CUP_I_UN_CDF_Pilot_MNT", "CUP_I_UN_CDF_Pilot_MNT"]],
				["Dismounts", ["CUP_I_UN_CDF_Soldier_MG_MNT", "CUP_I_UN_CDF_Soldier_GL_MNT", "CUP_I_UN_CDF_Soldier_MNT", "CUP_I_UN_CDF_Soldier_LAT_MNT", "CUP_I_UN_CDF_Soldier_AT_MNT", "CUP_I_UN_CDF_Soldier_MNT", "CUP_I_UN_CDF_Soldier_MNT"]],
				["VicShouldAssault", false]
			]
		]
	]
]
