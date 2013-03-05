local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	PVPUIFrame:StripTextures()
	PVPUIFrame:SetTemplate()
	PVPUIFrame.LeftInset:StripTextures()
	--PVPUIFrame.LeftInset:SetTemplate("Transparent")
	PVPUIFrame.Shadows:StripTextures()

	PVPUIFrameCloseButton:SkinCloseButton()

	for i=1, 2 do
		_G["PVPUIFrameTab"..i]:SkinTab()
	end

	for i=1, 3 do
		local button = _G["PVPQueueFrameCategoryButton"..i]
		button:SetTemplate()
		button.Background:Kill()
		button.Ring:Kill()
		button.Icon:Size(45)
		button.Icon:SetTexCoord(.15, .85, .15, .85)
		button:CreateBackdrop()
		button.backdrop:SetOutside(button.Icon)
		button.backdrop:SetFrameLevel(button:GetFrameLevel())
		button.Icon:SetParent(button.backdrop)
		button:StyleButton()

		button:CreateShadow("Default")
		--button.shadow:SetBackdropBorderColor(unpack(E['media'].rgbvaluecolor))

		if i == 1 then
			button.shadow:SetAlpha(1)
		else
			button.shadow:SetAlpha(0)
		end

		button:HookScript("OnClick", function(self)
			for j=1, 3 do
				local b = _G["PVPQueueFrameCategoryButton"..j]
				if self:GetID() == b:GetID() then
					b.shadow:SetAlpha(1)
				else
					b.shadow:SetAlpha(0)
				end
			end
		end)
	end

	for i=1, 3 do
		local button = _G["PVPArenaTeamsFrameTeam"..i]
		button:SetTemplate('Default')
		button.Background:Kill()
		button:StyleButton()
		button:CreateShadow("Default")
		--button.shadow:SetBackdropBorderColor(unpack(E['media'].rgbvaluecolor))

		if i == 1 then
			button.shadow:SetAlpha(1)
		else
			button.shadow:SetAlpha(0)
		end

		button:HookScript("OnClick", function(self)
			for j=1, 3 do
				local b = _G["PVPArenaTeamsFrameTeam"..j]
				if self:GetID() == b:GetID() then
					b.shadow:SetAlpha(1)
				else
					b.shadow:SetAlpha(0)
				end
			end
		end)
	end

	-->>>HONOR FRAME
	HonorFrameTypeDropDown:SkinDropDownBox()

	HonorFrame.Inset:StripTextures()
	--HonorFrame.Inset:SetTemplate("Transparent")

	HonorFrameSpecificFrameScrollBar:SkinScrollBar()
	HonorFrameSoloQueueButton:SkinButton(true)
	HonorFrameGroupQueueButton:SkinButton(true)
	HonorFrame.BonusFrame:StripTextures()
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:SkinButton()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	HonorFrame.BonusFrame.CallToArmsButton:StripTextures()
	HonorFrame.BonusFrame.CallToArmsButton:SkinButton()
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	
	for i = 1, 2 do
		local b = HonorFrame.BonusFrame["WorldPVP"..i.."Button"]
		b:StripTextures()
		b:SkinButton()
		b.SelectedTexture:ClearAllPoints()
		b.SelectedTexture:SetAllPoints()
		b.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	end
	
	-->>>CONQUEST FRAME
	ConquestFrame.Inset:StripTextures()
	--ConquestFrame.Inset:SetTemplate("Transparent")

	--CapProgressBar_Update(ConquestFrame.ConquestBar, 0, 0, nil, nil, 1000, 2200);
	ConquestPointsBarLeft:Kill()
	ConquestPointsBarRight:Kill()
	ConquestPointsBarMiddle:Kill()
	ConquestPointsBarBG:Kill()
	ConquestPointsBarShadow:Kill()
	ConquestPointsBar.progress:SetTexture(C["media"].normTex)
	ConquestPointsBar:CreateBackdrop('Default')
	ConquestPointsBar.backdrop:SetOutside(ConquestPointsBar, nil, -T.mult)
	ConquestFrame:StripTextures()
	ConquestFrame.ShadowOverlay:StripTextures()
	ConquestFrame.RatedBG:StripTextures()
	ConquestFrame.RatedBG:SkinButton()
	ConquestFrame.RatedBG.SelectedTexture:ClearAllPoints()
	ConquestFrame.RatedBG.SelectedTexture:SetAllPoints()
	ConquestFrame.RatedBG.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	ConquestJoinButton:SkinButton(true)

	-->>>WARGRAMES FRAME
	WarGamesFrame:StripTextures()
	WarGamesFrame.RightInset:StripTextures()
	WarGameStartButton:SkinButton(true)
	WarGamesFrameScrollFrameScrollBar:SkinScrollBar()
	WarGamesFrame.HorizontalBar:StripTextures()

	-->>>ARENATEAMS
	PVPArenaTeamsFrame:StripTextures()
	ArenaTeamFrame.TopInset:StripTextures()
	ArenaTeamFrame.BottomInset:StripTextures()
	ArenaTeamFrame.WeeklyDisplay:StripTextures()
	ArenaTeamFrame.weeklyToggleRight:SkinNextPrevButton()
	ArenaTeamFrame.weeklyToggleLeft:SkinNextPrevButton()
	ArenaTeamFrame:StripTextures()
	ArenaTeamFrame.TopShadowOverlay:StripTextures()

	for i=1, 4 do
		_G["ArenaTeamFrameHeader"..i.."Left"]:Kill()
		_G["ArenaTeamFrameHeader"..i.."Middle"]:Kill()
		_G["ArenaTeamFrameHeader"..i.."Right"]:Kill()
		_G["ArenaTeamFrameHeader"..i]:SetHighlightTexture(nil)
	end
	
	for i=1, 3 do
		local b = ARENA_BUTTONS[i]
		b:StripTextures()
		b:SkinButton()
		b.SelectedTexture:ClearAllPoints()
		b.SelectedTexture:SetAllPoints()
		b.SelectedTexture:SetTexture(0, 1, 0, 0.1)
	end

	ArenaTeamFrame.AddMemberButton:SkinButton(true)

	-->>>PVP BANNERS
	PVPBannerFrame:StripTextures()
	PVPBannerFramePortrait:SetAlpha(0)
	PVPBannerFrame:SetTemplate()
	PVPBannerFrameCloseButton:SkinCloseButton()
	PVPBannerFrameEditBox:SkinEditBox()
	PVPBannerFrameEditBox.backdrop:SetOutside(PVPBannerFrameEditBox, 2, -5)
	PVPBannerFrame.Inset:StripTextures()

	PVPBannerFrameAcceptButton:SkinButton(true)
	PVPBannerFrameCancelButton:SkinButton(true)

	--Duplicate button name workaround
	for i=1, PVPBannerFrame:GetNumChildren() do
		local child = select(i, PVPBannerFrame:GetChildren())
		if child and child:GetObjectType() == "Button" and child:GetWidth() == 80 then
			child:SkinButton(true)
		end
	end

	for i=1, 3 do
		_G["PVPColorPickerButton"..i]:SkinButton(true)
		_G["PVPColorPickerButton"..i]:SetHeight(_G["PVPColorPickerButton"..i]:GetHeight() - 2)
	end

	PVPBannerFrameCustomizationFrame:StripTextures()

	for i=1, 2 do
		_G["PVPBannerFrameCustomization"..i]:StripTextures()
		_G["PVPBannerFrameCustomization"..i.."RightButton"]:SkinNextPrevButton()
		_G["PVPBannerFrameCustomization"..i.."LeftButton"]:SkinNextPrevButton()
	end
end

T.SkinFuncs["Blizzard_PVPUI"] = LoadSkin