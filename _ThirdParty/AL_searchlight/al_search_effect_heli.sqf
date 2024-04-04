// by ALIAS
// Searchlight DEMO
// Tutorial: https://www.youtube.com/user/aliascartoons

private ["_ob_source_search","_coord_search_lit","_color_source_search","_bri_source_search","_lightjos","_coord_x","_coord_y","_coord_z"];

if (!hasInterface) exitWith {};

_ob_source_search = _this select 0;

while {alive _ob_source_search} do 
{
_lightjos = "#lightpoint" createVehicle position _ob_source_search;  
_lightjos setLightAmbient [.9,.8,.5];  
_lightjos setLightColor [.9,.8,.5];
_lightjos setLightIntensity 1000;
_lightjos setLightUseFlare true;
_lightjos setLightFlareSize 0;
_lightjos setLightFlareMaxDistance 2000;
_lightjos setLightAttenuation [2000,50,1,200,40,80]; 
_lightjos setLightDayLight true;
_lightjos attachTo [_ob_source_search, [0,150,-100]];

	while {(alive _ob_source_search)and(_ob_source_search getVariable "search_lit_ON")} do 
	{
		_coord_z = getPosATL _ob_source_search select 2;
		_lightjos lightAttachObject [_ob_source_search,[0,150,-_coord_z+5]];
		sleep 1;
	};
	deleteVehicle _lightjos;
waitUntil {sleep 0.5;(_ob_source_search getVariable "search_lit_ON")};
};