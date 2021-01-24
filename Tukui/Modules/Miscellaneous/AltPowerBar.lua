local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local AltPowerBar = CreateFrame("Button", "TukuiAltPowerBar", T.PetHider)

function AltPowerBar:Update()
	local Status = self.Status
	local Power = UnitPower("player", ALTERNATE_POWER_INDEX)
	local MaxPower = UnitPowerMax("player", ALTERNATE_POWER_INDEX) or 0
	local Percent = math.floor(Power / MaxPower * 100 + .5) or 0
	local R, G, B = T.ColorGradient(Power, MaxPower, .8, 0, 0, .8, .8, 0, 0, .8, 0)
	local PowerName = GetUnitPowerBarStrings("player") or UNKNOWN

	Status:SetMinMaxValues(0, MaxPower)
	Status:SetValue(Power)
	Status:SetStatusBarColor(R, G, B)
	
	Status.Text:SetText(PowerName)
	
	Status.Percent:SetText(Percent .. "%")
	
	self.Backdrop:SetBackdropColor(R * .2, G * .2, B * .2)
end

function AltPowerBar:OnEvent(event, unit, power)
	local AltPowerInfo = GetUnitPowerBarInfo("player")

	if (not AltPowerInfo) then
		if self:IsShown() then
			self:Hide()
		end
	else
		if not self:IsShown() then
			self:Show()
		end
		
		self:Update()
	end
end

function AltPowerBar:DisableBlizzardBar()
	PlayerPowerBarAlt:UnregisterAllEvents()
end

function AltPowerBar:Create()
	self:DisableBlizzardBar()
	self:SetSize(180, 17)
	self:SetPoint("TOP", 0, -28)
	self:CreateBackdrop()
	self:CreateShadow()
	self:SetFrameStrata(T.DataTexts.Panels.Left:GetFrameStrata())
	self:SetFrameLevel(T.DataTexts.Panels.Left:GetFrameLevel() + 10)
	self:RegisterEvent("UNIT_POWER_BAR_SHOW")
	self:RegisterEvent("UNIT_POWER_BAR_HIDE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_POWER_UPDATE")
	self:SetScript("OnEvent", self.OnEvent)

	self.Status = CreateFrame("StatusBar", nil, self)
	self.Status:SetFrameLevel(self:GetFrameLevel() + 1)
	self.Status:SetStatusBarTexture(C.Medias.Normal)
	self.Status:SetMinMaxValues(0, 100)
	self.Status:SetInside(DataTextLeft)

	self.Status.Text = self.Status:CreateFontString(nil, "OVERLAY")
	self.Status.Text:SetFont(C.Medias.Font, 12, "OUTLINE")
	self.Status.Text:SetPoint("CENTER", self, "CENTER", 0, -23)
	
	self.Status.Percent = self.Status:CreateFontString(nil, "OVERLAY")
	self.Status.Percent:SetFont(C.Medias.Font, 12, "OUTLINE")
	self.Status.Percent:SetPoint("CENTER", self, "CENTER", 0, 0)
	
	T.Movers:RegisterFrame(self, "Alternative Power Bar")
end

function AltPowerBar:Enable()
	self:Create()
end

Miscellaneous.AltPowerBar = AltPowerBar