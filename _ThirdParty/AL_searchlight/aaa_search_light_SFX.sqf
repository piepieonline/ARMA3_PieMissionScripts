// by ALIAS

private ["_vik_aaa","_gunner_aaa","_rot","_ii","_obiect_lit"];

if (!hasInterface) exitwith {};

_vik_aaa 	= _this select 0;
//_obiect_lit = _this select 1;

_veh_turr_beg = getText (configfile >> "CfgVehicles" >> (typeOf _vik_aaa) >> "Turrets" >> "MainTurret" >> "gunBeg");
_veh_turr_end = getText (configfile >> "CfgVehicles" >> (typeOf _vik_aaa) >> "Turrets" >> "MainTurret" >> "gunEnd");

_obiect_lit = createSimpleObject ["A3\data_f\VolumeLight_searchLight.p3d", [0,0,0]];
_obiect_lit attachTo [_vik_aaa, [0,0,-0.2], _veh_turr_beg];

while {alive _vik_aaa} do 
{
	_obiect_lit setVectorDirAndUp 
	[   
	(_vik_aaa selectionPosition _veh_turr_beg) vectorFromTo (_vik_aaa selectionPosition _veh_turr_end),[0,0,1]
	];
	sleep 0.005;
};

deleteVehicle _obiect_lit;