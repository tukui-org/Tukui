local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local Movers = T["Movers"]
local Button = ExtraActionButton1
local Icon = ExtraActionButton1Icon
local Container = ExtraAbilityContainer
local ZoneAbilities = ZoneAbilityFrame

function ActionBars:DisableExtraButtonTexture()
	local Bar = ExtraActionBarFrame
	
	if (HasExtraActionBar()) then
		Button.style:SetTexture("")
		
		Icon:SetInside()
	end
end

function ActionBars:SkinZoneAbilities()
	for SpellButton in ZoneAbilities.SpellButtonContainer:EnumerateActive() do
		if not SpellButton.IsSkinned then
			SpellButton:CreateBackdrop()
			SpellButton:StyleButton()
			SpellButton:CreateShadow()
			
			SpellButton.Backdrop:SetFrameLevel(SpellButton:GetFrameLevel() - 1)

			SpellButton.Icon:SetTexCoord(unpack(T.IconCoord))
			SpellButton.Icon:ClearAllPoints()
			SpellButton.Icon:SetInside(SpellButton.Backdrop)

			SpellButton.NormalTexture:SetAlpha(0)
			
			SpellButton.IsSkinned = true
		end
	end
end

function ActionBars:SetupExtraButton()
	local ExtraHolder = CreateFrame("Frame", "TukuiExtraActionButton", UIParent)
	local ZoneHolder = CreateFrame("Frame", "TukuiZoneAbilitiesButtons", UIParent)
	local Bar = ExtraActionBarFrame
	local Icon = ExtraActionButton1Icon

	ExtraHolder:SetSize(160, 80)
	ExtraHolder:SetPoint("BOTTOM", 0, 250)
	
	ZoneHolder:SetSize(160, 80)
	ZoneHolder:SetPoint("BOTTOM", 0, 330)
	
	Container:SetParent(ExtraHolder)
	Container:ClearAllPoints()
	Container:SetPoint("CENTER", ExtraHolder, "CENTER", 0, 0)
	Container.ignoreFramePositionManager = true
	
	Button:StripTextures()
	Button:CreateBackdrop()
	Button:StyleButton()
	Button:SetNormalTexture("")
	Button:CreateShadow()
	
	Button.HotKey:Kill()
	
	Button.QuickKeybindHighlightTexture:SetTexture("")
	
	Icon:SetDrawLayer("ARTWORK")
	Icon:SetTexCoord(unpack(T.IconCoord))
	
	ZoneAbilities.Style:SetAlpha(0)
	ZoneAbilities:SetParent(ZoneHolder)
	ZoneAbilities:ClearAllPoints()
	ZoneAbilities:SetPoint("CENTER")
	
	Movers:RegisterFrame(ExtraHolder)
	Movers:RegisterFrame(ZoneHolder)

	hooksecurefunc("ExtraActionBar_Update", self.DisableExtraButtonTexture)
	hooksecurefunc(ZoneAbilities, "UpdateDisplayedZoneAbilities", ActionBars.SkinZoneAbilities)
end