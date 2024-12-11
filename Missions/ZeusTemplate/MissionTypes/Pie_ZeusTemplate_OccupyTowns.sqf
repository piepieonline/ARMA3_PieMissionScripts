/*
	Zeus Template: Occupy Towns
		No objectives, base mission for a zeus to work from
		Fills the selected towns with enemies
		Civilians can be added separately
		Requires Zeus to place down the units and vehicles that the enemy faction should use  
*/

Pie_fnc_ZeusTemplate_StartOccupyTowns = {
    _callingPlayerOwner = _this param [0, 0];

    _towns = missionNamespace getVariable ["Pie_ZeusTemplate_Towns", []];

    {
		[_x, getPos _x] call Pie_fnc_OccupyTown;
    } forEach _towns;

	// Create the AO marker (TODO: One marker covering everything)
	{
		_markerstr = createMarker [("aoTown_" + text _x), position _x];
		_markerstr setMarkerShape "ELLIPSE";
		_markerstr setMarkerSize [500, 500];
		_markerstr setMarkerColor "ColorRed";
		_markerstr setMarkerAlpha 0.5;
		_markerstr setMarkerBrush "BDiagonal";
	} forEach _towns;
}