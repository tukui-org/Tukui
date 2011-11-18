local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	if T.toc >= 40200 then
		EncounterJournal:StripTextures(true)
		
		EncounterJournal.backdrop = EncounterJournal:CreateTexture(nil, "BACKGROUND")
		EncounterJournal.backdrop:SetDrawLayer("BACKGROUND", -7)
		EncounterJournal.backdrop:SetTexture(0, 0, 0)
		EncounterJournal.backdrop:Point("TOPLEFT", EncounterJournal, "TOPLEFT", -T.mult*3, T.mult*3)
		EncounterJournal.backdrop:Point("BOTTOMRIGHT", EncounterJournal, "BOTTOMRIGHT", T.mult*3, -T.mult*3)
		
		EncounterJournal.backdrop2 = EncounterJournal:CreateTexture(nil, "BACKGROUND")
		EncounterJournal.backdrop2:SetDrawLayer("BACKGROUND", -6)
		EncounterJournal.backdrop2:SetTexture(unpack(C["media"].bordercolor))
		EncounterJournal.backdrop2:Point("TOPLEFT", EncounterJournal, "TOPLEFT", -T.mult*2, T.mult*2)
		EncounterJournal.backdrop2:Point("BOTTOMRIGHT", EncounterJournal, "BOTTOMRIGHT", T.mult*2, -T.mult*2)						

		EncounterJournal.backdrop3 = EncounterJournal:CreateTexture(nil, "BACKGROUND")
		EncounterJournal.backdrop3:SetDrawLayer("BACKGROUND", -5)
		EncounterJournal.backdrop3:SetTexture(0, 0, 0)
		EncounterJournal.backdrop3:Point("TOPLEFT", EncounterJournal, "TOPLEFT", -T.mult, T.mult)
		EncounterJournal.backdrop3:Point("BOTTOMRIGHT", EncounterJournal, "BOTTOMRIGHT", T.mult, -T.mult)					

		EncounterJournal.backdrop4 = EncounterJournal:CreateTexture(nil, "BACKGROUND")
		EncounterJournal.backdrop4:SetDrawLayer("BACKGROUND", -4)
		EncounterJournal.backdrop4:SetTexture(unpack(C["media"].backdropcolor))
		EncounterJournal.backdrop4:SetAllPoints()						
		
		EncounterJournalNavBar:StripTextures(true)
		EncounterJournalNavBarOverlay:StripTextures(true)
		
		EncounterJournalNavBar:CreateBackdrop("Default")
		EncounterJournalNavBar.backdrop:Point("TOPLEFT", -2, 0)
		EncounterJournalNavBar.backdrop:SetPoint("BOTTOMRIGHT")
		T.SkinButton(EncounterJournalNavBarHomeButton, true)
		
		T.SkinEditBox(EncounterJournalSearchBox)
		T.SkinCloseButton(EncounterJournalCloseButton)
		
		EncounterJournalInset:StripTextures(true)
		EncounterJournal:HookScript("OnShow", function()
			if not EncounterJournalInstanceSelect.backdrop then						
				EncounterJournalInstanceSelect.backdrop = EncounterJournalInstanceSelect:CreateTexture(nil, "BACKGROUND")
				EncounterJournalInstanceSelect.backdrop:SetDrawLayer("BACKGROUND", -3)
				EncounterJournalInstanceSelect.backdrop:SetTexture(0, 0, 0)
				EncounterJournalInstanceSelect.backdrop:Point("TOPLEFT", EncounterJournalInstanceSelect.bg, "TOPLEFT", -T.mult*3, T.mult*3)
				EncounterJournalInstanceSelect.backdrop:Point("BOTTOMRIGHT", EncounterJournalInstanceSelect.bg, "BOTTOMRIGHT", T.mult*3, -T.mult*3)
				
				EncounterJournalInstanceSelect.backdrop2 = EncounterJournalInstanceSelect:CreateTexture(nil, "BACKGROUND")
				EncounterJournalInstanceSelect.backdrop2:SetDrawLayer("BACKGROUND", -2)
				EncounterJournalInstanceSelect.backdrop2:SetTexture(unpack(C["media"].bordercolor))
				EncounterJournalInstanceSelect.backdrop2:Point("TOPLEFT", EncounterJournalInstanceSelect.bg, "TOPLEFT", -T.mult*2, T.mult*2)
				EncounterJournalInstanceSelect.backdrop2:Point("BOTTOMRIGHT", EncounterJournalInstanceSelect.bg, "BOTTOMRIGHT", T.mult*2, -T.mult*2)						

				EncounterJournalInstanceSelect.backdrop3 = EncounterJournalInstanceSelect:CreateTexture(nil, "BACKGROUND")
				EncounterJournalInstanceSelect.backdrop3:SetDrawLayer("BACKGROUND", -1)
				EncounterJournalInstanceSelect.backdrop3:SetTexture(0, 0, 0)
				EncounterJournalInstanceSelect.backdrop3:Point("TOPLEFT", EncounterJournalInstanceSelect.bg, "TOPLEFT", -T.mult, T.mult)
				EncounterJournalInstanceSelect.backdrop3:Point("BOTTOMRIGHT", EncounterJournalInstanceSelect.bg, "BOTTOMRIGHT", T.mult, -T.mult)								
			end
			
			if not EncounterJournalEncounterFrameInfo.backdrop then						
				EncounterJournalEncounterFrameInfo.backdrop = EncounterJournalEncounterFrameInfo:CreateTexture(nil, "BACKGROUND")
				EncounterJournalEncounterFrameInfo.backdrop:SetDrawLayer("BACKGROUND", -3)
				EncounterJournalEncounterFrameInfo.backdrop:SetTexture(0, 0, 0)
				EncounterJournalEncounterFrameInfo.backdrop:Point("TOPLEFT", EncounterJournalEncounterFrameInfoBG, "TOPLEFT", -T.mult*3, T.mult*3)
				EncounterJournalEncounterFrameInfo.backdrop:Point("BOTTOMRIGHT", EncounterJournalEncounterFrameInfoBG, "BOTTOMRIGHT", T.mult*3, -T.mult*3)
				
				EncounterJournalEncounterFrameInfo.backdrop2 = EncounterJournalEncounterFrameInfo:CreateTexture(nil, "BACKGROUND")
				EncounterJournalEncounterFrameInfo.backdrop2:SetDrawLayer("BACKGROUND", -2)
				EncounterJournalEncounterFrameInfo.backdrop2:SetTexture(unpack(C["media"].bordercolor))
				EncounterJournalEncounterFrameInfo.backdrop2:Point("TOPLEFT", EncounterJournalEncounterFrameInfoBG, "TOPLEFT", -T.mult*2, T.mult*2)
				EncounterJournalEncounterFrameInfo.backdrop2:Point("BOTTOMRIGHT", EncounterJournalEncounterFrameInfoBG, "BOTTOMRIGHT", T.mult*2, -T.mult*2)						

				EncounterJournalEncounterFrameInfo.backdrop3 = EncounterJournalEncounterFrameInfo:CreateTexture(nil, "BACKGROUND")
				EncounterJournalEncounterFrameInfo.backdrop3:SetDrawLayer("BACKGROUND", -1)
				EncounterJournalEncounterFrameInfo.backdrop3:SetTexture(0, 0, 0)
				EncounterJournalEncounterFrameInfo.backdrop3:Point("TOPLEFT", EncounterJournalEncounterFrameInfoBG, "TOPLEFT", -T.mult, T.mult)
				EncounterJournalEncounterFrameInfo.backdrop3:Point("BOTTOMRIGHT", EncounterJournalEncounterFrameInfoBG, "BOTTOMRIGHT", T.mult, -T.mult)								
			end	
			EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
			EncounterJournalEncounterFrameInfoBossTab:Point("LEFT", EncounterJournalEncounterFrameInfoEncounterTile, "RIGHT", -10, 4)
			EncounterJournalEncounterFrameInfoLootTab:ClearAllPoints()
			EncounterJournalEncounterFrameInfoLootTab:Point("LEFT", EncounterJournalEncounterFrameInfoBossTab, "RIGHT", -24, 0)
			
			EncounterJournalEncounterFrameInfoBossTab:SetFrameStrata("HIGH")
			EncounterJournalEncounterFrameInfoLootTab:SetFrameStrata("HIGH")
			
			EncounterJournalEncounterFrameInfoBossTab:SetScale(0.75)
			EncounterJournalEncounterFrameInfoLootTab:SetScale(0.75)
		end)
		
		T.SkinScrollBar(EncounterJournalInstanceSelectScrollFrameScrollBar)

		EncounterJournalEncounterFrameInfoBossTab:GetNormalTexture():SetTexture(nil)
		EncounterJournalEncounterFrameInfoBossTab:GetPushedTexture():SetTexture(nil)
		EncounterJournalEncounterFrameInfoBossTab:GetDisabledTexture():SetTexture(nil)
		EncounterJournalEncounterFrameInfoBossTab:GetHighlightTexture():SetTexture(nil)

		EncounterJournalEncounterFrameInfoLootTab:GetNormalTexture():SetTexture(nil)
		EncounterJournalEncounterFrameInfoLootTab:GetPushedTexture():SetTexture(nil)
		EncounterJournalEncounterFrameInfoLootTab:GetDisabledTexture():SetTexture(nil)
		EncounterJournalEncounterFrameInfoLootTab:GetHighlightTexture():SetTexture(nil)		
	end
end

if T.toc == 40200 then
	tinsert(T.SkinFuncs["Tukui"], LoadSkin)
else
	T.SkinFuncs["Blizzard_EncounterJournal"] = LoadSkin
end