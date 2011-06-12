local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	TabardFrame:StripTextures(true)
	TabardFrame:SetTemplate("Default")
	TabardModel:CreateBackdrop("Default")
	T.SkinButton(TabardFrameCancelButton)
	T.SkinButton(TabardFrameAcceptButton)
	T.SkinCloseButton(TabardFrameCloseButton)
	T.SkinRotateButton(TabardCharacterModelRotateLeftButton)
	T.SkinRotateButton(TabardCharacterModelRotateRightButton)
	TabardFrameCostFrame:StripTextures()
	TabardFrameCustomizationFrame:StripTextures()

	for i=1, 5 do
		local custom = "TabardFrameCustomization"..i
		_G[custom]:StripTextures()
		T.SkinNextPrevButton(_G[custom.."LeftButton"])
		T.SkinNextPrevButton(_G[custom.."RightButton"])
		
		
		if i > 1 then
			_G[custom]:ClearAllPoints()
			_G[custom]:Point("TOP", _G["TabardFrameCustomization"..i-1], "BOTTOM", 0, -6)
		else
			local point, anchor, point2, x, y = _G[custom]:GetPoint()
			_G[custom]:Point(point, anchor, point2, x, y+4)
		end
	end

	TabardCharacterModelRotateLeftButton:Point("BOTTOMLEFT", 4, 4)
	TabardCharacterModelRotateRightButton:Point("TOPLEFT", TabardCharacterModelRotateLeftButton, "TOPRIGHT", 4, 0)
	TabardCharacterModelRotateLeftButton.SetPoint = T.dummy
	TabardCharacterModelRotateRightButton.SetPoint = T.dummy
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)