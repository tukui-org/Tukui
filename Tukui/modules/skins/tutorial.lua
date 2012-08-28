local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	TutorialFrame:StripTextures()
	TutorialFrame:CreateBackdrop("Default")
	TutorialFrame.backdrop:CreateShadow("Default")
	TutorialFrame.backdrop:Point("TOPLEFT", 6, 0)
	TutorialFrame.backdrop:Point("BOTTOMRIGHT", 6, -6)
	TutorialFrameCloseButton:SkinCloseButton(TutorialFrameCloseButton.backdrop)
	TutorialFramePrevButton:SkinNextPrevButton()
	TutorialFrameNextButton:SkinNextPrevButton()
	TutorialFrameOkayButton:SkinButton()
	TutorialFrameOkayButton:ClearAllPoints()
	TutorialFrameOkayButton:Point("LEFT", TutorialFrameNextButton,"RIGHT", 10, 0)	
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)