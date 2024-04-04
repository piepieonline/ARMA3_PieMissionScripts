// by ALIAS
// Searchlight DEMO
// Tutorial: https://www.youtube.com/user/aliascartoons

private ["_unghi_vert","_search_light_0","_search_light_31","_search_light_32","_poz_0","_poz_31","_poz_32","_pos_search_end","_poz_abs","_poz_rel","_unghi_search","_unghi_car","_poz_lit","_dir_gun","_flash_light","_veh_armed","_veh_turr_beg","_veh_turr_end","_search_light_1","_search_light_2","_search_light_3","_search_light_4","_search_light_5","_search_light_6","_search_light_7","_search_light_8","_search_light_9","_search_light_91","_search_light_92","_search_light_end","_poz_1","_poz_2","_poz_3","_poz_4","_poz_5","_poz_6","_poz_7","_poz_8","_poz_9","_poz_91","_poz_92","_poz_end"];

if (!hasInterface) exitWith {};

_veh_armed = _this select 0;
_obiect_comp = _this select 1;

_veh_turr_beg = getText (configfile >> "CfgVehicles" >> (typeOf _veh_armed) >> "Turrets" >> "MainTurret" >> "gunBeg");
_veh_turr_end = getText (configfile >> "CfgVehicles" >> (typeOf _veh_armed) >> "Turrets" >> "MainTurret" >> "gunEnd");

while {alive _veh_armed} do 
{
	_veh_armed setVariable ["search_lit_ON",true,true];
	_obiect_lit = createSimpleObject ["Sign_Sphere10cm_F", [0,0,0]]; _obiect_lit setObjectTextureGlobal [0,"#(argb,8,8,3)color(0,0,0,0,ca)"]; _obiect_lit attachTo [_veh_armed, [0,0,-0.2], _veh_turr_end];
	
	if(isNil "_obiect_comp") then
	{
		_obiect_comp = createSimpleObject ["A3\data_f\VolumeLight_searchLight.p3d",[0,0,0]];
		_obiect_comp hideObjectGlobal true;
		// _obiect_comp attachTo [_obiect_lit, [0,-2,0]];
	};

	_obiect_comp attachTo [_obiect_lit, [0,-2,0]];
	_obiect_dec = createVehicle ["Land_FloodLight_F", getpos _veh_armed, [], 0, "CAN_COLLIDE"]; _obiect_dec disableCollisionWith _veh_armed;
	_obiect_dec attachTo [_veh_armed, [0,0,-0.2],_veh_turr_end];
	
	_search_light_1 = "#lightpoint" createVehicle position _obiect_comp;  
	_search_light_1 setLightAmbient [.9,.8,.5];  
	_search_light_1 setLightColor [.9,.8,.5];
	_search_light_1 setLightIntensity 1000;
	_search_light_1 setLightUseFlare true;
	_search_light_1 setLightFlareSize 0;
	_search_light_1 setLightFlareMaxDistance 2000;
	_search_light_1 setLightAttenuation [2000,60,1,200,0.5,2.5]; 
	_search_light_1 setLightDayLight true;	
	_search_light_1 attachTo [_obiect_comp,[0,-1.5,0]];
	
	_search_light_2 = "#lightpoint" createVehicle position _obiect_comp;  
	_search_light_2 setLightAmbient [.9,.8,.5];  
	_search_light_2 setLightColor [.9,.8,.5];
	_search_light_2 setLightIntensity 1000;
	_search_light_2 setLightUseFlare true;
	_search_light_2 setLightFlareSize 0;
	_search_light_2 setLightFlareMaxDistance 2000;
	_search_light_2 setLightAttenuation [2000,60,1,200,0.5,2.5]; 
	_search_light_2 setLightDayLight true;	
	_search_light_2 attachTo [_obiect_comp,[0,-3,0]];

	_search_light_3 = "#lightpoint" createVehicle position _veh_armed;  
	_search_light_3 setLightAmbient [.9,.8,.5];  
	_search_light_3 setLightColor [.9,.8,.5];
	_search_light_3 setLightIntensity 1000;
	_search_light_3 setLightUseFlare true;
	_search_light_3 setLightFlareSize 0;
	_search_light_3 setLightFlareMaxDistance 2000;
	_search_light_3 setLightAttenuation [2000,60,1,200,1,4]; 
	_search_light_3 setLightDayLight true;	
	_search_light_3 attachTo [_obiect_comp,[0,-6,0]];
	
	_search_light_4 = "#lightpoint" createVehicle position _veh_armed;  
	_search_light_4 setLightAmbient [.9,.8,.5];  
	_search_light_4 setLightColor [.9,.8,.5];
	_search_light_4 setLightIntensity 1000;
	_search_light_4 setLightUseFlare true;
	_search_light_4 setLightFlareSize 0;
	_search_light_4 setLightFlareMaxDistance 2000;
	_search_light_4 setLightAttenuation [2000,60,1,200,1,6]; 
	_search_light_4 setLightDayLight true;	
	_search_light_4 attachTo [_obiect_comp,[0,-12,0]];
	
	_search_light_5 = "#lightpoint" createVehicle position _veh_armed;  
	_search_light_5 setLightAmbient [.9,.8,.5];  
	_search_light_5 setLightColor [.9,.8,.5];
	_search_light_5 setLightIntensity 1000;
	_search_light_5 setLightUseFlare true;
	_search_light_5 setLightFlareSize 0;
	_search_light_5 setLightFlareMaxDistance 2000;
	_search_light_5 setLightAttenuation [2000,60,1,200,1.5,8]; 
	_search_light_5 setLightDayLight true;	
	_search_light_5 attachTo [_obiect_comp,[0,-20,0]];	

	_search_light_6 = "#lightpoint" createVehicle position _veh_armed;  
	_search_light_6 setLightAmbient [.9,.8,.5];  
	_search_light_6 setLightColor [.9,.8,.5];
	_search_light_6 setLightIntensity 1000;
	_search_light_6 setLightUseFlare true;
	_search_light_6 setLightFlareSize 0;
	_search_light_6 setLightFlareMaxDistance 2000;
	_search_light_6 setLightAttenuation [2000,60,1,200,1.5,10]; 
	_search_light_6 setLightDayLight true;	
	_search_light_6 attachTo [_obiect_comp,[0,-31,0]];
	
	_search_light_7 = "#lightpoint" createVehicle position _veh_armed;  
	_search_light_7 setLightAmbient [.9,.8,.5];  
	_search_light_7 setLightColor [.9,.8,.5];
	_search_light_7 setLightIntensity 1000;
	_search_light_7 setLightUseFlare true;
	_search_light_7 setLightFlareSize 0;
	_search_light_7 setLightFlareMaxDistance 2000;
	_search_light_7 setLightAttenuation [2000,60,1,200,2,12]; 
	_search_light_7 setLightDayLight true;	
	_search_light_7 attachTo [_obiect_comp,[0,-45,0]];
	
	_search_light_8 = "#lightpoint" createVehicle position _veh_armed;  
	_search_light_8 setLightAmbient [.9,.8,.5];  
	_search_light_8 setLightColor [.9,.8,.5];
	_search_light_8 setLightIntensity 1000;
	_search_light_8 setLightUseFlare true;
	_search_light_8 setLightFlareSize 0;
	_search_light_8 setLightFlareMaxDistance 2000;
	_search_light_8 setLightAttenuation [2000,60,1,200,2,15]; 
	_search_light_8 setLightDayLight true;	
	_search_light_8 attachTo [_obiect_comp,[0,-62,0]];
	
	_obiect_lit setVectorDirAndUp [(_veh_armed selectionPosition _veh_turr_beg) vectorFromTo (_veh_armed selectionPosition _veh_turr_end),[0,0,1]];
//	_obiect_comp hideObjectGlobal false;
	
	while {(alive _veh_armed)and(_veh_armed getVariable "search_lit_ON")} do 
	{
		_dir_gun = [_veh_armed selectionPosition _veh_turr_beg,_veh_armed selectionPosition _veh_turr_end] call BIS_fnc_vectorFromXToY;
		_obiect_lit setVectorDirAndUp [_dir_gun,[0,0,1]];
		_unghi_gun = (_dir_gun select 0) atan2 (_dir_gun select 1);
		_obiect_dec setDir _unghi_gun+90;
	 	sleep 0.005;
	};
	deleteVehicle _obiect_lit;
//	deleteVehicle _obiect_comp;
	deleteVehicle _search_light_1;
	deleteVehicle _search_light_2;
	deleteVehicle _search_light_3;
	deleteVehicle _search_light_4;
	deleteVehicle _search_light_5;
	deleteVehicle _search_light_6;
	deleteVehicle _search_light_7;
	deleteVehicle _search_light_8;
	waitUntil {sleep 0.5;(_veh_armed getVariable "search_lit_ON")};
};
_veh_armed setVariable ["search_lit_ON",false,true];