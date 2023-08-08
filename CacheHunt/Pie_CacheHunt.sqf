Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "globalScripts\Zen_OccupyHouse.sqf";

Pie_Helper_SpawnCache = compileFinal preprocessFileLineNumbers "globalScripts\Pie_Helper_SpawnCache.sqf";

[] spawn {
	_dmpCore = allMissionObjects "dmp_Core" select 0;
	
	_aoCenter = getPos _dmpCore;
	_aoRadius = _dmpCore getVariable "dmpradius";

	// Select a town, a second town, and then the closest town to one of those two towns
	_aoTowns = [selectRandom nearestLocations [_aoCenter, ["NameCity", "NameCityCapital", "NameVillage"], _aoRadius]];
	_aoTowns pushBack ((nearestLocations [_aoCenter, ["NameCity", "NameCityCapital", "NameVillage"], _aoRadius, position (selectRandom _aoTowns)] - _aoTowns) select 0);
	_aoTowns pushBack ((nearestLocations [_aoCenter, ["NameCity", "NameCityCapital", "NameVillage"], _aoRadius, position (selectRandom _aoTowns)] - _aoTowns) select 0);

	{
		_x setPos getPos (_aoTowns select _forEachIndex);
	} forEach allMissionObjects "DMP_OccupiedTown";

	// Before spawning the actual cache, we need DMP to be ready
	waitUntil{!(isNil"dmpReady")};
	waitUntil{dmpReady};

	_selectedTown = selectRandom _aoTowns;
	_cache = [position (_selectedTown)] call Pie_Helper_SpawnCache;

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
	}];

	// Garrison troops around the cache
	_missedUnits = [position _cache, units garrisonForce] call Zen_OccupyHouse;

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
			{
				_minDistSqrCache = _minDistSqrCache min (_cache distanceSqr _x);
				_minDistSqrTown = _minDistSqrTown min ((position _selectedTown) distanceSqr _x);
			} forEach allPlayers;
			
			switch (true) do
			{
				case (_minDistSqrCache < _MaxDistExact): {
					_knowledge setVariable ["dmpKnowledgeSpecial", "a cache " + ([(position _cache), (position _selectedTown)] call DMP_fnc_ClosestPosition) + " of centre of the town"];
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
