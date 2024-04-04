// by ALIAS

nul = [vehicle_name,watch_altitude,delay_scan,"control_variable",enable_random_fire] execvm "globalScripts\_ThirdParty\AL_AI_scan\al_scan.sqf";

vehicle_name		- string, name of the vehicle you want to simulate sweep scan and or fire
watch_altitude		- number, altitude in meters, useful if you want the AI to look upwards and simulate AAA scan or shooting, 
						set it to zero if you want to keep AI watch direction more or less horizontal
delay_scan			- number, delay in seconds before AI selects another position/direction to watch at
"control_variable"	- string, is the name of a boolean variable you link the object to, it has to be between quotes "" to work, 
						is a variable that allows you to control de script,
						it needs to be defined when mission starts as true and before running the "AI Sector Scan script"
						As long the variable is true the script will keep running, make it false via trigger or another script to stop the script
						See the DEMO mission to see how you can use it
enable_random_fire	- boolean, if is true AI will shoot while scanning the area, if is false AI will only scan the sector

//* You can run the script

========= EXAMPLE 1
nul = [this,5,3,"scan_1",true] execvm "globalScripts\_ThirdParty\AL_AI_scan\al_scan.sqf";

========= EXAMPLE 2
nul = [this,0,3,"scan_1",false] execvm "globalScripts\_ThirdParty\AL_AI_scan\al_scan.sqf";

========= EXAMPLE 3
nul = [my_vehicle,0,3,"scan_1",true] execvm "globalScripts\_ThirdParty\AL_AI_scan\al_scan.sqf";
