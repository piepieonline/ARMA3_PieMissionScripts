_qrfFactionSetupOptions = _this param [0, []];
_respondLocation = _this param [1, []];
_spawnLocationBlacklist = _this param [2, []];
_minRangeToSpawn = _this param [3, 1000];
_maxRangeToSpawn = _this param [4, 3000];

_aoTowns = ((nearestLocations [_respondLocation, ["NameCity", "NameCityCapital"], _maxRangeToSpawn] call BIS_fnc_arrayShuffle) - _townsToIgnore);
_loc = _aoTowns select (_aoTowns findIf { _x distance _respondLocation > _minRangeToSpawn });

_qrfFactionSetup = selectRandom _qrfFactionSetupOptions;

_qrfVicClass = _qrfFactionSetup get "Vehicle";
_qrfCrewClasses = _qrfFactionSetup get "Crew";
_qrfDismountClasses = _qrfFactionSetup get "Dismounts";
_qrfShouldVicAssault = _qrfFactionSetup get "VicShouldAssault";

// Create the QRF vic and units
_crewGrp = createGroup resistance;
_dismountGrp = createGroup resistance;
_roadSeg = ([locationPosition _loc, 500] call BIS_fnc_nearestRoad);
_spawnPos = (getPos _roadSeg);

_vic = objNull;
_isLandVic = !(_qrfVicClass isKindOf "Helicopter");
if(_isLandVic) then
{
	_vic = (createVehicle [_qrfVicClass, _spawnPos, [], 0, "NONE"]);
}
else
{
	_vic = (createVehicle [_qrfVicClass, _spawnPos, [], 0, "FLY"]);
};

_vic setDir ((getRoadInfo _roadSeg select 6) getDir (getRoadInfo _roadSeg select 7));

_crewGrp addVehicle _vic;

{
	_unit = _crewGrp createUnit [_x, _spawnPos, [], 0, "NONE"];

	if(!_isLandVic) then
	{
		_unit moveInAny _vic;
	};
} forEach(_qrfCrewClasses);

if(_isLandVic) then
{
	_getInWP = _crewGrp addWaypoint [getPosASL _vic, -1];
	_getInWP waypointAttachVehicle _vic;
	_getInWP setWaypointType "GETIN";
};

[_dismountGrp, _spawnPos, _vic, _qrfDismountClasses] spawn {
	sleep 20;
	params ["_dismountGrp", "_spawnPos", "_vic", "_qrfDismountClasses"];
	{
		_unit = _dismountGrp createUnit [_x, _spawnPos, [], 0, "NONE"];
		_unit moveInCargo _vic;
	} forEach(_qrfDismountClasses);
};

_crewGrp setBehaviour "CARELESS";
_crewGrp setSpeedMode "FULL";

[_spawnPos, _crewGrp, _dismountGrp, _vic, _respondLocation, _qrfShouldVicAssault, _isLandVic] spawn {
	params ["_spawnPos", "_crewGrp", "_dismountGrp", "_vic", "_respondLocation", "_qrfShouldVicAssault", "_isLandVic"];

	_dropLocation = _respondLocation getPos [100, random 360];

	sleep 10;
	
	if(_isLandVic) then
	{
		_moveWP = _crewGrp addWaypoint [getPosASL ([_dropLocation, 500] call BIS_fnc_nearestRoad), -1];
		_moveWP setWaypointCompletionRadius 100;
	}
	else
	{
		_moveWP = _crewGrp addWaypoint [AGLToASL(_dropLocation), -1];
		_moveWP setWaypointCompletionRadius 100;
	};

	sleep 1;

	_unloadWP = _crewGrp addWaypoint [AGLToASL(_dropLocation), -1];
	_unloadWP setWaypointType "TR UNLOAD";

	_sadWP = _dismountGrp addWaypoint [AGLToASL(_respondLocation), -1];
	_sadWP setWaypointType "SAD";

	waitUntil { count fullCrew _vic == count units _crewGrp };

	if(_qrfShouldVicAssault) then
	{
		_sadCrewWP = _crewGrp addWaypoint [AGLToASL(_respondLocation), -1];
		_sadCrewWP setWaypointType "SAD";
		_sadCrewWP setWaypointBehaviour "AWARE";
	}
	else
	{
		_rtbWP = _crewGrp addWaypoint [AGLToASL(_spawnPos), -1];
	};
};