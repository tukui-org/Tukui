local T, C, L, G = unpack(select(2, ...)) 
if not C["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- Hide/Disable all Blizzard stuff that we don't need
---------------------------------------------------------------------------

local hide = TukuiUIHider
local frames = {
	MainMenuBar, MainMenuBarArtFrame, OverrideActionBar,
	PossessBarFrame, PetActionBarFrame, IconIntroTracker,
	ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
}

-- hide what we dont need
for i, f in pairs(frames) do
	f:UnregisterAllEvents()
	f.ignoreFramePositionManager = true
	f:SetParent(hide)
end

-- This frame puts spells on the damn actionbar, fucking obliterate that shit
IconIntroTracker:UnregisterAllEvents()
IconIntroTracker:SetParent(hide)

-- some kind of hack to always block Multi Bars animation
MainMenuBar.slideOut.IsPlaying = function() return true end

-- more safety
SetCVar("alwaysShowActionBars", 1)

-- we don't use these buttons in Tukui, disable them.
for i = 1, 6 do
	local b = _G["OverrideActionBarButton"..i]
	b:UnregisterAllEvents()
	b:SetAttribute("statehidden", 1)
end

-- fix main bar keybind not working after a talent switch. :X
hooksecurefunc('TalentFrame_LoadUI', function()
	PlayerTalentFrame:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
end)