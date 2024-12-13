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

	[(_towns apply { [_x, getPos _x] })] call Pie_fnc_OccupyTowns;
}