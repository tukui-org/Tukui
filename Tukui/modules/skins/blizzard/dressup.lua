local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	DressUpFrame:StripTextures(true)
	DressUpFrame:CreateBackdrop("Default")
	DressUpFrame.backdrop:CreateShadow("Default")
	DressUpFrame.backdrop:Point("TOPLEFT", 6, 0)
	DressUpFrame.backdrop:Point("BOTTOMRIGHT", -32, 70)

	T.SkinButton(DressUpFrameResetButton)
	T.SkinButton(DressUpFrameCancelButton)
	T.SkinCloseButton(DressUpFrameCloseButton, DressUpFrame.backdrop)
	if T.toc < 40300 then
		T.SkinRotateButton(DressUpModelRotateLeftButton)
		T.SkinRotateButton(DressUpModelRotateRightButton)
		DressUpModelRotateRightButton:Point("TOPLEFT", DressUpModelRotateLeftButton, "TOPRIGHT", 2, 0)
	end
	DressUpFrameResetButton:Point("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)