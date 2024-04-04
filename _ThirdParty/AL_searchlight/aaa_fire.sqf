// by ALIAS
// null = [this] execVM "globalScripts\_ThirdParty\AL_searchlight\aaa_fire.sqf"

if (!isServer) exitWith {};

_vik_aaa = _this select 0;

if (!isNil{_vik_aaa getVariable "activ"}) exitWith {};
_vik_aaa setVariable ["activ",true,true];

//_obiect_lit = createSimpleObject ["A3\data_f\VolumeLight_searchLight.p3d", [0,0,0]];

//[[_vik_aaa,_obiect_lit],"globalScripts\_ThirdParty\AL_searchlight\aaa_search_light_SFX.sqf"] remoteExec ["execVM"];
[[_vik_aaa],"globalScripts\_ThirdParty\AL_searchlight\aaa_search_light_SFX.sqf"] remoteExec ["execVM"];