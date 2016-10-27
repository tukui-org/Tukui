local T, C, L = select(2, ...):unpack()

local TukuiActionBars = T["ActionBars"]
local Movers = T["Movers"]
local Button = ExtraActionButton1
local Zone = ZoneAbilityFrame
local ZoneButton = Zone.SpellButton
local Texture = Button.style
local ZoneTexture = ZoneButton.Style

function TukuiActionBars:DisableExtraButtonTexture(texture, loop)
	if loop then
		return
	end

	self:SetTexture("", true)
end

function TukuiActionBars:SetUpExtraActionButton()
	local Holder = CreateFrame("Frame", "TukuiExtraActionButton", UIParent)
	
	Holder:Size(160, 80)
	Holder:SetPoint("BOTTOM", 0, 250)

	ExtraActionBarFrame:SetParent(UIParent)
	ExtraActionBarFrame:ClearAllPoints()
	ExtraActionBarFrame:SetPoint("CENTER", Holder, "CENTER", 0, 0)
	ExtraActionBarFrame.ignoreFramePositionManager = true
	
	ZoneAbilityFrame:SetParent(UIParent)
	ZoneAbilityFrame:ClearAllPoints()
	ZoneAbilityFrame:SetPoint("CENTER", Holder, "CENTER", 0, 0)
	ZoneAbilityFrame.ignoreFramePositionManager = true
	
	ZoneButton:SetTemplate()
	ZoneButton:StyleButton()
	ZoneButton:SetNormalTexture("")
	ZoneButton.Icon:SetInside()
	ZoneButton.Icon:SetDrawLayer("ARTWORK")
	ZoneButton.Icon:SetTexCoord(unpack(T.IconCoord))

	Texture:SetTexture("")
	ZoneTexture:SetTexture("")

	Movers:RegisterFrame(Holder)
end