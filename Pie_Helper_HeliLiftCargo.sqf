/*
Helper script to get a helicopter to lift a piece of cargo. If a helicopter is not passed in, a default can be set on the mission level. Or a random one will be chosen if avaliable.

Usage:
	Mission default helicoper, otherwise any helicopter that can:
		[targetObject] execVM "globalScripts\Pie_Helper_HeliLiftCargo.sqf";
	Specific helicoper:
		[targetObject, specificHeli] execVM "globalScripts\Pie_Helper_HeliLiftCargo.sqf";

To choose a specific helicopter to act by default:
	`missionNamespace setVariable ["Pie_Mis_HeliLiftCargo_HeliVic", this];`
*/

_itemToLift = _this param [0, objNull];
_heliToUse = _this param [1, objNull];

if(isNull _heliToUse) then
{
	_heliToUse = missionNamespace getVariable ["Pie_Mis_HeliLiftCargo_HeliVic", objNull];

	if(isNull _heliToUse) then
	{
		{
			if(vehicle _x canSlingLoad _itemToLift) then
			{
				_heliToUse = vehicle _x;
				break;
			}
		} forEach units side player;
	}
};

if(isNull _heliToUse || isNull _itemToLift) exitWith
{
	['Heli Lift failed'] remoteExec ['systemChat'];
};

if(_heliToUse canSlingLoad _itemToLift) then
{
	[driver _heliToUse, 'Cargo lift on the way'] remoteExec ['sideChat'];
	_grp = group driver _heliToUse;

	_liftWP = _grp addWaypoint [position _itemToLift, 0];
	_liftWP waypointAttachVehicle _itemToLift;
	_liftWP setWaypointType "HOOK";

	_dropWP = _grp addWaypoint [_heliToUse getRelPos [20, 0], 0];
	_dropWP setWaypointType "UNHOOK";
	_dropWP setWaypointStatements ["true", "vehicle leader this land 'LAND'"];
}
else
{
	[driver _heliToUse, 'Negative on cargo lift!'] remoteExec ['sideChat'];
};

