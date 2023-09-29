[] spawn {
	_dmpCore = allMissionObjects "dmp_Core" select 0;
	_dmpBlacklists = allMissionObjects "dmp_Blacklist";

	_aoCenter = getPos _dmpCore;
	_aoRadius = ["aoSize", _dmpCore getVariable ["dmpradius", 6500]] call BIS_fnc_getParamValue;
	_dmpCore setVariable ["dmpradius", _aoRadius, true];

	// Get the blacklisted towns
	_blacklistedTowns = [];
	{
		_blacklistedTowns insert [-1, nearestLocations [position _x, ["NameCity", "NameCityCapital", "NameVillage"], _x getVariable "dmpradius"], true];
	} forEach _dmpBlacklists;

	_aoTowns = (nearestLocations [_aoCenter, ["NameCity", "NameCityCapital"], _aoRadius] call BIS_fnc_arrayShuffle) - _blacklistedTowns;

	_ambushTown = _aoTowns select 0;
	_startTown = _aoTowns select (_aoTowns findIf { _x distance _ambushTown > 1000 });
	_endTown = _aoTowns select (_aoTowns findIf { _x distance _ambushTown > 1000 && _x distance _startTown > 1000 });

	(createMarker [text _ambushTown, position _ambushTown]) setMarkerType "mil_circle"; 
	(createMarker [text _startTown, position _startTown]) setMarkerType "mil_start"; 
	(createMarker [text _endTown, position _endTown]) setMarkerType "mil_end"; 

	waitUntil{missionNamespace getVariable ["Pie_DynFac_Ready", false]};
	dmpWaitForGo = false;

	// Create the convoy units
	_grp = createGroup resistance;
	_convVics = [];
	_convUnits = [];
	{
		_roadSeg = ([locationPosition _startTown, 500] call BIS_fnc_nearestRoad);
		_pos = (getPos _roadSeg);

		if(count _convVics == 0) then
		{
			// Clear the town location of buildings
			{ _x hideObjectGlobal true } foreach (nearestTerrainObjects [_pos, [], 75]);
		}
		else
		{
			_roadSeg = ([(_convVics select 0) getRelPos [(10 * _forEachIndex), 180], 100] call BIS_fnc_nearestRoad);
			_pos = (getPos _roadSeg);
		};


		_vic = (createVehicle [_x select 0, _pos, [], 0, "NONE"]);
		_vic setDir ((getRoadInfo _roadSeg select 6) getDir (getRoadInfo _roadSeg select 7));
		_x deleteAt 0;

		{
			_unit = _grp createUnit [_x, _pos, [], 0, "NONE"];
			_unit moveInAny _vic;

			if(_x == ((missionNamespace getVariable "Pie_DynFac_SelectedFaction") get "HVTClass")) then
			{
				removeAllWeapons _unit;
			};

			_convUnits pushBack _unit;
		} forEach(_x);

		_convVics pushBack _vic;
		sleep 1;
	} forEach ((missionNamespace getVariable "Pie_DynFac_SelectedFaction") get "ConvoyUnits");

	// Set the waypoint for the convoy
	_ambushWP = (group driver (_convVics select 0)) addWaypoint [getPosASL ([locationPosition _ambushTown, 500] call BIS_fnc_nearestRoad), -1];
	_ambushWP setWaypointCompletionRadius 30;
	_endWP = (group driver (_convVics select 0)) addWaypoint [getPosASL ([locationPosition _endTown, 500] call BIS_fnc_nearestRoad), -1];
	_endWP setWaypointCompletionRadius 30;

	// Occupy some towns around the map.
	_occupiedTownsGroup = createGroup sideLogic;
	Pie_Mis_OccupiedTownModules = [];
	{
		// Need to be added to a global list to be initalised properly
		if((random 1) > 0.5 || _x in [_startTown, _endTown]) then
		{
			"DMP_OccupiedTown" createUnit [
				position _x,
				_occupiedTownsGroup,
				"this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; this setVariable ['dmpOccupiedTownFaction', 'Resistance', true]; Pie_Mis_OccupiedTownModules pushBack this;"
			];
		};
	} forEach _aoTowns;

	// Force the modules to init
	Pie_Mis_OccupiedTownModules call BIS_fnc_initModules;

	// Create the convoy logic
	logicCenter_01 = createCenter sideLogic;
	logicGroup_01 = createGroup logicCenter_01;
	Convoy_01 = logicGroup_01 createUnit ["Logic", [0,0,0], [], 0, "NONE"];
	Convoy_01 setVariable ["maxSpeed", 40];
	Convoy_01 setVariable ["convSeparation", 35];
	Convoy_01 setVariable ["stiffnessCoeff", 0.2];
	Convoy_01 setVariable ["dampingCoeff", 0.6];
	Convoy_01 setVariable ["curvatureCoeff", 0.3];
	Convoy_01 setVariable ["stiffnessLinkCoeff", 0.1];
	Convoy_01 setVariable ["pathFrequecy", 0.05];
	Convoy_01 setVariable ["speedFrequecy", 0.2];
	Convoy_01 setVariable ["speedModeConv", "NORMAL"];
	Convoy_01 setVariable ["behaviourConv", "pushThroughContact"];
	Convoy_01 setVariable ["debug", false];

	call{ 0 = [Convoy_01, _convVics] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf" };

	// Setup QRF
	[_convUnits] spawn {
		params ["_convUnits"];
		
		_callerUnit = objNull;

		while { isNull _callerUnit } do {
			
			/*
			{
				_currUnit = _x;
				_knownPlayer = 

				if(allPlayers findIf { _currUnit knowsAbout _x >= 1.5 } != -1) then
				{
					_callerUnit = _currUnit;
					break;
				}
			} forEach _convUnits;
			*/
			
			sleep 1;
		};

		[(missionNamespace getVariable "Pie_DynFac_SelectedFaction") get "QRF", position _callerUnit, []] execVM "globalScripts\Pie_Helper_QRF.sqf";
	}
};