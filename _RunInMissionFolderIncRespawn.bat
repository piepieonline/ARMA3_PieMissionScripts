mklink /J globalScripts "D:\Game Modding\ARMA 3\_CustomScripts"
echo [false] execVM "globalScripts\Pie_RespawnHelper.sqf"; >> init.sqf
echo respawn = 3; > Description.ext
echo respawnDelay = 3; >> Description.ext