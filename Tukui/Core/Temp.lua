----------------------------------
-- Temporary code in this file! --
----------------------------------

local T, C, L = select(2, ...):unpack()

hooksecurefunc("SetCVar", function(a, b, c) print(a, b, c) end)