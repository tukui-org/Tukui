local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

function UnitFrames:Raid()
	local HealthTexture = T.GetTexture(C["Textures"].UFRaidHealthTexture)
	local PowerTexture = T.GetTexture(C["Textures"].UFRaidPowerTexture)
	local Font = T.GetFont(C["Raid"].Font)
	local HealthFont = T.GetFont(C["Raid"].HealthFont)

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
	Health:SetHeight(self:GetHeight() - 3 - 19)
	Health:SetStatusBarTexture(HealthTexture)

	if C.Raid.VerticalHealth then
		Health:SetOrientation("VERTICAL")
	end

	Health.Background = Health:CreateTexture(nil, "BACKGROUND")
	Health.Background:SetTexture(HealthTexture)
    Health.Background:SetAllPoints(Health)
	Health.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(HealthFont)
	Health.Value:SetPoint("CENTER", Health, "CENTER", 0, -6)

	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true
	Health.isRaid = true

	-- Power
	local Power = CreateFrame("StatusBar", nil, self)
	Power:SetHeight(3)
	Power:SetPoint("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
	Power:SetPoint("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetTexture(PowerTexture)
	Power.Background:SetAllPoints(Power)
	Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Power:SetStatusBarTexture(PowerTexture)

	Power.colorPower = true
	Power.isRaid = true

	local Panel = CreateFrame("Frame", nil, self)
	Panel:SetPoint("TOPLEFT", Power, "BOTTOMLEFT", 0, -1)
	Panel:SetPoint("TOPRIGHT", Power, "BOTTOMRIGHT", 0, -1)
	Panel:SetPoint("BOTTOM", 0, 0)
	Panel:CreateBackdrop()
	Panel.Backdrop:SetBorderColor(0, 0, 0, 0)

	local Name = Panel:CreateFontString(nil, "OVERLAY", 1)
	Name:SetPoint("CENTER")
	Name:SetFontObject(Font)

	local ReadyCheck = Power:CreateTexture(nil, "OVERLAY", 2)
	ReadyCheck:SetHeight(12)
	ReadyCheck:SetWidth(12)
	ReadyCheck:SetPoint("CENTER")

	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(C.UnitFrames.RaidIconSize, C.UnitFrames.RaidIconSize)
	RaidIcon:SetPoint("TOP", self, 0, C.UnitFrames.RaidIconSize / 2)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	local Range = {
		insideAlpha = 1,
		outsideAlpha = C["Raid"].RangeAlpha,
	}
	
	if C.Raid.AuraTrack then
		local AuraTrack = CreateFrame("Frame", nil, Health)
		AuraTrack:SetAllPoints()
		AuraTrack.Texture = C.Medias.Normal
		AuraTrack.Icons = C.Raid.AuraTrackIcons
		AuraTrack.Thickness = C.Raid.AuraTrackThickness
		AuraTrack.IconSize = C.Raid.AuraTrackIconSize
		AuraTrack.Spacing = C.Raid.AuraTrackSpacing

		self.AuraTrack = AuraTrack
	elseif C.Raid.RaidBuffs.Value ~= "Hide" then
		local Buffs = CreateFrame("Frame", self:GetName().."Buffs", Health)
		local onlyShowPlayer = C.Raid.RaidBuffs.Value == "Self"
		local filter = C.Raid.RaidBuffs.Value == "All" and "HELPFUL" or "HELPFUL|RAID"

		Buffs:SetPoint("TOPLEFT", Health, "TOPLEFT", 0, 0)
		Buffs:SetHeight(16)
		Buffs:SetWidth(79)
		Buffs.size = 16
		Buffs.num = 5
		Buffs.numRow = 1
		Buffs.spacing = 0
		Buffs.initialAnchor = "TOPLEFT"
		Buffs.disableCooldown = true
		Buffs.disableMouse = true
		Buffs.onlyShowPlayer = onlyShowPlayer
		Buffs.desaturateNonPlayerBuffs = C.Raid.DesaturateNonPlayerBuffs
		Buffs.filter = filter
		Buffs.IsRaid = true
		Buffs.PostCreateIcon = UnitFrames.PostCreateAura

		self.Buffs = Buffs
	end

	if C.Raid.DebuffWatch then
		local RaidDebuffs = CreateFrame("Frame", nil, Health)
		RaidDebuffs:SetHeight(20)
		RaidDebuffs:SetWidth(20)
		RaidDebuffs:SetPoint("CENTER", Health)
		RaidDebuffs:SetFrameLevel(Health:GetFrameLevel() + 10)
		RaidDebuffs:CreateBackdrop()
		RaidDebuffs:CreateShadow()
		RaidDebuffs.Shadow:SetFrameLevel(RaidDebuffs:GetFrameLevel() + 1)
		RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, "ARTWORK")
		RaidDebuffs.icon:SetTexCoord(.1, .9, .1, .9)
		RaidDebuffs.icon:SetInside(RaidDebuffs)
		RaidDebuffs.cd = CreateFrame("Cooldown", nil, RaidDebuffs, "CooldownFrameTemplate")
		RaidDebuffs.cd:SetInside(RaidDebuffs, 1, 0)
		RaidDebuffs.cd:SetReverse(true)
		RaidDebuffs.cd.noOCC = true
		RaidDebuffs.cd.noCooldownCount = true
		RaidDebuffs.cd:SetHideCountdownNumbers(true)
		RaidDebuffs.cd:SetAlpha(.7)
		RaidDebuffs.showDispellableDebuff = true
		RaidDebuffs.onlyMatchSpellID = true
		RaidDebuffs.FilterDispellableDebuff = true
		RaidDebuffs.time = RaidDebuffs:CreateFontString(nil, "OVERLAY")
		RaidDebuffs.time:SetFont(C.Medias.Font, 12, "OUTLINE")
		RaidDebuffs.time:SetPoint("CENTER", RaidDebuffs, 1, 0)
		RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, "OVERLAY")
		RaidDebuffs.count:SetFont(C.Medias.Font, 12, "OUTLINE")
		RaidDebuffs.count:SetPoint("BOTTOMRIGHT", RaidDebuffs, "BOTTOMRIGHT", 2, 0)
		RaidDebuffs.count:SetTextColor(1, .9, 0)
		--RaidDebuffs.forceShow = true

		self.RaidDebuffs = RaidDebuffs
	end

	if C.UnitFrames.HealComm then
		local myBar = CreateFrame("StatusBar", nil, Health)
		local otherBar = CreateFrame("StatusBar", nil, Health)
		local absorbBar = CreateFrame("StatusBar", nil, Health)

		myBar:SetFrameLevel(Health:GetFrameLevel())
		myBar:SetStatusBarTexture(HealthTexture)
		myBar:SetPoint("TOP")
		myBar:SetPoint("BOTTOM")
		myBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT")
		myBar:SetWidth(129)
		myBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommSelfColor))

		otherBar:SetFrameLevel(Health:GetFrameLevel())
		otherBar:SetPoint("TOP")
		otherBar:SetPoint("BOTTOM")
		otherBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT")
		otherBar:SetWidth(129)
		otherBar:SetStatusBarTexture(HealthTexture)
		otherBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommOtherColor))
		
		absorbBar:SetFrameLevel(Health:GetFrameLevel())
		absorbBar:SetPoint("TOP")
		absorbBar:SetPoint("BOTTOM")
		absorbBar:SetPoint("LEFT", Health:GetStatusBarTexture(), "RIGHT")
		absorbBar:SetWidth(129)
		absorbBar:SetStatusBarTexture(HealthTexture)
		absorbBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommAbsorbColor))

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
	Highlight:SetBackdrop({edgeFile = C.Medias.Glow, edgeSize = C.Raid.HighlightSize})
	Highlight:SetOutside(self, C.Raid.HighlightSize, C.Raid.HighlightSize)
	Highlight:SetBackdropBorderColor(unpack(C.Raid.HighlightColor))
	Highlight:SetFrameLevel(0)
	Highlight:Hide()

	self:Tag(Name, "[Tukui:GetRaidNameColor][Tukui:NameShort]")
	self:Tag(Health.Value, C.Raid.HealthTag.Value)
	self.Health = Health
	self.Health.bg = Health.Background
	self.Power = Power
	self.Power.bg = Power.Background
	self.Panel = Panel
	self.Name = Name
	self.ReadyCheckIndicator = ReadyCheck
	self.Range = Range
	self.RaidTargetIndicator = RaidIcon
	self.Highlight = Highlight
	self.ResurrectIndicator = ResurrectIndicator

	self:RegisterEvent("PLAYER_TARGET_CHANGED", UnitFrames.Highlight, true)
	self:RegisterEvent("RAID_ROSTER_UPDATE", UnitFrames.Highlight, true)
end
