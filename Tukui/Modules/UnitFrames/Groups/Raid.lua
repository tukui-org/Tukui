local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local Widgets = UnitFrames.Widgets

local function addDefaultWidgets(self)
	self:add("Health", Widgets.HealthBar, { height = C.Raid.HeightSize - 1 - 3 - 1 - 18,  -- border, power, border, namepanel
			texture = C.Raid.UFRaidHealthTexture, font = C.Raid.HealthFont,	tag = C.Raid.HealthTag.Value,
			orientation = C.Raid.VerticalHealth and "VERTICAL" or "HORIZONTAL", })
	self:add("Power", Widgets.PowerBar, { texture = C.Textures.UFRaidPowerTexture, })
	self:add("NamePanel", Widgets.NamePanel, { font = C.Raid.Font, tag = "[Tukui:GetRaidNameColor][Tukui:NameShort]", })

	if C.UnitFrames.HealComm then
		self:add("HealComm", Widgets.HealComm, { texture = C.Raid.UFRaidHealthTexture, })
	end

	self:add("RaidTargetIndicator", Widgets.RaidTargetIndicator)
	self:add("ReadyCheckIndicator", Widgets.ReadyCheckIndicator)
	self:add("ResurrectIndicator", Widgets.ResurrectIndicator)
	self:add("Range", Widgets.RangeIndicator, { outsideAlpha = C.Raid.RangeAlpha, })
	self:add("Highlight", Widgets.HighlightIndicator, { size = C.Raid.HighlightSize, color = C.Raid.HighlightColor, })

	if C.Raid.RaidBuffsStyle.Value == "Standard" then
		self:add("Buffs", Widgets.BuffsIndicator, { filter = C.Raid.RaidBuffs.Value == "All" and "HELPFUL" or "HELPFUL|RAID",
				onlyShowPlayer = C.Raid.RaidBuffs.Value == "Self", })
	elseif C.Raid.RaidBuffsStyle.Value == "Aura Track" then
		self:add("AuraTrack", Widgets.AuraTrackIndicator)
	end

	if C.Raid.DebuffWatch then
		self:add("RaidDebuffs", Widgets.DebuffIndicator)
	end
end

-- Create new WidgetManager for Raid and expose for external edits.
UnitFrames.RaidWidgets = UnitFrames.newWidgetManager("Raid", addDefaultWidgets)

--[[ Raid style function. ]]
function UnitFrames.Raid(self)
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
end
