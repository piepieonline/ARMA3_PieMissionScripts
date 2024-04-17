/* 
 * This file contains config parameters and a function call to start the civilian script.
 * The parameters in this file may be edited by the mission developer.
 *
 * See file Engima\Civilians\Documentation.txt for documentation and a full reference of 
 * how to customize and use Engima's Civilians.
 */
 
private ["_parameters"];

// Set civilian parameters.
_parameters = [
	["UNIT_CLASSES", 
	[
		//  Ryanzombies  classnames
				//Crawler Zombies
				"RyanZombieCrawler1","RyanZombieCrawler10","RyanZombieCrawler11","RyanZombieCrawler12","RyanZombieCrawler13",
				"RyanZombieCrawler14","RyanZombieCrawler15","RyanZombieCrawler16","RyanZombieCrawler17","RyanZombieCrawler18",
				"RyanZombieCrawler19","RyanZombieCrawler2","RyanZombieCrawler20","RyanZombieCrawler21","RyanZombieCrawler22",
				"RyanZombieCrawler23","RyanZombieCrawler24","RyanZombieCrawler25","RyanZombieCrawler26","RyanZombieCrawler27",
				"RyanZombieCrawler28","RyanZombieCrawler29","RyanZombieCrawler3","RyanZombieCrawler30","RyanZombieCrawler31",
				"RyanZombieCrawler32","RyanZombieCrawler4","RyanZombieCrawler5","RyanZombieCrawler6","RyanZombieCrawler7",
				"RyanZombieCrawler8","RyanZombieCrawler9",
				//Fast Zombies
				"RyanZombieC_man_1","RyanZombieC_man_hunter_1_F","RyanZombieC_man_pilot_F","RyanZombieC_scientist_F",
				"RyanZombieB_RangeMaster_F","RyanZombieC_journalist_F","RyanZombieC_Orestes","RyanZombieC_Nikos",
				"RyanZombieB_Soldier_02_f","RyanZombie15","RyanZombie16","RyanZombie18","RyanZombieC_man_polo_1_F",
				"RyanZombie19","RyanZombie32","RyanZombie20","RyanZombie21","RyanZombie22","RyanZombie23","RyanZombie24",
				"RyanZombie25","RyanZombie26","RyanZombie27","RyanZombie28","RyanZombie29","RyanZombieC_man_polo_2_F",
				"RyanZombie30","RyanZombieB_Soldier_lite_F","RyanZombieB_Soldier_lite_F_1","RyanZombieB_Soldier_02_f_1",
				"RyanZombieB_Soldier_03_f","RyanZombieB_Soldier_03_f_1","RyanZombieB_Soldier_03_f_1_1","RyanZombieB_Soldier_04_f",
				"RyanZombie31","RyanZombieB_Soldier_02_f_1_1","RyanZombieC_man_polo_4_F","RyanZombieC_man_polo_6_F",
				"RyanZombieC_man_p_fugitive_F","RyanZombieC_man_w_worker_F","RyanZombieB_Soldier_05_f","RyanZombieC_man_polo_5_F",
				"RyanZombieB_Soldier_04_f_1","RyanZombieB_Soldier_04_f_1_1",
				//Medium Zombies
				"RyanZombieC_man_1medium","RyanZombieC_man_hunter_1_Fmedium","RyanZombie18medium","RyanZombieB_Soldier_05_fmedium",
				"RyanZombieB_RangeMaster_Fmedium","RyanZombieB_Soldier_02_fmedium","RyanZombieB_Soldier_lite_Fmedium",
				"RyanZombieC_man_pilot_Fmedium","RyanZombieC_journalist_Fmedium","RyanZombieC_Orestesmedium",
				"RyanZombieC_Nikosmedium","RyanZombie15medium","RyanZombie16medium","RyanZombie17medium","RyanZombie19medium",
				"RyanZombieC_man_polo_1_Fmedium","RyanZombie20medium","RyanZombie22medium","RyanZombieC_man_polo_2_Fmedium",
				"RyanZombie32medium","RyanZombieC_man_polo_4_Fmedium","RyanZombieC_man_p_fugitive_Fmedium",
				"RyanZombieC_man_w_worker_Fmedium","RyanZombieC_scientist_Fmedium","RyanZombieB_Soldier_02_f_1medium",
				"RyanZombieB_Soldier_02_f_1_1medium","RyanZombieB_Soldier_03_fmedium","RyanZombie21medium","RyanZombie23medium",
				"RyanZombie28medium","RyanZombie29medium","RyanZombie24medium","RyanZombieB_Soldier_03_f_1medium",
				"RyanZombieB_Soldier_03_f_1_1medium","RyanZombieB_Soldier_04_f_1medium","RyanZombie25medium","RyanZombie26medium",
				"RyanZombie27medium","RyanZombie30medium","RyanZombie31medium","RyanZombieB_Soldier_04_fmedium",
				"RyanZombieB_Soldier_04_f_1_1medium","RyanZombieC_man_polo_6_Fmedium","RyanZombieB_Soldier_lite_F_1medium",
				//Slow Zombies
				"RyanZombieC_man_1slow","RyanZombieC_man_hunter_1_Fslow","RyanZombieC_man_pilot_Fslow","RyanZombieC_journalist_Fslow",
				"RyanZombieC_Orestesslow","RyanZombieC_Nikosslow","RyanZombie15slow","RyanZombie16slow","RyanZombie17slow",
				"RyanZombie18slow","RyanZombie22slow","RyanZombie30slow","RyanZombieC_scientist_Fslow",
				"RyanZombieB_Soldier_03_f_1_1slow","RyanZombie19slow","RyanZombieC_man_polo_1_Fslow","RyanZombie23slow",
				"RyanZombie27slow","RyanZombie28slow","RyanZombieC_man_polo_5_Fslow","RyanZombieC_man_w_worker_Fslow",
				"RyanZombieB_Soldier_05_fslow","RyanZombieB_Soldier_02_f_1_1slow","RyanZombieB_Soldier_03_f_1slow",
				"RyanZombieB_Soldier_04_f_1slow","RyanZombie21slow","RyanZombie24slow","RyanZombieB_Soldier_04_f_1_1slow",
				"RyanZombie25slow","RyanZombie26slow","RyanZombie29slow","RyanZombieC_man_polo_2_Fslow","RyanZombie32slow",
				"RyanZombieC_man_polo_4_Fslow","RyanZombieC_man_polo_6_Fslow","RyanZombieC_man_p_fugitive_Fslow",
				"RyanZombieB_Soldier_02_fslow","RyanZombieB_RangeMaster_Fslow","RyanZombieB_Soldier_lite_Fslow",
				"RyanZombieB_Soldier_03_fslow","RyanZombieB_Soldier_04_fslow",
				//Spider Zombies
				"RyanZombieSpider1","RyanZombieSpider10","RyanZombieSpider11","RyanZombieSpider30","RyanZombieSpider31",
				"RyanZombieSpider9","RyanZombieSpider12","RyanZombieSpider13","RyanZombieSpider14","RyanZombieSpider15",
				"RyanZombieSpider16","RyanZombieSpider17","RyanZombieSpider18","RyanZombieSpider19","RyanZombieSpider20",
				"RyanZombieSpider21","RyanZombieSpider22","RyanZombieSpider23","RyanZombieSpider24","RyanZombieSpider25",
				"RyanZombieSpider26","RyanZombieSpider27","RyanZombieSpider28","RyanZombieSpider29","RyanZombieSpider3",
				"RyanZombieSpider32","RyanZombieSpider4","RyanZombieSpider5","RyanZombieSpider6","RyanZombieSpider7",
				"RyanZombieSpider8",
				//Walker Zombies
				"RyanZombieC_man_1walker","RyanZombieC_man_hunter_1_Fwalker","RyanZombieC_man_pilot_Fwalker",
				"RyanZombieC_journalist_Fwalker","RyanZombieC_Oresteswalker","RyanZombie15walker","RyanZombie16walker",
				"RyanZombie17walker","RyanZombie18walker","RyanZombie19walker","RyanZombieC_man_polo_1_Fwalker","RyanZombie20walker",
				"RyanZombie21walker","RyanZombie22walker","RyanZombie23walker","RyanZombie24walker","RyanZombie25walker",
				"RyanZombie26walker","RyanZombie27walker","RyanZombie28walker","RyanZombie29walker","RyanZombieC_man_polo_2_Fwalker",
				"RyanZombie30walker","RyanZombie31walker","RyanZombie32walker","RyanZombieC_man_polo_5_Fwalker",
				"RyanZombieC_man_polo_6_Fwalker","RyanZombieC_man_p_fugitive_Fwalker","RyanZombieC_scientist_Fwalker",
				"RyanZombieB_Soldier_05_fwalker","RyanZombieB_Soldier_03_fwalker","RyanZombieC_man_polo_4_Fwalker",
				"RyanZombieC_man_w_worker_Fwalker","RyanZombieB_Soldier_02_fwalker","RyanZombieB_Soldier_lite_Fwalker",
				"RyanZombieB_Soldier_02_f_1walker","RyanZombieB_Soldier_02_f_1_1walker","RyanZombieB_Soldier_lite_F_1walker",
				"RyanZombieB_Soldier_03_f_1walker","RyanZombieB_Soldier_03_f_1_1walker","RyanZombieB_Soldier_04_fwalker",
				"RyanZombieB_Soldier_04_f_1walker","RyanZombieB_Soldier_04_f_1_1walker",
				//Demons
				"RyanZombieboss1","RyanZombieboss10","RyanZombieboss12","RyanZombieboss11","RyanZombieboss13","RyanZombieboss17",
				"RyanZombieboss14","RyanZombieboss16","RyanZombieboss2","RyanZombieboss15","RyanZombieboss19","RyanZombieboss20",
				"RyanZombieboss29","RyanZombieboss31","RyanZombieboss21","RyanZombieboss22","RyanZombieboss24","RyanZombieboss32",
				"RyanZombieboss4","RyanZombieboss5","RyanZombieboss6","RyanZombieboss7","RyanZombieboss8","RyanZombieboss9",
				"RyanZombieboss23","RyanZombieboss25","RyanZombieboss27","RyanZombieboss28","RyanZombieboss30","RyanZombieboss26"
	]],
	["UNITS_PER_BUILDING", 0.2],
	["MAX_GROUPS_COUNT", 20],
	["MIN_SPAWN_DISTANCE", 200],
	["MAX_SPAWN_DISTANCE", 600],
	["BLACKLIST_MARKERS", []],
	["HIDE_BLACKLIST_MARKERS", true],
	["ON_UNIT_SPAWNED_CALLBACK", {}],
	["ON_UNIT_REMOVE_CALLBACK", { true }],
	["DEBUG", false]	//false true
];

// Start the script
_parameters spawn ENGIMA_CIVILIANS_StartCivilians;
