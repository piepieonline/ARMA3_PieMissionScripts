[false] execVM "globalScripts\Pie_RespawnHelper.sqf";

_action = ["SpawnAmmo", "Spawn Resupply Box", "", {
	_newBox = createVehicle ["Box_NATO_Equip_F", getPos resupplySpawnPos];
	clearItemCargoGlobal _newBox;
	{
		_newBox addItemCargo [_x select 0, _x select 1];
	} forEach (getItemCargo resupplyAmmo);
}, { true } ] call ace_interact_menu_fnc_createAction;
[resupplySpawner, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

vicVic addEventHandler ["Explosion", { 
	[vicVic] execVM "globalScripts\Missions\HeliCrashRescue\Pie_HeliCrashOnExplosionEvent.sqf";
}];

if(isServer) then
{
	if (difficultyOption "mapContent" != 0) then
	{
		hint "Wrong difficulty, turn off map markers!";
	};

	(leader vicVicSquad) setCaptive true;

	_enemyUnits = [
		[100, false, "UK3CB_CHD_O_SL", "UK3CB_CHD_O_MD", "UK3CB_CHD_O_MG", "UK3CB_CHD_O_RIF_1", "UK3CB_CHD_O_RIF_3", "UK3CB_CHD_O_LAT"],
		[100, false, "UK3CB_CHD_O_SL", "UK3CB_CHD_O_MD", "UK3CB_CHD_O_MG", "UK3CB_CHD_O_RIF_1", "UK3CB_CHD_O_RIF_3", "UK3CB_CHD_O_LAT"],
		[100, false, "UK3CB_CHD_O_SL", "UK3CB_CHD_O_MD", "UK3CB_CHD_O_MG", "UK3CB_CHD_O_RIF_1", "UK3CB_CHD_O_RIF_3", "UK3CB_CHD_O_LAT"],
		[100, true, "UK3CB_CHD_O_SL", "UK3CB_CHD_O_MD", "UK3CB_CHD_O_MG", "UK3CB_CHD_O_RIF_1", "UK3CB_CHD_O_RIF_3", "UK3CB_CHD_O_LAT"],
		[100, true, "UK3CB_CHD_O_SL", "UK3CB_CHD_O_MD", "UK3CB_CHD_O_MG", "UK3CB_CHD_O_RIF_1", "UK3CB_CHD_O_RIF_3", "UK3CB_CHD_O_LAT"],
		[100, true, "UK3CB_CHD_O_SL", "UK3CB_CHD_O_MD", "UK3CB_CHD_O_MG", "UK3CB_CHD_O_RIF_1", "UK3CB_CHD_O_RIF_3", "UK3CB_CHD_O_LAT"],
		[100, true, "UK3CB_CHD_O_SL", "UK3CB_CHD_O_MD", "UK3CB_CHD_O_MG", "UK3CB_CHD_O_RIF_1", "UK3CB_CHD_O_RIF_3", "UK3CB_CHD_O_LAT"]
	];

	_enemyVics = [
		[50, "UK3CB_CHD_W_O_MTLB_PKT", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW"],
		[50, "UK3CB_CHD_O_BRDM2", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW"],
		[50, "UK3CB_CHD_O_Hilux_M2", "UK3CB_CHD_O_RIF_2", "UK3CB_CHD_O_RIF_2"],
		[50, "UK3CB_CHD_O_UAZ_MG", "UK3CB_CHD_O_RIF_2", "UK3CB_CHD_O_RIF_2"]
	];

	_enemyAAVics = [
		[100, "UK3CB_CHD_O_MTLB_ZU23", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW"],
		[100, "UK3CB_CHD_O_ZU23", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW"],
		[100, "UK3CB_CHD_O_ZU23", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW"],
		[100, "UK3CB_CHD_O_ZU23", "UK3CB_CHD_O_CREW", "UK3CB_CHD_O_CREW"]
	];

	_townsToOccupy = 3;

	// Doesn't work on Altis...
	// _nearbyLocations = nearestLocations [[worldSize / 2, worldsize / 2, 0], ["FlatAreaCity", "FlatAreaCitySmall"], worldsize];
	// _nearbyLocations = nearestLocations [[worldSize / 2, worldsize / 2, 0], ["FlatArea", "FlatAreaCity", "FlatAreaCitySmall"], worldsize];
	_nearbyLocations = nearestLocations [[worldSize / 2, worldsize / 2, 0], ["NameCity", "NameCityCapital", "NameVillage"], worldsize];
	_randomLocation = (getPos selectRandom (nearestTerrainObjects [getPos selectRandom _nearbyLocations, ["ROAD", "MAIN ROAD", "TRACK"], 500])) findEmptyPosition [0, 100, _enemyAAVics select 0 select 1];

	_spawnHeight = 100;
	_offsetDistance = 750;
	_offsetAngle = random 360;
	_oppOffsetAngle = (_offsetAngle + 180) % 360;

	vicVic setDir _offsetAngle;
	vicVic setPosATL [(_randomLocation select 0) + ((cos _offsetAngle) * _offsetDistance), (_randomLocation select 1) + (sin _offsetAngle * _offsetDistance), _spawnHeight];

	_vicHoldWP = vicVicSquad addWaypoint [getPos vicVic, -1];
	_vicHoldWP setWaypointType "HOLD";

	_vicMoveWP = vicVicSquad addWaypoint [[(_randomLocation select 0) + (cos _oppOffsetAngle * _offsetDistance), (_randomLocation select 1) + (sin _oppOffsetAngle * _offsetDistance), _spawnHeight], -1];

	_murderVicLocation = [_randomLocation select 0, _randomLocation select 1, 2]; 

	_murderVicConfig = _enemyAAVics deleteAt 0;
	_murderVicConfig deleteAt 0;
	_murderVicSquad = createGroup east;
	_murderVic = (_murderVicConfig deleteAt 0) createVehicle _murderVicLocation;

	{
		_unit = _murderVicSquad createUnit [_x, _murderVicLocation, [], 0, "NONE"];
		_unit moveInAny _murderVic;
		_unit unassignItem "ItemMap"; 
		_unit removeItem "ItemMap";
	} forEach _murderVicConfig;

	_murderVic setFuel 0;
	missionNamespace setVariable ["murderVicSquad", _murderVicSquad, true];

	// Populate the town
	_townNumber = 0;
	_nearbyTowns = nearestLocations [_murderVicLocation, ["Name", "NameCity", "NameCityCapital", "NameVillage"], worldsize];

	{
		_groupNumber = 0;
		_infSpawnLocations = nearestTerrainObjects [getPos _x, ["BUILDING", "HOUSE", "CHAPEL", "CHURCH", "HOSPITAL", "FUELSTATION"], 500];
		{
			if ((_x select 0) >= random 100) then
			{
				_garrison = _x select 1;

				_newGroup = createGroup east;
				_spawnPosInf = getPos (selectRandom _infSpawnLocations);

				{
					_unit = _newGroup createUnit [_x, _spawnPosInf, [], 0, "NONE"];
					_unit unassignItem "ItemMap"; 
					_unit removeItem "ItemMap";
				} forEach (_x select [2]);

				if(_garrison) then
				{
					[_newGroup] call lambs_wp_fnc_taskGarrison;
				}
				else
				{
					_wp = nil;

					{
						_wp = _newGroup addWaypoint [[(_spawnPosInf select 0) + (cos _x * 80), (_spawnPosInf select 1) + (sin _x * 80), 0], -1];
						_wp setWaypointBehaviour "SAFE";
					} forEach [0, 90, 180, 270];

					_wp setWaypointType "CYCLE";
				};

				if (_townNumber == 0 && _groupNumber == 0) then
				{
					missionNamespace setVariable ["enemyCrashInvestigateSquad", _newGroup, true];
				};
			};
			_groupNumber = _groupNumber + 1;
		} forEach _enemyUnits;

		if (_townNumber > 0) then
		{
			_vicToSpawn = _enemyAAVics deleteAt 0;
			if ((_vicToSpawn deleteAt 0) >= random 100) then
			{
				_newGroup = createGroup east;
				_spawnPosAA = getPos(selectRandom (nearestTerrainObjects [getPos(_x), ["ROAD", "MAIN ROAD", "TRACK"], 150, false, true]));

				_newVic = (_vicToSpawn deleteAt 0) createVehicle _spawnPosAA;

				{
					_unit = _newGroup createUnit [_x, _spawnPosAA, [], 0, "NONE"];
					_unit unassignItem "ItemMap";
					_unit removeItem "ItemMap";
					_unit moveInAny _newVic;
				} forEach _vicToSpawn;
			};
		};

		_townNumber = _townNumber + 1;

		if(_townNumber > _townsToOccupy) then
		{
			break;
		}
	} forEach _nearbyTowns;


	// Populate the town with a few vics
	_vicSpawnLocations = nearestTerrainObjects [_murderVicLocation, ["ROAD", "MAIN ROAD", "TRACK"], 500, false, true];
	{
		if ((_x deleteAt 0) >= random 100) then
		{
			_newGroup = createGroup east;
			_spawnPosVic = getPos (selectRandom _vicSpawnLocations);

			_newVic = (_x deleteAt 0) createVehicle _spawnPosVic;

			{
				_unit = _newGroup createUnit [_x, _spawnPosVic, [], 0, "NONE"];
				_unit unassignItem "ItemMap";
				_unit removeItem "ItemMap";
				_unit moveInAny _newVic;
			} forEach _x;
		};
	} forEach _enemyVics;

	// Murder vic and squad heli are holding - set combat mode and skip first waypoint to start
	// Done in a trigger
};