local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	GuildControlUI:StripTextures()
	GuildControlUIHbar:StripTextures()
	GuildControlUI:SetTemplate("Default")
	GuildControlUI:CreateShadow("Default")
	
	local function SkinGuildRanks()
		for i=1, GuildControlGetNumRanks() do
			local rankFrame = _G["GuildControlUIRankOrderFrameRank"..i]
			if rankFrame then
				rankFrame.downButton:SkinButton()
				rankFrame.upButton:SkinButton()
				rankFrame.deleteButton:SkinButton()
				
				if not rankFrame.nameBox.backdrop then
					rankFrame.nameBox:SkinEditBox()
				end
				
				rankFrame.nameBox.backdrop:Point("TOPLEFT", -2, -4)
				rankFrame.nameBox.backdrop:Point("BOTTOMRIGHT", -4, 4)
			end
		end				
	end
	hooksecurefunc("GuildControlUI_RankOrder_Update", SkinGuildRanks)

	GuildControlUIRankOrderFrameNewButton:HookScript("OnClick", function()
		T.Delay(1, SkinGuildRanks)
	end)
	
	GuildControlUINavigationDropDown:SkinDropDownBox()
	GuildControlUIRankSettingsFrameRankDropDown:SkinDropDownBox(180)
	GuildControlUINavigationDropDownButton:Width(20)
	GuildControlUIRankSettingsFrameRankDropDownButton:Width(20)
	
	for i=1, NUM_RANK_FLAGS do
		if _G["GuildControlUIRankSettingsFrameCheckbox"..i] then
			_G["GuildControlUIRankSettingsFrameCheckbox"..i]:SkinCheckBox()
		end
	end
	
	GuildControlUIRankOrderFrameNewButton:SkinButton()
	
	GuildControlUIRankSettingsFrameGoldBox:SkinEditBox()
	GuildControlUIRankSettingsFrameGoldBox.backdrop:Point("TOPLEFT", -2, -4)
	GuildControlUIRankSettingsFrameGoldBox.backdrop:Point("BOTTOMRIGHT", 2, 4)
	GuildControlUIRankSettingsFrameGoldBox:StripTextures()
	
	GuildControlUIRankBankFrame:StripTextures()
	
	local once = false
	hooksecurefunc("GuildControlUI_BankTabPermissions_Update", function()
		local numTabs = GetNumGuildBankTabs()
		if numTabs < MAX_BUY_GUILDBANK_TABS then
			numTabs = numTabs + 1
		end
		for i=1, numTabs do
			local tab = _G["GuildControlBankTab"..i.."Owned"]
			local icon = tab.tabIcon
			local editbox = tab.editBox
			
			icon:SetTexCoord(.08, .92, .08, .92)
			
			if once == false then
				_G["GuildControlBankTab"..i.."BuyPurchaseButton"]:SkinButton()
				_G["GuildControlBankTab"..i.."OwnedStackBox"]:StripTextures()
			end
		end
		once = true
	end)
	
	GuildControlUIRankBankFrameRankDropDown:SkinDropDownBox(180)
	GuildControlUIRankBankFrameRankDropDownButton:Width(20)
	GuildControlUICloseButton:SkinCloseButton()
	GuildControlUIRankBankFrameInset:StripTextures()
	GuildControlUIRankBankFrameInsetScrollFrame:StripTextures()
	GuildControlUIRankBankFrameInsetScrollFrameScrollBar:SkinScrollBar()
end

T.SkinFuncs["Blizzard_GuildControlUI"] = LoadSkin