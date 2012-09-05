local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	local tabs = {
		"LeftDisabled",
		"MiddleDisabled",
		"RightDisabled",
		"Left",
		"Middle",
		"Right",
	}
	
	local function SkinSocialHeaderTab(tab)
		if not tab then return end
		for _, object in pairs(tabs) do
			local tex = _G[tab:GetName()..object]
			tex:SetTexture(nil)
		end
		tab:GetHighlightTexture():SetTexture(nil)
		tab.backdrop = CreateFrame("Frame", nil, tab)
		tab.backdrop:SetTemplate("Default")
		tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
		tab.backdrop:Point("TOPLEFT", 3, -8)
		tab.backdrop:Point("BOTTOMRIGHT", -6, 0)
	end
		
	local StripAllTextures = {
		"FriendsListFrame",
		"FriendsTabHeader",
		"FriendsFrameFriendsScrollFrame",
		"WhoFrameColumnHeader1",
		"WhoFrameColumnHeader2",
		"WhoFrameColumnHeader3",
		"WhoFrameColumnHeader4",
		"ChannelListScrollFrame",
		"ChannelRoster",
		"FriendsFramePendingButton1",
		"FriendsFramePendingButton2",
		"FriendsFramePendingButton3",
		"FriendsFramePendingButton4",
		"ChannelFrameDaughterFrame",
		"AddFriendFrame",
		"AddFriendNoteFrame",
		"FriendsFriendsFrame",
		"FriendsFriendsList",
		"FriendsFriendsNoteFrame",
		"ChannelFrameLeftInset",
		"ChannelFrameRightInset",
		"LFRQueueFrameRoleInset",
		"LFRQueueFrameListInset",
		"LFRQueueFrameCommentInset",
		"WhoFrameListInset",
		"WhoFrameEditBoxInset",
		"IgnoreListFrame",
		"PendingListFrame",
	}			

	local KillTextures = {
		"FriendsFrameInset",
		"FriendsFrameTopLeft",
		"FriendsFrameTopRight",
		"FriendsFrameBottomLeft",
		"FriendsFrameBottomRight",
		"ChannelFrameVerticalBar",
		"FriendsFrameBroadcastInputLeft",
		"FriendsFrameBroadcastInputRight",
		"FriendsFrameBroadcastInputMiddle",
		"ChannelFrameDaughterFrameChannelNameLeft",
		"ChannelFrameDaughterFrameChannelNameRight",
		"ChannelFrameDaughterFrameChannelNameMiddle",
		"ChannelFrameDaughterFrameChannelPasswordLeft",
		"ChannelFrameDaughterFrameChannelPasswordRight",				
		"ChannelFrameDaughterFrameChannelPasswordMiddle",			
	}

	local buttons = {
		"FriendsFrameAddFriendButton",
		"FriendsFrameSendMessageButton",
		"WhoFrameWhoButton",
		"WhoFrameAddFriendButton",
		"WhoFrameGroupInviteButton",
		"ChannelFrameNewButton",
		"FriendsFrameIgnorePlayerButton",
		"FriendsFrameUnsquelchButton",
		"FriendsFramePendingButton1AcceptButton",
		"FriendsFramePendingButton1DeclineButton",
		"FriendsFramePendingButton2AcceptButton",
		"FriendsFramePendingButton2DeclineButton",
		"FriendsFramePendingButton3AcceptButton",
		"FriendsFramePendingButton3DeclineButton",
		"FriendsFramePendingButton4AcceptButton",
		"FriendsFramePendingButton4DeclineButton",
		"ChannelFrameDaughterFrameOkayButton",
		"ChannelFrameDaughterFrameCancelButton",
		"AddFriendEntryFrameAcceptButton",
		"AddFriendEntryFrameCancelButton",
		"AddFriendInfoFrameContinueButton",
		"FriendsFriendsSendRequestButton",
		"FriendsFriendsCloseButton",
	}			

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end
	--Reposition buttons
	WhoFrameWhoButton:Point("RIGHT", WhoFrameAddFriendButton, "LEFT", -2, 0)
	WhoFrameAddFriendButton:Point("RIGHT", WhoFrameGroupInviteButton, "LEFT", -2, 0)
	WhoFrameGroupInviteButton:Point("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -44, 82)
	--Resize Buttons
	WhoFrameWhoButton:Size(WhoFrameWhoButton:GetWidth() - 4, WhoFrameWhoButton:GetHeight())
	WhoFrameAddFriendButton:Size(WhoFrameAddFriendButton:GetWidth() - 4, WhoFrameAddFriendButton:GetHeight())
	WhoFrameGroupInviteButton:Size(WhoFrameGroupInviteButton:GetWidth() - 4, WhoFrameGroupInviteButton:GetHeight())
	WhoFrameEditBox:SkinEditBox()
	WhoFrameEditBox:Height(WhoFrameEditBox:GetHeight() - 15)
	WhoFrameEditBox:Point("BOTTOM", WhoFrame, "BOTTOM", -10, 108)
	WhoFrameEditBox:Width(WhoFrameEditBox:GetWidth() + 17)
	FriendsFrameFriendsScrollFrameScrollBar:SkinScrollBar()
	WhoListScrollFrameScrollBar:SkinScrollBar()
	FriendsFriendsScrollFrameScrollBar:SkinScrollBar()

	for _, texture in pairs(KillTextures) do
		if _G[texture] then
			_G[texture]:Kill()
		end
	end

	for _, object in pairs(StripAllTextures) do
		if _G[object] then
			_G[object]:StripTextures()
		end
	end
	FriendsFrame:StripTextures()
	FriendsFrameIcon:SetAlpha(0)

	AddFriendNameEditBox:SkinEditBox()
	AddFriendFrame:SetTemplate("Default")			

	--Who Frame
	local function UpdateWhoSkins()
		WhoListScrollFrame:StripTextures()
	end
	--Channel Frame
	local function UpdateChannel()
		ChannelRosterScrollFrame:StripTextures()
	end
	--BNet Frame
	FriendsFrameBroadcastInput:CreateBackdrop("Default")
	ChannelFrameDaughterFrameChannelName:CreateBackdrop("Default")
	ChannelFrameDaughterFrameChannelPassword:CreateBackdrop("Default")			

	ChannelFrame:HookScript("OnShow", UpdateChannel)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateChannel)

	WhoFrame:HookScript("OnShow", UpdateWhoSkins)
	hooksecurefunc("FriendsFrame_OnEvent", UpdateWhoSkins)

	ChannelFrameDaughterFrame:CreateBackdrop("Default")
	
	ChannelFrameDaughterFrameDetailCloseButton:SkinCloseButton(ChannelFrameDaughterFrame)
	FriendsFrameCloseButton:SkinCloseButton(FriendsFrame.backdrop)
	FriendsFrameCloseButton:ClearAllPoints()
	FriendsFrameCloseButton:SetPoint("TOPRIGHT", 0, 0)	
	WhoFrameDropDown:SkinDropDownBox(150)
	FriendsFrameStatusDropDown:SkinDropDownBox(70)
	FriendsTabHeaderSoRButton:SkinButton()
	FriendsTabHeaderSoRButton:StyleButton()
	FriendsTabHeaderSoRButton.icon:SetTexCoord(.08, .92, .08, .92)
	FriendsTabHeaderSoRButton.icon:ClearAllPoints()
	FriendsTabHeaderSoRButton.icon:Point("TOPLEFT", 2, -2)
	FriendsTabHeaderSoRButton.icon:Point("BOTTOMRIGHT", -2, 2)
	FriendsTabHeaderSoRButton.icon:SetDrawLayer('ARTWORK')

	ScrollOfResurrectionSelectionFrame:StripTextures()
	ScrollOfResurrectionSelectionFrameList:StripTextures()
	ScrollOfResurrectionSelectionFrame:SetTemplate()
	ScrollOfResurrectionSelectionFrameList:SetTemplate()
	ScrollOfResurrectionSelectionFrameAcceptButton:SkinButton()
	ScrollOfResurrectionSelectionFrameCancelButton:SkinButton()
	ScrollOfResurrectionSelectionFrameListScrollFrameScrollBar:SkinScrollBar()
	ScrollOfResurrectionSelectionFrameTargetEditBox:SkinEditBox()
	ScrollOfResurrectionFrameTargetEditBox:Height(ScrollOfResurrectionFrameTargetEditBox:GetHeight() - 5)
	ScrollOfResurrectionFrame:SetTemplate()
	ScrollOfResurrectionFrameNoteFrame:StripTextures()
	ScrollOfResurrectionFrameNoteFrame:SetTemplate()
	ScrollOfResurrectionFrameAcceptButton:SkinButton()
	ScrollOfResurrectionFrameCancelButton:SkinButton()

	--Bottom Tabs
	for i=1, 4 do
		_G["FriendsFrameTab"..i]:SkinTab()
	end

	for i=1, 3 do
		SkinSocialHeaderTab(_G["FriendsTabHeaderTab"..i])
	end

	local function Channel()
		for i=1, MAX_DISPLAY_CHANNEL_BUTTONS do
			local button = _G["ChannelButton"..i]
			if button then
				button:StripTextures()
				button:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
				
				_G["ChannelButton"..i.."Text"]:SetFont(C.media.font, 12)
			end
		end
	end
	hooksecurefunc("ChannelList_Update", Channel)

	FriendsFriendsFrame:CreateBackdrop("Default")
	FriendsFriendsList:SkinEditBox()
	FriendsFriendsNoteFrame:SkinEditBox()
	FriendsFriendsFrameDropDown:SkinDropDownBox(150)
	WhoFrameEditBox:ClearAllPoints()
	WhoFrameWhoButton:ClearAllPoints()
	WhoFrameAddFriendButton:ClearAllPoints()
	WhoFrameGroupInviteButton:ClearAllPoints()
	WhoFrameWhoButton:Point("BOTTOMLEFT", 4, 4)
	WhoFrameGroupInviteButton:Point("BOTTOMRIGHT", -4, 4)
	WhoFrameAddFriendButton:Point("LEFT", WhoFrameWhoButton, "RIGHT", 4, 0)
	WhoFrameAddFriendButton:Width(125)
	WhoListScrollFrame:ClearAllPoints()
	WhoListScrollFrame:SetPoint("TOPRIGHT", WhoFrameListInset, -25, 0)
	WhoFrameEditBox:Point("BOTTOM", 0, 32)
	WhoFrameEditBox:Point("LEFT", 6, 0)
	WhoFrameEditBox:Point("RIGHT", -6, 0)
	RaidFrameConvertToRaidButton:SkinButton()
	RaidFrameRaidInfoButton:SkinButton()
	RaidFrameRaidBrowserButton:SkinButton()
	FriendsFrameMutePlayerButton:SkinButton()
	FriendsFrameMutePlayerButton:Width(107)
	FriendsFrameBattlenetFrame:StripTextures()
	FriendsFrameBattlenetFrame.BroadcastButton:SetAlpha(0)
	FriendsFrameBattlenetFrame.BroadcastButton:ClearAllPoints()
	FriendsFrameBattlenetFrame.BroadcastButton:SetAllPoints(FriendsFrameBattlenetFrame)
	FriendsFrameBattlenetFrame.BroadcastFrame:StripTextures()
	FriendsFrameBattlenetFrame.BroadcastFrame:SetTemplate()
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame:StripTextures()
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame:SetTemplate()
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame.CancelButton:SkinButton()
	FriendsFrameBattlenetFrame.BroadcastFrame.ScrollFrame.UpdateButton:SkinButton()
	BattleTagInviteFrame:StripTextures()
	BattleTagInviteFrame:SetTemplate()
	BattleTagInviteFrameScrollFrame:StripTextures()
	BattleTagInviteFrameScrollFrame:SetTemplate()
	for i=1, BattleTagInviteFrame:GetNumChildren() do
		local child = select(i, BattleTagInviteFrame:GetChildren())
		if child:GetObjectType() == "Button" then
			child:SkinButton()
		end
	end
	
	FriendsFrameIgnoreScrollFrameScrollBar:SkinScrollBar()
	FriendsFrameIgnoreScrollFrame:SetHeight(294)
	FriendsFrameIgnoreScrollFrameScrollBar:SetPoint("TOPLEFT", FriendsFrameIgnoreScrollFrame, "TOPRIGHT", 42, -10)
	
	-- bn report
	BNetReportFrame:StripTextures()
	BNetReportFrame:SetTemplate()
	BNetReportFrameCommentScrollFrameScrollBar:SkinScrollBar()
	BNetReportFrameComment:StripTextures()
	BNetReportFrameComment:SetTemplate()
	BNetReportFrameReportButton:SkinButton()
	BNetReportFrameCancelButton:SkinButton()
	
	FriendsFrame:SetTemplate("Default")
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)