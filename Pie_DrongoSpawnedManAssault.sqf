private ["_man"];
_man = _this;

private _dmpSpawner = missionNamespace getVariable "Pie_DMPSpawner";
if (isNil "_dmpSpawner") then
{
	_dmpSpawner = allMissionObjects "dmp_AmbientFactionRegional" select 0;
	missionNamespace setVariable ["Pie_DMPSpawner", _dmpSpawner];
};

// Delete anyone too close
if(_man distance _dmpSpawner < 300) then
{
	deleteVehicle _man;
}
else
{
	_spawnedGroup = group _man;

	if(leader _spawnedGroup == _man) then
	{
		_spawnedGroup setVariable["dmpAIcurrent","",TRUE];

		{
			deleteWaypoint _x
		} forEach(waypoints _spawnedGroup);

		if(isNull (assignedVehicle _man)) then
		{
			[_spawnedGroup, 1000, 600, [], position _dmpSpawner, false] spawn lambs_wp_fnc_taskRush;
		}
		else
		{
			{
				if(!(_x moveInAny (assignedVehicle _x))) then
				{
					deleteVehicle _x;
				};
			} forEach units _spawnedGroup;

			_wp = _spawnedGroup addWaypoint [(position _dmpSpawner), 0, -1, "MOVE"];
			_wp setWaypointCombatMode "RED";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "COMBAT";
		};
	};
};
