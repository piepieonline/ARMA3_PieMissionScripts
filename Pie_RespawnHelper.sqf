/*
Respawn setup for missions. Needs a marker position to respawn by default (2 seconds recommended), then go to spectator until the admin allows for reJIP.
Default spawns at the first found alive player, can also change to respawn in a set vehicle

init.sqf: 
	[] execVM "globalScripts\Pie_RespawnHelper.sqf";
*/

if(isServer) then
{
	addMissionEventHandler ["EntityRespawned", {
		params ["_newEntity", "_oldEntity"];

		[{
			[] call ace_spectator_fnc_setSpectator;
			[allPlayers] call ace_spectator_fnc_updateUnits;
			[[1, 2], [0]] call ace_spectator_fnc_updateCameraModes;
			[[-2, -1], [0, 1, 2]] call ace_spectator_fnc_updateVisionModes;
		}] remoteExec ["call", owner _newEntity];
	}];
};

Pie_fnc_DoRejoin = {
	if (call BIS_fnc_admin != 0 || clientOwner == 2) then {
		[{
			_deadPlayers = [] call ace_spectator_fnc_players;
			_alivePlayers = allPlayers - _deadPlayers;
			if(player in _deadPlayers) then
			{
				_respawnVic = missionNamespace getVariable ["PieRespawn_RespawnVic", objNull]; 
				if(!isNull _respawnVic && alive _respawnVic) then
				{
					player moveInAny _respawnVic;
				}
				else
				{
					player setPosATL (getPosATL (_alivePlayers select 0));
				}
			};

			[false] call ace_spectator_fnc_setSpectator;
		}] remoteExec ["call"];
	};
};

Pie_fnc_SetRejoinVic = {
	if (call BIS_fnc_admin != 0 || clientOwner == 2) then {
		if(vehicle player != player) then
		{
			missionNamespace setVariable ["PieRespawn_RespawnVic", vehicle player, true];
			hint ("Respawn vehicle set: " + (str vehicle player));
		};
	};
};

Pie_fnc_ClearRejoinVic = {
	if (call BIS_fnc_admin != 0 || clientOwner == 2) then {
		if(vehicle player != player) then
		{
			missionNamespace setVariable ["PieRespawn_RespawnVic", objNull, true];
			hint ("Respawn vehicle cleared");
		};
	};
};

player createDiarySubject ["Gameplay", "Gameplay"];
player createDiaryRecord ["Gameplay", ["Rejoin", "<font color='#33CC33'><execute expression = '[] call Pie_fnc_ClearRejoinVic'Clear rejoin vehicle</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin", "<font color='#33CC33'><execute expression = '[] call Pie_fnc_SetRejoinVic'>Set as rejoin vehicle</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin", "<font color='#33CC33'><execute expression = '[] call Pie_fnc_DoRejoin'>Rejoin all</execute></font color>"]];