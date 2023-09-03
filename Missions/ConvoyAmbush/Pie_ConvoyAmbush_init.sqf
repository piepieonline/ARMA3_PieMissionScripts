[] execVM "globalScripts\Pie_RespawnHelper.sqf";

[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";

[setupLaptop, [
	["UN", "ConvoyAmbush\UN", "CUP_I_UN"]
]] execVM "globalScripts\DynamicFactions\Pie_DynamicDMPFactionSelector.sqf";

if(isServer) then
{
	[] execVM "globalScripts\Missions\ConvoyAmbush\Pie_ConvoyAmbush.sqf";
};