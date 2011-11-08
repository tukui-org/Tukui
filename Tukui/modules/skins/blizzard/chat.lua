local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	local frames = {
		"ChatConfigFrame",
		"ChatConfigCategoryFrame",
		"ChatConfigBackgroundFrame",
		"ChatConfigChatSettingsClassColorLegend",
		"ChatConfigChannelSettingsClassColorLegend",
		"ChatConfigCombatSettingsFilters",
		"ChatConfigCombatSettingsFiltersScrollFrame",
		"CombatConfigColorsHighlighting",
		"CombatConfigColorsColorizeUnitName",
		"CombatConfigColorsColorizeSpellNames",
		"CombatConfigColorsColorizeDamageNumber",
		"CombatConfigColorsColorizeDamageSchool",
		"CombatConfigColorsColorizeEntireLine",
		"ChatConfigChatSettingsLeft",
		"ChatConfigOtherSettingsCombat",
		"ChatConfigOtherSettingsPVP",
		"ChatConfigOtherSettingsSystem",
		"ChatConfigOtherSettingsCreature",
		"ChatConfigChannelSettingsLeft",
		"CombatConfigMessageSourcesDoneBy",
		"CombatConfigMessageSourcesDoneTo",
		"CombatConfigColorsUnitColors",
	}
	
	for i = 1, getn(frames) do
		local SkinFrames = _G[frames[i]]
		SkinFrames:StripTextures()
		SkinFrames:SetTemplate("Default")
	end
	
	local otherframe = {
		"CombatConfigColorsColorizeSpellNames",
		"CombatConfigColorsColorizeDamageNumber",
		"CombatConfigColorsColorizeDamageSchool",
		"CombatConfigColorsColorizeEntireLine",
	}
	
	for i = 1, getn(otherframe) do
		local SkinFrames = _G[otherframe[i]]
		SkinFrames:ClearAllPoints()
		if SkinFrames == CombatConfigColorsColorizeSpellNames then
			SkinFrames:Point("TOP",CombatConfigColorsColorizeUnitName,"BOTTOM",0,-2)
		else
			SkinFrames:Point("TOP",_G[otherframe[i-1]],"BOTTOM",0,-2)
		end
	end
	
	ChatConfigChannelSettingsLeft:RegisterEvent("PLAYER_ENTERING_WORLD")
	ChatConfigChannelSettingsLeft:SetScript("OnEvent", function(self, event)
		ChatConfigChannelSettingsLeft:UnregisterEvent("PLAYER_ENTERING_WORLD")
		for i = 1,#ChatConfigChannelSettingsLeft.checkBoxTable do
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigChannelSettingsLeftCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:SetHeight(ChatConfigOtherSettingsCombatCheckBox1:GetHeight())
			T.SkinCheckBox(_G["ChatConfigChannelSettingsLeftCheckBox"..i.."Check"])
			T.SkinCheckBox(_G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"])
			_G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"]:SetHeight(ChatConfigChatSettingsLeftCheckBox1Check:GetHeight())
		end
	end)
	
	--Makes the skin work, but only after /reload ui :o   (found in chatconfingframe.xml)
	CreateChatChannelList(self, GetChannelList())
	ChatConfig_CreateCheckboxes(ChatConfigChannelSettingsLeft, CHAT_CONFIG_CHANNEL_LIST, "ChatConfigCheckBoxWithSwatchAndClassColorTemplate", CHANNELS)
	ChatConfig_UpdateCheckboxes(ChatConfigChannelSettingsLeft)
	
	
	ChatConfigBackgroundFrame:SetScript("OnShow", function(self)
		-- >> Chat >> Chat Settings
		for i = 1,#CHAT_CONFIG_CHAT_LEFT do
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigChatSettingsLeftCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigChatSettingsLeftCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:SetHeight(ChatConfigOtherSettingsCombatCheckBox1:GetHeight())
			T.SkinCheckBox(_G["ChatConfigChatSettingsLeftCheckBox"..i.."Check"])
			T.SkinCheckBox(_G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"])
			_G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"]:SetHeight(ChatConfigChatSettingsLeftCheckBox1Check:GetHeight())
		end
	
		-- >> Other >> Combat
		for i = 1,#CHAT_CONFIG_OTHER_COMBAT do
			_G["ChatConfigOtherSettingsCombatCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsCombatCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigOtherSettingsCombatCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigOtherSettingsCombatCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsCombatCheckBox"..i.."Check"])
		end
			
		-- >> Other >> PvP
		for i = 1,#CHAT_CONFIG_OTHER_PVP do
			_G["ChatConfigOtherSettingsPVPCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsPVPCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigOtherSettingsPVPCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigOtherSettingsPVPCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsPVPCheckBox"..i.."Check"])
		end
	
		-- >> Other >> System
		for i = 1,#CHAT_CONFIG_OTHER_SYSTEM do
			_G["ChatConfigOtherSettingsSystemCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsSystemCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigOtherSettingsSystemCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigOtherSettingsSystemCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsSystemCheckBox"..i.."Check"])
		end
	
		-- >> Other >> Creatures
		for i = 1,#CHAT_CONFIG_CHAT_CREATURE_LEFT do
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsCreatureCheckBox"..i.."Check"])
		end
	
		-- >> Sources >> DoneBy
		for i = 1,#COMBAT_CONFIG_MESSAGESOURCES_BY do
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i]:StripTextures()
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i]:CreateBackdrop()
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["CombatConfigMessageSourcesDoneByCheckBox"..i.."Check"])
		end
	
		-- >> Sources >> DoneTo
		for i = 1,#COMBAT_CONFIG_MESSAGESOURCES_TO do
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i]:StripTextures()
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i]:CreateBackdrop()
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["CombatConfigMessageSourcesDoneToCheckBox"..i.."Check"])
		end
	
		-- >> Combat >> Colors >> Unit Colors
		for i = 1,#COMBAT_CONFIG_UNIT_COLORS do
			_G["CombatConfigColorsUnitColorsSwatch"..i]:StripTextures()
			_G["CombatConfigColorsUnitColorsSwatch"..i]:CreateBackdrop()
			_G["CombatConfigColorsUnitColorsSwatch"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["CombatConfigColorsUnitColorsSwatch"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
		end
			
		-- >> Combat >> Messages Types
		for i=1,4 do
			for j=1,4 do
				if _G["CombatConfigMessageTypesLeftCheckBox"..i] and _G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j] then
					T.SkinCheckBox(_G["CombatConfigMessageTypesLeftCheckBox"..i])
					T.SkinCheckBox(_G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j])
				end
			end
			for j=1,10 do
				if _G["CombatConfigMessageTypesRightCheckBox"..i] and _G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j] then
					T.SkinCheckBox(_G["CombatConfigMessageTypesRightCheckBox"..i])
					T.SkinCheckBox(_G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j])
				end
			end
			T.SkinCheckBox(_G["CombatConfigMessageTypesMiscCheckBox"..i])
		end
	end)
			
	-- >> Combat >> Tabs
	for i = 1,#COMBAT_CONFIG_TABS do
		local cctab = _G["CombatConfigTab"..i]
		if cctab then
			T.SkinTab(cctab)
			cctab:SetHeight(cctab:GetHeight()-2)
			cctab:SetWidth(math.ceil(cctab:GetWidth()+1.6))
			_G["CombatConfigTab"..i.."Text"]:SetPoint("BOTTOM",0,10)
		end
	end
	CombatConfigTab1:ClearAllPoints()
	CombatConfigTab1:SetPoint("BOTTOMLEFT",ChatConfigBackgroundFrame,"TOPLEFT",6,-2)

	local ccbuttons = {
		"ChatConfigFrameOkayButton",
		"ChatConfigFrameDefaultButton",
		"CombatLogDefaultButton",
		"ChatConfigCombatSettingsFiltersDeleteButton",
		"ChatConfigCombatSettingsFiltersAddFilterButton",
		"ChatConfigCombatSettingsFiltersCopyFilterButton",
		"CombatConfigSettingsSaveButton",
	}
	for i = 1, getn(ccbuttons) do
		local ccbtn = _G[ccbuttons[i]]
		if ccbtn then
			T.SkinButton(ccbtn)
			ccbtn:ClearAllPoints()
		end
	end
	ChatConfigFrameOkayButton:SetPoint("TOPRIGHT",ChatConfigBackgroundFrame,"BOTTOMRIGHT",-3,-5)
	ChatConfigFrameDefaultButton:SetPoint("TOPLEFT",ChatConfigCategoryFrame,"BOTTOMLEFT",1,-5)
	CombatLogDefaultButton:SetPoint("TOPLEFT",ChatConfigCategoryFrame,"BOTTOMLEFT",1,-5)
	ChatConfigCombatSettingsFiltersDeleteButton:SetPoint("TOPRIGHT",ChatConfigCombatSettingsFilters,"BOTTOMRIGHT",-3,-1)
	ChatConfigCombatSettingsFiltersCopyFilterButton:SetPoint("RIGHT",ChatConfigCombatSettingsFiltersDeleteButton,"LEFT",-2,0)
	ChatConfigCombatSettingsFiltersAddFilterButton:SetPoint("RIGHT",ChatConfigCombatSettingsFiltersCopyFilterButton,"LEFT",-2,0)
	
	local cccheckbox = {
		"CombatConfigColorsHighlightingLine",
		"CombatConfigColorsHighlightingAbility",
		"CombatConfigColorsHighlightingDamage",
		"CombatConfigColorsHighlightingSchool",
		"CombatConfigColorsColorizeUnitNameCheck",
		"CombatConfigColorsColorizeSpellNamesCheck",
		"CombatConfigColorsColorizeSpellNamesSchoolColoring",
		"CombatConfigColorsColorizeDamageNumberCheck",
		"CombatConfigColorsColorizeDamageNumberSchoolColoring",
		"CombatConfigColorsColorizeDamageSchoolCheck",
		"CombatConfigColorsColorizeEntireLineCheck",
		"CombatConfigFormattingShowTimeStamp",
		"CombatConfigFormattingShowBraces",
		"CombatConfigFormattingUnitNames",
		"CombatConfigFormattingSpellNames",
		"CombatConfigFormattingItemNames",
		"CombatConfigFormattingFullText",
		"CombatConfigSettingsShowQuickButton",
		"CombatConfigSettingsSolo",
		"CombatConfigSettingsParty",
		"CombatConfigSettingsRaid",
	}
	for i = 1, getn(cccheckbox) do
	local ccbtn = _G[cccheckbox[i]]
		T.SkinCheckBox(_G[cccheckbox[i]])
	end
	
	T.SkinNextPrevButton(ChatConfigMoveFilterUpButton,true)
	T.SkinNextPrevButton(ChatConfigMoveFilterDownButton,true)
	ChatConfigMoveFilterUpButton:ClearAllPoints()
	ChatConfigMoveFilterDownButton:ClearAllPoints()
	ChatConfigMoveFilterUpButton:SetPoint("TOPLEFT",ChatConfigCombatSettingsFilters,"BOTTOMLEFT",3,0)
	ChatConfigMoveFilterDownButton:SetPoint("LEFT",ChatConfigMoveFilterUpButton,24,0)
	
	T.SkinEditBox(CombatConfigSettingsNameEditBox)

	ChatConfigFrame:Size(680,596)
	ChatConfigFrameHeader:ClearAllPoints()
	ChatConfigFrameHeader:SetPoint("TOP", ChatConfigFrame, 0, -5)
	
	T.SkinScrollBar(ChannelRosterScrollFrameScrollBar)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)