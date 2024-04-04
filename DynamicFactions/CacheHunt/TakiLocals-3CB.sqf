createHashMapFromArray [
	[
		"FactionClass",
		"UK3CB_TKM_I"
	],
	[
		"DMPModules",
		[
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["UK3CB_TKM_I_SL"], "SERGEANT"],
					[["UK3CB_TKA_I_CREW"], "CAPTAIN"],
					[["UK3CB_TKA_I_HELI_PILOT"], "MAJOR"],
					[["UK3CB_TKM_I_ENG", "UK3CB_TKM_I_MK", "UK3CB_TKM_I_MD", "UK3CB_TKM_I_LAT", "UK3CB_TKM_I_RIF_1", "UK3CB_TKM_I_RIF_2", "UK3CB_TKM_I_DEM", "UK3CB_TKM_I_AR"]]
				]],
				["Pie_Vehicles_Def", [
					"UK3CB_TKM_I_Hilux_M2",
					"UK3CB_TKM_I_Hilux_Pkm",
					"UK3CB_TKM_I_BRDM2_HQ",
					"UK3CB_TKA_I_BTR40_MG"
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
					[["UK3CB_TKA_I_CREW"], "CAPTAIN"],
					[["UK3CB_TKA_I_HELI_PILOT"], "MAJOR"]
				]],
				["Pie_Vehicles_Def", [
					"UK3CB_TKA_I_T34",
					"UK3CB_TKM_I_BRDM2",
					"UK3CB_TKA_I_UH1H_GUNSHIP",
					"rhsgref_cdf_reg_mi17sh"
				]],
				["dmpFactionName", "ResistanceArmour"],
				["dmpFactionVehicleSize", "1,1"],
				["dmpFactionVehiclePatrols", "2,5"],
				["dmpFactionHelos", "0,3"]
			]
		]
	],
	[
		"StaticSquadComposition",
		["UK3CB_TKM_I_SL", "UK3CB_TKM_I_MD", "UK3CB_TKM_I_MG", "UK3CB_TKM_I_LAT", "UK3CB_TKM_I_RIF_1", "UK3CB_TKM_I_MD", "UK3CB_TKM_I_GL"]
	],
	[
		"QRF",
		[
			createHashMapFromArray [
				["Vehicle", "UK3CB_TKM_I_BRDM2"],
				["Crew", ["UK3CB_TKA_I_CREW", "UK3CB_TKA_I_CREW"]],
				["Dismounts", ["UK3CB_TKM_I_SL", "UK3CB_TKM_I_MD", "UK3CB_TKM_I_AR", "UK3CB_TKM_I_LAT", "UK3CB_TKM_I_RIF_1", "UK3CB_TKM_I_GL"]],
				["VicShouldAssault", true]
			]
		]
	]
];