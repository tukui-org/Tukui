local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	ColorPickerFrame:CreateBackdrop("Default")
	T.SkinButton(ColorPickerOkayButton)
	T.SkinButton(ColorPickerCancelButton)
	ColorPickerOkayButton:ClearAllPoints()
	ColorPickerOkayButton:Point("RIGHT", ColorPickerCancelButton,"LEFT", -2, 0)
	-- we cant use StripTexture() here, doing it manually
	for i=1, ColorPickerFrame:GetNumRegions() do
		local region = select(i, ColorPickerFrame:GetRegions())
		if region:GetObjectType() == "Texture" and (region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Border" or region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Background" or region:GetTexture() == "Interface\\DialogFrame\\UI-DialogBox-Header") then
			region:SetTexture(nil)
		end
	end		
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)