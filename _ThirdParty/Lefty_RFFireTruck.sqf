// [fireEngine] execVM "globalScripts\_ThirdParty\Lefty_RFFireTruck.sqf";

params ["_fireEngine"];

_fireEngine addAction["Take Fire hose",{ 
    params ["_target", "_caller", "_actionId", "_arguments"];

    // Create and hide bucket object attached to the hose, which is attached to the player
    _hoseend = "LayFlatHose_01_StraightShort_F" createVehicle (position player); 
    _hose = ropeCreate [_target,[1.2,0.175,0],_hoseend,[0,-0.2,0],30]; 
    _bucket = "WaterBucket_1000L_Red_RF" createvehicle (position _hoseend); 
    _bucket attachTo [_hoseend,[0,1.5,0.2]]; 
    _bucket setVectorUp [0,-0.1,0.04]; 
    [_bucket, "setFill",1]  call lxRF_fnc_bucket; 
    hideObjectGlobal _bucket; 
    _caller setVariable["bp_firehose",_hose]; 
    _caller setVariable["bp_firebucket",_bucket]; 
    _caller setVariable ["bp_hoseend",_hoseend]; 


    _wid = _caller addAction ["Start Waterflow", { 
        params ["_htarget", "_hcaller", "_actionId", "_arguments"]; 
        _bucket = _hcaller getVariable ["bp_firebucket",objNull]; 
        _hcaller setVariable ["bp_iswaterflowing", true]; 
        [_bucket, "releaseWater",1]  call lxRF_fnc_bucket; 

        [_bucket, _hcaller] spawn { 
            params["_thebucket", "_hcaller"];
            // Refill the bucket until it's put back into the truck
            while {alive _thebucket && _hcaller getVariable ["bp_iswaterflowing", false]; } do { 
                waitUntil {_thebucket getVariable ["lxRF_ReleasingWater",-1] == -1};
				sleep 1;
                [_thebucket, "setFill",1]  call lxRF_fnc_bucket; 
                [_thebucket, "releaseWater",1]  call lxRF_fnc_bucket; 
            }; 
        }; 
    },nil,1.5,true,true,"","!(_this getVariable ['bp_iswaterflowing',false])"]; 

    _wid = _caller addAction ["Stop Waterflow", { 
		params ["_htarget", "_hcaller", "_actionId", "_arguments"]; 
		_hcaller setVariable ["bp_iswaterflowing", false]; 
    },nil,1.5,true,true,"","(_this getVariable ['bp_iswaterflowing',false])"]; 

    _caller setVariable ["bp_firetruck",_target]; 

    _id = _caller addAction ["Put hose back in truck",{ 
        params ["_htarget", "_hcaller", "_actionId", "_arguments"]; 
        _bphose = _hcaller getVariable ["bp_firehose",objNull]; 
        _bpbucket = _hcaller getVariable["bp_firebucket",objNull]; 
        _bphoseend = _hcaller getVariable ["bp_hoseend",objNull]; 
        _hcaller setVariable ["bp_firebucket",objNull]; 
        deletevehicle _bphose; 
        _bpbucket setDammage 1; 
        deletevehicle _bpbucket; 
        deletevehicle _bphoseend; 
        _id = _hcaller getVariable ["bp_hoseaction",-1]; 
        _wid = _hcaller getVariable ["bp_wateraction",-1]; 
        if(_id > -1) then {_hcaller removeAction _id;}; 
        if(_wid > -1) then {_hcaller removeAction _wid;}; 
    },nil,1.5,true,true,"","_firetruck = _target getVariable ['bp_firetruck',_target];_target distance _firetruck < 8"]; 

    _caller setVariable ["bp_hoseaction",_id]; 
    _caller setVariable ["bp_wateraction",_wid]; 
    _hoseend attachTo [_caller,[0.3,0,0.9],"ruce"]; 

},nil,1.5,true,true,"","isNull (_this getVariable['bp_firebucket',objNull]) && (_this distance _target) < 8"];