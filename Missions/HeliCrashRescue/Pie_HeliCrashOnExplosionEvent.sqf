params ["_vehicle"];

if (!(_vehicle getVariable ["wasHit", false])) then
{
	_vehicle setVariable ["wasHit", true, true];
	(driver _vehicle) setCaptive true;
	(missionNamespace getVariable "murderVicSquad") setCombatMode "BLUE";
	[_vehicle] spawn {
		params ["_vehicle"];

		_fullDamageComponents = ["HitVRotor", "HitEngine", "HitEngine1", "HitEngine2"];
		_halfDamageComponents = ["HitHull", "HitGlass1", "HitGlass2", "HitGlass3", "HitGlass4", "HitGlass5", "HitGlass6", "HitGlass7", "HitLGlass", "HitRGlass"];

		// systemChat "hit heli";
		// Kill copilot, start the crash
		_vehicle setFuel 0;
		heliCopilot setDamage 1;
		
		// Sleep long enough to absorb further impacts
		sleep 2;
		
		_vehicle allowDamage true;
		sleep 0.1;

		{
			_vehicle setHitPointDamage [_x, 1];
		} forEach _fullDamageComponents;
		

		{
			_vehicle setHitPointDamage [_x, 0.5];
		} forEach _halfDamageComponents;

		_vehicle allowDamage false;

		// Wait for the vehicle to hit the ground
		while {!isTouchingGround _vehicle} do 
		{
			sleep 0.1;
		};
		
		_crashPos = getPos _vehicle;
		
		// systemChat "helicrash";

		// Kill the pilot, move out players, destroy the vehicle
		(driver _vehicle) setDamage 1;

		sleep 3;

		_vehicle allowDamage true;

		sleep 0.1;

		_vehicle setVehicleLock "UNLOCKED";
		{ 
			moveOut _x;
		} forEach (crew _vehicle select { alive _x });

		sleep 5;

		_vehicle setDamage 1;

		sleep 5;

		{
			_x allowDamage true;
		} forEach (units playerSquad);

		sleep 5;

		{
			_x setDamage 0;
		} forEach (units playerSquad);

		_dir = round ((((leader rescueGroup) getDir (leader playerSquad)) / 45) % 8);

		_dirName = switch (_dir) do
		{
			case 0: { "north" };
			case 1: { "north-east" };
			case 2: { "east" };
			case 3: { "south-east" };
			case 4: { "south" };
			case 5: { "south-west" };
			case 6: { "west" };
			case 7: { "north-west" };
		};

		[[west, "Base"], "Priority update: The recon team helicopter has gone down " + _dirName + " of here - find them and extract!"] remoteExec ["commandChat", [rescueGroup]];
		sleep 20;

		_enemyCrashInvestigateSquad = missionNamespace getVariable "enemyCrashInvestigateSquad";
		_crashInvestigateWP = _enemyCrashInvestigateSquad addWaypoint [_crashPos, -1];
		_crashInvestigateWP setWaypointBehaviour "COMBAT";
		_enemyCrashInvestigateSquad setCurrentWaypoint ((waypoints _enemyCrashInvestigateSquad) select -1);

		sleep 100;

		(missionNamespace getVariable "murderVicSquad") setCombatMode "RED";
	};
};