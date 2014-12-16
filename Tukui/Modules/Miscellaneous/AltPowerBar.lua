local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local AltPowerBar = CreateFrame("Button")

function AltPowerBar:Update(unit, power)
	if (unit ~= "player" and power ~= "ALTERNATE") then
		return
	end
	
	local Status = self.Status
	local Power = UnitPower(unit, ALTERNATE_POWER_INDEX)
	local MaxPower = UnitPowerMax(unit, ALTERNATE_POWER_INDEX)
	local R, G, B = T.ColorGradient(Power, MaxPower, 0, .8, 0, .8, .8, 0, .8, 0, 0)
	local PowerName = select(10, UnitAlternatePowerInfo(unit)) or UNKNOWN
	
	Status:SetMinMaxValues(0, UnitPowerMax(unit, ALTERNATE_POWER_INDEX))
	Status:SetValue(Power)
	Status:SetStatusBarColor(R, G, B)
	Status.Text:SetText(PowerName..": "..Power.." / "..MaxPower)
end

function AltPowerBar:OnEvent(event, unit, power)
	if (event == "UNIT_POWER" or event == "UNIT_MAXPOWER") then
		self:Update(unit, power)
	else
		if UnitAlternatePowerInfo("player") then
			self:Show()
			self:Update("player", "ALTERNATE")
		else
			self:Hide()
		end
	end
end

function AltPowerBar:DisableBlizzardBar()
	PlayerPowerBarAlt:UnregisterAllEvents()
end

function AltPowerBar:Create()
	local Panels = T["Panels"]
	local DataTextLeft = Panels.DataTextLeft

	self:DisableBlizzardBar()
	self:SetParent(DataTextLeft)
	self:SetAllPoints(DataTextLeft)
	self:SetTemplate()
	self:SetFrameStrata(DataTextLeft:GetFrameStrata())
	self:SetFrameLevel(DataTextLeft:GetFrameLevel() + 10)
	self:RegisterEvent("UNIT_POWER")
	self:RegisterEvent("UNIT_MAXPOWER")
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:SetScript("OnEvent", self.OnEvent)
	self:SetScript("OnClick", self.Hide)
	
	self.Status = CreateFrame("StatusBar", nil, self)
	self.Status:SetFrameLevel(self:GetFrameLevel() + 1)
	self.Status:SetStatusBarTexture(C.Medias.Normal)
	self.Status:SetMinMaxValues(0, 100)
	self.Status:SetInside(DataTextLeft)

	self.Status.Text = self.Status:CreateFontString(nil, "OVERLAY")
	self.Status.Text:SetFont(C.Medias.Font, 12)
	self.Status.Text:Point("CENTER", self, "CENTER", 0, 0)
	self.Status.Text:SetShadowColor(0, 0, 0)
	self.Status.Text:SetShadowOffset(1.25, -1.25)
end

function AltPowerBar:Enable()
	self:Create()
end

Miscellaneous.AltPowerBar = AltPowerBar