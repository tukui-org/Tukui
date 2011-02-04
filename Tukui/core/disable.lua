------------------------------------------------------------------------
-- auto-overwrite script config is X mod is found
------------------------------------------------------------------------

-- because users are too lazy to disable feature in config file
-- adding an auto disable if some mods are loaded
local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if (IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") or IsAddOnLoaded("ag_UnitFrames")) then
	C["unitframes"].enable = false
end

if (IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft")) then
	C["nameplate"].enable = false
end

if (IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("Macaroon")) then
	C["actionbar"].enable = false
end

if (IsAddOnLoaded("Mapster")) then
	C["map"].enable = false
end

if (IsAddOnLoaded("Prat") or IsAddOnLoaded("Chatter")) then
	C["chat"].enable = false
end

if (IsAddOnLoaded("Quartz") or IsAddOnLoaded("AzCastBar") or IsAddOnLoaded("eCastingBar")) then
	C["unitframes"].unitcastbar = false
end

if (IsAddOnLoaded("TipTac")) then
	C["tooltip"].enable = false
end

if (IsAddOnLoaded("Gladius")) then
	C["arena"].unitframes = false
end