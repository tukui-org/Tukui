local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	-- Others Blizzard frame we want to reskin
	local skins = {
		"StaticPopup1",
		"StaticPopup2",
		"StaticPopup3",
		"StaticPopup4",
		"GameMenuFrame",
		"InterfaceOptionsFrame",
		"VideoOptionsFrame",
		"AudioOptionsFrame",
		"LFDDungeonReadyStatus",
		"BNToastFrame",
		"TicketStatusFrameButton",
		"LFDSearchStatus",
		"AutoCompleteBox",
		"ConsolidatedBuffsTooltip",
		"ReadyCheckFrame",
		"StackSplitFrame",
		"CharacterFrame",
		"VoiceChatTalkers"
	}

	for i = 1, getn(skins) do
		if _G[skins[i]] then
			_G[skins[i]]:SetTemplate("Default")
			if _G[skins[i]] ~= _G["AutoCompleteBox"] then -- frame to blacklist from create shadow function
				_G[skins[i]]:CreateShadow("Default")
			end
		end
	end

	local StripAllTextures = {
		"VideoOptionsFrameCategoryFrame",
		"VideoOptionsFramePanelContainer",
		"AudioOptionsSoundPanelPlayback",
		"AudioOptionsSoundPanelHardware",
		"AudioOptionsSoundPanelVolume",
		"AudioOptionsVoicePanelTalking",
		"AudioOptionsVoicePanelBinding",
		"AudioOptionsVoicePanelListening",
		"InterfaceOptionsFrameCategories",
		"InterfaceOptionsFramePanelContainer",
		"InterfaceOptionsFrameTab1",
		"InterfaceOptionsFrameTab2",
		"InterfaceOptionsFrameAddOns",
	}
	
	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local ChatMenus = {
		"ChatMenu",
		"EmoteMenu",
		"LanguageMenu",
		"VoiceMacroMenu",		
	}
	--
	for i = 1, getn(ChatMenus) do
		if _G[ChatMenus[i]] == _G["ChatMenu"] then
			_G[ChatMenus[i]]:HookScript("OnShow", function(self) self:SetTemplate("Default", true) self:SetBackdropColor(unpack(C["media"].backdropcolor)) self:ClearAllPoints() self:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, T.Scale(30)) end)
		else
			_G[ChatMenus[i]]:HookScript("OnShow", function(self) self:SetTemplate("Default", true) self:SetBackdropColor(unpack(C["media"].backdropcolor)) end)
		end
	end

	--LFD Role Picker frame
	LFDRoleCheckPopup:StripTextures()
	LFDRoleCheckPopup:SetTemplate("Default")
	T.SkinButton(LFDRoleCheckPopupAcceptButton)
	T.SkinButton(LFDRoleCheckPopupDeclineButton)
	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonTank:GetChildren())
	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonDPS:GetChildren())
	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonHealer:GetChildren())
	LFDRoleCheckPopupRoleButtonTank:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonTank:GetChildren():GetFrameLevel() + 1)
	LFDRoleCheckPopupRoleButtonDPS:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonDPS:GetChildren():GetFrameLevel() + 1)
	LFDRoleCheckPopupRoleButtonHealer:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonHealer:GetChildren():GetFrameLevel() + 1)

	-- reskin popup buttons
	for i = 1, 4 do
		for j = 1, 3 do
			T.SkinButton(_G["StaticPopup"..i.."Button"..j])
			T.SkinEditBox(_G["StaticPopup"..i.."EditBox"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameGold"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameSilver"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameCopper"])
			_G["StaticPopup"..i.."EditBox"].backdrop:Point("TOPLEFT", -2, -4)
			_G["StaticPopup"..i.."EditBox"].backdrop:Point("BOTTOMRIGHT", 2, 4)
			_G["StaticPopup"..i.."ItemFrameNameFrame"]:Kill()
			_G["StaticPopup"..i.."ItemFrame"]:GetNormalTexture():Kill()
			_G["StaticPopup"..i.."ItemFrame"]:SetTemplate("Default")
			_G["StaticPopup"..i.."ItemFrame"]:StyleButton()
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:SetTexCoord(.08, .92, .08, .92)
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:ClearAllPoints()
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:Point("TOPLEFT", 2, -2)
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:Point("BOTTOMRIGHT", -2, 2)
		end
	end

	-- reskin all esc/menu buttons
	local BlizzardMenuButtons = {
		"Options", 
		"SoundOptions", 
		"UIOptions", 
		"Keybindings", 
		"Macros",
		"Ratings",
		"AddOns", 
		"Logout", 
		"Quit", 
		"Continue", 
		"MacOptions",
		"Help"
	}

	for i = 1, getn(BlizzardMenuButtons) do
		local ElvuiMenuButtons = _G["GameMenuButton"..BlizzardMenuButtons[i]]
		if ElvuiMenuButtons then
			T.SkinButton(ElvuiMenuButtons)
		end
	end

	if IsAddOnLoaded("OptionHouse") then
		T.SkinButton(GameMenuButtonOptionHouse)
	end

	-- hide header textures and move text/buttons.
	local BlizzardHeader = {
		"GameMenuFrame", 
		"InterfaceOptionsFrame", 
		"AudioOptionsFrame", 
		"VideoOptionsFrame",
	}

	for i = 1, getn(BlizzardHeader) do
		local title = _G[BlizzardHeader[i].."Header"]			
		if title then
			title:SetTexture("")
			title:ClearAllPoints()
			if title == _G["GameMenuFrameHeader"] then
				title:SetPoint("TOP", GameMenuFrame, 0, 7)
			else
				title:SetPoint("TOP", BlizzardHeader[i], 0, 0)
			end
		end
	end

	-- here we reskin all "normal" buttons
	local BlizzardButtons = {
		"VideoOptionsFrameOkay", 
		"VideoOptionsFrameCancel", 
		"VideoOptionsFrameDefaults", 
		"VideoOptionsFrameApply", 
		"AudioOptionsFrameOkay", 
		"AudioOptionsFrameCancel", 
		"AudioOptionsFrameDefaults", 
		"InterfaceOptionsFrameDefaults", 
		"InterfaceOptionsFrameOkay", 
		"InterfaceOptionsFrameCancel",
		"ReadyCheckFrameYesButton",
		"ReadyCheckFrameNoButton",
		"StackSplitOkayButton",
		"StackSplitCancelButton",
		"RolePollPopupAcceptButton",
		"InterfaceOptionsHelpPanelResetTutorials",
		"CompactUnitFrameProfilesGeneralOptionsFrameResetPositionButton",
	}

	for i = 1, getn(BlizzardButtons) do
		local Buttons = _G[BlizzardButtons[i]]
		if Buttons then
			T.SkinButton(Buttons)
		end
	end

	-- if a button position is not really where we want, we move it here
	_G["VideoOptionsFrameCancel"]:ClearAllPoints()
	_G["VideoOptionsFrameCancel"]:SetPoint("RIGHT",_G["VideoOptionsFrameApply"],"LEFT",-4,0)		 
	_G["VideoOptionsFrameOkay"]:ClearAllPoints()
	_G["VideoOptionsFrameOkay"]:SetPoint("RIGHT",_G["VideoOptionsFrameCancel"],"LEFT",-4,0)	
	_G["AudioOptionsFrameOkay"]:ClearAllPoints()
	_G["AudioOptionsFrameOkay"]:SetPoint("RIGHT",_G["AudioOptionsFrameCancel"],"LEFT",-4,0)
	_G["InterfaceOptionsFrameOkay"]:ClearAllPoints()
	_G["InterfaceOptionsFrameOkay"]:SetPoint("RIGHT",_G["InterfaceOptionsFrameCancel"],"LEFT", -4,0)
	_G["ReadyCheckFrameYesButton"]:SetParent(_G["ReadyCheckFrame"])
	_G["ReadyCheckFrameNoButton"]:SetParent(_G["ReadyCheckFrame"])
	_G["ReadyCheckFrameYesButton"]:ClearAllPoints()
	_G["ReadyCheckFrameNoButton"]:ClearAllPoints()
	_G["ReadyCheckFrameYesButton"]:SetPoint("RIGHT", _G["ReadyCheckFrame"], "CENTER", -2, -20)
	_G["ReadyCheckFrameNoButton"]:SetPoint("LEFT", _G["ReadyCheckFrameYesButton"], "RIGHT", 3, 0)
	_G["ReadyCheckFrameText"]:SetParent(_G["ReadyCheckFrame"])	
	_G["ReadyCheckFrameText"]:ClearAllPoints()
	_G["ReadyCheckFrameText"]:SetPoint("TOP", 0, -12)

	-- others
	_G["ReadyCheckListenerFrame"]:SetAlpha(0)
	_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end) -- bug fix, don't show it if initiator
	_G["StackSplitFrame"]:GetRegions():Hide()

	RolePollPopup:SetTemplate("Default")
	RolePollPopup:CreateShadow("Default")
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)