local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function UnitFrames:Party()
	local HealthTexture = T.GetTexture(C["Textures"].UFPartyHealthTexture)
	local PowerTexture = T.GetTexture(C["Textures"].UFPartyPowerTexture)
	local Font = T.GetFont(C["Party"].Font)
	local HealthFont = T.GetFont(C["Party"].HealthFont)

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:CreateShadow()
	self.Shadow:SetFrameLevel(2)
	
	self.Backdrop = CreateFrame("Frame", nil, self, "BackdropTemplate")
	self.Backdrop:SetAllPoints()
	self.Backdrop:SetFrameLevel(self:GetFrameLevel())
	self.Backdrop:SetBackdrop(UnitFrames.Backdrop)
	self.Backdrop:SetBackdropColor(0, 0, 0)

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetHeight(self:GetHeight() - 5)
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BACKGROUND")
	Health.Background:SetTexture(HealthTexture)
	Health.Background:SetAllPoints(Health)
	Health.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	if C.Party.ShowHealthText then
		Health.Value = Health:CreateFontString(nil, "OVERLAY")
		Health.Value:SetFontObject(Font)
		Health.Value:SetPoint("TOPRIGHT", -4, 6)
		
		self:Tag(Health.Value, C.Party.HealthTag.Value)
	end

	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true
	Health.isParty = true

	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetHeight(4)
	Power:SetPoint("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:SetPoint("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetTexture(PowerTexture)
	Power.Background:SetAllPoints(Power)
	Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	if C.Party.ShowManaText then
		Power.Value = Power:CreateFontString(nil, "OVERLAY")
		Power.Value:SetFontObject(Font)
		Power.Value:SetPoint("BOTTOMRIGHT", -4, 0)
		Power.PostUpdate = UnitFrames.PostUpdatePower
	end

	Power.colorPower = true
	Power.isParty = true

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("TOPLEFT", 4, 7)
	Name:SetFontObject(Font)

	local Buffs = CreateFrame("Frame", self:GetName().."Buffs", self)
	Buffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -6)
	Buffs:SetHeight(24)
	Buffs:SetWidth(206)
	Buffs.size = 24
	Buffs.num = 7
	Buffs.numRow = 1
	Buffs.spacing = 2
	Buffs.initialAnchor = "TOPLEFT"
	Buffs.PostCreateIcon = UnitFrames.PostCreateAura
	Buffs.PostUpdateIcon = UnitFrames.PostUpdateAura

	local Debuffs = CreateFrame("Frame", self:GetName().."Debuffs", self)
	Debuffs:SetPoint("LEFT", self, "RIGHT", 6, 0)
	Debuffs:SetHeight(self:GetHeight())
	Debuffs:SetWidth(250)
	Debuffs.size = self:GetHeight()
	Debuffs.num = 6
	Debuffs.spacing = 2
	Debuffs.initialAnchor = "TOPLEFT"
	Debuffs.PostCreateIcon = UnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = UnitFrames.PostUpdateAura

	local Leader = self:CreateTexture(nil, "OVERLAY")
	Leader:SetSize(16, 16)
	Leader:SetPoint("TOPRIGHT", self, "TOPLEFT", -4, 0)

	local MasterLooter = self:CreateTexture(nil, "OVERLAY")
	MasterLooter:SetSize(16, 16)
	MasterLooter:SetPoint("TOPRIGHT", self, "TOPLEFT", -4.5, -20)

	local ReadyCheck = Health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetPoint("CENTER", Health, "CENTER")
	ReadyCheck:SetSize(16, 16)

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(C.UnitFrames.RaidIconSize, C.UnitFrames.RaidIconSize)
	RaidIcon:SetPoint("CENTER", Health, "CENTER")
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	local Range = {
		insideAlpha = 1,
		outsideAlpha = C["Party"].RangeAlpha,
	}

	if C.UnitFrames.HealComm then
		local myBar = CreateFrame("StatusBar", nil, Health)
		local otherBar = CreateFrame("StatusBar", nil, Health)
		local absorbBar = CreateFrame("StatusBar", nil, Health)

		myBar:SetFrameLevel(Health:GetFrameLevel())
		myBar:SetStatusBarTexture(HealthTexture)
		myBar:SetPoint("TOP")
		myBar:SetPoint("BOTTOM")
		myBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT")
		myBar:SetWidth(180)
		myBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommSelfColor))
		myBar:SetMinMaxValues(0, 1)
		myBar:SetValue(0)

		otherBar:SetFrameLevel(Health:GetFrameLevel())
		otherBar:SetPoint("TOP")
		otherBar:SetPoint("BOTTOM")
		otherBar:SetPoint("LEFT", myBar:GetStatusBarTexture(), "RIGHT")
		otherBar:SetWidth(180)
		otherBar:SetStatusBarTexture(HealthTexture)
		otherBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommOtherColor))
		otherBar:SetMinMaxValues(0, 1)
		otherBar:SetValue(0)
		
		absorbBar:SetFrameLevel(Health:GetFrameLevel())
		absorbBar:SetPoint("TOP")
		absorbBar:SetPoint("BOTTOM")
		absorbBar:SetPoint("LEFT", otherBar:GetStatusBarTexture(), "RIGHT")
		absorbBar:SetWidth(180)
		absorbBar:SetStatusBarTexture(HealthTexture)
		absorbBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommAbsorbColor))
		absorbBar:SetMinMaxValues(0, 1)
		absorbBar:SetValue(0)

		local HealthPrediction = {
			myBar = myBar,
			otherBar = otherBar,
			absorbBar = absorbBar,
			maxOverflow = 1,
		}

		self.HealthPrediction = HealthPrediction
	end
	
	local ResurrectIndicator = Health:CreateTexture(nil, "OVERLAY")
	ResurrectIndicator:SetSize(24, 24)
	ResurrectIndicator:SetPoint("CENTER", Health)

	local Highlight = CreateFrame("Frame", nil, self, "BackdropTemplate")
	Highlight:SetBackdrop({edgeFile = C.Medias.Glow, edgeSize = C.Party.HighlightSize})
	Highlight:SetOutside(self, C.Party.HighlightSize, C.Party.HighlightSize)
	Highlight:SetBackdropBorderColor(unpack(C.Party.HighlightColor))
	Highlight:SetFrameLevel(0)
	Highlight:Hide()
	
	-- Enable smoothing bars animation?
	if C.UnitFrames.Smoothing then
		Health.smoothing = true
		Power.smoothing = true

		if self.HealthPrediction then
			self.HealthPrediction.smoothing = true
		end
	end

	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
	self.Buffs = Buffs
	self.Debuffs = Debuffs
	self.LeaderIndicator = Leader
	self.MasterLooterIndicator = MasterLooter
	self.ReadyCheckIndicator = ReadyCheck
	self.RaidTargetIndicator = RaidIcon
	self.Range = Range
	self.Highlight = Highlight
	self.ResurrectIndicator = ResurrectIndicator
	
	if T.Retail then
		self:Tag(Name, "[level] [Tukui:NameLong] [Tukui:Role]")
	else
		self:Tag(Name, "[level] [Tukui:NameLong]")
	end

	self:RegisterEvent("PLAYER_TARGET_CHANGED", UnitFrames.Highlight, true)
	self:RegisterEvent("RAID_ROSTER_UPDATE", UnitFrames.Highlight, true)
end
