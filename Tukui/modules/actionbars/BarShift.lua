local T, C, L, G = unpack(select(2, ...)) 
if not C["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- Setup Shapeshift Bar
---------------------------------------------------------------------------

-- create the shapeshift bar if we enabled it
local bar = CreateFrame("Frame", "TukuiStance", UIParent, "SecureHandlerStateTemplate")
bar:SetPoint("TOPLEFT", 4, -46)
bar:SetWidth((T.petbuttonsize * 5) + (T.petbuttonsize * 4))
bar:SetHeight(10)
bar:SetFrameStrata("MEDIUM")
bar:SetMovable(true)
bar:SetClampedToScreen(true)
G.ActionBars.Stance = bar

-- shapeshift command to move totem or shapeshift in-game
local ssmover = CreateFrame("Frame", "TukuiStanceHolder", UIParent)
ssmover:SetAllPoints(TukuiStance)
ssmover:SetTemplate("Default")
ssmover:SetFrameStrata("HIGH")
ssmover:SetBackdropBorderColor(1,0,0)
ssmover:SetAlpha(0)
ssmover.text = T.SetFontString(ssmover, C.media.uffont, 12)
ssmover.text:SetPoint("CENTER")
ssmover.text:SetText(L.move_shapeshift)
G.ActionBars.Stance.Holder = ssmover

-- hide it if not needed and stop executing code
if C.actionbar.hideshapeshift then TukuiStance:Hide() return end

local States = {
	["DRUID"] = "show",
	["WARRIOR"] = "show",
	["PALADIN"] = "show",
	["DEATHKNIGHT"] = "show",
	["ROGUE"] = "show,",
	["PRIEST"] = "show,",
	["HUNTER"] = "show,",
	["WARLOCK"] = "show,",
	["MONK"] = "show,",
}

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
bar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
bar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
bar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
bar:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		StanceBarFrame.ignoreFramePositionManager = true
		StanceBarFrame:StripTextures()
		StanceBarFrame:SetParent(bar)
		StanceBarFrame:ClearAllPoints()
		StanceBarFrame:SetPoint("BOTTOMLEFT", bar, "TOPLEFT", -11, 4)
		StanceBarFrame:EnableMouse(false)
		
		for i = 1, NUM_STANCE_SLOTS do
			local button = _G["StanceButton"..i]
			button:SetFrameStrata("LOW")
			if i ~= 1 then
				button:ClearAllPoints()				
				local previous = _G["StanceButton"..i-1]
				button:Point("LEFT", previous, "RIGHT", T.buttonspacing, 0)
			end
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			else
				button:Hide()
			end
			
			G.ActionBars.Stance["Button"..i] = button
		end
		RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle] hide; show")
	elseif event == "UPDATE_SHAPESHIFT_FORMS" then
		-- Update Shapeshift Bar Button Visibility
		-- I seriously don't know if it's the best way to do it on spec changes or when we learn a new stance.
		if InCombatLockdown() then return end -- > just to be safe ;p
		for i = 1, NUM_STANCE_SLOTS do
			local button = _G["StanceButton"..i]
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			else
				button:Hide()
			end
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		T.ShiftBarUpdate(self)
		T.StyleShift(self)
	else
		T.ShiftBarUpdate(self)
	end
end)

RegisterStateDriver(bar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")