A bunch of scripts to run complicated, dynamic Drongos missions.

Usage:
In init, put:

Pie_CSAR = compileFinal preprocessFileLineNumbers "globalScripts\Pie_CSAR.sqf";  
0 spawn   
{  
    [hostage, garrisonForce, wreckToSpawn, wreckGuard] call Pie_CSAR;  
    sleep 5;  
    dmpWaitForGo = false;  
};