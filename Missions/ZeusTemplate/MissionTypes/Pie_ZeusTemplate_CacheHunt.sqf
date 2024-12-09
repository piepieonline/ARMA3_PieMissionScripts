/*
	Zeus Template: Cache Hunt
		Players have to find a cache hidden in a town, and either destroy or retrieve it
		Requires Zeus to place down the units and vehicles that the enemy faction should use

	TODO
		- UI for setup, don't rerun if their are no enemy units spawned
		- Better vehicle setup
		- Patrolling vehicles between towns
		- Update diary tasks when intel is gained from civilians?
		- Some sort of QRF when the cache is hit?
		- Update the civi list (Hardcode per map)
*/

Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "globalScripts\_ThirdParty\Zen_OccupyHouse.sqf";
Pie_Helper_SpawnCache = compileFinal preprocessFileLineNumbers "globalScripts\Pie_Helper_SpawnCache.sqf";
call compile preprocessFileLineNumbers "globalScripts\_ThirdParty\Engima-Civilians-Traffic-Zombies-main\Engima\Civilians\Init.sqf";

if(isServer) then
{
	_missionSetupInteractionPoint = _this param [0, objNull];

	[
		_missionSetupInteractionPoint, ["Prep Cache Hunt", {
			[owner player] remoteExec ["Pie_fnc_ZeusTemplate_PrepCacheHunt", 2];
		},
		nil, 1.5, true, true, "", "true", 5]
	] remoteExec ["addAction", 0, true];

	[
		_missionSetupInteractionPoint, ["Start Cache Hunt", {
			[owner player] remoteExec ["Pie_fnc_ZeusTemplate_StartCacheHunt", 2];
		},
		nil, 1.5, true, true, "", "true", 5]
	] remoteExec ["addAction", 0, true];
};


Pie_fnc_ZeusTemplate_PrepCacheHunt = {
    _callingPlayerOwner = _this param [0, 0];

    [] call Pie_fnc_ZeusTemplate_AssignEnemyFaction;
    [-1] remoteExec ["Pie_fnc_ZeusTemplate_SelectLocationOnMap", _callingPlayerOwner];
};

Pie_fnc_ZeusTemplate_StartCacheHunt = {
    _callingPlayerOwner = _this param [0, 0];

    _towns = missionNamespace getVariable ["Pie_ZeusTemplate_Towns", []];

	// Spawn cache
	_selectedTown = selectRandom _towns;
	_cache = [position (_selectedTown), 250, "IG_supplyCrate_F"] call Pie_Helper_SpawnCache;
	_cachePosition = position _cache;
	missionNamespace setVariable ["Pie_CachePosition", _cachePosition, true];
	missionNamespace setVariable ["Pie_CacheTown", _selectedTown, true];
	missionNamespace setVariable ["Pie_CacheObject", _cache, true];

    {
        // nul = [target, side, radius, spawn [men, divers], spawn [land vehicles, water vehicles, air vehicles], still, men [groups, random extra groups], vehicle [groups, random extra groups], skills, group, custom init, ID, smokes, doors, classes] execVM "LV\militarize.sqf";
        // nul = [getpos _x, 2, 250, [true, false], [true,false,true], false, [4, 2], [1, 2], "default", nil, nil, nil, true, true, ["ALL"]] execVM "LV\militarize.sqf";
        
		_centerOn = getPos _x;
		if(_x == _selectedTown) then 
		{
			_centerOn = _cachePosition;
		};

		[_x, _cachePosition] call Pie_fnc_OccupyTown;

    } forEach _towns;

	// Create the AO marker (TODO: One marker covering everything)
	{
		_markerstr = createMarker [("aoTown_" + text _x), position _x];
		_markerstr setMarkerShape "ELLIPSE";
		_markerstr setMarkerSize [500, 500];
		_markerstr setMarkerColor "ColorRed";
		_markerstr setMarkerAlpha 0.5;
		_markerstr setMarkerBrush "BDiagonal";
	} forEach _towns;

	// Create the task, and a trigger to complete it
	_taskTownNameList = (_towns apply { "<marker name='aoTown_" + text _x + "'>" + text _x + "</marker>" }) joinString ", ";

	// Depending on the mission variant, create different objectives

	// if((["destroyInPlace", 1] call BIS_fnc_getParamValue) == 1) then
    if (true) then
	{
		// Destroy in place
		[true, "Pie_Task_CacheHunt_GetCache", ["An enemy supply cache that needs to be destroyed has been reported somewhere in the vicinity of " + _taskTownNameList, "Find and destroy the cache"], objNull, "ASSIGNED", -1, true, "Destroy", false] call BIS_fnc_taskCreate;
		_cache addEventHandler ["Killed", {
			["Pie_Task_CacheHunt_GetCache", "SUCCEEDED"] call BIS_fnc_taskSetState;
			[true, "PieTask2", ["Mission complete, return to base", "RTB"], getMarkerPos "respawn", "ASSIGNED", -1, true, "GetOut", true] call BIS_fnc_taskCreate;
			// [] call Pie_fnc_SendCacheQRF;
		}];
	}
	else
	{
		// Get it back to base
		// Only draggable in this case, so the mission can be played without ACE
		
		[_cache, true, [0, 2, 0], 0, true] remoteExec ["ace_dragging_fnc_setDraggable", 0, true];
		[true, "Pie_Task_CacheHunt_GetCache", ["A enemy supply cache that needs to be retrieved has been reported somewhere in the vicinity of " + _taskTownNameList, "Find and retrieve the cache"], objNull, "ASSIGNED", -1, true, "Container", false] call BIS_fnc_taskCreate;
		[_cache, _cachePosition] spawn {
			params ["_cache", "_cachePosition"];
			// Wait for the cache to start moving before sending QRF
			while { _cachePosition distance2D _cache < 20 } do
			{
				sleep 2;
			};
			// [] call Pie_fnc_SendCacheQRF;
			// Wait for it to arrive at base before setting RTB task
			while { getMarkerPos "respawn" distance2D _cache > 200 } do
			{
				sleep 2;
			};
			["Pie_Task_CacheHunt_GetCache", "SUCCEEDED"] call BIS_fnc_taskSetState;
			[true, "PieTask2", ["Mission complete, return to base", "RTB"], getMarkerPos "respawn", "ASSIGNED", -1, true, "GetOut", true] call BIS_fnc_taskCreate;
		}
	};

	// Garrison troops around the cache
	_garrisonForceGroup = [_cachePosition, east, selectRandom (missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []])] call BIS_fnc_spawnGroup;
	_missedUnits = [_cachePosition, units _garrisonForceGroup] call Zen_OccupyHouse;

	// TODO: Better system than just deleting overflow
	{
		deleteVehicle _x;
	} forEach _missedUnits;

	// Create civis with intel system
	missionNamespace setVariable ["Pie_Mis_Zeus_CacheIntelFound", false, true];
	call compile preprocessFileLineNumbers "globalScripts\Missions\ZeusTemplate\Helpers\EngimaCiviConfig.sqf";
};

Pie_fnc_DoNPCTalkIntel = {
    _talkingCivi = _this param [0, objNull];

	[_talkingCivi] spawn {
		params ["_talkingCivi"];

		// Cache the response, the same civi should always answer the same
		// Only works because civis are locked in position anyway
		if(isNil { _talkingCivi getVariable "cacheResponse" }) then {
			_closestTown = (nearestLocations [getPos _talkingCivi, ["NameCity", "NameCityCapital", "NameLocal", "NameMarine", "NameVillage"], worldSize]) select 0;

			if(missionNamespace getVariable "Pie_CacheTown" == _closestTown) then
			{
				if((random 100) < 40) then
				{
					// 40% chance of telling the player to beat it
					_talkingCivi setVariable ["cacheResponse", "I'm not telling you anything!", true];
				}
				else
				{
					// 60% of telling the player a rough location
					// Nearest 100m, compass direction
					_dist = round ((_talkingCivi distance2D (missionNamespace getVariable "Pie_CacheObject")) / 100) * 100;

					if(_dist == 0) then
					{
						_talkingCivi setVariable ["cacheResponse", "There's something just around the corner from here.", true];
					}
					else
					{
						_dir = round ((((_talkingCivi) getDir (missionNamespace getVariable "Pie_CacheObject")) / 45) % 8);

						_dirName = switch (_dir) do
						{
							case 0: { "north" };
							case 1: { "north-east" };
							case 2: { "east" };
							case 3: { "south-east" };
							case 4: { "south" };
							case 5: { "south-west" };
							case 6: { "west" };
							case 7: { "north-west" };
							case 8: { "north" };
							default { str _dir };
						};

						_talkingCivi setVariable ["cacheResponse", format["I think I heard there was something about %1m %2 of here.", _dist, _dirName], true];
					};
				};
			}
			else
			{
				_talkingCivi setVariable ["cacheResponse", "I don't think there is anything like that here.", true];
			}
		};

		_TextToSay = _talkingCivi getVariable "cacheResponse";
		_NameOfSpeaker = name _talkingCivi;

		// Adapted from HCOLL_NpcDialog, uses it's UI
		_StructuredText = format["<t shadow='2' align='%5' size='1.1'><t color='%4'>%2: </t><t color='%3'>%1</t></t>", _TextToSay, _NameOfSpeaker, "#ffffff", "#660080", "center"];
		"HCOLL_Dialog_Layer" cutRsc ["HCOLL_Dialog_Popup","PLAIN",1];
		_disp = (uiNamespace getVariable ["HCOLL_Dialog_Popup", displayNull]);
		if(isNull _disp)then{hint "disp is null"};
		(_disp displayCtrl 1199) ctrlSetStructuredText parseText _StructuredText;
		(_disp displayCtrl 1297) ctrlSetText "\HCOLL_NpcDialog\HcollNpcTalk\RadioBG.paa";
		(_disp displayCtrl 1298) ctrlSetText "";
		(_disp displayCtrl 1299) ctrlSetText "";

		_talkingCivi setRandomLip true; 

		// Calculation taken from the mod
		_Duration = ((((count _TextToSay) + (count _NameOfSpeaker)) / 20) + 2 );

		sleep _Duration;

		// Turn off the random lip sync and hide the popup
		_talkingCivi setRandomLip false;
		"HCOLL_Dialog_Layer" cutFadeOut 1;
	};
};

/*
LV_classnames = {
    _sideFilters = param [0,["ALL"],[]];
    _request = param [1,[],[]];
    _side = _request param [0,0,[1,2,3]];
    _type = _request param [1,0,[1,2,3,4,5,6,7]];

    _results = [];

    switch(_type) do {
        case 1:{
            _results = [missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyVic", []]];
        };
        case 2:{
            _results = []; // _CIVtanks;
        };
        case 3:{
            _results = []; // _CIVhelis;
        };
        case 4:{
            _results = []; // _CIVplanes;
        };
        case 5:{
            _results = []; // _CIVships;
        };
        case 6:{
            _results = [missionNamespace getVariable ["Pie_ZeusMis_SelectedEnemyInf", []]];
        };
        case 7:{
            _results = [[]]; // _CIVdivers;
        };
    };

    _results;
};
*/