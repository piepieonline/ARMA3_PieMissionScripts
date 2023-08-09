Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "globalScripts\Zen_OccupyHouse.sqf";

Pie_Helper_SpawnCache = compileFinal preprocessFileLineNumbers "globalScripts\Pie_Helper_SpawnCache.sqf";

[] spawn {
	_dmpCore = allMissionObjects "dmp_Core" select 0;
	_dmpBlacklists = allMissionObjects "dmp_Blacklist";

	_aoCenter = getPos _dmpCore;
	_aoRadius = ["aoSize", 6500] call BIS_fnc_getParamValue;
	_dmpCore setVariable ["dmpradius", _aoRadius, true];

	// Get the blacklisted towns
	_blacklistedTowns = [];
	{
		_blacklistedTowns insert [-1, nearestLocations [position _x, ["NameCity", "NameCityCapital", "NameVillage"], _x getVariable "dmpradius"], true];
	} forEach _dmpBlacklists;

	// Select a town
	_aoTowns = [selectRandom (nearestLocations [_aoCenter, ["NameCity", "NameCityCapital", "NameVillage"], _aoRadius] - _blacklistedTowns)];

	_distractionTownCount = ["possibleExtraTowns", 2] call BIS_fnc_getParamValue;
	if((["spreadSelectedTowns", 0] call BIS_fnc_getParamValue) == 0) then 
	{
		// If we aren't spreading them out, select the closest town to one of the previously selected towns
		for "_i" from 1 to _distractionTownCount do {
			_aoTowns pushBack ((nearestLocations [_aoCenter, ["NameCity", "NameCityCapital", "NameVillage"], _aoRadius, position (selectRandom _aoTowns)] - _aoTowns - _blacklistedTowns) select 0);
		};
	}
	else
	{
		// Otherwise, pick randomly
		for "_i" from 1 to _distractionTownCount do {
			_aoTowns pushBack ((nearestLocations [_aoCenter, ["NameCity", "NameCityCapital", "NameVillage"], _aoRadius] - _aoTowns - _blacklistedTowns) select 0);
		};
	};

	// Occupy the selected towns.
	_occupiedTownsGroup = createGroup sideLogic;
	Pie_Mis_OccupiedTownModules = [];
	{
		// Need to be added to a global list to be initalised properly
		"DMP_OccupiedTown" createUnit [
			position _x,
			_occupiedTownsGroup,
			"this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; this setVariable ['dmpOccupiedTownFaction', 'Resistance', true]; Pie_Mis_OccupiedTownModules pushBack this;"
		];
	} forEach _aoTowns;

	// Force the modules to init
	Pie_Mis_OccupiedTownModules call BIS_fnc_initModules;

	// Before spawning the actual cache, we need DMP to be ready
	waitUntil{!(isNil"dmpReady")};
	waitUntil{dmpReady};

	_selectedTown = selectRandom _aoTowns;
	_cache = [position (_selectedTown), 250, "IG_supplyCrate_F"] call Pie_Helper_SpawnCache;
	[_cache, true, [0, 2, 0], 0, true] call ace_dragging_fnc_setDraggable;
	_cachePosition = position _cache;
	missionNamespace setVariable ["Pie_CachePosition", _cachePosition];

	// Create the AO marker (TODO: One marker covering everything)
	{
		_markerstr = createMarker [("aoTown_" + text _x), position _x];
		_markerstr setMarkerShape "ELLIPSE";
		_markerstr setMarkerSize [500, 500];
		_markerstr setMarkerColor "ColorRed";
		_markerstr setMarkerAlpha 0.5;
		_markerstr setMarkerBrush "BDiagonal";
	} forEach _aoTowns;

	// Create the task, and a trigger to complete it
	_taskTownNameList = (_aoTowns apply { "<marker name='aoTown_" + text _x + "'>" + text _x + "</marker>" }) joinString ", ";
	[true, "PieTask1", ["A cache has been reported somewhere in the vicinty of " + _taskTownNameList, "Find and destroy the insurgent cache"], objNull, "ASSIGNED", -1, true, "Destroy", false] call BIS_fnc_taskCreate;
	_cache addEventHandler ["Killed",{
		["PieTask1", "SUCCEEDED"] call BIS_fnc_taskSetState;
		[true, "PieTask2", ["Mission complete, return to base", "RTB"], getMarkerPos "respawn", "ASSIGNED", -1, true, "GetOut", true] call BIS_fnc_taskCreate;

		{
			if(((leader _x) getvariable ["dmpfaction", ""]) == "ResistanceArmour") then
			{
				_x setVariable["dmpAIcurrent","",TRUE];
				{
					deleteWaypoint _x
				} forEach (waypoints _x);
				_x addWaypoint [missionNamespace getVariable "Pie_CachePosition", -1];
				break;
			};
		} forEach allGroups; 
	}];

	// Garrison troops around the cache
	_missedUnits = [_cachePosition, units garrisonForce] call Zen_OccupyHouse;

	// TODO: Better system than just deleting overflow
	{
		deleteVehicle _x;
	} forEach _missedUnits;

	// Create intel system
	[_aoCenter, _cache, _selectedTown] spawn {
		params ["_aoCenter", "_cache", "_selectedTown"];
		_knowledge = createGroup sideLogic createUnit ["DMP_KnowledgeSpecial", _aoCenter, [], 0, "NONE"];
		_knowledge setVariable ["dmpKnowledgeSpecial", "nothing"];

		_minDistSqrCache = 10000 ^ 2;
		_minDistSqrTown = 10000 ^ 2;

		_MaxDistSomething = 500 ^ 2;
		_MaxDistExact = 100 ^ 2;
		while { true } do 
		{
			if(!alive _cache) then
			{
				_knowledge setVariable ["dmpKnowledgeSpecial", "nothing"];
				break;
			};

			{
				_minDistSqrCache = _minDistSqrCache min (_cache distanceSqr _x);
				_minDistSqrTown = _minDistSqrTown min ((position _selectedTown) distanceSqr _x);
			} forEach allPlayers;
			
			switch (true) do
			{
				case (_minDistSqrCache < _MaxDistExact): {
					_knowledge setVariable ["dmpKnowledgeSpecial", "a cache " + ([_cachePosition, (position _selectedTown)] call DMP_fnc_ClosestPosition) + " of centre of the town"];
				};
				case (_minDistSqrTown < _MaxDistSomething): {
					_knowledge setVariable ["dmpKnowledgeSpecial", "a cache somewhere around"];
				};
				default {
					_knowledge setVariable ["dmpKnowledgeSpecial", "nothing"];
				}
			};

			sleep 1;
		}; 
	} 
}
