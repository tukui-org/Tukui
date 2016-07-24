----------------------------------
-- Temporary code in this file! --
----------------------------------

local T, C, L = select(2, ...):unpack()

-- TEMP FIX FOR PVP UI TAINT IN MICROMENU.LUA
PVEFrameTab1:Kill()
PVEFrameTab2:Kill() -- This one was tainting the UI on click