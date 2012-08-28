local T, C, L, G = unpack(select(2, ...))

-- Allow the use of color picker with Tukui Config.
ColorPickerFrame:SetParent(nil)
ColorPickerFrame:SetScale(C.general.uiscale)

local function LoadSkin()
	ColorPickerFrame:SetTemplate("Default")
	ColorPickerOkayButton:SkinButton()
	ColorPickerCancelButton:SkinButton()
	ColorPickerOkayButton:ClearAllPoints()
	ColorPickerOkayButton:Point("RIGHT", ColorPickerCancelButton,"LEFT", -2, 0)
	ColorPickerFrameHeader:ClearAllPoints()
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)