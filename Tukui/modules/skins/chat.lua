local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	local frames = {
		"ChatConfigFrame",
		"ChatConfigCategoryFrame",
		"ChatConfigBackgroundFrame",
		"ChatConfigCombatSettingsFilters",
		"ChatConfigCombatSettingsFiltersScrollFrame",
		"CombatConfigColorsHighlighting",
		"CombatConfigColorsColorizeUnitName",
		"CombatConfigColorsColorizeSpellNames",
		"CombatConfigColorsColorizeDamageNumber",
		"CombatConfigColorsColorizeDamageSchool",
		"CombatConfigColorsColorizeEntireLine",
		"CombatConfigMessageSourcesDoneBy",
		"CombatConfigMessageSourcesDoneTo",
		"CombatConfigColorsUnitColors",
	}
	
	for i = 1, getn(frames) do
		local SkinFrames = _G[frames[i]]
		SkinFrames:StripTextures()
		SkinFrames:SetTemplate("Default")
	end
	
	ChatConfigChatSettingsClassColorLegend:StripTextures()
	ChatConfigChannelSettingsClassColorLegend:StripTextures()
	ChatConfigChatSettingsLeft:StripTextures()
	ChatConfigChannelSettingsLeft:StripTextures()
	ChatConfigOtherSettingsCombat:StripTextures()
	ChatConfigOtherSettingsPVP:StripTextures()
	ChatConfigOtherSettingsSystem:StripTextures()
	ChatConfigOtherSettingsCreature:StripTextures()
	
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
	
	ChatConfigCategoryFrameButton3:HookScript("OnClick", function()
		for i = 1,#ChatConfigChannelSettingsLeft.checkBoxTable do
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:SetHeight(ChatConfigOtherSettingsCombatCheckBox1:GetHeight())
			_G["ChatConfigChannelSettingsLeftCheckBox"..i.."Check"]:SkinCheckBox()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"]:SkinCheckBox()
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
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:SetHeight(ChatConfigOtherSettingsCombatCheckBox1:GetHeight())
			_G["ChatConfigChatSettingsLeftCheckBox"..i.."Check"]:SkinCheckBox()
			_G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"]:SkinCheckBox()
			_G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"]:SetHeight(ChatConfigChatSettingsLeftCheckBox1Check:GetHeight())
		end
	
		-- >> Other >> Combat
		for i = 1,#CHAT_CONFIG_OTHER_COMBAT do
			_G["ChatConfigOtherSettingsCombatCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsCombatCheckBox"..i.."Check"]:SkinCheckBox()
		end
			
		-- >> Other >> PvP
		for i = 1,#CHAT_CONFIG_OTHER_PVP do
			_G["ChatConfigOtherSettingsPVPCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsPVPCheckBox"..i.."Check"]:SkinCheckBox()
		end
	
		-- >> Other >> System
		for i = 1,#CHAT_CONFIG_OTHER_SYSTEM do
			_G["ChatConfigOtherSettingsSystemCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsSystemCheckBox"..i.."Check"]:SkinCheckBox()
		end
		
		for i = 1, #CHAT_CONFIG_CHANNEL_LIST do
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i.."Check"]:SkinCheckBox()
		end
	
		-- >> Other >> Creatures
		for i = 1,#CHAT_CONFIG_CHAT_CREATURE_LEFT do
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i.."Check"]:SkinCheckBox()
		end
	
		-- >> Sources >> DoneBy
		for i = 1,#COMBAT_CONFIG_MESSAGESOURCES_BY do
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i]:StripTextures()
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i.."Check"]:SkinCheckBox()
		end
	
		-- >> Sources >> DoneTo
		for i = 1,#COMBAT_CONFIG_MESSAGESOURCES_TO do
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i]:StripTextures()
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i.."Check"]:SkinCheckBox()
		end
	
		-- >> Combat >> Colors >> Unit Colors
		for i = 1,#COMBAT_CONFIG_UNIT_COLORS do
			_G["CombatConfigColorsUnitColorsSwatch"..i]:StripTextures()
		end
			
		-- >> Combat >> Messages Types
		for i=1,4 do
			for j=1,4 do
				if _G["CombatConfigMessageTypesLeftCheckBox"..i] and _G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j] then
					_G["CombatConfigMessageTypesLeftCheckBox"..i]:SkinCheckBox()
					_G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j]:SkinCheckBox()
				end
			end
			for j=1,10 do
				if _G["CombatConfigMessageTypesRightCheckBox"..i] and _G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j] then
					_G["CombatConfigMessageTypesRightCheckBox"..i]:SkinCheckBox()
					_G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j]:SkinCheckBox()
				end
			end
			_G["CombatConfigMessageTypesMiscCheckBox"..i]:SkinCheckBox()
		end
	end)
			
	-- >> Combat >> Tabs
	for i = 1,#COMBAT_CONFIG_TABS do
		local cctab = _G["CombatConfigTab"..i]
		if cctab then
			cctab:SkinTab()
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
			ccbtn:SkinButton()
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
		_G[cccheckbox[i]]:SkinCheckBox()
	end
	
	ChatConfigMoveFilterUpButton:SkinNextPrevButton(true)
	ChatConfigMoveFilterDownButton:SkinNextPrevButton(true)
	ChatConfigMoveFilterUpButton:ClearAllPoints()
	ChatConfigMoveFilterDownButton:ClearAllPoints()
	ChatConfigMoveFilterUpButton:SetPoint("TOPLEFT",ChatConfigCombatSettingsFilters,"BOTTOMLEFT",3,0)
	ChatConfigMoveFilterDownButton:SetPoint("LEFT",ChatConfigMoveFilterUpButton,24,0)
	
	CombatConfigSettingsNameEditBox:SkinEditBox()

	ChatConfigFrame:Size(680,596)
	ChatConfigFrameHeader:ClearAllPoints()
	ChatConfigFrameHeader:SetPoint("TOP", ChatConfigFrame, 0, -5)
	
	ChannelRosterScrollFrameScrollBar:SkinScrollBar()
	
	-- BNConversationInviteDialog
	BNConversationInviteDialog:StripTextures()
	BNConversationInviteDialog:SetTemplate()
	BNConversationInviteDialogInviteButton:SkinButton()
	BNConversationInviteDialogCancelButton:SkinButton()
	BNConversationInviteDialogList:StripTextures()
	BNConversationInviteDialogListScrollFrameScrollBar:SkinScrollBar()
	BNConversationInviteDialogInviteButton:SkinButton()
	hooksecurefunc("BNConversationInvite_Update", function()
		for i = 1, BN_CONVERSATION_INVITE_NUM_DISPLAYED do
			local b = _G["BNConversationInviteDialogListFriend"..i]
			local c = b.checkButton
			if c and not c.isSkinned then
				c:SkinCheckBox()
				c.isSkinned = true
			end
		end
	end)
	
	-- Channel Pullout
	ChannelPulloutBackground:Hide()
	ChannelPullout:SetTemplate()
	ChannelPulloutCloseButton:SkinCloseButton()
	ChannelPulloutTab:SkinTab()
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)