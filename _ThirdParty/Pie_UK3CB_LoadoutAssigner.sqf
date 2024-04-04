/*
Author: www.3commandobrigade.com 
Add ACE items to a unit's loadout
Arguments:
0: unit
1: 3cb unit config module 

2: The unit class name to use, instead of 'typeOf _unit';

Return Value:
none
*/

private _unit = _this select 0;
private _logic = _this select 1;
private _unitName = _this select 2;

//diag_log format ["********* %1 %2 %3", _unit, _unitName, _logic];

// Default values
private _perc = 0.75;
private _excluded_items = [];

if !(isNull _logic) then {	

	// Determine loadout percentage
	private _rawPerc = _logic getVariable ["uk3cb_Factions_loadout_quantity", 75];
	if (_rawPerc > 95) then { 
		_perc = 1.0;
	} else { 
		if ( _rawPerc >= 0 ) then {
			_perc = _rawPerc * 0.01;
		};
	};

	// Determine time of mission and whether a night loadout is required
	if (_logic getVariable ["uk3cb_Factions_remove_night_equipment", false]) then {
		private _time = dayTime;
		private _sunriseSunset = date call BIS_fnc_sunriseSunsetTime;
		if ((_time > ((_sunriseSunset select 0)-0.25)) && (_time < ((_sunriseSunset select 1)-3))) then {
			_excluded_items = _excluded_items + getArray (ConfigFile >> "CfgVehicles" >> _unitName >> "UK3CB_loadout_nightTime_items");
		};
		//diag_log format ["***** time %1, sun rise %2, sun set %3", _time, _sunriseSunset select 0, _sunriseSunset select 1];
	};

	// Determine if reduced ACE medical supplies has been selected
	if (_logic getVariable ["uk3cb_Factions_reducedMedicalSupplies", false]) then {
		_excluded_items = _excluded_items + getArray (ConfigFile >> "CfgVehicles" >> _unitName >> "UK3CB_loadout_reduced_medical_items");
	};
	
	// Determine if frags are to be removed
	if (_logic getVariable ["uk3cb_Factions_removeFrags", false]) then {
		_excluded_items = _excluded_items + ["HandGrenade", "1Rnd_HE_Grenade_shell", "rhs_VOG25", "rhs_mag_rgd5"];
	};
	
	// Determine if NVGs are to be removed
	if (_logic getVariable ["uk3cb_Factions_removeNVG", false]) then {
		_excluded_items = _excluded_items + ["UK3CB_BAF_HMNVS", "rhs_1PN138"];
	};
};

// Find variable loadout items
private _variable_items = getArray (ConfigFile >> "CfgVehicles" >> _unitName >> "UK3CB_loadout_variable_items");

//diag_log format ["excluded items %1", _excluded_items];

// Determine whether to use ACE or Vanilla items
private ["_loadout_gear", "_loadout_backpack"];
if (isClass (configFile >> "cfgPatches" >> "ace_medical")) then {
	_loadout_gear = "UK3CB_loadout_ace_gear";
	_loadout_backpack = "UK3CB_loadout_ace_backpack";
} else {
	_loadout_gear = "UK3CB_loadout_vanilla_gear";
	_loadout_backpack = "UK3CB_loadout_vanilla_backpack";
};

// Add beret
private _beret = getText (ConfigFile >> "CfgVehicles" >> _unitName >> "UB3CB_loadout_beret");
if (_beret != "") then {
	_unit addItemToBackpack _beret;
};

// Add ammo
private ["_item", "_quantity"];
{
	_item = _x select 0;
	_quantity = _x select 1;
	if (_item in _variable_items) then {
		_quantity = round (_quantity * _perc); // 0.5 rounded up	
	};
	if !(_item in _excluded_items) then {
		for "_i" from 1 to _quantity do {
			_unit addItem _item;	
		};
	};
} forEach getArray (ConfigFile >> "CfgVehicles" >> _unitName >> "UK3CB_loadout_magazines");

// Add ammo to backpack
private ["_item", "_quantity"];
{
	_item = _x select 0;
	_quantity = _x select 1;
	if (_item in _variable_items) then {
		_quantity = round (_quantity * _perc); // 0.5 rounded up	
	};
	if !(_item in _excluded_items) then {
		for "_i" from 1 to _quantity do {
			_unit addItemToBackpack _item;	
		};
	};
} forEach getArray (ConfigFile >> "CfgVehicles" >> _unitName >> "UK3CB_loadout_magazines_backpack");

// Add items to inventory (ie uniform, vest or backpack)
{
	_item = _x select 0;
	_quantity = _x select 1;
	if (_item in _variable_items) then {
		_quantity = round (_quantity * _perc); // 0.5 rounded up	
	};
	if !(_item in _excluded_items) then {
		for "_i" from 1 to _quantity do {
			_unit addItem _item;	
		};
	};
} forEach getArray (ConfigFile >> "CfgVehicles" >> _unitName >> _loadout_gear);

// Add items just to backpack
{
	_item = _x select 0;
	_quantity = _x select 1;
	if (_item in _variable_items) then {
		_quantity = round (_quantity * _perc); // 0.5 rounded up	
	};
	if !(_item in _excluded_items) then {
		for "_i" from 1 to _quantity do {
			_unit addItemToBackpack _item;	
		};
	};
} forEach getArray (ConfigFile >> "CfgVehicles" >> _unitName >> _loadout_backpack);

	
if !(isNull _logic) then {

	// Add Ctab if mod enabled
	private _cTab = _logic getVariable ["uk3cb_Factions_addcTab", 1];
	if (_cTab > 0) then {
		[_unit, _cTab] call UK3CB_Factions_Common_fnc_add_cTab;
	};
	
	// // Remove NVGs
	// if (_logic getVariable ["uk3cb_Factions_removeNVGS", false]) then {
		// _unit call UK3CB_Factions_Common_fnc_remove_nvgs;
	// };	

	// Remove GPS
	if (_logic getVariable ["uk3cb_Factions_removeGPS", false]) then {
		_unit call UK3CB_Factions_Common_fnc_remove_gps;
	};	
	
	// // Remove frags
	// if (_logic getVariable ["uk3cb_Factions_removeFrags", false]) then {
		// _unit call UK3CB_Factions_Common_fnc_remove_frags;
	// };
	
	// Replace scopes with reflex sights
	if (_logic getVariable ["uk3cb_Factions_replaceScopes", false]) then {
		_unit call UK3CB_Factions_Common_fnc_add_reflex_sights;
	};
};

