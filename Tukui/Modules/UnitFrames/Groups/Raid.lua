local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local CreateFrame = _G.CreateFrame

local HealthTexture
local PowerTexture
local NameFont
local HealthFont


-- oUF base elements
-- Configures oUF element Health.
local HealthBar
do
	local defaults = function(unitFrame)
		return {
			height = C.Raid.HeightSize - 1 - 3 - 1 - 18,  -- border, power, border, namepanel
			orientation = C.Raid.VerticalHealth and "VERTICAL" or "HORIZONTAL",
			valueFont = HealthFont,
			valueAnchor = {"CENTER", 0, -6},
			Tag = C.Raid.HealthTag.Value,
		}
	end

	HealthBar = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local Health = CreateFrame("StatusBar", nil, unitFrame)

		Health:SetPoint("TOPLEFT")
		Health:SetPoint("TOPRIGHT")
		Health:SetHeight(config.height)
		Health:SetStatusBarTexture(HealthTexture)
		Health:SetOrientation(config.orientation)

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
end

-- Configures oUF element Power.
local PowerBar
do
	local defaults = function(unitFrame)
		return {
			height = 3,
		}
	end

	PowerBar = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local Health = unitFrame.Health
		local Power = CreateFrame("StatusBar", nil, unitFrame)

		Power:SetPoint("TOPLEFT", Health, "BOTTOMLEFT", 0, -1)
		Power:SetPoint("TOPRIGHT", Health, "BOTTOMRIGHT", 0, -1)
		Power:SetHeight(config.height)
		Power:SetStatusBarTexture(PowerTexture)

		Power.Background = Power:CreateTexture(nil, "BORDER")
		Power.Background:SetTexture(PowerTexture)
		Power.Background:SetAllPoints(Power)
		Power.Background.multiplier = C.UnitFrames.StatusBarBackgroundMultiplier / 100

		Power.colorPower = true
		if C.UnitFrames.Smoothing then
			Power.smoothing = true
		end

		unitFrame.Power = Power
		unitFrame.Power.bg = Power.Background
	end
end

-- Configures oUF element RaidTargetIndicator.
local RaidTargetIndicator
do
	local defaults = function(unitFrame)
		return {
			parent = unitFrame.Health,
			size = C.UnitFrames.RaidIconSize,
			anchor = {"TOP", 0, C.UnitFrames.RaidIconSize / 2},
		}
	end

	RaidTargetIndicator = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local RaidIcon = config.parent:CreateTexture(nil, "OVERLAY")

		RaidIcon:SetSize(config.size, config.size)
		RaidIcon:SetPoint(config.anchor[1], config.parent, config.anchor[2], config.anchor[3], config.anchor[4])
		RaidIcon:SetTexture([[Interface\AddOns\Tukui\Medias\Textures\Others\RaidIcons]])

		unitFrame.RaidTargetIndicator = RaidIcon
	end
end

-- Configures oUF element ReadyCheckIndicator.
local ReadyCheckIndicator
do
	local defaults = function(unitFrame)
		return {
			parent = unitFrame.Power,
			size = 12,
			anchor = {"CENTER"},
		}
	end

	ReadyCheckIndicator = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local ReadyCheck = config.parent:CreateTexture(nil, "OVERLAY", nil, 2)

		ReadyCheck:SetSize(config.size, config.size)
		ReadyCheck:SetPoint(config.anchor[1], config.parent, config.anchor[2], config.anchor[3], config.anchor[4])

		unitFrame.ReadyCheckIndicator = ReadyCheck
	end
end


-- Configures oUF element ResurrectIndicator.
local ResurrectIndicator
do
	local defaults = function(unitFrame)
		return {
			parent = unitFrame.Health,
			size = 24,
			anchor = {"CENTER"},
		}
	end

	ResurrectIndicator = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local Resurrect = config.parent:CreateTexture(nil, "OVERLAY")

		Resurrect:SetSize(config.size, config.size)
		Resurrect:SetPoint(config.anchor[1], config.parent, config.anchor[2], config.anchor[3], config.anchor[4])

		unitFrame.ResurrectIndicator = Resurrect
	end
end

-- Configures oUF element Range.
local RangeIndicator
do
	local defaults = function(unitFrame)
		return {
			outsideAlpha = C["Raid"].RangeAlpha,
		}
	end

	RangeIndicator = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local Range = {
			insideAlpha = 1,
			outsideAlpha = config.outsideAlpha,
		}

		unitFrame.Range = Range
	end
end

-- Configures oUF element Buffs (part of Auras).
local BuffsIndicator
do
	local defaults = function(unitFrame)
		return {
			parent = unitFrame.Health,
			height = 16,
			width = 79,
			anchor = {"TOPLEFT"},
			buffSize = 16,
			buffNum = 5,
			filter = C.Raid.RaidBuffs.Value == "All" and "HELPFUL" or "HELPFUL|RAID",
			onlyShowPlayer = C.Raid.RaidBuffs.Value == "Self",
		}
	end

	BuffsIndicator = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local Buffs = CreateFrame("Frame", unitFrame:GetName().."Buffs", config.parent)

		Buffs:SetPoint(config.anchor[1], config.parent, config.anchor[2], config.anchor[3], config.anchor[4])
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
end

-- Configures oUF element HealthPrediction.
local HealComm
do
	local defaults = function(unitFrame)
		return {
			width = C.Raid.WidthSize,
		}
	end

	HealComm = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local Health = unitFrame.Health
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

		-- Enable smoothing bars animation?
		if C.UnitFrames.Smoothing then
				HealthPrediction.smoothing = true
		end

		unitFrame.HealthPrediction = HealthPrediction
	end
end


-- oUF Plugins
-- Configures oUF_AuraTrack.
local AuraTrackIndicator
do
	local defaults = function(unitFrame)
		return {
			parent = unitFrame.Health,
			icons = C.Raid.AuraTrackIcons,
			texture = C.Raid.AuraTrackSpellTextures,
			thickness = C.Raid.AuraTrackThickness,
		}
	end

	AuraTrackIndicator = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local AuraTrack = CreateFrame("Frame", nil, config.parent)

		AuraTrack:SetAllPoints()
		AuraTrack.Texture = C.Medias.Normal
		AuraTrack.Font = C.Medias.Font
		AuraTrack.Icons = config.icons
		AuraTrack.SpellTextures = config.texture
		AuraTrack.Thickness = config.thickness

		unitFrame.AuraTrack = AuraTrack
	end
end

-- Configures oUF_RaidDebuffs.
local DebuffIndicator
do
	local defaults = function(unitFrame)
		return {
			parent = unitFrame.Health,
			size = 24,
			anchor = {"CENTER"},
		}
	end

	DebuffIndicator = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local RaidDebuffs = CreateFrame("Frame", nil, config.parent)

		RaidDebuffs:SetSize(config.size, config.size)
		RaidDebuffs:SetPoint(config.anchor[1], config.parent, config.anchor[2], config.anchor[3], config.anchor[4])
		RaidDebuffs:SetFrameLevel(config.parent:GetFrameLevel() + 10)
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
end


-- additional plugins
-- Creates a panel for the unit name.
local NamePanel
do
	local defaults = function()
		return {
			nameFont = NameFont,
			nameAnchor = {"CENTER"},
			Tag = "[Tukui:GetRaidNameColor][Tukui:NameShort]",
		}
	end
	NamePanel = function(unitFrame, config)
		setmetatable(config, { __index = defaults() })
		local Power = unitFrame.Power
		local Panel = CreateFrame("Frame", nil, unitFrame)

		Panel:SetPoint("TOPLEFT", Power, "BOTTOMLEFT", 0, -1)
		Panel:SetPoint("TOPRIGHT", Power, "BOTTOMRIGHT", 0, -1)
		Panel:SetPoint("BOTTOM", 0, 0)
		Panel:CreateBackdrop()
		Panel.Backdrop:SetBorderColor(0, 0, 0, 0)

		local Name = Panel:CreateFontString(nil, "OVERLAY")
		Name:SetPoint(config.nameAnchor[1], Panel, config.nameAnchor[2], config.nameAnchor[3], config.nameAnchor[4])
		Name:SetFontObject(config.nameFont)

		unitFrame.Panel = Panel
		unitFrame.Name = Name

		if T.Retail then
			unitFrame:Tag(Name, config.Tag)
		else
			unitFrame:Tag(Name, "[Tukui:NameShort]") --FIXME: really needed?
		end
	end
end

-- Highlights the currently selected unit.
local HighlightIndicator
do
	local defaults = function(unitFrame)
		return {
			size = C.Raid.HighlightSize,
			color = C.Raid.HighlightColor,
		}
	end

	HighlightIndicator = function(unitFrame, config)
		setmetatable(config, { __index = defaults(unitFrame) })
		local Highlight = CreateFrame("Frame", nil, unitFrame, "BackdropTemplate")

		Highlight:SetBackdrop({edgeFile = C.Medias.Glow, edgeSize = config.size})
		Highlight:SetOutside(unitFrame, config.size, config.size)
		Highlight:SetBackdropBorderColor(unpack(config.color))
		Highlight:SetFrameLevel(0)
		Highlight:Hide()

		unitFrame.Highlight = Highlight
	end
end


local function addDefaultWidgets(self)
	self:add("Health", HealthBar)
	self:add("Power", PowerBar)
	self:add("NamePanel", NamePanel)

	if C.UnitFrames.HealComm then
		self:add("HealComm", HealComm)
	end

	self:add("RaidTargetIndicator", RaidTargetIndicator)
	self:add("ReadyCheckIndicator", ReadyCheckIndicator)
	self:add("ResurrectIndicator", ResurrectIndicator)
	self:add("Range", RangeIndicator)
	self:add("Highlight", HighlightIndicator)

	if C.Raid.RaidBuffsStyle.Value == "Standard" then
		self:add("Buffs", BuffsIndicator)
	elseif C.Raid.RaidBuffsStyle.Value == "Aura Track" then
		self:add("AuraTrack", AuraTrackIndicator)
	end

	if C.Raid.DebuffWatch then
		self:add("RaidDebuffs", DebuffIndicator)
	end
end

-- Create new WidgetManager for Raid and expose for external edits.
UnitFrames.RaidWidgets = UnitFrames.newWidgetManager("Raid", addDefaultWidgets)

--[[ Raid style function. ]]
function UnitFrames.Raid(self)
	HealthTexture = T.GetTexture(C["Textures"].UFRaidHealthTexture)
	PowerTexture = T.GetTexture(C["Textures"].UFRaidPowerTexture)
	NameFont = T.GetFont(C["Raid"].Font)
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

	UnitFrames.RaidWidgets:createWidgets(self)

	self:RegisterEvent("PLAYER_TARGET_CHANGED", UnitFrames.Highlight, true)
	self:RegisterEvent("RAID_ROSTER_UPDATE", UnitFrames.Highlight, true)
end
