Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "globalScripts\_ThirdParty\Zen_OccupyHouse.sqf";

// TODO: Extract location not moving properly potentially
// TODO: Will fail to generate if it doesn't find multiple pieces of road, instead of a dead end

if (!isServer) then
{
	0 spawn    
	{
		waitUntil{"respawn" in allMapMarkers}; 
		waitUntil { alive player };
		// [(str formationPosition player)] remoteExec ["systemChat"];
		// [(str getMarkerPos ["respawn"])] remoteExec ["systemChat"];

		// not working
		/*
		private _formationPos = formationPosition player;
		_formationPos set [2, 0];
		player setPosATL _formationPos;
		*/
		player setPosATL (getMarkerPos ["respawn"]);
	};
}
else
{
	// Param 0, var unit of convoy, not array of all
	_convoyGroup = _this param [0, objNull];
	// Param 1, var of base template (playerBaseSetup)
	_baseTemplate = _this param [1, objNull];
	// Param 2 (optional), classname of base markers
	_baseSpawnClassNames = _this param [2, "c_man_p_beggar_f"];

	_convoy = [_convoyGroup, true] call BIS_fnc_groupVehicles;

	_dmpCore = allMissionObjects "dmp_Core" select 0;
	_dmpDefend = allMissionObjects "dmp_Defend" select 0;
	_dmpTalk = allMissionObjects "dmp_MissionTalk" select 0;
	_blacklists = allMissionObjects "dmp_Blacklist";

	_debug = (_dmpCore getVariable "dmpdebugmode") == "TRUE";

	_distanceFromTowns = 400;
	_distanceToOthersForSingleCompound = 125;
	_distanceToRoad = 50;
	_minCountForCompound = 3;
	_minBuildingPos = 3;

	// Find a remote compound for the AO to spawn at
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

	_townPositions = [];
	_validCompounds = [];

	// Find populated positions
	{ 
		_town = _x;

		_townPositions pushBack (position _town);
	} forEach nearestLocations [_aoCenter, ["NameCity", "NameCityCapital", "NameLocal", "NameMarine", "NameVillage"], _aoRadius];

	// Find enterable houses that aren't close to towns
	{
		_house = _x;
		_housePosition = position _house;

		_validRemoteCompound = true;
		{
			_townPosition = _x;
			if (_townPosition distance _housePosition < _distanceFromTowns) then
			{
				_validRemoteCompound = false;
				break;
			};
		} forEach _townPositions;

		// Exclude blacklist areas
		{
			_distance = (getPos _x) distance (getPos _house);
			_maxDistance = _x getVariable "dmpradius";

			if(_distance < _maxDistance) then
			{
				_validRemoteCompound = false;
				break;
			};
		} forEach _blacklists;


		if(_validRemoteCompound) then
		{
			// Not already tracked
			if ((_validCompounds findIf {(_x distance _housePosition < _distanceToOthersForSingleCompound)}) != -1) then
			{
				continue;
			};

			// Close enough to a road (not end, middle piece)
			if(count (_housePosition nearRoads _distanceToRoad) < 2) then
			{
				continue;
			};

			// TODO: Check spots in buildings that we found as part of this compound

			_validCompounds pushBack _house;
		};
	} forEach nearestTerrainObjects [_aoCenter, ["House"], _aoRadius, false];

	// Debug markers for possible spawns
	if(_debug) then
	{
		{
			(createMarker [str _x, position _x]) setMarkerType "mil_circle";
		} forEach _validCompounds;
	};

	// Find a compound that has at least x enterable buildings
	_suitableBuildings = [];
	{
		_compound = _x;
		_suitableBuildings = [];
		{
			if(count (_x buildingPos -1) > _minBuildingPos) then
			{
				_suitableBuildings pushBack _x;
			};
		} forEach nearestTerrainObjects[_compound, ["House"], _distanceToOthersForSingleCompound, false];

		if(count _suitableBuildings > _minCountForCompound) then
		{
			break;
		}
		else
		{
			// Skipped compounds
			if(_debug) then
			{
				(createMarker [str _x, position _x]) setMarkerType "mil_destroy";
			};
		};
	} forEach (_validCompounds call BIS_fnc_arrayShuffle);

	// From our compound, select a random building
	_building = _suitableBuildings call BIS_fnc_arrayShuffle select 0;
	_road = objNull;

	{
		if(count roadsConnectedTo _x > 1) then
		{
			_road = _x;
			break;
		}
	} forEach (position _building nearRoads _distanceToRoad) call BIS_fnc_arrayShuffle select 0;

	if(_debug) then
	{
		(createMarker [str _building, position _building]) setMarkerType "mil_pickup";
	};

	// Setup the player spawn
	// Get the possible positions, select the closest to the objective
	_spawnPoints = nearestObjects [position _dmpDefend, [_baseSpawnClassNames], 20000, true];
	_selectedSpawnPoint = _spawnPoints select 0;

	// Move everything
	{
		_offset = _baseTemplate worldToModel position _x;
		_offsetRot = getDir _x; 
		_newPos = _selectedSpawnPoint modelToWorld [(_offset select 0), (_offset select 1), 0];
		_x setPosATL _newPos;
		_x setDir ((getDir _selectedSpawnPoint) + _offsetRot);
	} forEach (synchronizedObjects _baseTemplate);

	createMarker ["respawn", position _selectedSpawnPoint];

	// Delete marker objects
	{
		deleteVehicle _x;
	} forEach _spawnPoints;

	// Setup the mission content
	// All units, seperated per vehicle
	_convoyUnits = [];
	// All units that are out of the vehicles
	_convoyUnitsExceptGunners = [];

	// Move things to the selected location
	(_convoy select 0) setPos position _road;
	(_convoy select 0) setDir (_road getDir (roadsConnectedTo _road select 0));
	_dmpDefend setPos position _road;
	_dmpTalk setPos position _building;


	{
		_vic = _x;

		if(_forEachIndex > 0) then
		{
			_leadVic = _convoy select 0;
			// private _formationPos = formationPosition driver _vic;
			// _formationPos set [2, 0];
			// _vic setPosATL _formationPos;
			_vic setPosATL (_leadVic getRelPos [15 * _forEachIndex, 180]);
			_vic setDir getDir _leadVic;
		};

		// Lock the vic, keep the gunner in, but disable
		_vic allowCrewInImmobile true;
		_vic lockDriver true;
		_vic SetHitPointDamage ["hitengine", 1];
		_vic SetHitPointDamage ["hit_engine", 1];

		// Disable damage until players are leaving for vics
		_vic allowDamage false;

		_convoyUnits pushBack [];
		{
			_crewMember = (_x select 0);
			(_convoyUnits select -1) pushBack _crewMember;
			// Crew setup
			// Disable damage until players arrive for crew
			_crewMember allowDamage false;

			// Give crew unlimited ammo
			_crewMember addEventHandler ["Reloaded",{
				_unit = _this select 0 ;
				_mag = _this select 4 select 0 ;
				_unit addMagazine _mag ;
			}] ;

			// If the crew isn't on the gun, move them out to a building
			if (_x select 1 != "gunner") then
			{
				moveOut (_x select 0);
				[_x select 0] allowGetIn false;
				_convoyUnitsExceptGunners pushBack (_x select 0);
			};
		} forEach fullCrew _vic;
	} forEach _convoy;

	// Occupy the building
	_missedUnits = [position _building, _convoyUnitsExceptGunners, -1] call Zen_OccupyHouse;

	// Try to find another building for any leftovers
	if(count _missedUnits > 0) then
	{
		_missedUnits = [position _building, _missedUnits, 30] call Zen_OccupyHouse;
	};

	_wasTalkDone = false;

	missionNamespace setVariable ["PIE_TalkDone", false];
	// Create a trigger to progress the mission
	addMissionEventHandler ["EachFrame", {
		_convoy = _thisArgs select 0;
		_convoyUnits = _thisArgs select 1; 
		_dmpDefend = _thisArgs select 2;

		_talkDone = "talkDone" in dmpGoCodes;
		if(_talkDone) then
		{
			if(!(missionNamespace getVariable "PIE_TalkDoneTrigger")) then
			{
				missionNamespace setVariable ["PIE_TalkDoneTrigger", true];
			};
		};

		if(missionNamespace getVariable "PIE_TalkDoneTrigger") then
		{
			{
				_vicCrew = _x;
				{
					_x allowDamage true;
				} forEach _x;
			} forEach _convoyUnits;
		};

		_canAllMove = true;
		{
			if (!canMove _x) then
			{
				_canAllMove = false;
				break;
			};
		} forEach (_thisArgs select 0);

		if (_canAllMove && _talkDone) then
		{
			// Objective complete, move the AI back to where they should be
			removeMissionEventHandler ["EachFrame", _thisEventHandler];

			// End the DMP objective
			_dmpDefend setVariable["dmpDefendKills", (_dmpDefend getVariable "dmpdefendkilltarget") + 1, TRUE];

			_playerGroup = group ((call BIS_fnc_listPlayers) select 0);
			_convoyGroup = _playerGroup; // group (_convoyUnits select 0 select 0);

			// Move the units back into their vics. Cheat, because they don't want to walk
			{
				_vic = _convoy select _forEachIndex;
				_vicCrew = _x;

				_vic lockDriver false;
				_vic setUnloadInCombat [false, false];
				_vic allowDamage true;
				_vicCrew allowGetIn true;
				_vicCrew joinSilent _playerGroup;

				{
					_x moveInAny _vic;
					_x forceSpeed -1;
				} forEach _vicCrew;

				
			} forEach _convoyUnits;

			// Assign the units to the player group, so they follow them home
			_convoyGroup setFormation "FILE";
			_convoyGroup setCombatMode "YELLOW";
		};
	}, [_convoy, _convoyUnits, _dmpDefend]];

	// Check for something breaking in generation
	if((_convoy select 0) distance [0, 0] < 5) then
	{
		hint "MISSION FAILED TO GENERATE. Restart required";
	};
};