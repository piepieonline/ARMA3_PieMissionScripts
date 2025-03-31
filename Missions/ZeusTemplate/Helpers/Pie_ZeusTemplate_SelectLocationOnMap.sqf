Pie_fnc_ZeusTemplate_SelectLocationOnMap = {
    _maxTownsSelected = _this param [0, -1];
    _labelControl = _this param [1, objNull];
    _isAmbientTown = _this param [2, false];

    _storeInVariable = if (_isAmbientTown) then { "AmbientTowns" } else { "Towns" };

    openMap [true, false];
    [] call Pie_fnc_ZeusTemplate_RedrawMarkers;

    hint "Click on a location to include it, shift click to remove it";

    [_maxTownsSelected, _labelControl, _storeInVariable] onMapSingleClick {
        params ["_maxTownsSelected", "_labelControl", "_storeInVariable"];
        _missionVariable = format ["Pie_ZeusTemplate_%1" + _storeInVariable];
        _towns = missionNamespace getVariable [_missionVariable, []];
        // _pos, _shift, _alt

        _newTown = (nearestLocations [_pos, ["NameCity", "NameCityCapital", "NameLocal", "NameMarine", "NameVillage"], worldSize]) select 0;

        _townCount = count _towns;

        // Shift deletes
        _townIndex = _towns find _newTown;
        if(_shift) then
        {
            if(_townIndex >= 0) then {
                _towns deleteAt _townIndex;
            };
        }
        else
        {
            if(_townIndex == -1) then {
                if(_maxTownsSelected >= 0 && count _towns == _maxTownsSelected - 1) then {
                    _towns deleteAt 0;
                };
                _towns pushBack _newTown;
            };
        };

        missionNamespace setVariable [_missionVariable, _towns, true];

        if(!isNull _labelControl) then
        {
            _labelControl ctrlSetText ([_storeInVariable] call Pie_fnc_ZeusTemplate_CreateTownLabel);
        };

        [] call Pie_fnc_ZeusTemplate_RedrawMarkers;

        true;
    };

    [] spawn
    {
        sleep 0.5;
        waitUntil { !visibleMap };
        onMapSingleClick "";
    };
};

Pie_fnc_ZeusTemplate_RedrawMarkers = {
    _markers = missionNamespace getVariable ["Pie_ZeusTemplate_TownMarkers", []];

    {
        deleteMarker _x;
    } forEach _markers;

    {
        _townType = _x;
        {
            _markerName = format ["Pie_ZeusTemplate_%1_%2", _townType, _forEachIndex];
            _dotmarkerstr = createMarker [_markerName, [(getPos _x select 0) - 35, (getPos _x select 1)]];

            if(_townType == "Towns") then
            {
                _dotmarkerstr setMarkerType "hd_objective";
            }
            else
            {
                _dotmarkerstr setMarkerType "hd_warning";
            };
            
            _markers pushBack _markerName;
        } forEach (missionNamespace getVariable [("Pie_ZeusTemplate_" + _x), []]);
    } forEach ["Towns", "AmbientTowns"];
    

    missionNamespace setVariable ["Pie_ZeusTemplate_TownMarkers", _markers, true];
};

Pie_fnc_ZeusTemplate_ClearTownMarkers = {
    _markers = missionNamespace getVariable ["Pie_ZeusTemplate_TownMarkers", []];

    {
        deleteMarker _x;
    } forEach _markers;
};

Pie_fnc_ZeusTemplate_CreateTownLabel = {
    params ["_townType"];

    _towns = missionNamespace getVariable [(format ["Pie_ZeusTemplate_%1", _townType]), []];
    _result = "None";
    if(count _towns != 0) then
    {
        _result = format ["%1", _towns apply { text _x } joinString ", "];
    };

    _result
}