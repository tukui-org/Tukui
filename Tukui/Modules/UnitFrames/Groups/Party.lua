local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:Party()
	local HealthTexture = T.GetTexture(C["Textures"].UFPartyHealthTexture)
	local PowerTexture = T.GetTexture(C["Textures"].UFPartyPowerTexture)
	local Font = T.GetFont(C["Party"].Font)
	local HealthFont = T.GetFont(C["Party"].HealthFont)

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:Height(self:GetHeight() - 5)
	Health:SetStatusBarTexture(HealthTexture)

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetColorTexture(.1, .1, .1)

	Health.frequentUpdates = true

	if C.Party.ShowHealthText then
		Health.Value = Health:CreateFontString(nil, "OVERLAY")
		Health.Value:SetFontObject(HealthFont)
		Health.Value:Point("RIGHT", Health, "RIGHT", 0, 0)

		Health.PostUpdate = TukuiUnitFrames.PostUpdateHealth
	end

	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true

	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end

	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(4)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
	Power:SetStatusBarTexture(PowerTexture)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints(Power)
	Power.Background:SetColorTexture(.4, .4, .4)
	Power.Background.multiplier = 0.3

	Power.frequentUpdates = true
	Power.colorPower = true

	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end

	local Name = Health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("TOPLEFT", -1, 18)
	Name:SetFontObject(Font)

	local Buffs = CreateFrame("Frame", self:GetName()..'Buffs', self)
	Buffs:Point("TOPLEFT", self, "BOTTOMLEFT", 0, -6)
	Buffs:SetHeight(24)
	Buffs:SetWidth(250)
	Buffs.size = 24
	Buffs.num = 8
	Buffs.numRow = 1
	Buffs.spacing = 2
	Buffs.initialAnchor = "TOPLEFT"
	Buffs.PostCreateIcon = TukuiUnitFrames.PostCreateAura
	Buffs.PostUpdateIcon = TukuiUnitFrames.PostUpdateAura

	local Debuffs = CreateFrame("Frame", self:GetName()..'Debuffs', self)
	Debuffs:Point("LEFT", self, "RIGHT", 6, 0)
	Debuffs:SetHeight(self:GetHeight())
	Debuffs:SetWidth(250)
	Debuffs.size = self:GetHeight()
	Debuffs.num = 6
	Debuffs.spacing = 2
	Debuffs.initialAnchor = "TOPLEFT"
	Debuffs.PostCreateIcon = TukuiUnitFrames.PostCreateAura
	Debuffs.PostUpdateIcon = TukuiUnitFrames.PostUpdateAura

	local Leader = self:CreateTexture(nil, "OVERLAY")
	Leader:SetSize(16, 16)
	Leader:SetPoint("TOPRIGHT", self, "TOPLEFT", -4, 0)

	local MasterLooter = self:CreateTexture(nil, "OVERLAY")
	MasterLooter:SetSize(16, 16)
	MasterLooter:SetPoint("TOPRIGHT", self, "TOPLEFT", -4.5, -20)

	local ReadyCheck = Health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetPoint("CENTER", Health, "CENTER")
	ReadyCheck:SetSize(16, 16)

	local RaidIcon = self:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(12, 12)
	RaidIcon:SetPoint("TOPRIGHT", self, 1, 18)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	local PhaseIcon = Health:CreateTexture(nil, 'OVERLAY')
	PhaseIcon:SetSize(24, 24)
	PhaseIcon:SetPoint("TOPRIGHT", self, 7, 24)

	if (C.Party.HealBar) then
		local Width = C["Party"].Portrait and 162 or 206

		local FirstBar = CreateFrame("StatusBar", nil, Health)
		FirstBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		FirstBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		FirstBar:Width(Width)
		FirstBar:SetStatusBarTexture(HealthTexture)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, 1)
		FirstBar:SetMinMaxValues(0,1)

		local SecondBar = CreateFrame("StatusBar", nil, Health)
		SecondBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		SecondBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		SecondBar:Width(Width)
		SecondBar:SetStatusBarTexture(HealthTexture)
		SecondBar:SetStatusBarColor(0, 0.3, 0, 1)

		local ThirdBar = CreateFrame("StatusBar", nil, Health)
		ThirdBar:SetPoint("TOPLEFT", Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
		ThirdBar:SetPoint("BOTTOMLEFT", Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
		ThirdBar:Width(Width)
		ThirdBar:SetStatusBarTexture(HealthTexture)
		ThirdBar:SetStatusBarColor(0.3, 0.3, 0, 1)

		ThirdBar:SetFrameLevel(Health:GetFrameLevel())
		SecondBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 1)
		FirstBar:SetFrameLevel(ThirdBar:GetFrameLevel() + 2)

		self.HealthPrediction = {
			myBar = FirstBar,
			otherBar = SecondBar,
			absorbBar = ThirdBar,
			maxOverflow = 1,
		}
	end

	if (Class == "PRIEST" and C.UnitFrames.WeakBar) then
		-- Weakened Soul Bar
		local WSBar = CreateFrame("StatusBar", nil, Power)
		WSBar:SetAllPoints(Power)
		WSBar:SetStatusBarTexture(C.Medias.Normal)
		WSBar:GetStatusBarTexture():SetHorizTile(false)
		WSBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		WSBar:SetBackdropColor(unpack(C["General"].BackdropColor))
		WSBar:SetStatusBarColor(0.75, 0.04, 0.04)

		-- Register
		self.WeakenedSoul = WSBar
	end

	local Threat = Health:CreateTexture(nil, "OVERLAY")
	Threat.Override = TukuiUnitFrames.UpdateThreat
	
	local Highlight = CreateFrame("Frame", nil, self)
	Highlight:SetPoint("TOPLEFT", self, "TOPLEFT")
	Highlight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT")
	Highlight:SetBackdrop(TukuiUnitFrames.HighlightBorder)
	Highlight:SetFrameLevel(0)
	Highlight:Hide()
	
	--[[
	if Class == "PRIEST" then
		local Atonement = CreateFrame("StatusBar", nil, Power)
		Atonement:SetAllPoints()
		Atonement:SetStatusBarTexture(C.Medias.Normal)
		Atonement:SetFrameStrata(Power:GetFrameStrata())
		Atonement:SetFrameLevel(Power:GetFrameLevel() + 1)
		
		self.Atonement = Atonement
	end
	--]]

	local Range = {
		insideAlpha = 1,
		outsideAlpha = C["Party"].RangeAlpha,
	}

	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Name = Name
	--self.Role = Role -- This is a global lookup
	self.Buffs = Buffs
	self.Debuffs = Debuffs
	self.LeaderIndicator = Leader
	self.MasterLooterIndicator = MasterLooter
	self.ReadyCheckIndicator = ReadyCheck
	self.RaidTargetIndicator = RaidIcon
	self.PhaseIcon = PhaseIcon
	self.ThreatIndicator = Threat
	self.Range = Range
	self.Highlight = Highlight
	self:Tag(Name, "[Tukui:GetNameColor][Tukui:NameLong][Tukui:Role]")
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED", TukuiUnitFrames.Highlight)
	self:RegisterEvent("RAID_ROSTER_UPDATE", TukuiUnitFrames.Highlight)
	self:RegisterEvent("PLAYER_FOCUS_CHANGED", TukuiUnitFrames.Highlight)
end
