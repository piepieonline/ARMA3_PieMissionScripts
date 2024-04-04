[false] execVM "globalScripts\Pie_RespawnHelper.sqf";
[setupLaptop, loadoutBox] execVM "globalScripts\Pie_Helper_DynamicPlayerFaction.sqf";

if(isServer) then
{
	[
		setupLaptop, ["Heal all players", {
			{
				_x setDamage 0;
			} forEach allPlayers;
		},
		nil, 1.5, true, true, "", "true", 5]
	] remoteExec ["addAction", 0, true];
};