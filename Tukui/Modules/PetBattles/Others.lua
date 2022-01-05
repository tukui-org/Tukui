local T, C, L = select(2, ...):unpack()

local PetBattles = PetBattleFrame
local Battle = T["PetBattles"]

function Battle:SkinTooltips()
	local Tooltips = {
		PetBattlePrimaryAbilityTooltip,
		PetBattlePrimaryUnitTooltip,
		FloatingBattlePetTooltip,
		BattlePetTooltip,
		FloatingPetBattleAbilityTooltip,
	}

	for i, Tooltip in pairs(Tooltips) do
		if Tooltip.NineSlice then
			Tooltip.NineSlice:StripTextures()
			Tooltip.NineSlice:SetTemplate("Transparent")
		end

		if Tooltip.Delimiter1 then
			Tooltip.Delimiter1:SetTexture(nil)
			Tooltip.Delimiter2:SetTexture(nil)
		elseif Tooltip.Delimiter then
			Tooltip.Delimiter:SetTexture(nil)
		end

		if Tooltip.CloseButton then
			Tooltip.CloseButton:SkinCloseButton()
		end
	end
end

function Battle:AddTooltipsHooks()
	hooksecurefunc("PetBattleAbilityTooltip_Show", function()
		local Tooltip = PetBattlePrimaryAbilityTooltip
		local Anchor = T.DataTexts.Panels.Left

		if Anchor then
			Tooltip:ClearAllPoints()
			Tooltip:SetPoint("BOTTOMLEFT", Anchor, "TOPLEFT", 0, 6)
		end
	end)
end

function Battle:SkinPetSelection()
	for i = 1, 3 do
		local Pet = PetBattles.BottomFrame.PetSelectionFrame["Pet"..i]

		Pet.HealthBarBG:SetAlpha(0)
		Pet.HealthDivider:SetAlpha(0)
		Pet.ActualHealthBar:SetAlpha(0)
		Pet.SelectedTexture:SetAlpha(0)
		Pet.MouseoverHighlight:SetAlpha(0)
		Pet.Framing:SetAlpha(0)
		Pet.Icon:SetAlpha(0)
		Pet.Name:SetAlpha(0)
		Pet.DeadOverlay:SetAlpha(0)
		Pet.Level:SetAlpha(0)
		Pet.HealthText:SetAlpha(0)
	end
end

function Battle:Enable()
	PetBattleFrame:StripTextures()

	self:SkinUnitFrames()
	self:AddUnitFramesHooks()
	self:SkinTooltips()
	self:AddTooltipsHooks()
	self:SkinPetSelection()
	self:AddActionBar()
	self:SkinActionBar()
	self:AddActionBarHooks()
end
