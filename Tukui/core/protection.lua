------------------------------------------------------------------------
-- We don't want 2 addons enabled doing the same thing. 
-- Disable a feature on Tukui if X addon is found.
------------------------------------------------------------------------

local T, C, L, G = unpack(select(2, ...))

if (IsAddOnLoaded("Stuf") or IsAddOnLoaded("PitBull4") or IsAddOnLoaded("ShadowedUnitFrames") or IsAddOnLoaded("ag_UnitFrames")) then
	C["unitframes"].enable = false
end

if (IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Aloft") or IsAddOnLoaded("dNamePlates") or IsAddOnLoaded("caelNamePlates")) then
	C["nameplate"].enable = false
end

if (IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("Macaroon")) then
	C["actionbar"].enable = false
end

if (IsAddOnLoaded("Prat") or IsAddOnLoaded("Prat-3.0") or IsAddOnLoaded("Chatter")) then
	C["chat"].enable = false
end

if (IsAddOnLoaded("Quartz") or IsAddOnLoaded("AzCastBar") or IsAddOnLoaded("eCastingBar")) then
	C["unitframes"].unitcastbar = false
end

if (IsAddOnLoaded("TipTac") or IsAddOnLoaded("FreebTip")) then
	C["tooltip"].enable = false
end

if (IsAddOnLoaded("Gladius")) then
	C["unitframes"].arena = false
end

if (IsAddOnLoaded("SatrinaBuffFrame") or IsAddOnLoaded("ElkBuffBars")) then
	C["auras"].player = false
end

if IsAddOnLoaded("AdiBags") or IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("cargBags_Nivaya") or IsAddOnLoaded("cargBags") or IsAddOnLoaded("Bagnon") or IsAddOnLoaded("Combuctor") then
	C.bags.enable = false
end

if IsAddOnLoaded("InlineAura") then
	C.cooldown.enable = false
end