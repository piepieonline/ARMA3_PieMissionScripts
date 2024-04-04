

_veh_armed	= _this select 0;
_operator	= _this select 1;

if (_operator != gunner _veh_armed) exitwith {};
[_veh_armed,["click_sl",10]] remoteExec ["say3d"];
if (_veh_armed getVariable "search_lit_ON") then {_veh_armed setVariable ["search_lit_ON",false,true]} else {_veh_armed setVariable ["search_lit_ON",true,true]};