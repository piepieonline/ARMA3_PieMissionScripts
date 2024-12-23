/*
Helper script to spawn a cache in a random building position, within a given radius

Usage:
	Pie_Helper_SpawnCache = compileFinal preprocessFileLineNumbers "globalScripts\Pie_Helper_SpawnCache.sqf";
	[position, radius, class] call Pie_Helper_SpawnCache;
*/

// Ensure DMP functions are ready, as we use some of them
_dmpHandle = [] execVM "globalScripts\_ThirdParty\Pie_DMP_FunctionDefs.sqf";
waitUntil { scriptDone _dmpHandle };

_pos = _this param [0, [0, 0, 0]];
_radius = _this param [1, 250];
_class = _this param [2, "Box_FIA_Ammo_F"];
_doSpawn = _this param [3, true];

_buildings = [_pos, _radius] call DMP_fnc_GetOpenBuildings;
{ 
	_positions = _x call DMP_fnc_BuildingPositionsInside;
	if ((count _positions)<1) then
	{
		_buildings=_buildings-[_x]
	}
} forEach _buildings;

if ((count _buildings)>0) then 
{
	_building=selectRandom _buildings;
	_positions=_building call DMP_fnc_BuildingPositionsInside;
	if ((count _positions)>0) then
	{
		_pos=selectRandom _positions
	};
};

_result = _pos;

if(_doSpawn) then
{
	_objCacheObject = _class createVehicle _pos;
	_pos = [_pos, _class] call DMP_fnc_LootPos;
	_objCacheObject setPos _pos;
	_objCacheObject setDir(random 360);
	_result = _objCacheObject;
};

_result