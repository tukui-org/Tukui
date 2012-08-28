local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	PetitionFrame:StripTextures(true)
	PetitionFrame:SetTemplate("Default")
	PetitionFrame:CreateShadow("Default")
	PetitionFrameInset:StripTextures()

	PetitionFrameRequestButton:SkinButton()
	PetitionFrameRequestButton:Width(110)
	PetitionFrameRenameButton:SkinButton()
	PetitionFrameCancelButton:SkinButton()
	PetitionFrameSignButton:SkinButton()
	PetitionFrameCloseButton:SkinCloseButton()

	PetitionFrameCharterTitle:SetTextColor(1, 1, 0)
	PetitionFrameCharterName:SetTextColor(1, 1, 1)
	PetitionFrameMasterTitle:SetTextColor(1, 1, 0)
	PetitionFrameMasterName:SetTextColor(1, 1, 1)
	PetitionFrameMemberTitle:SetTextColor(1, 1, 0)

	for i=1, 9 do
		_G["PetitionFrameMemberName"..i]:SetTextColor(1, 1, 1)
	end

	PetitionFrameInstructions:SetTextColor(1, 1, 1)

	PetitionFrameRenameButton:Point("LEFT", PetitionFrameRequestButton, "RIGHT", 3, 0)
	PetitionFrameRenameButton:Point("RIGHT", PetitionFrameCancelButton, "LEFT", -3, 0)
	PetitionFrame:Height(PetitionFrame:GetHeight() - 80)

	PetitionFrameCancelButton:Point("BOTTOMRIGHT", PetitionFrame, "BOTTOMRIGHT", -40, 20)
	PetitionFrameRequestButton:Point("BOTTOMLEFT", PetitionFrame, "BOTTOMLEFT", 22, 20)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)
