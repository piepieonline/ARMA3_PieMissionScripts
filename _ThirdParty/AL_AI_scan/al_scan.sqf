// nul = [this,100,3,"scan_1",true] execvm "globalScripts\_ThirdParty\AL_AI_scan\al_scan.sqf";

private ["_vik","_ai_scan","_alt","_ini_dir","_ini_poz","_alt","_rnd_fct","_delay","_v_chek","_fire_y","_v_chk"];
sleep 10;
if (!isServer) exitwith {};

_vik	= _this select 0;
_alt 	= _this select 1;
_delay	= _this select 2;
_v_chk	= _this select 3;
_fire_y = _this select 4;

_ai_scan = gunner _vik;
_v_chek = missionNamespace getVariable [_v_chk, true];

if (!isNil{_vik getVariable "activ"}) exitWith {};
_vik setVariable ["activ",true,true];

if (_delay < 1) exitWith {"I recommend using a higher delay than 1 sec"};

_ini_dir = getdir _ai_scan;
_ini_poz = getposASL _ai_scan;

if (_alt>0) then {_rnd_fct = 50} else {_rnd_fct=0};
if (_fire_y) then {_tur_lans = (_vik weaponsTurret [0] select 0);[_vik,_tur_lans,_v_chk] execvm "globalScripts\_ThirdParty\AL_AI_scan\start_fire.sqf"};

_obiect_comp = createSimpleObject ["A3\data_f\VolumeLight_searchLight.p3d",[0,0,0]];
_obiect_comp hideObjectGlobal true; 

[[_vik,_obiect_comp],"globalScripts\_ThirdParty\AL_searchlight\al_search_light_effect.sqf"] remoteExec ["execvm",0,true];
_obiect_comp hideObjectGlobal false;

while {alive _ai_scan} do 
{
	_v_chek = missionNamespace getVariable [_v_chk, true];
	if (!_v_chek) then {_ai_scan enableAI "move";_ai_scan enableAI "target";_ai_scan enableAI "autotarget"; while {!_v_chek} do {sleep 5; _v_chek = missionNamespace getVariable _v_chk};};
	waitUntil {sleep 5; _v_chek};
	_angle = [(random 30),(random 30)*(-1)]call BIS_fnc_selectRandom;
	_watchpos = _ini_poz getPos [20+(random 100),_ini_dir+_angle];
	_watchpos = [_watchpos select 0, _watchpos select 1, (_watchpos select 2) + _alt + (random _rnd_fct)];
	_ai_scan dowatch _watchpos;
	_ai_scan disableai "move";
	_ai_scan disableai "target";
	_ai_scan disableai "autotarget";	
	sleep _delay + (random 3);
};
deleteVehicle _obiect_comp;
_ai_scan enableAI "move";
_ai_scan enableAI "target";
_ai_scan enableAI "autotarget";