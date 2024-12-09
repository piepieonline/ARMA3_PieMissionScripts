Pie_fnc_ZeusTemplate_SelectLocationOnMap = {
    _maxTownsSelected = _this param [0, -1];

    openMap [true, false];
    
    onMapSingleClick {
        _towns = missionNamespace getVariable ["Pie_ZeusTemplate_Towns", []];
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

        missionNamespace setVariable ["Pie_ZeusTemplate_Towns", _towns, true];

        [] call Pie_fnc_ZeusTemplate_RedrawMarkers;

        true;
    };
};

Pie_fnc_ZeusTemplate_RedrawMarkers = {
    _towns = missionNamespace getVariable ["Pie_ZeusTemplate_Towns", []];
    _markers = missionNamespace getVariable ["Pie_ZeusTemplate_Markers", []];

    {
        deleteMarker _x;
    } forEach _markers;

    {
        _markerName = format ["Pie_ZeusTemplate_%1", _forEachIndex];
        _dotmarkerstr = createMarker [_markerName, [(getPos _x select 0) - 35, (getPos _x select 1)]];

        if(_forEachIndex == 0 || _forEachIndex == (count _towns) - 1) then
        {
            // _dotmarkerstr setMarkerType (if(_forEachIndex == 0) then { "hd_start" } else { "hd_end" });
            _dotmarkerstr setMarkerType "hd_objective";
        }
        else
        {
            _dotmarkerstr setMarkerType "hd_objective";
            // _dotmarkerstr setMarkerText str (_forEachIndex);
        };
        
        _markers pushBack _markerName;
    } forEach _towns;

    missionNamespace setVariable ["Pie_ZeusTemplate_Markers", _markers, true];
};