if(isServer) then
{
	[] spawn {
		while { true } do
		{
			{
				if(vehicle leader _x != leader _x) then
				{
					_vic = vehicle leader _x;
					_driver = driver _vic;
					_gunner = gunner _vic;

					_alreadyReacting = _vic getVariable ["Pie_GunnerReplacement_IsReacting", false];

					if(!_alreadyReacting) then
					{
						_unconscious = _gunner getVariable ["ACE_isUnconscious", false];
						if(!alive _gunner || _unconscious) then
						{
							[_vic, _driver, _gunner] call Pie_fnc_DriverReactToLostGunner;
						};
					};
				};
			} forEach allGroups;
			sleep 1;
		};
	};
};

Pie_fnc_DriverReactToLostGunner = {
	params ["_vic", "_driver", "_gunner"];
	if(isServer) then
	{
		[_vic, _driver, _gunner] spawn {
			params ["_vic", "_driver", "_gunner"];

			_vic setVariable ["Pie_GunnerReplacement_IsReacting", true];
			_vic setVariable ["Pie_GunnerReplacement_GunnerClass", typeOf _gunner];
			_vic setVariable ["Pie_GunnerReplacement_LastPosition", position _vic];

			if(random 1 > 0.5) then
			{
				[_vic, _driver, _gunner] call Pie_fnc_DriverReactToLostGunner_DriveAway;
			}
			else
			{
				[_vic, _driver, _gunner] call Pie_fnc_DriverReactToLostGunner_Swap;
			};
		}
	};
};

Pie_fnc_DriverReactToLostGunner_Swap = {
	params ["_vic", "_driver", "_gunner"];

	if(isServer) then
	{
		sleep (random [2, 6, 4]);
		moveOut _driver;
		_driver moveInGunner _vic;
		_vic setVariable ["Pie_GunnerReplacement_IsReacting", false];
	};
};

Pie_fnc_DriverReactToLostGunner_DriveAway = {
	params ["_vic", "_driver", "_gunner"];

	if(isServer) then
	{
		_group = group _driver;

		_group deleteGroupWhenEmpty true;
		_newGroup = createGroup side _driver;

		units _group joinSilent _newGroup;

		_group = _newGroup;

		sleep 2;

		_runawayLocation = _vic getRelPos [2000, 180];
		{
			if((getPos _vic) distance _x > 600) then
			{
				_runawayLocation = getPosASL ([locationPosition _x, 500] call BIS_fnc_nearestRoad);
				break;
			};
		} forEach nearestLocations [position _vic, ["NameCity", "NameCityCapital", "NameVillage"], 2500];

		_moveAwayWP = _group addWaypoint [_runawayLocation, -1];
		_moveAwayWP setWaypointSpeed "FULL";
		_moveAwayWP setWaypointBehaviour "CARELESS";
		_moveAwayWP setWaypointCompletionRadius 20;
		_moveAwayWP setWaypointStatements ["true", "[group this] call Pie_fnc_DriverReactToLostGunner_SpawnNewGunner"];
	};
};

Pie_fnc_DriverReactToLostGunner_SpawnNewGunner = {
	params ["_group"];
	
	if(isServer) then
	{
		_vic = vehicle leader _group;
		_replacementClass = _vic getVariable ["Pie_GunnerReplacement_GunnerClass", ""];

		_newGunner = _group createUnit [_replacementClass, position player, [], 0, "NONE"];
		_newGunner moveInGunner _vic;

		_moveWP = _group addWaypoint [_vic getVariable ["Pie_GunnerReplacement_LastPosition", [0, 0, 0]], 0];
		_moveWP setWaypointSpeed "FULL";
		_moveWP setWaypointBehaviour "SAFE";
		_moveWP setWaypointCompletionRadius 20;

		_vic setVariable ["Pie_GunnerReplacement_IsReacting", false];
	};
};