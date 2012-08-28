local T, C, L, G = unpack(select(2, ...))

-- not fully tested, only tested via: /script LoadAddOn("Blizzard_ItemUpgradeUI") ShowUIPanel(ItemUpgradeFrame)

local function LoadSkin()
	ItemUpgradeFrame:StripTextures()
	ItemUpgradeFrame:SetTemplate()
	ItemUpgradeFrame:CreateShadow()
	ItemUpgradeFrameShadows:Kill()
	ItemUpgradeFrameInset:Kill()

	ItemUpgradeFrameCloseButton:SkinCloseButton()
	
	ItemUpgradeFrame.ItemButton:StripTextures()
	ItemUpgradeFrame.ItemButton:SetTemplate()
	ItemUpgradeFrame.ItemButton:StyleButton()

	hooksecurefunc("ItemUpgradeFrame_Update", function()
		if GetItemUpgradeItemInfo() then
			ItemUpgradeFrame.ItemButton.IconTexture:SetAlpha(1)
			ItemUpgradeFrame.ItemButton.IconTexture:SetTexCoord(.1,.9,.1,.9)
		else
			ItemUpgradeFrame.ItemButton.IconTexture:SetAlpha(0)
		end
	end)

	ItemUpgradeFrameMoneyFrame:StripTextures()
	ItemUpgradeFrameUpgradeButton:StripTextures()
	ItemUpgradeFrameUpgradeButton:SkinButton()
	ItemUpgradeFrame.FinishedGlow:Kill()
end

T.SkinFuncs["Blizzard_ItemUpgradeUI"] = LoadSkin