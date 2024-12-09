[] execVM "globalScripts\Pie_RespawnHelper.sqf";

[player, "pieLiftCacheComms", nil, nil, ""] call BIS_fnc_addCommMenuItem;

[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";

[setupLaptop, [
	["FIA", "CacheHunt\FIA", "IND_G_F"],
	["European Locals", "CacheHunt\EuroLocals", "PIE_LocalEuro"],
	["Russian (Heavy)", "CacheHunt\RussianHeavy", "CUP_O_RU"],
	["Takistan Locals (CUP)", "CacheHunt\TakiLocals-CUP", "CUP_I_TK_GUE"],
	["Takistan Locals (3CB)", "CacheHunt\TakiLocals-3CB", "UK3CB_TKM_I"]
]] execVM "globalScripts\DynamicFactions\Pie_DynamicDMPFactionSelector.sqf";

_handle_AIGunnerDownReaction = [] execVM "globalScripts\Pie_Helper_AIGunnerDownReaction.sqf";
waitUntil { scriptDone _handle_AIGunnerDownReaction };
[] call Pie_fnc_WatchAllVehicleGunners;

if(isServer) then
{
	[] execVM "globalScripts\Pie_Helper_BaseSafeZoneMarker.sqf";
	[] execVM "globalScripts\Missions\CacheHunt\Pie_CacheHunt.sqf";
};