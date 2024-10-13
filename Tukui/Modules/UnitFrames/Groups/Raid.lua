local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local CreateFrame = _G.CreateFrame

local HealthTexture
local PowerTexture
local Font
local HealthFont



-- oUF base elements
-- Configures oUF element Health.
local function createHealth(unitFrame, config)
	local Health = CreateFrame("StatusBar", nil, unitFrame)
	Health:SetPoint("TOPLEFT")
	Health:SetPoint("TOPRIGHT")
	Health:SetHeight(config.height)
	Health:SetStatusBarTexture(HealthTexture)

	if C.Raid.VerticalHealth then
		Health:SetOrientation("VERTICAL")
	end

	Health.Background = Health:CreateTexture(nil, "BACKGROUND")
	Health.Background:SetTexture(HealthTexture)
	Health.Background:SetAllPoints(Health)
	Health.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Health.Value = Health:CreateFontString(nil, "OVERLAY")
	Health.Value:SetFontObject(config.valueFont)
	Health.Value:SetPoint(config.valueAnchor[1], Health, config.valueAnchor[2], config.valueAnchor[3], config.valueAnchor[4])

	Health.colorDisconnected = true
	Health.colorClass = true
	Health.colorReaction = true
	if C.UnitFrames.Smoothing then
		Health.smoothing = true
	end

	unitFrame.Health = Health
	unitFrame.Health.bg = Health.Background
	unitFrame:Tag(Health.Value, config.Tag)
end

-- Configures oUF element Power.
local function createPower(unitFrame, config)
	local Power = CreateFrame("StatusBar", nil, unitFrame)
	Power:SetHeight(config.height or 3)
	Power:SetPoint("TOPLEFT", unitFrame.Health, "BOTTOMLEFT", 0, -1)
	Power:SetPoint("TOPRIGHT", unitFrame.Health, "BOTTOMRIGHT", 0, -1)

	Power.Background = Power:CreateTexture(nil, "BORDER")
	Power.Background:SetTexture(PowerTexture)
	Power.Background:SetAllPoints(Power)
	Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

	Power:SetStatusBarTexture(PowerTexture)

	Power.colorPower = true
	if C.UnitFrames.Smoothing then
		Power.smoothing = true
	end

	unitFrame.Power = Power
	unitFrame.Power.bg = Power.Background
end

-- Configures oUF element RaidTargetIndicator.
local function createRaidTargetIndicator(unitFrame, config)
	local Health = unitFrame.Health
	local RaidIcon = Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(config.size, config.size)
	RaidIcon:SetPoint(config.anchor[1], Health, config.anchor[2], config.anchor[3], config.anchor[4])
	RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

	unitFrame.RaidTargetIndicator = RaidIcon
end

-- Configures oUF element ReadyCheckIndicator.
local function createReadyCheckIndicator(unitFrame, config)
	local Power = unitFrame.Power
	local ReadyCheck = Power:CreateTexture(nil, "OVERLAY", nil, 2)
	ReadyCheck:SetSize(config.size, config.size)
	ReadyCheck:SetPoint(config.anchor[1], Power, config.anchor[2], config.anchor[3], config.anchor[4])

	unitFrame.ReadyCheckIndicator = ReadyCheck
end

-- Configures oUF element ResurrectIndicator.
local function createResurrectIndicator(unitFrame, config)
	local Health = unitFrame.Health
	local ResurrectIndicator = Health:CreateTexture(nil, "OVERLAY")
	ResurrectIndicator:SetSize(config.size, config.size)
	ResurrectIndicator:SetPoint(config.anchor[1], Health, config.anchor[2], config.anchor[3], config.anchor[4])

	unitFrame.ResurrectIndicator = ResurrectIndicator
end

-- Configures oUF element Range.
local function createRange(unitFrame, config)
	local Range = {
		insideAlpha = 1,
		outsideAlpha = config.outsideAlpha,
	}

	unitFrame.Range = Range
end

-- Configures oUF element Buffs (part of Auras).
local function createBuffs(unitFrame, config)
	local Buffs = CreateFrame("Frame", unitFrame:GetName().."Buffs", unitFrame.Health)

	Buffs:SetPoint(config.anchor[1], unitFrame.Health, config.anchor[2], config.anchor[3], config.anchor[4])
	Buffs:SetHeight(config.height)
	Buffs:SetWidth(config.width)
	Buffs.size = config.buffSize
	Buffs.num = config.buffNum
	Buffs.numRow = 1
	Buffs.spacing = 0
	Buffs.initialAnchor = "TOPLEFT"
	Buffs.disableCooldown = true
	Buffs.disableMouse = true
	Buffs.onlyShowPlayer = config.onlyShowPlayer
	Buffs.filter = config.filter
	Buffs.PostCreateIcon = UnitFrames.PostCreateAura
	Buffs.PostUpdateIcon = UnitFrames.DesaturateBuffs
	Buffs.PostCreateButton = UnitFrames.PostCreateAura
	Buffs.PostUpdateButton = UnitFrames.DesaturateBuffs

	unitFrame.Buffs = Buffs
end

-- Configures oUF element HealthPrediction.
local function createHealComm(unitframe, config)
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
	myBar:SetWidth(config.width)
	myBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommSelfColor))
	myBar:SetMinMaxValues(0, 1)
	myBar:SetValue(0)

	otherBar:SetOrientation(Vertical and "VERTICAL" or "HORIZONTAL")
	otherBar:SetFrameLevel(Health:GetFrameLevel())
	otherBar:SetPoint(Vertical and "LEFT" or "TOP")
	otherBar:SetPoint(Vertical and "RIGHT" or "BOTTOM")
	otherBar:SetPoint(Vertical and "BOTTOM" or "LEFT", myBar:GetStatusBarTexture(), Vertical and "TOP" or "RIGHT")
	otherBar:SetWidth(config.width)
	otherBar:SetStatusBarTexture(HealthTexture)
	otherBar:SetStatusBarColor(unpack(C.UnitFrames.HealCommOtherColor))
	otherBar:SetMinMaxValues(0, 1)
	otherBar:SetValue(0)

	absorbBar:SetOrientation(Vertical and "VERTICAL" or "HORIZONTAL")
	absorbBar:SetFrameLevel(Health:GetFrameLevel())
	absorbBar:SetPoint(Vertical and "LEFT" or "TOP")
	absorbBar:SetPoint(Vertical and "RIGHT" or "BOTTOM")
	absorbBar:SetPoint(Vertical and "BOTTOM" or "LEFT", otherBar:GetStatusBarTexture(), Vertical and "TOP" or "RIGHT")
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
local function createAuraTrack(unitFrame, config)
	local AuraTrack = CreateFrame("Frame", nil, unitFrame.Health)
	AuraTrack:SetAllPoints()
	AuraTrack.Texture = C.Medias.Normal
	AuraTrack.Font = C.Medias.Font
	AuraTrack.Icons = config.icons
	AuraTrack.SpellTextures = config.texture
	AuraTrack.Thickness = config.thickness

	unitFrame.AuraTrack = AuraTrack
end

-- Configures oUF_RaidDebuffs.
local function createRaidDebuffs(unitFrame, config)
	local Health = unitFrame.Health
	local RaidDebuffs = CreateFrame("Frame", nil, Health)

	RaidDebuffs:SetSize(config.size, config.size)
	RaidDebuffs:SetPoint(config.anchor[1], config.anchor[2], config.anchor[3], config.anchor[4])
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
local function createNamePanel(unitFrame, config)
	local Panel = CreateFrame("Frame", nil, unitFrame)
	Panel:SetPoint("TOPLEFT", unitFrame.Power, "BOTTOMLEFT", 0, -1)
	Panel:SetPoint("TOPRIGHT", unitFrame.Power, "BOTTOMRIGHT", 0, -1)
	Panel:SetPoint("BOTTOM", 0, 0)
	Panel:CreateBackdrop()
	Panel.Backdrop:SetBorderColor(0, 0, 0, 0)

	local Name = Panel:CreateFontString(nil, "OVERLAY")
	Name:SetPoint(config.nameAnchor)
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
local function createHighlight(unitFrame, config)
	local Highlight = CreateFrame("Frame", nil, unitFrame, "BackdropTemplate")
	Highlight:SetBackdrop({edgeFile = C.Medias.Glow, edgeSize = config.size})
	Highlight:SetOutside(unitFrame, config.size, config.size)
	Highlight:SetBackdropBorderColor(unpack(config.color))
	Highlight:SetFrameLevel(0)
	Highlight:Hide()

	unitFrame.Highlight = Highlight
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

	RaidWidgets:add("Health", createHealth, { height = C.Raid.HeightSize - 1 - 3 - 1 -18,  -- border, power, border, namepanel
		valueFont = HealthFont, valueAnchor = {"CENTER", 0, -6}, Tag = C.Raid.HealthTag.Value })
	RaidWidgets:add("Power", createPower, {})
	RaidWidgets:add("NamePanel", createNamePanel, { nameAnchor = "CENTER" })

	RaidWidgets:add("RaidTargetIndicator", createRaidTargetIndicator, { size = C.UnitFrames.RaidIconSize, anchor = {"TOP", 0, C.UnitFrames.RaidIconSize / 2} })
	RaidWidgets:add("ReadyCheckIndicator", createReadyCheckIndicator, { size = 12, anchor = {"CENTER"} })
	RaidWidgets:add("ResurrectIndicator", createResurrectIndicator, { size = 24, anchor = {"CENTER"} })
	RaidWidgets:add("Range", createRange, { outsideAlpha = C["Raid"].RangeAlpha })
	RaidWidgets:add("Highlight", createHighlight, { size = C.Raid.HighlightSize, color = C.Raid.HighlightColor })

	if C.UnitFrames.HealComm then
		RaidWidgets:add("HealComm", createHealComm, { width = C.Raid.WidthSize })
	end

	if C.Raid.RaidBuffsStyle.Value == "Standard" then
		RaidWidgets:add("Buffs", createBuffs, { filter = C.Raid.RaidBuffs.Value == "All" and "HELPFUL" or "HELPFUL|RAID",
			onlyShowPlayer = C.Raid.RaidBuffs.Value == "Self", height = 16, width = 79, anchor = {"TOPLEFT"},
			buffSize = 16, buffNum = 5 })
	elseif C.Raid.RaidBuffsStyle.Value == "Aura Track" then
		RaidWidgets:add("AuraTrack", createAuraTrack, { icons = C.Raid.AuraTrackIcons, texture = C.Raid.AuraTrackSpellTextures, thickness = C.Raid.AuraTrackThickness })
	end

	if C.Raid.DebuffWatch then
		local height = C.Raid.HeightSize - 1 - 3 - 1 -18  -- border, power, border, namepanel
		RaidWidgets:add("RaidDebuffs", createRaidDebuffs, { size = height >= 32 and height - 16 or height, anchor = {"CENTER"} })
	end

	RaidWidgets:createWidgets(self)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", UnitFrames.Highlight, true)
	self:RegisterEvent("RAID_ROSTER_UPDATE", UnitFrames.Highlight, true)
end
