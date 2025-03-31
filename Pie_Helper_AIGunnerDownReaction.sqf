Pie_fnc_WatchSpecificVehicles = {
	params ["_vicsToWatch", ["_allowDriveAway", true], ["_allowDriverIntoGun", true]];
	if(isServer) then
	{
		[_vicsToWatch, _allowDriveAway, _allowDriverIntoGun] spawn {
			params ["_vicsToWatch", "_allowDriveAway", "_allowDriverIntoGun"];
			{
				_x lock true;
			}
			forEach _vicsToWatch;
			
			while { true } do
			{
				{
					if(alive _x) then 
					{
						_driver = driver _x;
						_gunner = gunner _x;

						_alreadyReacting = _x getVariable ["Pie_GunnerReplacement_IsReacting", false];

						if(!_alreadyReacting) then
						{
							_unconscious = _gunner getVariable ["ACE_isUnconscious", false];
							if(!alive _gunner || _unconscious) then
							{
								[_x, _driver, _gunner, _allowDriveAway, _allowDriverIntoGun] call Pie_fnc_DriverReactToLostGunner;
							};
						};
					};
					sleep 0.1;
				}
				forEach _vicsToWatch;
			};
		};
	};
};

Pie_fnc_WatchAllVehicleGunners = {
	params [["_allowDriveAway", true], ["_allowDriverIntoGun", true]];
	if(isServer) then
	{
		[_allowDriveAway, _allowDriverIntoGun] spawn {
			params ["_allowDriveAway", "_allowDriverIntoGun"];
			_excludedVehicles = missionNamespace getVariable ["Pie_GunnerReplacement_ExcludedVehicles", []];
			while { true } do
			{
				if ((missionNamespace getVariable ["Pie_GunnerReplacement_Paused", false])) then
				{
					sleep 1;
					continue;
				};

				{
					if(vehicle leader _x != leader _x && !(vehicle leader _x in _excludedVehicles)) then
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
								[_vic, _driver, _gunner, _allowDriveAway, _allowDriverIntoGun] call Pie_fnc_DriverReactToLostGunner;
							};
						};
					};
					sleep 0.1;
				} forEach allGroups;
			};
		};
	};
};

Pie_fnc_DriverReactToLostGunner = {
	params ["_vic", "_driver", "_gunner", "_allowDriveAway", "_allowDriverIntoGun"];
	if(isServer) then
	{
		[_vic, _driver, _gunner, _allowDriveAway, _allowDriverIntoGun] spawn {
			params ["_vic", "_driver", "_gunner", "_allowDriveAway", "_allowDriverIntoGun"];

			_vic setVariable ["Pie_GunnerReplacement_IsReacting", true];
			_vic setVariable ["Pie_GunnerReplacement_GunnerClass", typeOf _gunner];
			_vic setVariable ["Pie_GunnerReplacement_LastPosition", position _vic];

			// TODO: Only if the same squad
			private _vicCargo = fullCrew [_vic, "cargo"] + fullCrew [_vic, "turret"];

			if(count _vicCargo > 0) then
			{
				{
					_unitToCheckGun = _x select 0;
					if(alive _unitToCheckGun && (!(_unitToCheckGun getVariable ["ACE_isUnconscious", false]))) then
					{
						[_vic, _unitToCheckGun, _gunner, true] call Pie_fnc_DriverReactToLostGunner_Swap;
						break;
					};
				} forEach _vicCargo;
			}
			else
			{
				if((_allowDriveAway && random 1 > 0.5) || (_allowDriveAway && !_allowDriverIntoGun)) then
				{
					[_vic, _driver, _gunner] call Pie_fnc_DriverReactToLostGunner_DriveAway;
				}
				else
				{
					if(_allowDriverIntoGun) then
					{
						[_vic, _driver, _gunner, false] call Pie_fnc_DriverReactToLostGunner_Swap;
					};
				};
			};
		};
	};
};

Pie_fnc_DriverReactToLostGunner_Swap = {
	params ["_vic", "_aliveUnit", "_deadUnit", "_moveIntoCargo"];

	if(isServer) then
	{
		[_vic, _aliveUnit, _deadUnit, _moveIntoCargo] spawn {
			params ["_vic", "_aliveUnit", "_deadUnit", "_moveIntoCargo"];

			sleep (random [2, 6, 4]);

			moveOut _deadUnit;
			
			waitUntil { (isNull gunner _vic) };

			sleep 0.1;

			// _aliveUnit assignAsGunner _vic;
			moveOut _aliveUnit;
			_aliveUnit moveInGunner _vic;

			waitUntil { !(isNull gunner _vic) };

			_deadUnit moveInCargo _vic;
			_deadUnit moveInAny _vic;

			_vic setVariable ["Pie_GunnerReplacement_IsReacting", false];
		};
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
		[_group] spawn {
			params ["_group"];
			_vic = vehicle leader _group;
			_replacementClass = _vic getVariable ["Pie_GunnerReplacement_GunnerClass", ""];

			private _prevGunnerUnit = gunner _vic;
			
			// If uncon, wait for wake or death
			waitUntil { sleep 5; (!alive _prevGunnerUnit) || (!(_prevGunnerUnit getVariable ["ACE_isUnconscious", true])) };

			// If they woke up, don't sub them out
			// Could in theory have issues if they die on the way back to the fight, but oh well
			if(!alive _prevGunnerUnit) then
			{
				moveOut _prevGunnerUnit;
				_newGunner = _group createUnit [_replacementClass, getPos _vic, [], 0, "NONE"];
				// _newGunner assignAsGunner _vic;
				_newGunner moveInGunner _vic;
			};

			waitUntil { sleep 1; !(isNull gunner _vic) };

			_moveWP = _group addWaypoint [_vic getVariable ["Pie_GunnerReplacement_LastPosition", [0, 0, 0]], 0];
			_moveWP setWaypointSpeed "FULL";
			_moveWP setWaypointBehaviour "SAFE";
			_moveWP setWaypointCompletionRadius 20;

			sleep 10;

			_vic setVariable ["Pie_GunnerReplacement_IsReacting", false];
		};
	};
};