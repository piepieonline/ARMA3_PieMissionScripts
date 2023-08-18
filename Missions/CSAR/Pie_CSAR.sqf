Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "globalScripts\_ThirdParty\Zen_OccupyHouse.sqf"; 

/*
Remember to adjust hermes settings, side relations, add hostage
Arsenal box: `["AmmoboxInit",[this,true]] call BIS_fnc_arsenal;`

Needs:
- `hostage` hostage unit
- `wreckToSpawn` wreck object to spawn (pre-attach the crate)
*/

private ["_hostage", "_wreckToSpawn"];

_hostage = _this param [0, objNull, [], []];
_wreckToSpawn = _this param [1, objNull, [], []];

[_hostage, _wreckToSpawn] spawn {
	params ["_hostage", "_wreckToSpawn"];

	// Make sure the dynamic faction selection is complete
	waitUntil{missionNamespace getVariable ["Pie_DynFac_Ready", false]};

	_dmpCore = allMissionObjects "dmp_Core" select 0;
	_dmpSmallAO = allMissionObjects "dmp_ExtraAO";
	_blacklists = allMissionObjects "dmp_Blacklist";
	_dmpVirtualFaction = allMissionObjects "DMP_VirtualFaction" select 0;
	_dmpTaskRescue = allMissionObjects "DMP_MissionRescue" select 0;

	_debug = (_dmpCore getVariable "dmpdebugmode") == "TRUE";

	_aoCenter = getPos _dmpCore;
	_aoRadius = _dmpCore getVariable "dmpradius";

	if(_debug && false) then
	{
		resistance setFriend [west, 1];
		west setFriend [resistance, 1];

		resistance setFriend [east, 1];
		east setFriend [resistance, 1];

		west setFriend [east, 1];
		east setFriend [west, 1];

		deleteVehicle _dmpVirtualFaction;

		hint "Debug Mode: Enemy non-hostile";
	};

	_validTowns = [];

	// Find valid towns, and the buildings in them
	{ 
		_town = _x;

		_validBuildings = [_town];
		{
			if (count (_x buildingPos -1) > 3) then
			{
				_validBuildings pushBack _x;
			};
		} forEach nearestTerrainObjects [position _town, ["House"], 200];


		// Exclude blacklist areas
		_isBlacklisted = false;
		{
			_distance = (getPos _x) distance (getPos _town);
			_maxDistance = _x getVariable "dmpradius";

			if(_distance < _maxDistance) then
			{
				_isBlacklisted = true;
				break;
			};
		} forEach _blacklists;

		// At least 2 enterable buildings
		if(count _validBuildings < 2 || _isBlacklisted) then
		{
			continue;
		};

		_validTowns pushBack _validBuildings;

		if(_debug && false) then 
		{
			_marker = createMarker [text _x, position _x]; 
			if (count _validBuildings != 0) then 
			{
				_marker setMarkerType "mil_circle";
			} else {
				_marker setMarkerType "mil_destroy";
			};
		};
	} forEach nearestLocations [_aoCenter, ["NameCity", "NameCityCapital", "NameVillage"], _aoRadius];

	// Select the AO
	_townData = selectRandom _validTowns;
	_town = _townData select 0;
	_townData deleteAt 0;

	// If defined, shrink the AO to the smaller size
	if(count _dmpSmallAO > 0) then
	{
		// Draw the original AO for debugging
		if(_debug) then
		{
			_originalAOMarker = createMarker ["OriginalAOMarker", position _dmpCore]; 
			_originalAOMarker setMarkerShape "ELLIPSE";
			_originalAOMarker setMarkerBrush "Border";
			_originalAOMarker setMarkerSize [(_dmpCore getVariable "dmpradius"), (_dmpCore getVariable "dmpradius")];
			_originalAOMarker setMarkerColor "ColorRed";
			_originalAOMarker setMarkerAlpha 0.5;
		};

		_dmpSmallAO = _dmpSmallAO select 0;
		_dmpCore setVariable ["dmpradius", _dmpSmallAO getVariable "dmpradius"];
		_dmpCore setPos (position _town);
		deleteVehicle _dmpSmallAO;
	};

	// Select the building
	_building = selectRandom _townData;

	// Populate the building
	_garrisonForce = [_aoCenter, resistance, (missionNamespace getVariable "Pie_DynFac_SelectedFaction") get "GarrisonSquadComposition"] call BIS_fnc_spawnGroup;
	_missedUnits = [position _building, units _garrisonForce] call Zen_OccupyHouse;

	// Add the hostage
	_hostagePositions = (units _garrisonForce) apply { (position _x) distance (position _building), _x };
	_hostagePositions sort false;

	_hostage allowDamage false;
	_hostage setPos (position (_hostagePositions select 0)); // Eye height ?
	_hostage allowDamage true;

	if(_hostage distance position _building > 30) then
	{
		hint "Failed to place the hostage!";
		"generationFailure" call BIS_fnc_endMission;
	};

	if(_debug) then
	{
		(createMarker ["Objective", position _building]) setMarkerType "mil_objective";
	};

	// Place the wreck
	_wreckToSpawn setPos (selectBestPlaces [position _building, 300, "meadow - (100 * waterDepth) - hills", 1, 1] select 0 select 0);

	// Place the wreck guard, get extra inf out
	_wreckGuardGroup = createGroup resistance;
	_wreckGuard = createVehicle [
		(missionNamespace getVariable "Pie_DynFac_SelectedFaction") get "WreckGuardVehicle",
		(_wreckToSpawn getRelPos [random[10, 20, 15], random 360]),
		[],
		0,
		"NONE"
	];

	_wreckGuardGroup addVehicle _wreckGuard;

	{
		_unit = _wreckGuardGroup createUnit [_x, position _wreckGuard, [], 0, "NONE"];
		_unit moveInAny _wreckGuard;
	} forEach ((missionNamespace getVariable "Pie_DynFac_SelectedFaction") get "WreckGuardSquadComposition");

	(_wreckGuardGroup addWaypoint [position _wreckGuard, 0]) setWaypointType "GUARD";

	{
		[(_x select 0)] allowGetIn false;
		moveOut (_x select 0);
	} forEach fullCrew [_wreckGuard, "turret"];
	{
		[(_x select 0)] allowGetIn false;
		moveOut (_x select 0);
	} forEach fullCrew [_wreckGuard, "cargo"];

	// Move tasks
	_dmpTaskRescue setPos (position _town);
	
	// Occupy the selected town.
	_occupiedTownsGroup = createGroup sideLogic;
	Pie_Mis_OccupiedTownModules = [];
	// Need to be added to a global list to be initalised properly
	"DMP_OccupiedTown" createUnit [
		position _town,
		_occupiedTownsGroup,
		"this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; this setVariable ['dmpOccupiedTownFaction', 'Resistance', true]; Pie_Mis_OccupiedTownModules pushBack this;"
	];
	// Force the modules to init
	Pie_Mis_OccupiedTownModules call BIS_fnc_initModules;

	// Create intel to help players find the wreck
	_heliIntelLine = format ["%1 of here", ([position _town, getMarkerPos "respawn"] call DMP_fnc_ClosestPosition)];
	_pilotIntelLine = "";

	if((["knownLocation", 1] call BIS_fnc_getParamValue) == 1) then
	{
		_heliIntelLine = format ["%1 of %2", ([position _wreckToSpawn, position _town] call DMP_fnc_ClosestPosition), text _town];
		_pilotIntelLine = format [" and taken somewhere in %1", text _town];

		_markerstr = createMarker [("aoTown"), position _town];
		_markerstr setMarkerShape "ELLIPSE";
		_markerstr setMarkerSize [500, 500];
		_markerstr setMarkerColor "ColorRed";
		_markerstr setMarkerAlpha 0.5;
		_markerstr setMarkerBrush "BDiagonal";
	};

	missionNamespace setVariable ["Pie_Mis_HeliIntelLine", _heliIntelLine, true];
	missionNamespace setVariable ["Pie_Mis_PilotIntelLine", _pilotIntelLine, true];

	{
		player createDiaryRecord ["Diary", ["Situation", format ["A helicopter was lost %1, and radio interceptions confirm a pilot has been captured%2.<br />Destroy the wreck, rescue the pilot, and bring them home.", missionNamespace getVariable "Pie_Mis_HeliIntelLine", missionNamespace getVariable "Pie_Mis_PilotIntelLine"]]];	
	} remoteExec ["call"];
	
	dmpWaitForGo = false;
}
