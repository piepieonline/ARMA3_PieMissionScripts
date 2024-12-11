/*
	Zeus Template: CSAR
		Players have to find a helicopter crash site, destroy it and then find and rescue the pilot who is captive
		Chooses one town out of the players selection to use as the AO
		Civilians can be added separately
		Requires Zeus to place down the units and vehicles that the enemy faction should use

	TODO: Wreck guard
*/

Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "globalScripts\_ThirdParty\Zen_OccupyHouse.sqf";

Pie_fnc_ZeusTemplate_StartCSAR = {
    _callingPlayerOwner = _this param [0, 0];

    _aoTown = selectRandom (missionNamespace getVariable ["Pie_ZeusTemplate_Towns", []]);

	// Find an indoors location to put the pilot - use the same logic as spawning caches
	_hostagePosition = [position (_aoTown), 250, objNull, false] call Pie_Helper_SpawnCache;

	// Select the pilots class based on the player faction
	_hostageClass = "";
	if(missionNamespace getVariable ['Pie_Mis_SelectedPlayerFaction', ''] != "") then
	{
		{
			_soldierClassname = getText (_x >> 'displayName');

			if(["pilot", _soldierClassname, false] call BIS_fnc_inString) then
			{
				if(["heli", _soldierClassname, false] call BIS_fnc_inString) then
				{
					_hostageClass = configName _x;
					break;
				};
				if (_hostageClass isEqualTo "") then
				{
					_hostageClass = configName _x;
				};
			};
		} forEach (configProperties [configFile >> "CfgVehicles", format ["isClass _x && (getText (_x >> 'unitinfotype') == 'rscunitinfosoldier') and (getText (_x >> 'faction') == '%1')", missionNamespace getVariable "Pie_Mis_SelectedPlayerFaction"], true]);
	};

	if (_hostageClass isEqualTo "") then 
	{
		_hostageClass = "B_Helipilot_F";
	};

	// Spawn and handcuff the pilot
	_unit = (createGroup [west, true]) createUnit [_hostageClass, _hostagePosition, [], 0, "NONE"];
	[_unit, true] call ACE_captives_fnc_setHandcuffed;

	// Spawn the hostage's guard
	_garrisonForceGroup = [_hostagePosition, east, selectRandom (missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []])] call BIS_fnc_spawnGroup;
	_missedUnits = [_hostagePosition, units _garrisonForceGroup] call Zen_OccupyHouse;

	// Occupy the town based on where the hostage is put
	[_aoTown, _hostagePosition] call Pie_fnc_OccupyTown;

	// Spawn the wreck
	_wreckPos = (selectBestPlaces [_hostagePosition, 300, "meadow - (100 * waterDepth) - hills", 1, 1] select 0 select 0);
	_wreck = createVehicle ["Land_Wreck_Heli_Attack_01_F", _wreckPos, [], 0, "NONE"];
	_smoke = createVehicle ['test_EmptyObjectForSmoke', _wreckPos, [], 0, 'can_collide']; 

	// Spawn the wreck guards
	// Vehicle
	[[_wreckPos, 20, 75] call BIS_fnc_findSafePos, random 360, selectRandom (missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyVic", []]) select 0, east] call BIS_fnc_spawnVehicle;
	// Inf
	_grp = [[_wreckPos, 10, 50] call BIS_fnc_findSafePos, east, selectRandom (missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []])] call BIS_fnc_spawnGroup;
	[_grp, getPos (leader _grp), 25, [], true, true] call lambs_wp_fnc_taskCamp;

	// Create the objectives
	[true, "Pie_Task_CSAR_DestroyWreck", ["The wreck needs to be destroyed to stop the enemy getting any classified technology from it.", "Find and destroy the wreck"], objNull, "AUTOASSIGNED", -1, true, "Destroy", false] call BIS_fnc_taskCreate;
	[_wreck, ["Explosion", {
		params ["_vehicle", "_damage", "_explosionSource"];

		if((typeOf _explosionSource) isKindOf "PipeBombBase") then
		{
			["Pie_Task_CSAR_DestroyWreck", "SUCCEEDED"] call BIS_fnc_taskSetState;
		};
	}]] remoteExec ["addEventHandler", 0, true];
	
	[true, "Pie_Task_CSAR_RescuePilot", ["The pilot needs to be found and brought home safely.", "Rescue the pilot"], objNull, "AUTOASSIGNED", -1, true, "Search", false] call BIS_fnc_taskCreate;

	// Intel
	// Create intel to help players find the wreck
	_heliIntelLine = format ["%1 of here", ([position _aoTown, getMarkerPos "respawn"] call DMP_fnc_ClosestPosition)];
	_pilotIntelLine = "";

	if(missionNamespace getVariable ["Pie_Mis_Zeus_Mission_CSAR_KnownCrashSite", true]) then
	{
		_heliIntelLine = format ["%1 of %2", ([position _wreck, position _aoTown] call DMP_fnc_ClosestPosition), text _aoTown];
		_pilotIntelLine = " and taken somewhere in town";

		_markerstr = createMarker [("aoTown"), position _aoTown];
		_markerstr setMarkerShape "ELLIPSE";
		_markerstr setMarkerSize [500, 500];
		_markerstr setMarkerColor "ColorRed";
		_markerstr setMarkerAlpha 0.5;
		_markerstr setMarkerBrush "BDiagonal";
	};

	missionNamespace setVariable ["Pie_Mis_Zeus_CSAR_DiaryLine", format ["A helicopter was lost %1, and radio interceptions confirm a pilot has been captured%2.<br />Destroy the wreck, rescue the pilot, and bring them home.", _heliIntelLine,_pilotIntelLine], true];

	{
		player createDiaryRecord ["Diary", ["Situation", missionNamespace getVariable "Pie_Mis_Zeus_CSAR_DiaryLine"]];	
	} remoteExec ["call", 0, true];
}