if(isServer) then
{
	params ["_setupLaptop"];
	[
		_setupLaptop, ["Start CQC", {
			[] call Pie_fnc_Shoothouse_StartShoothouseDialog;
		},
		nil, 1.5, true, true, "", "!(missionNamespace getVariable ['Pie_Shoothouse_InProgress', false])", 5]
	] remoteExec ["addAction", 0, true];

	[
		_setupLaptop, ["Join CQC", {
			[player] call Pie_fnc_Shoothouse_JoinShoothouse;
		},
		nil, 1.5, true, true, "", "true", 5]
	] remoteExec ["addAction", 0, true];

	[
		_setupLaptop, ["End CQC", {
			[] call Pie_fnc_Shoothouse_EndShoothouse;
		},
		nil, 1.5, true, true, "", "missionNamespace getVariable ['Pie_Shoothouse_InProgress', false]", 5]
	] remoteExec ["addAction", 0, true];
};

Pie_fnc_Shoothouse_StartShoothouseDialog = {
	_display = createDialog ["RscDisplayEmpty", true];

	_instructionLabel = _display ctrlCreate ["RscText", 101];
	_instructionLabel ctrlSetPosition [0, 0.08, 1, 0.04];
	_instructionLabel ctrlSetText "Select a location and OPFOR faction";
	_instructionLabel ctrlCommit 0;

	// Location dropdown
	_locationDropdown = _display ctrlCreate ["RscCombo", 100];
	_locationDropdown ctrlSetPosition [0, 0.16, 1, 0.04];
	_locationDropdown ctrlCommit 0;

	_locationList = nearestLocations [[worldSize / 2, worldSize / 2], ["NameCity", "NameCityCapital", "NameVillage"], worldSize];
	_locationList sort true;
	missionNamespace setVariable ['Pie_Shoothouse_LocationList', _locationList, true];

	{
		_item = _locationDropdown lbAdd format ["%4 - %1 (%2x%3)", text _x, size _x select 0, size _x select 1, str _forEachIndex];
		_locationDropdown lbSetData [_item, str _forEachIndex];
	} forEach _locationList;

	_locationDropdown ctrlAddEventHandler ["LBSelChanged",
	{
		params ["_control", "_selectedIndex"];
		missionNamespace setVariable ['Pie_Shoothouse_SelectedLocation', (missionNamespace getVariable ['Pie_Shoothouse_LocationList', []]) select _selectedIndex];
	}];

	// Faction dropdown
	_factionDropdown = _display ctrlCreate ["RscCombo", 102];
	_factionDropdown ctrlSetPosition [0, 0.24, 1, 0.04];
	_factionDropdown ctrlCommit 0;

	_factionColours = [
		[1, 0, 0, 1],
		[0, 0, 1, 1],
		[0, 1, 0, 1]
	];

	_factionList = [];
	{
		_displayName = getText (_x >> 'displayName');
		if(_displayName != "" && _displayName != 'Other') then
		{
			_factionList pushBack [_displayName, _x];
		};
	} forEach (configProperties [configFile >> "cfgFactionClasses", "isClass _x && (getNumber (_x >> 'side')) <= 2", true]);

	_factionList sort true;

	{
		_displayName = _x select 0;
		_configEntry = _x select 1;

		if(getNumber (_configEntry >> 'side') == 0) then
		{
			_item = _factionDropdown lbAdd _displayName;
			_factionDropdown lbSetColor [_item, _factionColours select (getNumber (_configEntry >> 'side'))];
			_factionDropdown lbSetData [_item, configName _configEntry];
		};
	} forEach _factionList;

	_factionDropdown ctrlAddEventHandler ["LBSelChanged",
	{
		params ["_control", "_selectedIndex"];
		_selection = _control lbData (lbCurSel _control);

		if(_selection != "") then
		{
			missionNamespace setVariable ["Pie_Shoothouse_SelectedOpfor", _selection, true];
		};
	}];

	// Enemy size dropdown
	_enemySizeDropdown = _display ctrlCreate ["RscCombo", 105];
	_enemySizeDropdown ctrlSetPosition [0, 0.32, 1, 0.04];
	_enemySizeDropdown ctrlCommit 0;

	{
		_item = _enemySizeDropdown lbAdd format ["%1", str _x];
		_enemySizeDropdown lbSetData [_item, str _x];
	} forEach [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20];

	_enemySizeDropdown ctrlAddEventHandler ["LBSelChanged",
	{
		params ["_control", "_selectedIndex"];
		missionNamespace setVariable ['Pie_Shoothouse_NumOpforGroups', parseNumber (_control lbData (lbCurSel _control)), true];
	}];

	_shoothouseStartButton = _display ctrlCreate ["RscButton", 103];
	_shoothouseStartButton ctrlSetPosition [0, 0.5, 0.35, 0.04];
	_shoothouseStartButton ctrlCommit 0;
	_shoothouseStartButton ctrlSetText "Start";
	_shoothouseStartButton ctrlAddEventHandler ["ButtonClick",
	{
		// TODO: Don't work if fields not selected properly
		_selectedLocation = missionNamespace getVariable ["Pie_Shoothouse_SelectedLocation", null];
		_selectedOpfor = missionNamespace getVariable ["Pie_Shoothouse_SelectedOpfor", ""];
		_selectedOpforCount = missionNamespace getVariable ["Pie_Shoothouse_NumOpforGroups", -1];
		if(!(isNull _selectedLocation) &&  _selectedOpfor != "" && _selectedOpforCount > 0) then
		{
			closeDialog 1;
			[
				_selectedLocation,
				_selectedOpfor,
				_selectedOpforCount
			] spawn Pie_fnc_Shoothouse_BuildShoothouse;
		};
	}];

	_factionCloseButton = _display ctrlCreate ["RscButton", 104];
	_factionCloseButton ctrlSetPosition [0.5, 0.5, 0.35, 0.04];
	_factionCloseButton ctrlCommit 0;
	_factionCloseButton ctrlSetText "Close";
	_factionCloseButton ctrlAddEventHandler ["ButtonClick",
	{
		closeDialog 1;
	}];
};

Pie_fnc_Shoothouse_BuildShoothouse = {
	params ["_selectedLocation", "_selectedOpfor", "_opforGroupCount"];
	[format ["Starting CQC at %1 against %3 groups of %2", text _selectedLocation, getText (configFile >> "cfgFactionClasses" >> _selectedOpfor >> "displayName"), str _opforGroupCount]] remoteExec ['systemChat'];

	missionNamespace setVariable ['Pie_Shoothouse_InProgress', true, true];

	_infSpawnLocations = nearestTerrainObjects [getPos _selectedLocation, ["BUILDING", "HOUSE", "HOSPITAL", "FUELSTATION"], (size _selectedLocation select 0) max (size _selectedLocation select 1), false, true];
	_sortedInfSpawnLocations = nearestTerrainObjects [getPos selectRandom _infSpawnLocations, ["BUILDING", "HOUSE", "HOSPITAL", "FUELSTATION"], (size _selectedLocation select 0) max (size _selectedLocation select 1), true, true];

	// Select valid groups to spawn
	_validGroups = [];
	{
		if(count ("true" configClasses _x) > 4) then
		{
			_validGroups pushBack (_x);	
		};
	} forEach ("true" configClasses (configFile >> "cfgGroups" >> "East" >> _selectedOpfor >> "Infantry"));

	// Spawn groups
	_spawnedGroups = 0;
	_spawnedEnemyUnits = [];
	_firstGroupSpawnLocation = getPos (_sortedInfSpawnLocations select 0);
	_numGroups = missionNamespace getVariable ["Pie_Shoothouse_NumOpforGroups", 1];
	while {_spawnedGroups < _numGroups} do {
		// Location to spawn
		_botSpawnLocation = _sortedInfSpawnLocations deleteAt 0;

		// Delete a few more closest, so that there's a little more spacing
		_sortedInfSpawnLocations deleteAt 0;

		if(_numGroups > 2) then {
			_sortedInfSpawnLocations deleteAt 0;
		};

		// Spawn group
		_newGroup = [getPosATL _botSpawnLocation, east, selectRandom _validGroups] call BIS_fnc_spawnGroup;
		_newGroup deleteGroupWhenEmpty true;
		[_newGroup, _newGroup, 50, [], true, false, -2, false] call lambs_wp_fnc_taskGarrison;

		_spawnedEnemyUnits append (units _newGroup);

		_spawnedGroups = _spawnedGroups + 1;
	};

	missionNamespace setVariable ["Pie_Shoothouse_SpawnedEnemyUnits", _spawnedEnemyUnits];

	sleep 0.5;

	// Setup player spawns
	// Spawn a few buildings away
	_playerSpawnLocation = _sortedInfSpawnLocations select 0;
	
	_maxDistance = -1;
	{
		_distance2D = _firstGroupSpawnLocation distance2D (getPos _x);

		if(_distance2D > _maxDistance) then
		{
			_maxDistance = _distance2D;
		};
	} forEach _spawnedEnemyUnits;

	_playerSpawnMoved = false;
	{
		_minDistance = 1000;
		_testingLocation = getPos _x;

		{
			_distance2D = _testingLocation distance2D (getPos _x);

			if(_distance2D < _minDistance) then
			{
				_minDistance = _distance2D;
			};
		} forEach _spawnedEnemyUnits;

		if(_minDistance > 20) then
		{
			_playerSpawnLocation = _x;
			_playerSpawnMoved = true;
			break;
		};
	}
	forEach _sortedInfSpawnLocations;

	_playerSpawnSpots = [_playerSpawnLocation] call BIS_fnc_buildingPositions;;
	if(count _playerSpawnSpots == 0) then
	{
		missionNamespace setVariable ['Pie_Shoothouse_PlayerSpawnLocations', [getPos _playerSpawnLocation], true];
	} else {
		missionNamespace setVariable ['Pie_Shoothouse_PlayerSpawnLocations', _playerSpawnSpots, true];
	};

	// Create the marker
	_areamarkerstr = createMarker ["Pie_Shoothouse_AreaMarker", _firstGroupSpawnLocation];
	_areamarkerstr setMarkerShape "ELLIPSE";
	_areamarkerstr setMarkerSize [_maxDistance * 1.5, _maxDistance * 1.5];
	_areamarkerstr setMarkerAlpha 0.5;
	_areamarkerstr setMarkerColor "ColorRed";
	_areamarkerstr setMarkerBrush "DIAGGRID";

	_dotmarkerstr = createMarker ["Pie_Shoothouse_TextMarker", [_firstGroupSpawnLocation select 0, (_firstGroupSpawnLocation select 1) + (_maxDistance * 1.5), 0]];
	_dotmarkerstr setMarkerType "mil_start";
	_dotmarkerstr setMarkerText "CQC Location";

	// Join pending players
	{
		[_x] call Pie_fnc_Shoothouse_JoinShoothouse;
	} forEach (missionNamespace getVariable ["Pie_Shoothouse_Players", []]);
};

Pie_fnc_Shoothouse_JoinShoothouse = {
	params ["_player"];
	_shoothousePlayers = missionNamespace getVariable ["Pie_Shoothouse_Players", []];
	_shoothousePlayers pushBackUnique _player;
	missionNamespace setVariable ["Pie_Shoothouse_Players", _shoothousePlayers, true];

	if(missionNamespace getVariable ['Pie_Shoothouse_InProgress', false]) then
	{
		[format ["%1 has joined the CQC at %2", name _player, text (missionNamespace getVariable ["Pie_Shoothouse_SelectedLocation", null])]] remoteExec ['systemChat'];
		_player setPos selectRandom (missionNamespace getVariable ['Pie_Shoothouse_PlayerSpawnLocations', []]);
	} else {
		[format ["%1 has joined the pending CQC", name _player]] remoteExec ['systemChat'];
	};
};

Pie_fnc_Shoothouse_EndShoothouse = {
	_unitsAtStart = missionNamespace getVariable ["Pie_Shoothouse_SpawnedEnemyUnits", []];

	_remainingUnits = [];
	{
		if (alive _x) then
		{
			_remainingUnits pushBack _x;
		}
	}
	forEach _unitsAtStart;

	[format ["The CQC at %1 against %2 groups of %3 has ended. %4/%5 units remained.", text (missionNamespace getVariable ["Pie_Shoothouse_SelectedLocation", null]), str (missionNamespace getVariable ["Pie_Shoothouse_NumOpforGroups", -1]), getText (configFile >> "cfgFactionClasses" >> missionNamespace getVariable ["Pie_Shoothouse_SelectedOpfor", ""] >> "displayName"), str count _remainingUnits, str count _unitsAtStart]] remoteExec ['systemChat'];

	{
		deleteVehicle _x;
	}
	forEach _unitsAtStart;

	missionNamespace setVariable ['Pie_Shoothouse_InProgress', false, true];
	missionNamespace setVariable ["Pie_Shoothouse_Players", [], true];
	missionNamespace setVariable ["Pie_Shoothouse_SelectedIndex", -1, true];
	missionNamespace setVariable ["Pie_Shoothouse_SelectedOpfor", "", true];
	missionNamespace setVariable ["Pie_Shoothouse_NumOpforGroups", -1, true];
	missionNamespace setVariable ["Pie_Shoothouse_SpawnedEnemyUnits", [], true];
	deleteMarker "Pie_Shoothouse_AreaMarker";
	deleteMarker "Pie_Shoothouse_TextMarker";
};