local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales

--------------------------------------------------------------------------------------------
-- the interrupt spellIDs to track on screen in arena.
--------------------------------------------------------------------------------------------

T.interrupt = {
	[1766] = 10, -- kick
	[6552] = 10, -- pummel
	[2139] = 24, -- counterspell
	[19647] = 24, -- spell lock
	[34322] = 27, -- fear priest
	[47476] = 120, -- strangulate
	[47528] = 10, -- mindfreeze
	[57994] = 6, -- wind shear
	[72] = 12, -- shield bash
	[15487] = 45, -- silence priest
	[34490] = 20, -- silencing shot
	[85285] = 10, -- rebuke
	[80964] = 10, -- feral skull bash (cat)
	[80965] = 10, -- feral skull bash (bear)
}