local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	ReforgingFrame:StripTextures()
	ReforgingFrame:SetTemplate("Default")
	
	--ReforgingFrameButtonFrame:StripTextures()
	ReforgingFrameReforgeButton:ClearAllPoints()
	ReforgingFrameReforgeButton:Point("LEFT", ReforgingFrameRestoreButton, "RIGHT", 2, 0)
	ReforgingFrameReforgeButton:Point("BOTTOMRIGHT", -3, 3)
	
	ReforgingFrameRestoreButton:SkinButton(true)
	ReforgingFrameReforgeButton:SkinButton(true)
	
	ReforgingFrame.ItemButton:StripTextures()
	ReforgingFrame.ItemButton:SetTemplate("Default", true)
	ReforgingFrame.ItemButton.IconTexture:ClearAllPoints()
	ReforgingFrame.ItemButton.IconTexture:Point("TOPLEFT", 2, -2)
	ReforgingFrame.ItemButton.IconTexture:Point("BOTTOMRIGHT", -2, 2)
	
	hooksecurefunc("ReforgingFrame_Update", function(self)
		local currentReforge, icon, name, quality, bound, cost = GetReforgeItemInfo()
		if icon then
			ReforgingFrame.ItemButton.IconTexture:SetTexCoord(.08, .92, .08, .92)
		else
			ReforgingFrame.ItemButton.IconTexture:SetTexture(nil)
		end
	end)
	
	ReforgingFrameCloseButton:SkinCloseButton()
	ReforgingFrame.ButtonFrame:StripTextures()
	ReforgingFrame.RestoreMessage:SetTextColor(1, 0, 0)
end

T.SkinFuncs["Blizzard_ReforgingUI"] = LoadSkin