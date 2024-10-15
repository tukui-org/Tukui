local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local CreateFrame = _G.CreateFrame

local HealthTexture
local PowerTexture
local Font
local HealthFont



-- oUF base elements
-- Configures oUF element Health.
local function Health(unitFrame, config)
	local health = CreateFrame("StatusBar", nil, unitFrame)
	health:SetPoint("TOPLEFT")
	health:SetPoint("TOPRIGHT")
	health:SetHeight(config.height)
	health:SetStatusBarTexture(HealthTexture)

	if C.Raid.VerticalHealth then
		health:SetOrientation("VERTICAL")
	end

	health.Background = health:CreateTexture(nil, "BACKGROUND")
	health.Background:SetTexture(HealthTexture)
	health.Background:SetAllPoints(health)
	health.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	health.Value = health:CreateFontString(nil, "OVERLAY")
	health.Value:SetFontObject(config.valueFont)
	health.Value:SetPoint(config.valueAnchor[1], health, config.valueAnchor[2], config.valueAnchor[3], config.valueAnchor[4])

	health.colorDisconnected = true
	health.colorClass = true
	health.colorReaction = true

	if C.UnitFrames.Smoothing then
		health.smoothing = true
	end

	unitFrame.Health = health
	unitFrame.Health.bg = health.Background
	unitFrame:Tag(health.Value, config.Tag)
end

-- Configures oUF element Power.
local function Power(unitFrame, config)
	local health = unitFrame.Health
	local power = CreateFrame("StatusBar", nil, unitFrame)
	power:SetHeight(config.height or 3)
	power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -1)
	power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -1)
	power:SetStatusBarTexture(PowerTexture)

	power.Background = power:CreateTexture(nil, "BORDER")
	power.Background:SetTexture(PowerTexture)
	power.Background:SetAllPoints(power)
	power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	power.colorPower = true

	if C.UnitFrames.Smoothing then
		power.smoothing = true
	end

	unitFrame.Power = power
	unitFrame.Power.bg = power.Background
end

-- Configures oUF element RaidTargetIndicator.
local function RaidTargetIndicator(unitFrame, config)
	local health = unitFrame.Health
	local raidIcon = health:CreateTexture(nil, "OVERLAY")
	raidIcon:SetSize(config.size, config.size)
	raidIcon:SetPoint(config.anchor[1], health, config.anchor[2], config.anchor[3], config.anchor[4])
	raidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	unitFrame.RaidTargetIndicator = raidIcon
end

-- Configures oUF element ReadyCheckIndicator.
local function ReadyCheckIndicator(unitFrame, config)
	local power = unitFrame.Power
	local readyCheck = power:CreateTexture(nil, "OVERLAY", nil, 2)
	readyCheck:SetSize(config.size, config.size)
	readyCheck:SetPoint(config.anchor[1], power, config.anchor[2], config.anchor[3], config.anchor[4])

	unitFrame.ReadyCheckIndicator = readyCheck
end

-- Configures oUF element ResurrectIndicator.
local function ResurrectIndicator(unitFrame, config)
	local health = unitFrame.Health
	local resurrect = health:CreateTexture(nil, "OVERLAY")
	resurrect:SetSize(config.size, config.size)
	resurrect:SetPoint(config.anchor[1], health, config.anchor[2], config.anchor[3], config.anchor[4])

	unitFrame.ResurrectIndicator = resurrect
end

-- Configures oUF element Range.
local function Range(unitFrame, config)
	local range = {
		insideAlpha = 1,
		outsideAlpha = config.outsideAlpha,
	}

	unitFrame.Range = range
end

-- Configures oUF element Buffs (part of Auras).
local function Buffs(unitFrame, config)
	local health = unitFrame.Health
	local buffs = CreateFrame("Frame", unitFrame:GetName().."Buffs", health)
	buffs:SetPoint(config.anchor[1], health, config.anchor[2], config.anchor[3], config.anchor[4])
	buffs:SetHeight(config.height)
	buffs:SetWidth(config.width)

	buffs.size = config.buffSize
	buffs.num = config.buffNum
	buffs.numRow = 1
	buffs.spacing = 0
	buffs.initialAnchor = "TOPLEFT"
	buffs.disableCooldown = true
	buffs.disableMouse = true
	buffs.onlyShowPlayer = config.onlyShowPlayer
	buffs.filter = config.filter
	buffs.PostCreateIcon = UnitFrames.PostCreateAura
	buffs.PostUpdateIcon = UnitFrames.DesaturateBuffs
	buffs.PostCreateButton = UnitFrames.PostCreateAura
	buffs.PostUpdateButton = UnitFrames.DesaturateBuffs

	unitFrame.Buffs = buffs
end

-- Configures oUF element HealthPrediction.
local function HealComm(unitframe, config)
	local health = unitframe.Health
	local myBar = CreateFrame("StatusBar", nil, health)
	local otherBar = CreateFrame("StatusBar", nil, health)
	local absorbBar = CreateFrame("StatusBar", nil, health)
	local vertical = health:GetOrientation() == "VERTICAL" and true or false

	myBar:SetOrientation(vertical and "VERTICAL" or "HORIZONTAL")
	myBar:SetFrameLevel(health:GetFrameLevel())
	myBar:SetStatusBarTexture(HealthTexture)
	myBar:SetPoint(vertical and "LEFT" or "TOP")
	myBar:SetPoint(vertical and "RIGHT" or "BOTTOM")
	myBar:SetPoint(vertical and "BOTTOM" or "LEFT", health:GetStatusBarTexture(), vertical and "TOP" or "RIGHT")
	myBar:SetWidth(config.width)
	myBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommSelfColor))
	myBar:SetMinMaxValues(0, 1)
	myBar:SetValue(0)

	otherBar:SetOrientation(vertical and "VERTICAL" or "HORIZONTAL")
	otherBar:SetFrameLevel(health:GetFrameLevel())
	otherBar:SetPoint(vertical and "LEFT" or "TOP")
	otherBar:SetPoint(vertical and "RIGHT" or "BOTTOM")
	otherBar:SetPoint(vertical and "BOTTOM" or "LEFT", myBar:GetStatusBarTexture(), vertical and "TOP" or "RIGHT")
	otherBar:SetWidth(config.width)
	otherBar:SetStatusBarTexture(HealthTexture)
	otherBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommOtherColor))
	otherBar:SetMinMaxValues(0, 1)
	otherBar:SetValue(0)

	absorbBar:SetOrientation(vertical and "VERTICAL" or "HORIZONTAL")
	absorbBar:SetFrameLevel(health:GetFrameLevel())
	absorbBar:SetPoint(vertical and "LEFT" or "TOP")
	absorbBar:SetPoint(vertical and "RIGHT" or "BOTTOM")
	absorbBar:SetPoint(vertical and "BOTTOM" or "LEFT", otherBar:GetStatusBarTexture(), vertical and "TOP" or "RIGHT")
	absorbBar:SetWidth(config.width)
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

	-- Enable smoothing bars animation?
	if C.UnitFrames.Smoothing then
		unitframe.HealthPrediction.smoothing = true
	end
end


-- oUF Plugins
-- Configures oUF_AuraTrack.
local function AuraTrack(unitFrame, config)
	local health = unitFrame.Health
	local auraTrack = CreateFrame("Frame", nil, health)
	auraTrack:SetAllPoints()
	auraTrack.Texture = C.Medias.Normal
	auraTrack.Font = C.Medias.Font
	auraTrack.Icons = config.icons
	auraTrack.SpellTextures = config.texture
	auraTrack.Thickness = config.thickness

	unitFrame.AuraTrack = auraTrack
end

-- Configures oUF_RaidDebuffs.
local function RaidDebuffs(unitFrame, config)
	local health = unitFrame.Health
	local raidDebuffs = CreateFrame("Frame", nil, health)

	raidDebuffs:SetSize(config.size, config.size)
	raidDebuffs:SetPoint(config.anchor[1], health, config.anchor[2], config.anchor[3], config.anchor[4])
	raidDebuffs:SetFrameLevel(health:GetFrameLevel() + 10)
	raidDebuffs.icon = raidDebuffs:CreateTexture(nil, "ARTWORK")
	raidDebuffs.icon:SetTexCoord(.1, .9, .1, .9)
	raidDebuffs.icon:SetInside(raidDebuffs)
	raidDebuffs.cd = CreateFrame("Cooldown", nil, raidDebuffs, "CooldownFrameTemplate")
	raidDebuffs.cd:SetInside(raidDebuffs, 1, 0)
	raidDebuffs.cd:SetReverse(true)
	raidDebuffs.cd:SetHideCountdownNumbers(true)
	raidDebuffs.cd:SetAlpha(.7)
	raidDebuffs.timer = raidDebuffs:CreateFontString(nil, "OVERLAY")
	raidDebuffs.timer:SetFont(C.Medias.Font, 12, "OUTLINE")
	raidDebuffs.timer:SetPoint("CENTER", raidDebuffs, 1, 0)
	raidDebuffs.count = raidDebuffs:CreateFontString(nil, "OVERLAY")
	raidDebuffs.count:SetFont(C.Medias.Font, 12, "OUTLINE")
	raidDebuffs.count:SetPoint("BOTTOMRIGHT", raidDebuffs, "BOTTOMRIGHT", 2, 0)
	raidDebuffs.count:SetTextColor(1, .9, 0)

	unitFrame.RaidDebuffs = raidDebuffs
end


-- additional plugins
-- Creates a panel for the unit name.
local function NamePanel(unitFrame, config)
	local power = unitFrame.Power
	local panel = CreateFrame("Frame", nil, unitFrame)
	panel:SetPoint("TOPLEFT", power, "BOTTOMLEFT", 0, -1)
	panel:SetPoint("TOPRIGHT", power, "BOTTOMRIGHT", 0, -1)
	panel:SetPoint("BOTTOM", 0, 0)
	panel:CreateBackdrop()
	panel.Backdrop:SetBorderColor(0, 0, 0, 0)

	local name = panel:CreateFontString(nil, "OVERLAY")
	name:SetPoint(config.nameAnchor[1], panel, config.nameAnchor[2], config.nameAnchor[3], config.nameAnchor[4])
	name:SetFontObject(Font)

	unitFrame.Panel = panel
	unitFrame.Name = name

	if T.Retail then
		unitFrame:Tag(name, "[Tukui:GetRaidNameColor][Tukui:NameShort]")
	else
		unitFrame:Tag(name, "[Tukui:NameShort]")
	end
end

-- Highlights the currently selected unit.
local function Highlight(unitFrame, config)
	local highlight = CreateFrame("Frame", nil, unitFrame, "BackdropTemplate")
	highlight:SetBackdrop({edgeFile = C.Medias.Glow, edgeSize = config.size})
	highlight:SetOutside(unitFrame, config.size, config.size)
	highlight:SetBackdropBorderColor(unpack(config.color))
	highlight:SetFrameLevel(0)
	highlight:Hide()

	unitFrame.Highlight = highlight
end

-- Create new WidgetManager for Raid and expose for external edits.
local RaidWidgets = UnitFrames.newWidgetManager()
UnitFrames.RaidWidgets = RaidWidgets

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

	local config = {
		Health = {
			height = C.Raid.HeightSize - 1 - 3 - 1 -18,  -- border, power, border, namepanel
			valueFont = HealthFont,
			valueAnchor = {"CENTER", 0, -6},
			Tag = C.Raid.HealthTag.Value, },
		Power = {
			},
		NamePanel = {
			nameAnchor = "CENTER", },
		RaidTargetIndicator = {
			size = C.UnitFrames.RaidIconSize,
			anchor = {"TOP", 0, C.UnitFrames.RaidIconSize / 2}, },
		ReadyCheckIndicator = {
			size = 12,
			anchor = {"CENTER"}, },
		ResurrectIndicator = {
			size = 24,
			anchor = {"CENTER"}, },
		Range = {
			outsideAlpha = C["Raid"].RangeAlpha, },
		Highlight = {
			size = C.Raid.HighlightSize,
			color = C.Raid.HighlightColor, },
		HealComm = {
			width = C.Raid.WidthSize, },
		Buffs = {
			height = 16,
			width = 79,
			anchor = {"TOPLEFT"},
			buffSize = 16,
			buffNum = 5,
			filter = C.Raid.RaidBuffs.Value == "All" and "HELPFUL" or "HELPFUL|RAID",
			onlyShowPlayer = C.Raid.RaidBuffs.Value == "Self", },
		AuraTrack = {
			icons = C.Raid.AuraTrackIcons,
			texture = C.Raid.AuraTrackSpellTextures,
			thickness = C.Raid.AuraTrackThickness, },
		RaidDebuffs = {
			size = 24,
			anchor = {"CENTER"}, },
	}

	RaidWidgets:add("Health", Health, config.Health)
	RaidWidgets:add("Power", Power, config.Power)
	RaidWidgets:add("NamePanel", NamePanel, config.NamePanel)

	RaidWidgets:add("RaidTargetIndicator", RaidTargetIndicator, config.RaidTargetIndicator)
	RaidWidgets:add("ReadyCheckIndicator", ReadyCheckIndicator, config.ReadyCheckIndicator)
	RaidWidgets:add("ResurrectIndicator", ResurrectIndicator, config.ResurrectIndicator)
	RaidWidgets:add("Range", Range, config.Range)
	RaidWidgets:add("Highlight", Highlight, config.Highlight)

	if C.UnitFrames.HealComm then
		RaidWidgets:add("HealComm", HealComm, config.HealComm)
	end

	if C.Raid.RaidBuffsStyle.Value == "Standard" then
		RaidWidgets:add("Buffs", Buffs, config.Buffs)
	elseif C.Raid.RaidBuffsStyle.Value == "Aura Track" then
		RaidWidgets:add("AuraTrack", AuraTrack, config.AuraTrack)
	end

	if C.Raid.DebuffWatch then
		RaidWidgets:add("RaidDebuffs", RaidDebuffs, config.RaidDebuffs)
	end

	RaidWidgets:createWidgets(self)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", UnitFrames.Highlight, true)
	self:RegisterEvent("RAID_ROSTER_UPDATE", UnitFrames.Highlight, true)
end
