/*
Respawn setup for missions. Needs a marker position to respawn by default (2 seconds recommended), then go to spectator until the admin allows for reJIP.
Default spawns at the first found alive player, can also change to respawn in a set vehicle

init.sqf: 
	[moveRespawnMarker] execVM "globalScripts\Pie_RespawnHelper.sqf";
		moveRespawnMarker: Move the respawn marker to the first player's location when loading (useful for spawning on boats etc)
*/

if(isServer) then
{
	params [["_moveRespawnMarker", true]];

	// Move the marker to the first player's spawn location (otherwise it's always ASL, doesn't work with the carrier)
	if(_moveRespawnMarker) then
	{
		[] spawn {
			waitUntil { time > 0 };
			"respawn" setMarkerPos (allPlayers select 0);
		};
	};

	// When the first player has moved 100m from their spawn, save loadouts (Backup, as I always forget)
	[] spawn {
		_trackedPlayer = allPlayers select 0;
		_originalPlayerLocation = getPos _trackedPlayer;
		
		waitUntil { sleep 10; _originalPlayerLocation distance2D (getPos _trackedPlayer) > 100 };

		["Saving loadouts"] remoteExec ["systemChat"];
		[] call Pie_fnc_SaveAllRespawnLoadouts;
	};

	// When someone respawns, put them in spectator mode
	addMissionEventHandler ["EntityRespawned", {
		params ["_newEntity", "_oldEntity"];

		if(isPlayer _newEntity && (missionNamespace getVariable ["Pie_Respawn_Enabled", true])) then
		{
			[{
				_playerLoadout = localNamespace getVariable ["Pie_Respawn_Loadout", []];

				if(count _playerLoadout > 0) then
				{
					player setUnitLoadout _playerLoadout;
				};

				[] call ace_spectator_fnc_setSpectator;
				[(allPlayers - [player])] call ace_spectator_fnc_updateUnits;
				[[1, 2], [0]] call ace_spectator_fnc_updateCameraModes;
				[[-2, -1], [0, 1, 2]] call ace_spectator_fnc_updateVisionModes;
			}] remoteExec ["call", owner _newEntity];
		} else {
			_respawnedAI = missionNamespace getVariable ["Pie_Respawn_RespawnedAI", []];
			_respawnedAI pushBack _newEntity;
			_newEntity disableAI "PATH";
			_newEntity disableAI "RADIOPROTOCOL";
			missionNamespace setVariable ["Pie_Respawn_RespawnedAI", _respawnedAI, true];
		};
	}];
};

// Add actions to ZEN context menu as well
[["RespawnerParent", "Respawn", "\A3\ui_f\data\map\markers\nato\respawn_unknown_ca.paa"] call zen_context_menu_fnc_createAction, [], 0] call zen_context_menu_fnc_addAction;
[["RespawnerRespawnToVehicle", "Respawn Players To Vehicle", "\A3\ui_f\data\map\markers\nato\respawn_unknown_ca.paa", {["vic"] call Pie_fnc_DoRejoin}, {!isNull (missionNamespace getVariable ["PieRespawn_RespawnVic", objNull])}] call zen_context_menu_fnc_createAction, ["RespawnerParent"], 0] call zen_context_menu_fnc_addAction;
[["RespawnerRespawnToVehicle", "Respawn Players To Team", "\A3\ui_f\data\map\markers\nato\respawn_unknown_ca.paa", {["team"] call Pie_fnc_DoRejoin}] call zen_context_menu_fnc_createAction, ["RespawnerParent"], 0] call zen_context_menu_fnc_addAction;
[["RespawnerRespawnToVehicle", "Respawn Players To Base", "\A3\ui_f\data\map\markers\nato\respawn_unknown_ca.paa", {["base"] call Pie_fnc_DoRejoin}] call zen_context_menu_fnc_createAction, ["RespawnerParent"], 0] call zen_context_menu_fnc_addAction;
[["RespawnerSetVehicle", "Set Vehicle", "\a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa", {[_objects select 0] call Pie_fnc_SetRejoinVic}, {count _objects == 1}] call zen_context_menu_fnc_createAction, ["RespawnerParent"], 0] call zen_context_menu_fnc_addAction;

Pie_fnc_DoRejoin = {
	params ["_location"];
	if (call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player)) then {
		// Select the same respawn player for all respawners
		// Use the admin by default
		_respawnPlayer = player;

		_deadPlayers = [] call ace_spectator_fnc_players;
		_alivePlayers = (allPlayers - _deadPlayers) select {alive _x};
		// If the admin is dead, use the first player we find
		if(!(player in _alivePlayers)) then
		{
			if(count _alivePlayers > 0) then
			{
				_respawnPlayer = _alivePlayers select 0;
			}
			else
			{
				// No one is alive, we don't have a valid respawn player
				_respawnPlayer = objNull;
			};
		};

		missionNamespace setVariable ["PieRespawn_RespawnPlayer", _respawnPlayer, true];
		missionNamespace setVariable ["PieRespawn_RespawnLocation", _location, true];
		[{
			_deadPlayers = [] call ace_spectator_fnc_players;
			_location = missionNamespace getVariable ["PieRespawn_RespawnLocation", "base"];
			_respawnPlayer = missionNamespace getVariable ["PieRespawn_RespawnPlayer", objNull];
			if(player in _deadPlayers) then
			{
				_respawnVic = missionNamespace getVariable ["PieRespawn_RespawnVic", objNull];
				if(_location == "vic" && !isNull _respawnVic && alive _respawnVic) then
				{
					// [format ["Respawning %1 at vehicle %2", name player, typeof _respawnVic]] remoteExec ["systemChat"];
					player moveInAny _respawnVic;
				}
				else
				{
					if((_location == "team" || _location == "player") && !isNull _respawnPlayer) then
					{
						// [format ["Respawning %1 at player %2", name player, name _respawnPlayer]] remoteExec ["systemChat"];
						player setPosATL (getPosATL _respawnPlayer);
					};
				};
			};

			[false] call ace_spectator_fnc_setSpectator;
		}] remoteExec ["call"];

		// Reenable AI
		{
			_x enableAI "PATH";
			_x enableAI "RADIOPROTOCOL";
		} forEach (missionNamespace getVariable ["Pie_Respawn_RespawnedAI", []]);
		missionNamespace setVariable ["Pie_Respawn_RespawnedAI", [], true];
	};
};

Pie_fnc_SetRejoinVic = {
	if (call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player)) then {
		params ["_selectedVehicle"];
		
		if (!isNull _selectedVehicle) then
		{
			hint ("Respawn vehicle set: " + (typeof _selectedVehicle));
			missionNamespace setVariable ["PieRespawn_RespawnVic", _selectedVehicle, true];
		}
		else
		{
			if (vehicle player != player) then
			{
				hint ("Respawn vehicle set: " + (typeof vehicle player));
				missionNamespace setVariable ["PieRespawn_RespawnVic", vehicle player, true];
			};
		};
	};
};

Pie_fnc_ClearRejoinVic = {
	if (call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player)) then {
		if(vehicle player != player) then
		{
			missionNamespace setVariable ["PieRespawn_RespawnVic", objNull, true];
			hint ("Respawn vehicle cleared");
		};
	};
};

Pie_fnc_SaveRespawnLoadout = {
	localNamespace setVariable ["Pie_Respawn_Loadout", getUnitLoadout player];
};

Pie_fnc_SaveAllRespawnLoadouts = {
	if (call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player)) then {
		[] remoteExec ["Pie_fnc_SaveRespawnLoadout"];
	};
};

Pie_fnc_ResetAllLoadouts = {
	if (call BIS_fnc_admin != 0 || clientOwner == 2 || !isNull (getAssignedCuratorLogic player)) then {
		[{
			_playerLoadout = localNamespace getVariable ["Pie_Respawn_Loadout", []];

			if(count _playerLoadout > 0) then
			{
				player setUnitLoadout _playerLoadout;
			};
		}] remoteExec ["call"];
	};
};

player createDiarySubject ["Gameplay", "Gameplay"];
// Inverted order, last entry at the top
player createDiaryRecord ["Gameplay", ["Rejoin", "<font color='#33CC33'><execute expression = '[] call Pie_fnc_SaveRespawnLoadout'>Save loadout</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin - Admin", "<font color='#33CC33'><execute expression = '[] call Pie_fnc_ResetAllLoadouts'>Reset all player loadouts</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin - Admin", "<font color='#33CC33'><execute expression = '[] call Pie_fnc_SaveAllRespawnLoadouts'>Save all loadouts</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin - Admin", "<font color='#33CC33'><execute expression = '[] call Pie_fnc_ClearRejoinVic'>Clear rejoin vehicle</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin - Admin", "<font color='#33CC33'><execute expression = '[] call Pie_fnc_SetRejoinVic'>Set as rejoin vehicle</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin - Admin", "<font color='#33CC33'><execute expression = '[""vic""] call Pie_fnc_DoRejoin'>Rejoin all to vehicle</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin - Admin", "<font color='#33CC33'><execute expression = '[""team""] call Pie_fnc_DoRejoin'>Rejoin all to player</execute></font color>"]];
player createDiaryRecord ["Gameplay", ["Rejoin - Admin", "<font color='#33CC33'><execute expression = '[""base""] call Pie_fnc_DoRejoin'>Rejoin all to base</execute></font color>"]];