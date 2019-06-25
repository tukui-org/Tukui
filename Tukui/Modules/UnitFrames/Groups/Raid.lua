local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function TukuiUnitFrames:Raid()
	local HealthTexture = T.GetTexture(C["Textures"].UFRaidHealthTexture)
	local PowerTexture = T.GetTexture(C["Textures"].UFRaidPowerTexture)
	local Font = T.GetFont(C["Raid"].Font)
	local HealthFont = T.GetFont(C["Raid"].HealthFont)

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:SetBackdrop(TukuiUnitFrames.Backdrop)
	self:SetBackdropColor(0, 0, 0)
	self:CreateShadow()

	local Health = CreateFrame("StatusBar", nil, self)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:Height(28)
	Health:SetStatusBarTexture(HealthTexture)

	if C.Raid.VerticalHealth then
		Health:SetOrientation("VERTICAL")
	end

	Health.Background = Health:CreateTexture(nil, "BORDER")
	Health.Background:SetAllPoints()
	Health.Background:SetColorTexture(.1, .1, .1)

	if C.Raid.ShowHealthText then
		Health.Value = Health:CreateFontString(nil, "OVERLAY", 1)
		Health.Value:SetFontObject(HealthFont)
		Health.Value:Point("CENTER", Health, 0, 0)

		Health.PostUpdate = TukuiUnitFrames.PostUpdateHealth
	end

	Health.frequentUpdates = true
	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true

	if (C.UnitFrames.Smooth) then
		Health.Smooth = true
	end

	-- AuraWatch requires this handle ASAP
	self.Health = Health

	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:Height(3)
	Power:Point("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:Point("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetAllPoints(Power)
	Power.Background:SetColorTexture(.4, .4, .4)
	Power.Background.multiplier = 0.3

	Power:SetStatusBarTexture(PowerTexture)

	Power.frequentUpdates = true
	Power.colorPower = true

	if (C.UnitFrames.Smooth) then
		Power.Smooth = true
	end

	local Panel = CreateFrame("Frame", nil, self)
	Panel:Point("TOPLEFT", Power, "BOTTOMLEFT", 0, -1)
	Panel:Point("TOPRIGHT", Power, "BOTTOMRIGHT", 0, -1)
	Panel:SetPoint("BOTTOM", 0, 0)
	Panel:SetTemplate()
	Panel:SetBackdropBorderColor(C["General"].BorderColor[1] * 0.7, C["General"].BorderColor[2] * 0.7, C["General"].BorderColor[3] * 0.7)

	local Name = Panel:CreateFontString(nil, "OVERLAY", 1)
	Name:SetPoint("CENTER")
	Name:SetFontObject(Font)

	local ReadyCheck = Power:CreateTexture(nil, "OVERLAY", 2)
	ReadyCheck:Height(12)
	ReadyCheck:Width(12)
	ReadyCheck:SetPoint("CENTER")

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(16, 16)
	RaidIcon:SetPoint("TOP", self, 0, 8)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	if C["Raid"].ShowRessurection then
		local ResurrectIcon = Health:CreateTexture(nil, "OVERLAY", 3)
		ResurrectIcon:Size(16)
		ResurrectIcon:SetPoint("CENTER")

		self.ResurrectIndicator = ResurrectIcon
	end

	local Range = {
		insideAlpha = 1,
		outsideAlpha = C["Raid"].RangeAlpha,
	}

	if (C.Raid.HealBar) then
		local FirstBar = CreateFrame("StatusBar", nil, Health)
		local SecondBar = CreateFrame("StatusBar", nil, Health)
		local ThirdBar = CreateFrame("StatusBar", nil, Health)

		FirstBar:Width(66)
		FirstBar:Height(28)
		FirstBar:SetStatusBarTexture(HealthTexture)
		FirstBar:SetStatusBarColor(0, 0.3, 0.15, 1)
		FirstBar:SetMinMaxValues(0,1)

		SecondBar:Width(66)
		SecondBar:Height(28)
		SecondBar:SetStatusBarTexture(HealthTexture)
		SecondBar:SetStatusBarColor(0, 0.3, 0, 1)

		ThirdBar:Width(66)
		ThirdBar:Height(28)
		ThirdBar:SetStatusBarTexture(HealthTexture)
		ThirdBar:SetStatusBarColor(0.3, 0.3, 0, 1)

		if C.Raid.VerticalHealth then
			FirstBar:SetOrientation("VERTICAL")
			SecondBar:SetOrientation("VERTICAL")
			ThirdBar:SetOrientation("VERTICAL")

			FirstBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
			SecondBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
			ThirdBar:SetPoint("BOTTOM", Health:GetStatusBarTexture(), "TOP", 0, 0)
		else
			FirstBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT", 0, 0)
			SecondBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT", 0, 0)
			ThirdBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT", 0, 0)
		end

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

	-- AuraWatch (corner and center icon)
	if C["Raid"].AuraWatch then
		TukuiUnitFrames:CreateAuraWatch(self)

		local RaidDebuffs = CreateFrame("Frame", nil, self)
		RaidDebuffs:SetHeight(18)
		RaidDebuffs:SetWidth(18)
		RaidDebuffs:SetPoint("CENTER", Health)
		RaidDebuffs:SetFrameStrata("MEDIUM")
		RaidDebuffs:SetFrameLevel(Health:GetFrameLevel() + 1)
		RaidDebuffs:SetTemplate()
		RaidDebuffs:CreateShadow()

		RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, "ARTWORK")
		RaidDebuffs.icon:SetTexCoord(.1, .9, .1, .9)
		RaidDebuffs.icon:SetInside(RaidDebuffs)

		RaidDebuffs.cd = CreateFrame("Cooldown", nil, RaidDebuffs, "CooldownFrameTemplate")
		RaidDebuffs.cd:SetInside(RaidDebuffs, 1, 1)
		RaidDebuffs.cd:SetReverse(true)
		RaidDebuffs.cd.noOCC = true
		RaidDebuffs.cd.noCooldownCount = true
		RaidDebuffs.cd:SetHideCountdownNumbers(true)

		RaidDebuffs.showDispellableDebuff = true
		RaidDebuffs.onlyMatchSpellID = true
		RaidDebuffs.FilterDispellableDebuff = true
		--RaidDebuffs.forceShow = true -- TEST

		RaidDebuffs.time = RaidDebuffs:CreateFontString(nil, "OVERLAY")
		RaidDebuffs.time:SetFont(C.Medias.Font, 12, "OUTLINE")
		RaidDebuffs.time:Point("CENTER", RaidDebuffs, 0, 0)

		RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, "OVERLAY")
		RaidDebuffs.count:SetFont(C.Medias.Font, 12, "OUTLINE")
		RaidDebuffs.count:SetPoint("BOTTOMRIGHT", RaidDebuffs, "BOTTOMRIGHT", 2, 0)
		RaidDebuffs.count:SetTextColor(1, .9, 0)

		self.RaidDebuffs = RaidDebuffs
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

	self:Tag(Name, "[Tukui:GetRaidNameColor][Tukui:NameShort]")
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Panel = Panel
	self.Name = Name
	self.ReadyCheckIndicator = ReadyCheck
	self.Range = Range
	self.RaidTargetIndicator = RaidIcon
	self.ThreatIndicator = Threat
	self.Highlight = Highlight

	self:RegisterEvent("PLAYER_TARGET_CHANGED", TukuiUnitFrames.Highlight, true)
	self:RegisterEvent("RAID_ROSTER_UPDATE", TukuiUnitFrames.Highlight, true)
	self:RegisterEvent("PLAYER_FOCUS_CHANGED", TukuiUnitFrames.Highlight, true)
end
