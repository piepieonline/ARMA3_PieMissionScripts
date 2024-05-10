// Create waypoints:
// MOVE near drop pos with On Activation: `[(vehicle this), 25] call Pie_fnc_Heli_StartFastrope;`
// LIFT CARGO on drop pos
// Any away from drop pos (e.g. loiter)

Pie_fnc_Heli_StartFastrope = {
    params ['_heli', '_dropHeight'];

    if(!isServer) exitWith {};

    private _cargoUnits = fullCrew [_heli, "cargo", false] apply { _x select 0 };

    [_heli, _cargoUnits, _dropHeight] spawn {
        params ['_vic', '_cargoUnits', '_dropHeight'];

        private _driverGroup = group (driver _vic);
        private _cargoGroup = group (_cargoUnits select 0);

        private _tempCargoGroup = createGroup side (_cargoUnits select 0);
        _tempCargoGroup copyWaypoints _cargoGroup;

        private _hookWPIndex = (waypoints _driverGroup) findIf { waypointType _x == "HOOK" };
        private _ropeWPIndex = _hookWPIndex + 1;

        private _wp = (waypoints _driverGroup) select _hookWPIndex;
        
        systemChat "Waiting for pos";

        waitUntil {
            sleep 0.5;
            
            // systemChat format ["%1 distance %2", str _driverGroup, str ((waypointPosition _wp) distance2D _vic)];

            (waypointPosition _wp) distance2D _vic < 10
        };
        
        systemChat "Descending";

        waitUntil 
        {
			sleep 0.1;
			_alive = (alive _vic) and {(canMove _vic)};
			
			if (not _alive) exitWith {true};

            _vic setVelocity [0, 0, -4];	

			(getPosATL _vic select 2 < _dropHeight)
        };

        systemChat "In pos, Starting fastrope func";
        [_vic] call ace_fastroping_fnc_deployAI;

        waitUntil {sleep 1; !((_vic getVariable ["ace_fastroping_deployedRopes", []]) isEqualTo [])};

		waitUntil {
            sleep 1;
            {
                if(vehicle _x == _x) then
                {
                    _x setUnitPos "MIDDLE";
                };
            } forEach _cargoUnits;

            ((_vic getVariable ["ace_fastroping_deployedRopes", []]) isEqualTo [])
        };

		// waitUntil {sleep 1; ((_vic getVariable ["ace_fastroping_deployedRopes", []]) isEqualTo [])};

        _driverGroup setCurrentWaypoint ((waypoints _driverGroup) select _ropeWPIndex);

        systemChat "Roping complete";
        
        // Fastroping changes the group
        _cargoGroup = group (_cargoUnits select 0);
        _cargoGroup copyWaypoints _tempCargoGroup;
        deleteGroup _tempCargoGroup;
    };
};