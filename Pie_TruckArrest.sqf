_susTrucks = _this param [0, objNull];
_decoyTrucks = _this param [1, []];

// Finding random places to move to
Pie_fnc_GetNextRoadPosATL = {
	_pos = ([[[(getMarkerPos "aoMarker"), (getMarkerSize "aoMarker" select 0)]], [], { isOnRoad _this }] call BIS_fnc_randomPos);
	_pos set [2, 2];
	_pos
};

// Setup truck actions
{
	_truck = _x;

	_truck setVariable ["Pie_stopped", false, true];
	_truck setVariable ["Pie_searched", false, true];

	[
		_truck, ["Halt!", {
			_truck = _this select 0;
			_truck setVariable ["Pie_stopped", true, true];
			[_truck, 0] remoteExec ["limitSpeed"];
			[_truck, 0] remoteExec ["forceSpeed"];
		},
		nil, 1.5, true, true, "", "[_target, _this] call Pie_fnc_CondHaltAllowed", 20]
	] remoteExec ["addAction"];

	[
		_truck, ["Mark searched", {
			_truck = _this select 0;
			{
				[_x, false] remoteExec ["hideObject"];
			} forEach (synchronizedObjects _truck);
			_truck setVariable ["Pie_searched", true, true];
		},
		nil, 1.5, true, true, "", "_target call Pie_fnc_CondSearchAllowed", 7]
	] remoteExec ["addAction"];

	[
		_truck, ["Free to go", {
			_truck = _this select 0;
			_truck setVariable ["Pie_stopped", false, true];
			[_truck, -1] remoteExec ["limitSpeed"];
			[_truck, -1] remoteExec ["forceSpeed"];
		},
		nil, 1.5, true, true, "", "[_target, _this] call Pie_fnc_CondGoAllowed", 10]
	] remoteExec ["addAction"];


	_truckBackflaps = [];
	{
		[_x, _truck] call BIS_fnc_attachToRelative;

		// Hide things that need to be hidden by default
		if(_x getVariable ["shouldHide", false]) then
		{
			[_x, true] remoteExec ["hideObject"];
		};

		// Add the backflaps action and array
		if(_x getVariable ["isBackflap", false]) then
		{
			_truckBackflaps pushBack _x;
			[
				_x, ["Unzip", {
					_truck = (_this select 3) select 0;
					_flaps = _truck getVariable ["backflaps", []];
					
					{
						[_x, true] remoteExec ["hideObject"];
					} forEach _flaps;
				},
				[_truck], 1.5, true, true, ""]
			] remoteExec ["addAction"];
		};
	} forEach synchronizedObjects _truck;	

	_truck setVariable ["backflaps", _truckBackflaps, true];
} forEach _susTrucks;

// Decoy trucks act the same
{
	_truck = _x;
	_driverGroup = group driver _truck;	
	// Give each truck a random waypoint
	_wpt = (group driver _truck) addWaypoint [[] call Pie_fnc_GetNextRoadPosATL, 0];
	_wpt setWaypointCompletionRadius 50;

	// Random waypoints each time one is complete
	_driverGroup addEventHandler ["WaypointComplete", {
		params ["_group", "_waypointIndex"];
		_wpt = _group addWaypoint [[] call Pie_fnc_GetNextRoadPosATL, 0];
		_wpt setWaypointCompletionRadius 50;
	}];

	_driverGroup setBehaviourStrong "CARELESS";
} forEach (_susTrucks + _decoyTrucks);

// Failure state
(_susTrucks select 0) addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	[getPos _unit, 4500, 200] call rhs_fnc_ss21_nuke;
}];

// Speed controls for trucks
[(_susTrucks + _decoyTrucks)] spawn {
	_hasStopped = false;
	_trucks = _this select 0;
	while { true } do 
	{
		{
			_truck = _x;

			if(_truck getVariable "Pie_stopped") then
			{
				continue;
			};

			_minDistSqr = 10000;

			{
				_minDistSqr = _minDistSqr min (_truck distanceSqr _x);
			} forEach allPlayers;
			
			switch (true) do
			{
				case (_minDistSqr < 200): {
					// systemChat str _truck;
					// systemChat "setting stage 2";
					_truck limitSpeed 10;
				};
				case (_minDistSqr < 1000): {
					// systemChat str _truck;
					// systemChat "setting stage 1";
					_truck limitSpeed 25;
				};
				default {
					// systemChat str _truck;
					// systemChat "releasing";
					_truck limitSpeed -1;
				}
			};
		} forEach (_trucks);
		sleep 0.25;
	}; 
};

// Delete any bots that are too far from players (ambient spawner)
// Only start once DMP has recorded troop types
[] spawn {
	waitUntil{!(isNil"dmpReady")};
	waitUntil{dmpReady};
	sleep 10;
	while { true } do 
	{
		{
			_leader = leader _x;
			if (vehicle _leader == _leader) then
			{
				if(_leader getVariable["dmpAItype", ""] == "SuicideBomber") then
				{
					continue;
				};

				_minDistSqr = 2000000;
				{
					_minDistSqr = _minDistSqr min (_leader distanceSqr _x);
				} forEach allPlayers;

				// 800^2
				if(_minDistSqr > 640000) then
				{
					{
						deleteVehicle _x;
					} forEach units _x;
					deleteGroup _x;
				};
			};
		} forEach (groups resistance);
		sleep 5;
	}; 
};
