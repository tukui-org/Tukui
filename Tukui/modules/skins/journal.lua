local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
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
	EncounterJournalNavBarHomeButton:SkinButton(true)
	
	EncounterJournalSearchBox:SkinEditBox()
	EncounterJournalCloseButton:SkinCloseButton()
	
	EncounterJournalInset:StripTextures(true)
	EncounterJournal:HookScript("OnShow", function()
		if not EncounterJournalInstanceSelect.backdrop then						
								
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
		EncounterJournalEncounterFrameInfoBossTab:SetTemplate("Default")
		EncounterJournalEncounterFrameInfoBossTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoBossTab:Point("TOPRIGHT", EncounterJournalEncounterFrame, "TOPRIGHT", 75, 20)
		
		EncounterJournalEncounterFrameInfoLootTab:SetTemplate("Default")
		EncounterJournalEncounterFrameInfoLootTab:ClearAllPoints()
		EncounterJournalEncounterFrameInfoLootTab:Point("TOP", EncounterJournalEncounterFrameInfoBossTab, "BOTTOM", 0, -4)
		
		if T.toc > 50300 then
			EncounterJournalEncounterFrameInfoModelTab:SetTemplate()
			EncounterJournalEncounterFrameInfoModelTab:ClearAllPoints()
			EncounterJournalEncounterFrameInfoModelTab:Point("TOP", EncounterJournalEncounterFrameInfoLootTab, "BOTTOM", 0, -4)		
		end
	end)
	
	EncounterJournalInstanceSelectScrollFrameScrollBar:SkinScrollBar()

	EncounterJournalEncounterFrameInfoBossTab:GetNormalTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetPushedTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetDisabledTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoBossTab:GetHighlightTexture():SetTexture(nil)

	EncounterJournalEncounterFrameInfoLootTab:GetNormalTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetPushedTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetDisabledTexture():SetTexture(nil)
	EncounterJournalEncounterFrameInfoLootTab:GetHighlightTexture():SetTexture(nil)	
	
	EncounterJournalInstanceSelect:StripTextures()
	EncounterJournalInstanceSelectDungeonTab:SkinTab()
	EncounterJournalInstanceSelectRaidTab.grayBox:StripTextures()
	EncounterJournalInstanceSelectRaidTab:SkinTab()
	EncounterJournalInstanceSelectRaidTab:Enable()
	EncounterJournal.instanceSelect.bg:SetAlpha(0)
	EncounterJournalInstanceSelectScrollDownButton:SkinCloseButton()
	EncounterJournalInstanceSelectScrollDownButton.t:SetText(" V")
	EncounterJournalInstanceSelectScrollDownButton.t:SetPoint("CENTER")
	EncounterJournalInstanceSelectScrollDownButton:SetTemplate()
	EncounterJournalInstanceSelectScrollDownButton:Size(18,21)
	

	local function SkinDungeons()
		-- why the fuck button 1 is not named the same as 2+
		local b1 = EncounterJournalInstanceSelectScrollFrameScrollChildInstanceButton1
		if b1 and not b1.isSkinned then 
			b1:CreateBackdrop()
			b1.backdrop:SetBackdropColor(0,0,0,0)
			b1:StyleButton()
			b1.isSkinned = true
			b1.bgImage:SetTexCoord(0.08,.6,0.08,.6)
			b1.bgImage:SetDrawLayer("OVERLAY")
		end

		for i = 1, 100 do
			local b = _G["EncounterJournalInstanceSelectScrollFrameinstance"..i]
			if b and not b.isSkinned then
				b:CreateBackdrop()
				b.backdrop:SetBackdropColor(0,0,0,0)
				b:StyleButton()
				b.isSkinned = true
				b.bgImage:SetTexCoord(0.08,.6,0.08,.6)
				b.bgImage:SetDrawLayer("OVERLAY")
			end
		end
	end
	SkinDungeons()
	hooksecurefunc("EncounterJournal_ListInstances", SkinDungeons)
	
	EncounterJournalEncounterFrameInfoLootScrollFrameScrollBar:SkinScrollBar()
	EncounterJournalEncounterFrameInfoDetailsScrollFrameScrollBar:SkinScrollBar()
	EncounterJournalEncounterFrameInstanceFrameLoreScrollFrameScrollBar:SkinScrollBar()
	EncounterJournalEncounterFrameInfoBossesScrollFrameScrollBar:SkinScrollBar()
end

T.SkinFuncs["Blizzard_EncounterJournal"] = LoadSkin
