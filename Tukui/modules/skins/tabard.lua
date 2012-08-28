local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	TabardFrame:StripTextures()
	TabardFrame:CreateBackdrop("Default")
	TabardFrame.backdrop:Point("TOPLEFT", 0, 0)
	TabardFrame.backdrop:Point("BOTTOMRIGHT", 0, 0)

	TabardFrameInset:StripTextures()
	TabardFramePortrait:Kill()

	TabardFrameCloseButton:SkinCloseButton(TabardFrame.backdrop)

	TabardFrameCancelButton:SkinButton()
	TabardFrameAcceptButton:SkinButton()
	TabardFrameAcceptButton:ClearAllPoints()
	TabardFrameAcceptButton:Point("RIGHT", TabardFrameCancelButton, "LEFT", -3, 0)

	TabardCharacterModelRotateLeftButton:SkinRotateButton()
	TabardCharacterModelRotateRightButton:SkinRotateButton()
	TabardCharacterModelRotateLeftButton:ClearAllPoints()
	TabardCharacterModelRotateLeftButton:Point("BOTTOMLEFT", TabardModel.backdrop, "BOTTOMLEFT", 4, 4)
	TabardCharacterModelRotateRightButton:ClearAllPoints()
	TabardCharacterModelRotateRightButton:Point("LEFT", TabardCharacterModelRotateLeftButton, "RIGHT", 3, 0)

	TabardFrameMoneyBg:StripTextures()
	TabardFrameMoneyInset:StripTextures()
	TabardFrameCostFrame:StripTextures()
	TabardFrameCustomizationFrame:StripTextures()

	for i = 1, 5 do
		local custom = "TabardFrameCustomization"..i
		_G[custom]:StripTextures()
		_G[custom.."LeftButton"]:SkinNextPrevButton()
		_G[custom.."RightButton"]:SkinNextPrevButton()

		if i > 1 then
			_G[custom]:ClearAllPoints()
			_G[custom]:Point("TOP", _G["TabardFrameCustomization"..i-1], "BOTTOM", 0, -6)
		else
			local point, anchor, point2, x, y = _G[custom]:GetPoint()
			_G[custom]:Point(point, anchor, point2, x, y + 4)
		end
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)