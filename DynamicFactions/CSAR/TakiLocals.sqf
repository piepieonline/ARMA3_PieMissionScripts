createHashMapFromArray [
	[
		"FactionClass",
		"CUP_I_TK_GUE"
	],
	[
		"DMPModules",
		[
			createHashMapFromArray [
				["Pie_Units_Def", [
					[["CUP_I_TK_GUE_Soldier_TL"], "SERGEANT"],
					[["CUP_O_TK_Crew"], "CAPTAIN"],
					[["CUP_O_TK_Pilot"], "MAJOR"],
					[["CUP_I_TK_GUE_Demo", "CUP_I_TK_GUE_Guerilla_Enfield", "CUP_I_TK_GUE_Guerilla_Medic", "CUP_I_TK_GUE_Mechanic", "CUP_I_TK_GUE_Soldier", "CUP_I_TK_GUE_Soldier_AK_47S", "CUP_I_TK_GUE_Soldier_AR", "CUP_I_TK_GUE_Soldier_AT", "CUP_I_TK_GUE_Soldier_GL", "CUP_I_TK_GUE_Soldier_M16A2", "CUP_I_TK_GUE_Soldier_MG"]]
				]],
				["Pie_Vehicles_Def", [
					"CUP_I_Datsun_PK_TK_Random",
					"I_G_Offroad_01_armed_F",
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
					[["CUP_O_TK_Crew"], "CAPTAIN"],
					[["CUP_O_TK_Pilot"], "MAJOR"]
				]],
				["Pie_Vehicles_Def", [
					"CUP_I_T34_TK_GUE",
					"CUP_I_BRDM2_TK_GUE",
					"CUP_I_UH1H_gunship_RACS",
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
		["CUP_I_TK_GUE_Soldier_TL", "CUP_I_TK_GUE_Guerilla_Medic", "CUP_I_TK_GUE_Soldier_AR", "CUP_I_TK_GUE_Soldier_AT", "CUP_I_TK_GUE_Soldier_AK_47S", "CUP_I_TK_GUE_Guerilla_Medic", "CUP_I_TK_GUE_Soldier_GL"]
	],
	[
		"WreckGuardSquadComposition",
		["CUP_I_TK_GUE_Soldier_TL", "CUP_I_TK_GUE_Guerilla_Medic", "CUP_I_TK_GUE_Soldier_AR", "CUP_I_TK_GUE_Soldier_AK_47S","CUP_I_TK_GUE_Guerilla_Enfield"]
	],
	[
		"WreckGuardVehicle",
		"I_G_Offroad_01_armed_F"
	]
];