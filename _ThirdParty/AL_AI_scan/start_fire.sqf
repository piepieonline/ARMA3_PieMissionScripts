// by ALIAS

private ["_vik","_tur_lans","_v_chk","_v_chek","_burst"];

_vik		= _this select 0;
_tur_lans	= _this select 1;
_v_chk		= _this select 2;

sleep 10;

while {canFire _vik} do 
{
	_v_chek = missionNamespace getVariable _v_chk;
	if (!_v_chek) then {while {!_v_chek} do {sleep 5; _v_chek = missionNamespace getVariable _v_chk}};
	_burst = floor (random 15);
	while {_burst >0} do {_vik fire _tur_lans;_burst = _burst -1;sleep 0.1};
	sleep 1 + (random 5);
	_vik setvehicleammo 1;
};