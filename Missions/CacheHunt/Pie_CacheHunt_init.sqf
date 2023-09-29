[] execVM "globalScripts\Pie_RespawnHelper.sqf";

[player, "pieLiftCacheComms", nil, nil, ""] call BIS_fnc_addCommMenuItem;

[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";

[setupLaptop, [
	["FIA", "CacheHunt\FIA", "IND_G_F"],
	["European Locals", "CacheHunt\EuroLocals", "PIE_LocalEuro"],
	["Russian (Heavy)", "CacheHunt\RussianHeavy", "CUP_O_RU"],
	["Takistan Locals", "CacheHunt\TakiLocals", "CUP_I_TK_GUE"]
]] execVM "globalScripts\DynamicFactions\Pie_DynamicDMPFactionSelector.sqf";

[] execVM "globalScripts\Pie_Helper_AIGunnerDownReaction.sqf";

if(isServer) then
{
	[] execVM "globalScripts\Pie_Helper_BaseSafeZoneMarker.sqf";
	[] execVM "globalScripts\Missions\CacheHunt\Pie_CacheHunt.sqf";
};