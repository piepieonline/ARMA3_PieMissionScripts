Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "globalScripts\Zen_OccupyHouse.sqf";

/*
Remember to adjust hermes settings, side relations, add hostage
Arsenal box: `["AmmoboxInit",[this,true]] call BIS_fnc_arsenal;`

Needs:
- `hostage` hostage unit
- `garrisonForce` group to put in the building with the hostage
- `wreckToSpawn` wreck object to spawn (pre-attach the crate)
- `wreckGuard` vehicle to spawn protecting the wreck
*/

private ["_hostage", "_garrisonForce", "_wreckToSpawn", "_wreckGuard"];

_hostage = _this param [0, objNull, [], []];
_garrisonForce = _this param [1, objNull, [], []];
_wreckToSpawn = _this param [2, objNull, [], []];
_wreckGuard = _this param [3, objNull, [], []];

_dmpCore = allMissionObjects "dmp_Core" select 0;
_dmpSmallAO = allMissionObjects "dmp_ExtraAO";
_blacklists = allMissionObjects "dmp_Blacklist";
_dmpPopArea = allMissionObjects "DMP_OccupiedArea" select 0;
_dmpTaskRescue = allMissionObjects "DMP_MissionRescue" select 0;

_debug = (_dmpCore getVariable "dmpdebugmode") == "TRUE";

_aoCenter = getPos _dmpCore;
_aoRadius = _dmpCore getVariable "dmpradius";

if(_debug) then
{
	resistance setFriend [west, 1];
	west setFriend [resistance, 1];

	resistance setFriend [east, 1];
	east setFriend [resistance, 1];

	hint "Debug Mode: Enemy non-hostile";
};

_validTowns = [];

// Find valid towns, and the buildings in them
{ 
	_town = _x;

	_validBuildings = [_town];
	{
		if (count (_x buildingPos -1) > count units garrisonForce) then
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
_town = selectRandom _validTowns;
_townPosition = _town select 0;
_town deleteAt 0;

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
	_dmpCore setPos (position _townPosition);
	deleteVehicle _dmpSmallAO;
};

// Select the building
_building = selectRandom _town;

// Populate the building
_missedUnits = [position _building, units garrisonForce] call Zen_OccupyHouse;

// Add the hostage
_hostagePositions = (units garrisonForce) apply { (position _x) distance (position _building), _x };
_hostagePositions sort false;

hostage setPosASL (position (_hostagePositions select 0)); // Eye height ?

if(count _missedUnits > 0) then
{
	hint "Failed to place the hostage!";
};
// hint str _missedUnits;

if(_debug) then
{
	(createMarker ["Objective", position _building]) setMarkerType "mil_objective";
};

// Place the wreck
wreckToSpawn setPos (selectBestPlaces [position _building, 300, "meadow - (100 * waterDepth) - hills", 1, 1] select 0 select 0);

// Place the wreck guard, get extra inf out
wreckGuard setPos (wreckToSpawn getRelPos [random[10, 20, 15], random 360]);

{
	[(_x select 0)] allowGetIn false;
	moveOut (_x select 0);
} forEach fullCrew [wreckGuard, "turret"];
{
	[(_x select 0)] allowGetIn false;
	moveOut (_x select 0);
} forEach fullCrew [wreckGuard, "cargo"];

// Move tasks
_dmpTaskRescue setPos (position _townPosition);
_dmpPopArea setPos (position _townPosition);