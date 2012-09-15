local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	GMSurveyHeader:StripTextures()
	GMSurveyFrame:StripTextures()
	GMSurveyFrame:CreateBackdrop()
	GMSurveyFrame.backdrop:Point("TOPLEFT", 0, 0)
	GMSurveyFrame.backdrop:Point("BOTTOMRIGHT", -44, 10)

	GMSurveyCommentFrame:StripTextures()
	GMSurveyCommentFrame:SetTemplate()

	GMSurveySubmitButton:SkinButton()
	GMSurveyCancelButton:SkinButton()
	
	
	GMSurveyCloseButton:SkinCloseButton()
	GMSurveyScrollFrame:SkinScrollBar()

	for i = 1, 11 do
		_G["GMSurveyQuestion"..i]:StripTextures()
	end
end

T.SkinFuncs["Blizzard_GMSurveyUI"] = LoadSkin