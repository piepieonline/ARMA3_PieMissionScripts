private ["_object_with_searchlight","_obiect_search","_veh_turr_end"];

if (!isServer) exitWith {};

_object_with_searchlight = _this select 0;

if (!isNil{_object_with_searchlight getVariable "activ"}) exitWith {};
_object_with_searchlight setVariable ["activ",true,true];

if (_object_with_searchlight isKindOf "air") then {
	_object_with_searchlight setVariable ["search_lit_ON",true,true];
	_object_with_searchlight addAction ["Toggle Search Light","globalScripts\_ThirdParty\AL_searchlight\turn_on_off_sl_heli.sqf","",0,false,true,"","",15,false];
	[[_object_with_searchlight],"globalScripts\_ThirdParty\AL_searchlight\al_search_effect_heli.sqf"] remoteExec ["execVM",0,true];
} else {
	_object_with_searchlight addAction ["Toggle Search Light","globalScripts\_ThirdParty\AL_searchlight\turn_on_off_sl.sqf","",0,false,true,"","",2,false];
	[[_object_with_searchlight],"globalScripts\_ThirdParty\AL_searchlight\al_search_light_effect.sqf"] remoteExec ["execVM",0,true];
};