local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]

function TukuiUnitFrames:Pet()
	local DarkTheme = C["UnitFrames"].DarkTheme
	local HealthTexture = T.GetTexture(C["UnitFrames"].HealthTexture)
	local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)
	local Font = T.GetFont(C["UnitFrames"].Font)
	
	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Panel = CreateFrame("Frame", nil, self)
	Panel:SetTemplate()
	Panel:Size(129, 17)
	Panel:Point("BOTTOM", self, 0, 0)
	Panel:SetFrameLevel(2)
	Panel:SetFrameStrata("MEDIUM")
	Panel:SetBackdropBorderColor(C["General"].BorderColor[1] * 0.7, C["General"].BorderColor[2] * 0.7, C["General"].BorderColor[3] * 0.7)
	
	local Health = CreateFrame("StatusBar", nil, self)
	Health:Height(13)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetStatusBarTexture(HealthTexture)
	Health.PostUpdate = T.PostUpdatePetColor
	
	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:Point("TOPLEFT", Health, -1, 1)
	Health.Background:Point("BOTTOMRIGHT", Health, 1, -1)
	Health.Background:SetTexture(0, 0, 0)
	
	Health.frequentUpdates = true
	
	if DarkTheme then
		Health.colorTapping = false
		Health.colorDisconnected = false
		Health.colorClass = false
		Health:SetStatusBarColor(0.2, 0.2, 0.2, 1)
		Health.Background:SetVertexColor(0, 0, 0, 1)
	else
		Health.colorTapping = true
		Health.colorDisconnected = true
		Health.colorClass = true
		Health.colorReaction = true
	end
	
	if C.UnitFrames.Smooth then
		Health.Smooth = true
	end
	
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(4)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)
	
	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:Point("TOPLEFT", Power, -1, 1)
	Power.Background:Point("BOTTOMRIGHT", Power, 1, -1)
	Power.Background:SetTexture(0, 0, 0)
	
	Power.frequentUpdates = true
	
	if DarkTheme then
		Power.colorTapping = true
		Power.colorClass = true
		Power.Background.multiplier = 0.1				
	else
		Power.colorPower = true
	end
	
	if C.UnitFrames.Smooth then
		Power.Smooth = true
	end

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", Panel, "CENTER", 0, 0)
	Name:SetFontObject(Font)
	Name:SetJustifyH("CENTER")
	
	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(16, 16)
	RaidIcon:SetPoint("TOP", self, 0, 8)
	
	self:Tag(Name, "[Tukui:GetNameColor][Tukui:NameMedium] [Tukui:DiffColor][level]")
	self.Panel = Panel
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
	self.RaidIcon = RaidIcon
end