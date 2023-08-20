createHashMapFromArray [
	[
		"FactionClass",
		"PIE_LocalEuro"
	],
	[
		"DMPModules",
		[
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["PIE_LocalEuro_Warlord"], "SERGEANT"],
					[["PIE_LocalEuro_Guerilla_Crewman"], "CAPTAIN"],
					[["PIE_LocalEuro_Guerilla_Pilot"], "MAJOR"],
					[["PIE_LocalEuro_Guerilla_AKS", "PIE_LocalEuro_Guerilla_AK15_GL", "PIE_LocalEuro_Guerilla_Light", "PIE_LocalEuro_Guerilla_RPK", "PIE_LocalEuro_Guerilla_RPG", "PIE_LocalEuro_Guerilla_AKM", "PIE_LocalEuro_Guerilla_FN_FAL"]]
				]],
				["Pie_Vehicles_Def", [
					"PIE_LocalEuro_HMG_technical",
					"CUP_I_BRDM2_HQ_TK_GUE",
					"CUP_I_BTR40_MG_TKG"
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
					[["PIE_LocalEuro_Guerilla_Crewman"], "CAPTAIN"],
					[["PIE_LocalEuro_Guerilla_Pilot"], "MAJOR"]
				]],
				["Pie_Vehicles_Def", [
					"CUP_I_T34_TK_GUE",
					"CUP_I_BRDM2_TK_GUE",
					"I_E_Heli_light_03_dynamicLoadout_F",
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
		"GarrisonSquadComposition",
		["PIE_LocalEuro_Warlord", "PIE_LocalEuro_Guerilla_Medic", "PIE_LocalEuro_Guerilla_RPK", "PIE_LocalEuro_Guerilla_RPG", "PIE_LocalEuro_Guerilla_AKM", "PIE_LocalEuro_Guerilla_Medic", "PIE_LocalEuro_Guerilla_AK15_GL"]
	],
	[
		"WreckGuardSquadComposition",
		["PIE_LocalEuro_Warlord", "PIE_LocalEuro_Guerilla_Medic", "PIE_LocalEuro_Guerilla_RPK", "PIE_LocalEuro_Guerilla_AKM","PIE_LocalEuro_Guerilla_AKS"]
	],
	[
		"WreckGuardVehicle",
		"PIE_LocalEuro_HMG_technical"
	]
];