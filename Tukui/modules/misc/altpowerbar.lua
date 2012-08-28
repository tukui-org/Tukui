local T, C, L, G = unpack(select(2, ...))
if IsAddOnLoaded("SmellyPowerBar") then return end

PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
local AltPowerBar = CreateFrame("Frame", "TukuiAltPowerBar", TukuiInfoLeft)
AltPowerBar:SetAllPoints()
AltPowerBar:SetFrameStrata("MEDIUM")
AltPowerBar:SetFrameLevel(0)
AltPowerBar:EnableMouse(true)
AltPowerBar:SetTemplate("Default")
G.Misc.AltPowerBar = AltPowerBar

local AltPowerBarStatus = CreateFrame("StatusBar", "TukuiAltPowerBarStatus", AltPowerBar)
AltPowerBarStatus:SetFrameLevel(AltPowerBar:GetFrameLevel() + 1)
AltPowerBarStatus:SetStatusBarTexture(C.media.normTex)
AltPowerBarStatus:SetMinMaxValues(0, 100)
AltPowerBarStatus:Point("TOPLEFT", TukuiInfoLeft, "TOPLEFT", 2, -2)
AltPowerBarStatus:Point("BOTTOMRIGHT", TukuiInfoLeft, "BOTTOMRIGHT", -2, 2)
G.Misc.AltPowerBar.Status = AltPowerBarStatus

local AltPowerText = AltPowerBarStatus:CreateFontString("TukuiAltPowerBarText", "OVERLAY")
AltPowerText:SetFont(C.media.font, 12)
AltPowerText:Point("CENTER", AltPowerBar, "CENTER", 0, 0)
AltPowerText:SetShadowColor(0, 0, 0)
AltPowerText:SetShadowOffset(1.25, -1.25)
G.Misc.AltPowerBar.Text = AltPowerText

AltPowerBar:RegisterEvent("UNIT_POWER")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_SHOW")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_HIDE")
AltPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")

local function OnEvent(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if UnitAlternatePowerInfo("player") then
		self:Show()
	else
		self:Hide()
	end
end
AltPowerBar:SetScript("OnEvent", OnEvent)

local TimeSinceLastUpdate = 1
local function OnUpdate(self, elapsed)
	if not AltPowerBar:IsShown() then return end
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	
	if (TimeSinceLastUpdate >= 1) then
		self:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
		local power = UnitPower("player", ALTERNATE_POWER_INDEX)
		local mpower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
		self:SetValue(power)
		AltPowerText:SetText(power.." / "..mpower)
		local r, g, b = oUFTukui.ColorGradient(power,mpower, 0,.8,0,.8,.8,0,.8,0,0)
		AltPowerBarStatus:SetStatusBarColor(r, g, b)
		self.TimeSinceLastUpdate = 0
	end
end
AltPowerBarStatus:SetScript("OnUpdate", OnUpdate)