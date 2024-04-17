call compile preprocessFileLineNumbers "globalScripts\_ThirdParty\Engima-Civilians-Traffic-Zombies-main\Engima\Roaming_NPCS\Common\Common.sqf";
call compile preprocessFileLineNumbers "globalScripts\_ThirdParty\Engima-Civilians-Traffic-Zombies-main\Engima\Roaming_NPCS\Common\Debug.sqf";

// The following constants may be used to tweak behaviour

ENGIMA_CIVILIANS_SIDE = INDEPENDENT;      // If you for some reason want the units to spawn into another side.
ENGIMA_CIVILIANS_MINSKILL = 0.9;       // If you spawn something other than civilians, you may want to set another skill level of the spawned units.
ENGIMA_CIVILIANS_MAXSKILL = 1;       // If you spawn something other than civilians, you may want to set another skill level of the spawned units.

ENGIMA_CIVILIANS_MAXWAITINGTIME = 300; // Maximum standing still time in seconds
ENGIMA_CIVILIANS_RUNNINGCHANCE = 0.05; // Chance of running instead of walking

// Civilian personalities
ENGIMA_CIVILIANS_BEHAVIOURS = [
	["CITIZEN", 100] // Default citizen with ordinary behaviour. Spawns in a house and walks to another house, and so on...
];

// Do not edit anything beneath this line!

ENGIMA_CIVILIANS_INSTANCE_NO = 0;

if (isServer) then {
	call compile preprocessFileLineNumbers "globalScripts\_ThirdParty\Engima-Civilians-Traffic-Zombies-main\Engima\Roaming_NPCS\Server\ServerFunctions.sqf";
	call compile preprocessFileLineNumbers "globalScripts\_ThirdParty\Engima-Civilians-Traffic-Zombies-main\Engima\Roaming_NPCS\Roaming_Guerila_APEX\ConfigAndStart.sqf";
};
