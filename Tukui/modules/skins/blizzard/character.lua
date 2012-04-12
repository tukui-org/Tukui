local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	T.SkinCloseButton(CharacterFrameCloseButton)

	local slots = {
		"HeadSlot",
		"NeckSlot",
		"ShoulderSlot",
		"BackSlot",
		"ChestSlot",
		"ShirtSlot",
		"TabardSlot",
		"WristSlot",
		"HandsSlot",
		"WaistSlot",
		"LegsSlot",
		"FeetSlot",
		"Finger0Slot",
		"Finger1Slot",
		"Trinket0Slot",
		"Trinket1Slot",
		"MainHandSlot",
		"SecondaryHandSlot",
		"RangedSlot",
	}
	
	for _, slot in pairs(slots) do
		local icon = _G["Character"..slot.."IconTexture"]
		local slot = _G["Character"..slot]
		slot:StripTextures()
		slot:StyleButton(false)
		icon:SetTexCoord(.08, .92, .08, .92)
		icon:ClearAllPoints()
		icon:Point("TOPLEFT", 2, -2)
		icon:Point("BOTTOMRIGHT", -2, 2)
		
		slot:SetFrameLevel(slot:GetFrameLevel() + 2)
		slot:CreateBackdrop("Default")
		slot.backdrop:SetAllPoints()
	end

	--Strip Textures
	local charframe = {
		"CharacterFrame",
		"CharacterModelFrame",
		"CharacterFrameInset", 
		"CharacterStatsPane",
		"CharacterFrameInsetRight",
		"PaperDollSidebarTabs",
		"PaperDollEquipmentManagerPane",
		"PaperDollFrameItemFlyout",
	}

	CharacterFrameExpandButton:Size(CharacterFrameExpandButton:GetWidth() - 7, CharacterFrameExpandButton:GetHeight() - 7)
	T.SkinNextPrevButton(CharacterFrameExpandButton)

	if T.toc < 40300 then
		T.SkinRotateButton(CharacterModelFrameRotateLeftButton)
		T.SkinRotateButton(CharacterModelFrameRotateRightButton)
		CharacterModelFrameRotateLeftButton:Point("TOPLEFT", CharacterModelFrame, "TOPLEFT", 4, -4)
		CharacterModelFrameRotateRightButton:Point("TOPLEFT", CharacterModelFrameRotateLeftButton, "TOPRIGHT", 4, 0)

		--Swap item flyout frame (shown when holding alt over a slot)
		PaperDollFrameItemFlyout:HookScript("OnShow", function()
			PaperDollFrameItemFlyoutButtons:StripTextures()
			
			for i=1, PDFITEMFLYOUT_MAXITEMS do
				local button = _G["PaperDollFrameItemFlyoutButtons"..i]
				local icon = _G["PaperDollFrameItemFlyoutButtons"..i.."IconTexture"]
				if button then
					button:StyleButton(false)
					
					icon:SetTexCoord(.08, .92, .08, .92)
					button:GetNormalTexture():SetTexture(nil)
					
					icon:ClearAllPoints()
					icon:Point("TOPLEFT", 2, -2)
					icon:Point("BOTTOMRIGHT", -2, 2)	
					button:SetFrameLevel(button:GetFrameLevel() + 2)
					if not button.backdrop then
						button:CreateBackdrop("Default")
						button.backdrop:SetAllPoints()			
					end
				end
			end
		end)
	else
		EquipmentFlyoutFrameHighlight:Kill()
		local function SkinItemFlyouts()
			EquipmentFlyoutFrameButtons:StripTextures()

			for i = 1, EQUIPMENTFLYOUT_MAXITEMS do
				local button = _G["EquipmentFlyoutFrameButton"..i]
				local icon = _G["EquipmentFlyoutFrameButton"..i.."IconTexture"]
				if button then
					button:StyleButton(false)

					icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					button:GetNormalTexture():SetTexture(nil)

					icon:ClearAllPoints()
					icon:Point("TOPLEFT", 2, -2)
					icon:Point("BOTTOMRIGHT", -2, 2)
					button:SetFrameLevel(button:GetFrameLevel() + 2)
					button:SetFrameStrata("DIALOG")
					if not button.backdrop then
						button:CreateBackdrop("Default")
						button.backdrop:SetAllPoints()
					end
				end
			end
		end

		-- Swap item flyout frame (shown when holding alt over a slot)
		EquipmentFlyoutFrame:HookScript("OnShow", SkinItemFlyouts)
		hooksecurefunc("EquipmentFlyout_Show", SkinItemFlyouts)
	end

	--Icon in upper right corner of character frame
	CharacterFramePortrait:Kill()
	CharacterModelFrame:CreateBackdrop("Default")

	local scrollbars = {
		"PaperDollTitlesPaneScrollBar",
		"PaperDollEquipmentManagerPaneScrollBar",
		"CharacterStatsPaneScrollBar",
		"ReputationListScrollFrameScrollBar",
	}

	for _, scrollbar in pairs(scrollbars) do
		T.SkinScrollBar(_G[scrollbar])
	end

	for _, object in pairs(charframe) do
		if _G[object] then
			_G[object]:StripTextures()
		end
	end

	--Titles
	PaperDollTitlesPane:HookScript("OnShow", function(self)
		for x, object in pairs(PaperDollTitlesPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)

			object.Check:SetTexture(nil)
			object.text:SetFont(C["media"].font,12)
			object.text.SetFont = T.dummy
		end
	end)

	--Equipement Manager
	T.SkinButton(PaperDollEquipmentManagerPaneEquipSet)
	T.SkinButton(PaperDollEquipmentManagerPaneSaveSet)
	T.SkinScrollBar(GearManagerDialogPopupScrollFrameScrollBar)
	PaperDollEquipmentManagerPaneEquipSet:Width(PaperDollEquipmentManagerPaneEquipSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneSaveSet:Width(PaperDollEquipmentManagerPaneSaveSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneEquipSet:Point("TOPLEFT", PaperDollEquipmentManagerPane, "TOPLEFT", 8, 0)
	PaperDollEquipmentManagerPaneSaveSet:Point("LEFT", PaperDollEquipmentManagerPaneEquipSet, "RIGHT", 4, 0)
	PaperDollEquipmentManagerPaneEquipSet.ButtonBackground:SetTexture(nil)
	PaperDollEquipmentManagerPane:HookScript("OnShow", function(self)
		for x, object in pairs(PaperDollEquipmentManagerPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)

			object.Check:SetTexture(nil)
			object.icon:SetTexCoord(.08, .92, .08, .92)
			object:SetTemplate("Default")
		end
		GearManagerDialogPopup:StripTextures()
		GearManagerDialogPopup:SetTemplate("Default")
		GearManagerDialogPopup:Point("LEFT", PaperDollFrame, "RIGHT", 4, 0)
		GearManagerDialogPopupScrollFrame:StripTextures()
		GearManagerDialogPopupEditBox:StripTextures()
		GearManagerDialogPopupEditBox:SetTemplate("Default")
		T.SkinButton(GearManagerDialogPopupOkay)
		T.SkinButton(GearManagerDialogPopupCancel)
		
		for i=1, NUM_GEARSET_ICONS_SHOWN do
			local button = _G["GearManagerDialogPopupButton"..i]
			local icon = button.icon
			
			if button then
				button:StripTextures()
				button:StyleButton(true)
				
				icon:SetTexCoord(.08, .92, .08, .92)
				_G["GearManagerDialogPopupButton"..i.."Icon"]:SetTexture(nil)
				
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)	
				button:SetFrameLevel(button:GetFrameLevel() + 2)
				if not button.backdrop then
					button:CreateBackdrop("Default")
					button.backdrop:SetAllPoints()			
				end
			end
		end
	end)

	--Handle Tabs at bottom of character frame
	for i=1, 4 do
		T.SkinTab(_G["CharacterFrameTab"..i])
	end

	--Buttons used to toggle between equipment manager, titles, and character stats
	local function FixSidebarTabCoords()
		for i=1, #PAPERDOLL_SIDEBARS do
			local tab = _G["PaperDollSidebarTab"..i]
			if tab then
				tab.Highlight:SetTexture(1, 1, 1, 0.3)
				tab.Highlight:Point("TOPLEFT", 3, -4)
				tab.Highlight:Point("BOTTOMRIGHT", -1, 0)
				tab.Hider:SetTexture(0.4,0.4,0.4,0.4)
				tab.Hider:Point("TOPLEFT", 3, -4)
				tab.Hider:Point("BOTTOMRIGHT", -1, 0)
				tab.TabBg:Kill()
				
				if i == 1 then
					for i=1, tab:GetNumRegions() do
						local region = select(i, tab:GetRegions())
						region:SetTexCoord(0.16, 0.86, 0.16, 0.86)
						region.SetTexCoord = T.dummy
					end
				end
				tab:CreateBackdrop("Default")
				tab.backdrop:Point("TOPLEFT", 1, -2)
				tab.backdrop:Point("BOTTOMRIGHT", 1, -2)	
			end
		end
	end
	hooksecurefunc("PaperDollFrame_UpdateSidebarTabs", FixSidebarTabCoords)

	--Stat panels, atm it looks like 7 is the max
	for i=1, 7 do
		_G["CharacterStatsPaneCategory"..i]:StripTextures()
	end

	--Reputation
	local function UpdateFactionSkins()
		ReputationListScrollFrame:StripTextures()
		ReputationFrame:StripTextures(true)
		for i=1, GetNumFactions() do
			local statusbar = _G["ReputationBar"..i.."ReputationBar"]

			if statusbar then
				statusbar:SetStatusBarTexture(C["media"].normTex)
				
				if not statusbar.backdrop then
					statusbar:CreateBackdrop("Default")
				end
				
				_G["ReputationBar"..i.."Background"]:SetTexture(nil)
				_G["ReputationBar"..i.."LeftLine"]:Kill()
				_G["ReputationBar"..i.."BottomLine"]:Kill()
				_G["ReputationBar"..i.."ReputationBarHighlight1"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarHighlight2"]:SetTexture(nil)	
				_G["ReputationBar"..i.."ReputationBarAtWarHighlight1"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarAtWarHighlight2"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarLeftTexture"]:SetTexture(nil)
				_G["ReputationBar"..i.."ReputationBarRightTexture"]:SetTexture(nil)
				
			end		
		end
		ReputationDetailFrame:StripTextures()
		ReputationDetailFrame:SetTemplate("Default")
		ReputationDetailFrame:Point("TOPLEFT", ReputationFrame, "TOPRIGHT", 4, -28)
	end	
	ReputationFrame:HookScript("OnShow", UpdateFactionSkins)
	hooksecurefunc("ReputationFrame_OnEvent", UpdateFactionSkins)
	T.SkinCloseButton(ReputationDetailCloseButton)
	T.SkinCheckBox(ReputationDetailAtWarCheckBox)
	T.SkinCheckBox(ReputationDetailInactiveCheckBox)
	T.SkinCheckBox(ReputationDetailMainScreenCheckBox)
	
	local function UpdateReputationExpand()
		-- Skin Expand Buttons
		for i=1, NUM_FACTIONS_DISPLAYED do
			local bar = _G["ReputationBar"..i]
			local button = _G["ReputationBar"..i.."ExpandOrCollapseButton"]
			if not bar.isSkinned then
				button:StripTextures()
				button.SetNormalTexture = T.dummy
				T.SkinCloseButton(button)
				bar.isSkinned = true
			end
			
			-- set the X or V texture
			if bar.isCollapsed then
				button.t:SetText("V")
			else
				button.t:SetText("X")
			end
		end
	end
	hooksecurefunc("ReputationFrame_Update", UpdateReputationExpand)
	
	--Currency
	TokenFrame:HookScript("OnShow", function()
		for i=1, GetCurrencyListSize() do
			local button = _G["TokenFrameContainerButton"..i]
			
			if button then
				button.highlight:Kill()
				button.categoryMiddle:Kill()	
				button.categoryLeft:Kill()	
				button.categoryRight:Kill()
				
				if button.icon then
					button.icon:SetTexCoord(.08, .92, .08, .92)
				end
			end
		end
		TokenFramePopup:StripTextures()
		TokenFramePopup:SetTemplate("Default")
		TokenFramePopup:Point("TOPLEFT", TokenFrame, "TOPRIGHT", 4, -28)				
	end)
	T.SkinScrollBar(TokenFrameContainerScrollBar)

	--Pet
	PetModelFrame:CreateBackdrop("Default")
	PetPaperDollFrameExpBar:StripTextures()
	PetPaperDollFrameExpBar:SetStatusBarTexture(C["media"].normTex)
	PetPaperDollFrameExpBar:CreateBackdrop("Default")
	T.SkinRotateButton(PetModelFrameRotateRightButton)
	T.SkinRotateButton(PetModelFrameRotateLeftButton)
	PetModelFrameRotateRightButton:ClearAllPoints()
	PetModelFrameRotateRightButton:Point("LEFT", PetModelFrameRotateLeftButton, "RIGHT", 4, 0)

	local xtex = PetPaperDollPetInfo:GetRegions()
	xtex:SetTexCoord(.12, .63, .15, .55)
	PetPaperDollPetInfo:CreateBackdrop("Default")
	PetPaperDollPetInfo:Size(24, 24)
	
	-- a request to color item by rarity on character frame.
	local function ColorItemBorder()
		for _, slot in pairs(slots) do
			-- Colour the equipment slots by rarity
			local target = _G["Character"..slot]
			local slotId, _, _ = GetInventorySlotInfo(slot)
			local itemId = GetInventoryItemID("player", slotId)
			
			if itemId then
				local _, _, rarity, _, _, _, _, _, _, _, _ = GetItemInfo(itemId)
				if rarity then				
					target.backdrop:SetBackdropBorderColor(GetItemQualityColor(rarity))
				end
			else
				target.backdrop:SetBackdropBorderColor(unpack(C.media.bordercolor))
			end
		end
	end
	
	-- execute item coloring everytime we open character frame
	CharacterFrame:HookScript("OnShow", ColorItemBorder)
	
	-- execute item coloring everytime an item is changed
	local CheckItemBorderColor = CreateFrame("Frame")
	CheckItemBorderColor:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	CheckItemBorderColor:SetScript("OnEvent", ColorItemBorder)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)