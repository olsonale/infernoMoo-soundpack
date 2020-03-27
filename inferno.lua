PPI = require("ppi")
ppi = PPI.Load("aedf0cb0be5bf045860d54b7")
require "wait"
path = GetInfo(56).."/worlds/inferno/"
amb_id=0
amb_event = 0
music_id = 0
sound_id = 0
roundtime = 0
Gv = 80
Av = 30
Mv = 30
vol = 1  -- the volume to adjust.
vols = {{Gv, Mv, Av}, {"general volume", "music volume", "ambience volume"}}
area = ""
gender = ""
name = ""
channel = 0
cspam = "off"
craft = "on"
autotrack = true
look_fetish = false

AcceleratorTo("f5", "adjust_vol(-5)", 12)
AcceleratorTo("f6", "adjust_vol(5)", 12)
AcceleratorTo("f7", "cycle_volume_options()", 12)
Accelerator("ctrl+enter", "power")
function get_vols() -- returns an integer-indexed table with all three volumes at their current rate
gen, mus, amb = Gv, Mv, Av
return {gen, mus, amb}
end -- func
function cycle_volume_options()
local v = get_vols()
if vol + 1 > #vols[1] then
vol = 1
else
vol = vol + 1
end -- if
Note(vols[2][vol].." at "..v[vol])
end -- func
function adjust_vol(amt)
if vol == 1 then
if Gv + amt > 100 then
Gv = 100
Note("Max volume")
elseif Gv + amt < 0 then
Gv = 0
Note("Muted")
else
Gv = Gv + amt
ppi.play(path.."general/beep.ogg",0,0,Gv)
end -- if
elseif vol == 2 then
if Mv + amt > 100 then
Mv = 100
ppi.slideVol(Mv, music_id, 300)
Note("Max volume")
elseif Mv + amt < 0 then
Mv = 0
ppi.slideVol(Mv, music_id, 300)
Note("Muted")
else
Mv = Mv + amt
ppi.play(path.."general/beep.ogg",0,0,Mv)
ppi.slideVol(Mv, music_id, 300)
end -- if
elseif vol == 3 then
if Av + amt > 100 then
Av = 100
ppi.slideVol(Av, amb_id, 300)
Note("Max volume")
elseif Av + amt < 0 then
Av = 0
ppi.slideVol(Av, amb_id, 300)
Note("Muted")
else
Av = Av + amt
ppi.play(path.."general/beep.ogg",0,0,Av)
ppi.slideVol(Av, amb_id, 300)
end -- if
else
Note("Something went wrong!")
end -- if
end -- func

function toggle_autotrack() -- it does what you think it does
autotrack = not autotrack
if autotrack then
ppi.play(path.."utilities/autotracking_on.ogg", 0, 0, Gv)
else
ppi.play(path.."utilities/autotracking_off.ogg", 0, 0, Gv)
end -- if
end -- func
function toggle_ridemode()
ridemode = not ridemode
if ridemode then
Note("On")
else
Note("off")
end -- if
end -- func

