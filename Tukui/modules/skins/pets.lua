local T, C, L, G = unpack(select(2, ...))

-- THE FUCKING PET JOURNAL NEED TO BE COMPLETE WHEN PET BATTLE WILL BE AVAILABLE FOR TESTING

local function LoadSkin()
	-- global
	PetJournalParent:StripTextures()
	PetJournalParent:SetTemplate("Default")
	PetJournalParentPortrait:Hide()
	PetJournalParentTab1:SkinTab()
	PetJournalParentTab2:SkinTab()
	PetJournalParentCloseButton:SkinCloseButton()

	-------------------------------
	--[[ mount journal (tab 1) ]]--
	-------------------------------

	MountJournal:StripTextures()
	MountJournal.LeftInset:StripTextures()
	MountJournal.RightInset:StripTextures()
	MountJournal.MountDisplay:StripTextures()
	MountJournal.MountDisplay.ShadowOverlay:StripTextures()
	MountJournal.MountCount:StripTextures()
	MountJournalMountButton:SkinButton(true)
	MountJournalListScrollFrameScrollBar:SkinScrollBar()
	MountJournal.MountDisplay.ModelFrame.RotateLeftButton:SkinCloseButton()
	MountJournal.MountDisplay.ModelFrame.RotateRightButton:SkinCloseButton()
	MountJournal.MountDisplay.ModelFrame.RotateLeftButton.t:SetText("<")
	MountJournal.MountDisplay.ModelFrame.RotateRightButton.t:SetText(">")
	
	for i = 1, #MountJournal.ListScrollFrame.buttons do
		local b = _G["MountJournalListScrollFrameButton"..i]
		if not b.isSkinned then
			-- reskin mounts icons
			b:StripTextures()
			b:SetTemplate()
			b:StyleButton()
			b:SetBackdropBorderColor(0,0,0,0)
			b:HideInsets()
			b.icon:SetTexCoord(.08, .92, .08, .92)
			b.DragButton:StyleButton()
			b.DragButton.hover:SetAllPoints(b.DragButton)
			b.DragButton.ActiveTexture:SetAlpha(0)
			
			-- create a backdrop around the icon
			b:CreateBackdrop("Default")
			b.backdrop:Point("TOPLEFT", b.icon, -2, 2)
			b.backdrop:Point("BOTTOMRIGHT", b.icon, 2, -2)
			b.backdrop:SetBackdropColor(0, 0, 0, 0)
			
			b.isSkinned = true
		end
	end

	-- Color in green icon border on selected mount
	local function ColorSelectedMount()
		for i = 1, #MountJournal.ListScrollFrame.buttons do
			local b = _G["MountJournalListScrollFrameButton"..i]
			local t = _G["MountJournalListScrollFrameButton"..i.."Name"]
			if b.DragButton.ActiveTexture:IsShown() then
				t:SetTextColor(1,1,0)
				b.backdrop:SetBackdropBorderColor(1, 1, 0)
			else
				t:SetTextColor(1, 1, 1)
				b.backdrop:SetBackdropBorderColor(unpack(C.media.bordercolor))
			end
		end
	end
	hooksecurefunc("MountJournal_UpdateMountList", ColorSelectedMount)

	-- bug fix when we scroll
	MountJournalListScrollFrame:HookScript("OnVerticalScroll", ColorSelectedMount)
	MountJournalListScrollFrame:HookScript("OnMouseWheel", ColorSelectedMount)

	-----------------------------
	--[[ pet journal (tab 2) ]]--
	-----------------------------

	PetJournalSummonButton:StripTextures()
	PetJournalFindBattle:StripTextures()
	PetJournalSummonButton:SkinButton()
	PetJournalFindBattle:SkinButton()
	PetJournalRightInset:StripTextures()
	PetJournalLeftInset:StripTextures()

	PetJournal.PetCount:StripTextures()
	PetJournalSearchBox:SkinEditBox()
	PetJournalFilterButton:StripTextures(true)
	PetJournalFilterButton:SkinButton()
	PetJournalListScrollFrame:StripTextures()
	PetJournalListScrollFrameScrollBar:SkinScrollBar()
	
	for i = 1, #PetJournal.listScroll.buttons do
		local b = _G["PetJournalListScrollFrameButton"..i]
		if not b.isSkinned then
			-- reskin mounts icons
			b:StripTextures()
			b:SetTemplate()
			b:StyleButton()
			b:SetBackdropBorderColor(0,0,0,0)
			b:HideInsets()
			b.icon:SetTexCoord(.08, .92, .08, .92)
			b.dragButton:StyleButton()
			b.dragButton.hover:SetAllPoints(b.dragButton)
			b.dragButton.ActiveTexture:SetAlpha(0)
			
			-- create a backdrop around the icon
			b:CreateBackdrop("Default")
			b.backdrop:Point("TOPLEFT", b.icon, -2, 2)
			b.backdrop:Point("BOTTOMRIGHT", b.icon, 2, -2)
			b.backdrop:SetBackdropColor(0, 0, 0, 0)
			
			b.isSkinned = true
		end
	end

	local function ColorSelectedPet()
		for i = 1, #PetJournal.listScroll.buttons do
			local b = _G["PetJournalListScrollFrameButton"..i]
			local t = _G["PetJournalListScrollFrameButton"..i.."Name"]
			if b.dragButton.ActiveTexture:IsShown() then
				t:SetTextColor(1,1,0)
				b.backdrop:SetBackdropBorderColor(1, 1, 0)
			else
				t:SetTextColor(1, 1, 1)
				b.backdrop:SetBackdropBorderColor(unpack(C.media.bordercolor))
			end
		end
	end
	hooksecurefunc("PetJournal_UpdatePetList", ColorSelectedPet)
	PetJournalListScrollFrame:HookScript("OnVerticalScroll", ColorSelectedPet)
	PetJournalListScrollFrame:HookScript("OnMouseWheel", ColorSelectedPet)

	PetJournalAchievementStatus:DisableDrawLayer("BACKGROUND")

	PetJournalHealPetButton:StripTextures()
	PetJournalHealPetButton:CreateBackdrop()
	PetJournalHealPetButton:StyleButton()
	PetJournalHealPetButton.texture:SetTexture([[Interface\Icons\spell_magic_polymorphrabbit]])
	PetJournalHealPetButton.texture:SetTexCoord(.08, .88, .08, .88)
	PetJournalLoadoutBorder:StripTextures()
	for i=1, 3 do
		_G["PetJournalLoadoutPet"..i.."HelpFrame"]:StripTextures()
		_G["PetJournalLoadoutPet"..i]:StripTextures()
		_G["PetJournalLoadoutPet"..i]:CreateBackdrop()
		_G["PetJournalLoadoutPet"..i].backdrop:SetAllPoints()
		_G["PetJournalLoadoutPet"..i].petTypeIcon:SetPoint("BOTTOMLEFT", 2, 2)
		_G["PetJournalLoadoutPet"..i]:StyleButton()

		_G["PetJournalLoadoutPet"..i].dragButton:StyleButton()
		_G["PetJournalLoadoutPet"..i].dragButton:SetOutside(_G["PetJournalLoadoutPet"..i.."Icon"])
		_G["PetJournalLoadoutPet"..i].dragButton:SetFrameLevel(_G["PetJournalLoadoutPet"..i].dragButton:GetFrameLevel() + 1)
		_G["PetJournalLoadoutPet"..i]:SkinIconButton()
		_G["PetJournalLoadoutPet"..i].backdrop:SetFrameLevel(_G["PetJournalLoadoutPet"..i].backdrop:GetFrameLevel() + 1)

		_G["PetJournalLoadoutPet"..i].setButton:StripTextures()
		_G["PetJournalLoadoutPet"..i.."HealthFrame"].healthBar:StripTextures()
		_G["PetJournalLoadoutPet"..i.."HealthFrame"].healthBar:CreateBackdrop("Default")
		_G["PetJournalLoadoutPet"..i.."HealthFrame"].healthBar:SetStatusBarTexture(C.media.normTex)
		_G["PetJournalLoadoutPet"..i.."XPBar"]:StripTextures()
		_G["PetJournalLoadoutPet"..i.."XPBar"]:CreateBackdrop("Default")
		_G["PetJournalLoadoutPet"..i.."XPBar"]:SetStatusBarTexture(C.media.normTex)
		_G["PetJournalLoadoutPet"..i.."XPBar"]:SetFrameLevel(_G["PetJournalLoadoutPet"..i.."XPBar"]:GetFrameLevel() + 2)

		for index = 1, 3 do
			local f = _G["PetJournalLoadoutPet"..i.."Spell"..index]
			f:SkinIconButton()
			f.FlyoutArrow:SetTexture([[Interface\Buttons\ActionBarFlyoutButton]])
			_G["PetJournalLoadoutPet"..i.."Spell"..index.."Icon"]:SetInside(f)
		end
	end

	PetJournalSpellSelect:StripTextures()
	for i=1, 2 do
		local btn = _G["PetJournalSpellSelectSpell"..i]
		btn:SkinButton()
		_G["PetJournalSpellSelectSpell"..i.."Icon"]:SetInside(btn)
		_G["PetJournalSpellSelectSpell"..i.."Icon"]:SetDrawLayer("BORDER")
	end

	PetJournalPetCard:StripTextures()
	PetJournalPetCardInset:StripTextures()
	
	PetJournalTutorialButton.Ring:SetAlpha(0)
	PetJournalTutorialButton:ClearAllPoints()
	PetJournalTutorialButton:SetPoint("TOPLEFT", PetJournalParent, 0, 0)

	PetJournalPetCardPetInfo.levelBG:Kill()
	PetJournalPetCardPetInfoIcon:SetTexCoord(.1,.9,.1,.9)
	PetJournalPetCardPetInfo:CreateBackdrop()
	PetJournalPetCardPetInfo.backdrop:SetOutside(PetJournalPetCardPetInfoIcon)
	PetJournalPetCardPetInfoIcon:SetParent(PetJournalPetCardPetInfo.backdrop)
	PetJournalPetCardPetInfo.backdrop:SetFrameLevel(PetJournalPetCardPetInfo.backdrop:GetFrameLevel() + 2)
	PetJournalPetCardPetInfo.level:SetParent(PetJournalPetCardPetInfo.backdrop)

	PetJournalPrimaryAbilityTooltip:StripTextures()
	PetJournalPrimaryAbilityTooltip:SetTemplate()

	for i=1, 6 do
		local frame = _G["PetJournalPetCardSpell"..i]
		frame:SetFrameLevel(frame:GetFrameLevel() + 2)
		frame:DisableDrawLayer("BACKGROUND")
		frame:CreateBackdrop("Default")
		frame.backdrop:SetAllPoints()
		frame.icon:SetTexCoord(.1,.9,.1,.9)
		frame.icon:SetInside(frame.backdrop)
	end

	PetJournalPetCardHealthFrame.healthBar:StripTextures()
	PetJournalPetCardHealthFrame.healthBar:CreateBackdrop("Default")
	PetJournalPetCardHealthFrame.healthBar:SetStatusBarTexture(C.media.normTex)
	PetJournalPetCardXPBar:StripTextures()
	PetJournalPetCardXPBar:CreateBackdrop("Default")
	PetJournalPetCardXPBar:SetStatusBarTexture(C.media.normTex)
	PetJournalLoadoutBorder:Height(350)
end

T.SkinFuncs["Blizzard_PetJournal"] = LoadSkin

local function LoadPetStableSkin()
	PetStableFrame:StripTextures()
	PetStableFrame:SetTemplate()
	PetStableFrame:CreateShadow()
	PetStableFrameInset:StripTextures()
	PetStableLeftInset:StripTextures()
	PetStableBottomInset:StripTextures()
	PetStableFrameCloseButton:SkinCloseButton()
	PetStablePrevPageButton:SkinNextPrevButton()
	PetStableNextPageButton:SkinNextPrevButton()
	
	for i = 1, 5 do
		local b = _G["PetStableActivePet"..i]
		b.Border:Hide()
		b.Background:Hide()
		b:SkinButton()
	end
	
	for i = 1, 10 do
		local b = _G["PetStableStabledPet"..i]
		b.Background:Hide()
		b:SkinButton()
		b:StyleButton()
	end
end
tinsert(T.SkinFuncs["Tukui"], LoadPetStableSkin)