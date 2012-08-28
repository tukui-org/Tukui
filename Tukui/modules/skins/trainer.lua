local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	--Class Trainer Frame
	local StripAllTextures = {
		"ClassTrainerFrame",
		"ClassTrainerScrollFrameScrollChild",
		"ClassTrainerFrameSkillStepButton",
		"ClassTrainerFrameBottomInset",
	}

	local buttons = {
		"ClassTrainerTrainButton",
	}

	local KillTextures = {
		"ClassTrainerFrameInset",
		"ClassTrainerFramePortrait",
		"ClassTrainerScrollFrameScrollBarBG",
		"ClassTrainerScrollFrameScrollBarTop",
		"ClassTrainerScrollFrameScrollBarBottom",
		"ClassTrainerScrollFrameScrollBarMiddle",
	}

	for i=1,7 do
		_G["ClassTrainerScrollFrameButton"..i]:StripTextures()
		_G["ClassTrainerScrollFrameButton"..i]:StyleButton()
		_G["ClassTrainerScrollFrameButton"..i.."Icon"]:SetTexCoord(.08, .92, .08, .92)
		_G["ClassTrainerScrollFrameButton"..i]:CreateBackdrop()
		_G["ClassTrainerScrollFrameButton"..i].backdrop:Point("TOPLEFT", _G["ClassTrainerScrollFrameButton"..i.."Icon"], "TOPLEFT", -2, 2)
		_G["ClassTrainerScrollFrameButton"..i].backdrop:Point("BOTTOMRIGHT", _G["ClassTrainerScrollFrameButton"..i.."Icon"], "BOTTOMRIGHT", 2, -2)
		_G["ClassTrainerScrollFrameButton"..i.."Icon"]:SetParent(_G["ClassTrainerScrollFrameButton"..i].backdrop)
		
		_G["ClassTrainerScrollFrameButton"..i].selectedTex:SetTexture(1, 1, 1, 0.3)
		_G["ClassTrainerScrollFrameButton"..i].selectedTex:ClearAllPoints()
		_G["ClassTrainerScrollFrameButton"..i].selectedTex:Point("TOPLEFT", 2, -2)
		_G["ClassTrainerScrollFrameButton"..i].selectedTex:Point("BOTTOMRIGHT", -2, 2)
	end

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end
	
	ClassTrainerFrameFilterDropDown:SkinDropDownBox(155)
	ClassTrainerFrameFilterDropDown:ClearAllPoints()
	ClassTrainerFrameFilterDropDown:Point("TOPRIGHT", ClassTrainerFrame, "TOPRIGHT", 0, -32)
	ClassTrainerScrollFrameScrollBar:SkinScrollBar()

	ClassTrainerFrame:CreateBackdrop("Default")
	ClassTrainerFrame.backdrop:Point("TOPLEFT", ClassTrainerFrame, "TOPLEFT")
	ClassTrainerFrame.backdrop:Point("BOTTOMRIGHT", ClassTrainerFrame, "BOTTOMRIGHT")
	ClassTrainerFrameCloseButton:SkinCloseButton()
	ClassTrainerFrameSkillStepButton.icon:SetTexCoord(.08, .92, .08, .92)
	ClassTrainerFrameSkillStepButton:CreateBackdrop("Default")
	ClassTrainerFrameSkillStepButton.backdrop:Point("TOPLEFT", ClassTrainerFrameSkillStepButton.icon, "TOPLEFT", -2, 2)
	ClassTrainerFrameSkillStepButton.backdrop:Point("BOTTOMRIGHT", ClassTrainerFrameSkillStepButton.icon, "BOTTOMRIGHT", 2, -2)
	ClassTrainerFrameSkillStepButton.icon:SetParent(ClassTrainerFrameSkillStepButton.backdrop)
	ClassTrainerFrameSkillStepButtonHighlight:SetTexture(1,1,1,0.3)
	ClassTrainerFrameSkillStepButton.selectedTex:SetTexture(1,1,1,0.3)
	
	ClassTrainerStatusBar:StripTextures()
	ClassTrainerStatusBar:SetStatusBarTexture(C.media.normTex)
	ClassTrainerStatusBar:ClearAllPoints()
	ClassTrainerStatusBar:Point("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 15, -35)
	ClassTrainerStatusBar:CreateBackdrop("Transparent")
end

T.SkinFuncs["Blizzard_TrainerUI"] = LoadSkin