function runscript {
    parameter name.
    runpath("0:/"+name+".ks").
}

runscript("lib_navball").

set E2EPID to PIDLOOP(0.00001,0,0,0,1).
set CorY to PIDLOOP(0.01,0.001,0.01,-5,5).

function CoastTo {
  parameter LZ-1.
  parameter dis.
sas off.
set E2EPID:setpoint to dis.
lock throttle to 0.
until eta:apoapsis < 20 {wait 0.}
 lock steering to heading (LZ-1:heading + CorY:UPDATE(0.05,-horizontal_distance(LZ-1)),10).
 lock throttle to E2EPID:UPDATE(0.05,-vertical_distance_trajectory(LZ-1)).
until abs(vertical_distance_trajectory(LZ-1)) < dis {wait 0.}
unlock steering. lock throttle to 0.
return "Coast_Complete".
}

