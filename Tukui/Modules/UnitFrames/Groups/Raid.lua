local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local CreateFrame = _G.CreateFrame

local HealthTexture
local PowerTexture
local Font
local HealthFont

-- Make raid widgets available for external edits.
local RaidWidgets = UnitFrames.WidgetManager

-- oUF base elements
-- Configures oUF element Health.
local function createHealth(unitFrame)
	local Health = CreateFrame("StatusBar", nil, unitFrame)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetHeight(unitFrame:GetHeight() - 3 - 19)
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
	if C.UnitFrames.Smoothing then
		Health.smoothing = true
	end

	unitFrame.Health = Health
	unitFrame.Health.bg = Health.Background
	unitFrame:Tag(Health.Value, C.Raid.HealthTag.Value)
end

-- Configures oUF element Power.
local function createPower(unitFrame)
	local Power = CreateFrame("StatusBar", nil, unitFrame)
	Power:SetHeight(3)
	Power:SetPoint("TOPLEFT", unitFrame.Health, "BOTTOMLEFT", 0, -1)
	Power:SetPoint("TOPRIGHT", unitFrame.Health, "BOTTOMRIGHT", 0, -1)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetTexture(PowerTexture)
	Power.Background:SetAllPoints(Power)
	Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Power:SetStatusBarTexture(PowerTexture)

	Power.colorPower = true
	Power.isRaid = true
	if C.UnitFrames.Smoothing then
		Power.smoothing = true
	end

	unitFrame.Power = Power
	unitFrame.Power.bg = Power.Background
end

-- Configures oUF element RaidTargetIndicator.
local function createRaidTargetIndicator(unitFrame)
	local RaidIcon = unitFrame.Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(C.UnitFrames.RaidIconSize, C.UnitFrames.RaidIconSize)
	RaidIcon:SetPoint("TOP", unitFrame, 0, C.UnitFrames.RaidIconSize / 2)
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	unitFrame.RaidTargetIndicator = RaidIcon
end

-- Configures oUF element ReadyCheckIndicator.
local function createReadyCheckIndicator(unitFrame)
	local ReadyCheck = unitFrame.Power:CreateTexture(nil, "OVERLAY", nil, 2)
	ReadyCheck:SetSize(12, 12)
	ReadyCheck:SetPoint("CENTER")

	unitFrame.ReadyCheckIndicator = ReadyCheck
end

-- Configures oUF element ResurrectIndicator.
local function createResurrectIndicator(unitFrame)
	local Health = unitFrame.Health
	local ResurrectIndicator = Health:CreateTexture(nil, "OVERLAY")
	ResurrectIndicator:SetSize(24, 24)
	ResurrectIndicator:SetPoint("CENTER", Health)

	unitFrame.ResurrectIndicator = ResurrectIndicator
end

-- Configures oUF element Range.
local function createRange(unitFrame)
	local Range = {
		insideAlpha = 1,
		outsideAlpha = C["Raid"].RangeAlpha,
	}

	unitFrame.Range = Range
end

-- Configures oUF element Buffs (part of Auras).
local function createBuffs(unitFrame)
	local Buffs = CreateFrame("Frame", unitFrame:GetName().."Buffs", unitFrame.Health)
	local onlyShowPlayer = C.Raid.RaidBuffs.Value == "Self"
	local filter = C.Raid.RaidBuffs.Value == "All" and "HELPFUL" or "HELPFUL|RAID"

	Buffs:SetPoint("TOPLEFT", unitFrame.Health, "TOPLEFT", 0, 0)
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
	Buffs.filter = filter
	Buffs.IsRaid = true
	Buffs.PostCreateIcon = UnitFrames.PostCreateAura
	Buffs.PostUpdateIcon = UnitFrames.DesaturateBuffs
	Buffs.PostCreateButton = UnitFrames.PostCreateAura
	Buffs.PostUpdateButton = UnitFrames.DesaturateBuffs

	unitFrame.Buffs = Buffs
end

-- Configures oUF element HealthPrediction.
local function createHealComm(unitframe)
	if C.UnitFrames.HealComm then
		local Health = unitframe.Health
		local myBar = CreateFrame("StatusBar", nil, Health)
		local otherBar = CreateFrame("StatusBar", nil, Health)
		local absorbBar = CreateFrame("StatusBar", nil, Health)
		local Vertical = Health:GetOrientation() == "VERTICAL" and true or false

		myBar:SetOrientation(Vertical and "VERTICAL" or "HORIZONTAL")
		myBar:SetFrameLevel(Health:GetFrameLevel())
		myBar:SetStatusBarTexture(HealthTexture)
		myBar:SetPoint(Vertical and "LEFT" or "TOP")
		myBar:SetPoint(Vertical and "RIGHT" or "BOTTOM")
		myBar:SetPoint(Vertical and "BOTTOM" or "LEFT", Health:GetStatusBarTexture(), Vertical and "TOP" or "RIGHT")
		myBar:SetWidth(C.Raid.WidthSize)
		myBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommSelfColor))
		myBar:SetMinMaxValues(0, 1)
		myBar:SetValue(0)

		otherBar:SetOrientation(Vertical and "VERTICAL" or "HORIZONTAL")
		otherBar:SetFrameLevel(Health:GetFrameLevel())
		otherBar:SetPoint(Vertical and "LEFT" or "TOP")
		otherBar:SetPoint(Vertical and "RIGHT" or "BOTTOM")
		otherBar:SetPoint(Vertical and "BOTTOM" or "LEFT", myBar:GetStatusBarTexture(), Vertical and "TOP" or "RIGHT")
		otherBar:SetWidth(C.Raid.WidthSize)
		otherBar:SetStatusBarTexture(HealthTexture)
		otherBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommOtherColor))
		otherBar:SetMinMaxValues(0, 1)
		otherBar:SetValue(0)

		absorbBar:SetOrientation(Vertical and "VERTICAL" or "HORIZONTAL")
		absorbBar:SetFrameLevel(Health:GetFrameLevel())
		absorbBar:SetPoint(Vertical and "LEFT" or "TOP")
		absorbBar:SetPoint(Vertical and "RIGHT" or "BOTTOM")
		absorbBar:SetPoint(Vertical and "BOTTOM" or "LEFT", otherBar:GetStatusBarTexture(), Vertical and "TOP" or "RIGHT")
		absorbBar:SetWidth(C.Raid.WidthSize)
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

		unitframe.HealthPrediction = HealthPrediction
	end

	-- Enable smoothing bars animation?
	if C.UnitFrames.Smoothing then
		unitframe.Health.smoothing = true
		unitframe.Power.smoothing = true

		if unitframe.HealthPrediction then
			unitframe.HealthPrediction.smoothing = true
		end
	end
end


-- oUF Plugins
-- Configures oUF_AuraTrack.
local function createAuraTrack(unitFrame)
	local AuraTrack = CreateFrame("Frame", nil, unitFrame.Health)
	AuraTrack:SetAllPoints()
	AuraTrack.Texture = C.Medias.Normal
	AuraTrack.Icons = C.Raid.AuraTrackIcons
	AuraTrack.SpellTextures = C.Raid.AuraTrackSpellTextures
	AuraTrack.Thickness = C.Raid.AuraTrackThickness
	AuraTrack.Font = C.Medias.Font

	unitFrame.AuraTrack = AuraTrack
end

-- Configures oUF_RaidDebuffs.
local function createRaidDebuffs(unitFrame)
	local Health = unitFrame.Health
	local RaidDebuffs = CreateFrame("Frame", nil, Health)
	local Height = Health:GetHeight()
	local DebuffSize = Height >= 32 and Height - 16 or Height

	RaidDebuffs:SetSize(DebuffSize, DebuffSize)
	RaidDebuffs:SetPoint("CENTER", Health)
	RaidDebuffs:SetFrameLevel(Health:GetFrameLevel() + 10)
	RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, "ARTWORK")
	RaidDebuffs.icon:SetTexCoord(.1, .9, .1, .9)
	RaidDebuffs.icon:SetInside(RaidDebuffs)
	RaidDebuffs.cd = CreateFrame("Cooldown", nil, RaidDebuffs, "CooldownFrameTemplate")
	RaidDebuffs.cd:SetInside(RaidDebuffs, 1, 0)
	RaidDebuffs.cd:SetReverse(true)
	RaidDebuffs.cd:SetHideCountdownNumbers(true)
	RaidDebuffs.cd:SetAlpha(.7)
	RaidDebuffs.timer = RaidDebuffs:CreateFontString(nil, "OVERLAY")
	RaidDebuffs.timer:SetFont(C.Medias.Font, 12, "OUTLINE")
	RaidDebuffs.timer:SetPoint("CENTER", RaidDebuffs, 1, 0)
	RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, "OVERLAY")
	RaidDebuffs.count:SetFont(C.Medias.Font, 12, "OUTLINE")
	RaidDebuffs.count:SetPoint("BOTTOMRIGHT", RaidDebuffs, "BOTTOMRIGHT", 2, 0)
	RaidDebuffs.count:SetTextColor(1, .9, 0)

	unitFrame.RaidDebuffs = RaidDebuffs
end


-- additional plugins
-- Creates a panel for the unit name.
local function createNamePanel(unitFrame)
	local Panel = CreateFrame("Frame", nil, unitFrame)
	Panel:SetPoint("TOPLEFT", unitFrame.Power, "BOTTOMLEFT", 0, -1)
	Panel:SetPoint("TOPRIGHT", unitFrame.Power, "BOTTOMRIGHT", 0, -1)
	Panel:SetPoint("BOTTOM", 0, 0)
	Panel:CreateBackdrop()
	Panel.Backdrop:SetBorderColor(0, 0, 0, 0)

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER")
	Name:SetFontObject(Font)

	unitFrame.Panel = Panel
	unitFrame.Name = Name

	if T.Retail then
		unitFrame:Tag(Name, "[Tukui:GetRaidNameColor][Tukui:NameShort]")
	else
		unitFrame:Tag(Name, "[Tukui:NameShort]")
	end
end

-- Highlights the currently selected unit.
local function createHighlight(unitFrame)
	local Highlight = CreateFrame("Frame", nil, unitFrame, "BackdropTemplate")
	Highlight:SetBackdrop({edgeFile = C.Medias.Glow, edgeSize = C.Raid.HighlightSize})
	Highlight:SetOutside(unitFrame, C.Raid.HighlightSize, C.Raid.HighlightSize)
	Highlight:SetBackdropBorderColor(unpack(C.Raid.HighlightColor))
	Highlight:SetFrameLevel(0)
	Highlight:Hide()

	unitFrame.Highlight = Highlight
end


--[[ Raid style function. ]]
function UnitFrames.Raid(self)
	HealthTexture = T.GetTexture(C["Textures"].UFRaidHealthTexture)
	PowerTexture = T.GetTexture(C["Textures"].UFRaidPowerTexture)
	Font = T.GetFont(C["Raid"].Font)
	HealthFont = T.GetFont(C["Raid"].HealthFont)

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

	-- oUF base elements
	RaidWidgets:add("Health", createHealth)
	RaidWidgets:add("Power", createPower)
	RaidWidgets:add("RaidTargetIndicator", createRaidTargetIndicator)
	RaidWidgets:add("ReadyCheckIndicator", createReadyCheckIndicator)
	RaidWidgets:add("ResurrectIndicator", createResurrectIndicator)
	RaidWidgets:add("Range", createRange)
	if C.Raid.RaidBuffsStyle.Value == "Standard" then
		RaidWidgets:add("Buffs", createBuffs)
	end
	RaidWidgets:add("HealComm", createHealComm)

	-- oUF plugins
	if C.Raid.RaidBuffsStyle.Value == "Aura Track" then
		RaidWidgets:add("AuraTrack", createAuraTrack)
	end
	if C.Raid.DebuffWatch then
		RaidWidgets:add("RaidDebuffs", createRaidDebuffs)
	end

	-- additional plugins
	RaidWidgets:add("NamePanel", createNamePanel)
	RaidWidgets:add("Highlight", createHighlight)

	RaidWidgets:createWidgets(self)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", UnitFrames.Highlight, true)
	self:RegisterEvent("RAID_ROSTER_UPDATE", UnitFrames.Highlight, true)
end
