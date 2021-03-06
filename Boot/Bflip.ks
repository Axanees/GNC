clearscreen.
function runscript {
    parameter name.
    runpath("0:/"+name+".ks").
}
GLOBAL SSstat IS "Pre_Launch".

runscript("lib_navball").
runscript("Launch").
runscript("Guidance").
runscript("Glide").
runscript("Landing").
core:part:getmodule("kOSProcessor"):doevent("Open Terminal").
Print "Please choose a landingpad target" at(0,1).
until HASTARGET {wait 0.}
Print "Target acquired! proceeding with launch sequance" at(0,1).
//set LZ-1 to LATLNG(-0.0486120608592771,10.7244742855799).
set LZ-1 to TARGET:geoposition.
when SSstat = "Pre_Launch" then set SSstat to launch(100000,LZ-1).
//when SSstat = "MECO" then set SSstat to launch(100000,90).
when SSstat = "APOGEE" then set SSstat to CoastTo(LZ-1, 1250). 
when SSstat = "Coast_Complete" then {lock steering to LOOKDIRUP(velocity:surface:NORMALIZED,ship:up:vector) + R(0,90,0). until shouldland() steer(LZ-1).}
when shouldland() then land().

until false {wait 0. print "Status: " + SSstat at(0,1).}
