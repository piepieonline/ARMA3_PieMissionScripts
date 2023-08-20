[] execVM "globalScripts\Pie_RespawnHelper.sqf";

[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";

[setupLaptop, [
	["European Locals", "CSAR\EuroLocals", "PIE_LocalEuro"],
	["FIA", "CSAR\FIA", "IND_G_F"],
	["Russian (Heavy)", "CSAR\RussianHeavy", "CUP_O_RU"]
]] execVM "globalScripts\DynamicFactions\Pie_DynamicDMPFactionSelector.sqf";

[] execVM "globalScripts\Pie_Helper_AIGunnerDownReaction.sqf";

if(isServer) then
{
	[] execVM "globalScripts\Pie_Helper_BaseSafeZoneMarker.sqf";
	[hostage, wreckToSpawn] execVM "globalScripts\Missions\CSAR\Pie_CSAR.sqf";
};