[] execVM "globalScripts\Pie_RespawnHelper.sqf";

[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";

[setupLaptop, [
	["European Locals", "CSAR\EuroLocals", "PIE_LocalEuro"],
	["Russian (Heavy)", "CSAR\RussianHeavy", "CUP_O_RU"]
]] execVM "globalScripts\DynamicFactions\Pie_DynamicDMPFactionSelector.sqf";

if(isServer) then
{
	[hostage, wreckToSpawn] execVM "globalScripts\Missions\CSAR\Pie_CSAR.sqf";
};