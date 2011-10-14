local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	ReforgingFrame:StripTextures()
	ReforgingFrame:SetTemplate("Default")
	
	if T.toc < 40300 then
		ReforgingFrameTopInset:StripTextures()
		ReforgingFrameInset:StripTextures()
		ReforgingFrameBottomInset:StripTextures()
		T.SkinDropDownBox(ReforgingFrameFilterOldStat, 180)
		T.SkinDropDownBox(ReforgingFrameFilterNewStat, 180)
	else
		ReforgingFrameButtonFrame:StripTextures()
		ReforgingFrameReforgeButton:ClearAllPoints()
		ReforgingFrameReforgeButton:Point("LEFT", ReforgingFrameRestoreButton, "RIGHT", 2, 0)
		ReforgingFrameReforgeButton:Point("BOTTOMRIGHT", -3, 3)
	end
	
	T.SkinButton(ReforgingFrameRestoreButton, true)
	T.SkinButton(ReforgingFrameReforgeButton, true)
	
	ReforgingFrameItemButton:StripTextures()
	ReforgingFrameItemButton:SetTemplate("Default", true)
	ReforgingFrameItemButton:StyleButton()
	ReforgingFrameItemButtonIconTexture:ClearAllPoints()
	ReforgingFrameItemButtonIconTexture:Point("TOPLEFT", 2, -2)
	ReforgingFrameItemButtonIconTexture:Point("BOTTOMRIGHT", -2, 2)
	
	hooksecurefunc("ReforgingFrame_Update", function(self)
		local currentReforge, icon, name, quality, bound, cost = GetReforgeItemInfo()
		if icon then
			ReforgingFrameItemButtonIconTexture:SetTexCoord(.08, .92, .08, .92)
		else
			ReforgingFrameItemButtonIconTexture:SetTexture(nil)
		end
	end)
	
	T.SkinCloseButton(ReforgingFrameCloseButton)
end

T.SkinFuncs["Blizzard_ReforgingUI"] = LoadSkin