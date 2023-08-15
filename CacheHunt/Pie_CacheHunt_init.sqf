[] execVM "globalScripts\Pie_RespawnHelper.sqf";

[player, "pieLiftCacheComms", nil, nil, ""] call BIS_fnc_addCommMenuItem;

[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";

[setupLaptop, [
	["FIA", "CacheHunt\FIA", "IND_G_F"],
	["European Locals", "CacheHunt\EuroLocals", "PIE_LocalEuro"]
]] execVM "globalScripts\DynamicFactions\Pie_DynamicDMPFactionSelector.sqf";

if(isServer) then
{
	[] execVM "globalScripts\CacheHunt\Pie_CacheHunt.sqf";
};