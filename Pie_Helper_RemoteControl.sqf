/*
Helper script to take remote control of a given unit (eg heli pilot for insertion)

Usage:
	Pie_Helper_RemoteControl = compileFinal preprocessFileLineNumbers "globalScripts\Pie_Helper_RemoteControl.sqf";
	[this, controlledGunner, "true", "Control Tank"] call Pie_Helper_RemoteControl;
*/

_objectToAdd = _this param [0, objNull];
_unitToControl = _this param [1, objNull];
_condition = _this param [2, "true"]; // _target, _this, _originalTarget
_label = _this param [3, "Take Control"];

[
	_objectToAdd, [
	_label,
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[_target, _caller, _actionId, _arguments] call Pie_RemoteControl_TakeControl;
	},
	[_unitToControl],
	1.5,
	true,
	true,
	"",
	_condition, 
	3
]] remoteExec ["addAction", 0, true];

Pie_RemoteControl_TakeControl = {
	params ["_target", "_caller", "_actionId", "_arguments"];

	_unitToControl = _arguments select 0;

	_caller remoteControl _unitToControl;
	(vehicle _unitToControl) switchCamera "internal";

	_unitToControl setVariable ["Pie_Remote_UnderControl", true, true];

	// Drop control when dead or unconcious
	waitUntil { sleep 1; (!alive _unitToControl || _unitToControl getVariable ["ACE_isUnconscious", false] || !(_unitToControl getVariable ["Pie_Remote_UnderControl", false])) };

	sleep 1;

	_unitToControl setVariable ["Pie_Remote_UnderControl", false, true];

	objNull remoteControl _unitToControl;
	_caller switchCamera "internal";
};