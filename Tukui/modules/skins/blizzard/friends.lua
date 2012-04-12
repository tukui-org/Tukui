local T, C, L = unpack(select(2, ...))

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
		T.SkinButton(_G[button])
	end
	--Reposition buttons
	WhoFrameWhoButton:Point("RIGHT", WhoFrameAddFriendButton, "LEFT", -2, 0)
	WhoFrameAddFriendButton:Point("RIGHT", WhoFrameGroupInviteButton, "LEFT", -2, 0)
	WhoFrameGroupInviteButton:Point("BOTTOMRIGHT", WhoFrame, "BOTTOMRIGHT", -44, 82)
	--Resize Buttons
	WhoFrameWhoButton:Size(WhoFrameWhoButton:GetWidth() - 4, WhoFrameWhoButton:GetHeight())
	WhoFrameAddFriendButton:Size(WhoFrameAddFriendButton:GetWidth() - 4, WhoFrameAddFriendButton:GetHeight())
	WhoFrameGroupInviteButton:Size(WhoFrameGroupInviteButton:GetWidth() - 4, WhoFrameGroupInviteButton:GetHeight())
	T.SkinEditBox(WhoFrameEditBox)
	WhoFrameEditBox:Height(WhoFrameEditBox:GetHeight() - 15)
	WhoFrameEditBox:Point("BOTTOM", WhoFrame, "BOTTOM", -10, 108)
	WhoFrameEditBox:Width(WhoFrameEditBox:GetWidth() + 17)
	T.SkinScrollBar(FriendsFrameFriendsScrollFrameScrollBar)
	T.SkinScrollBar(WhoListScrollFrameScrollBar)
	T.SkinScrollBar(FriendsFriendsScrollFrameScrollBar)

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
	FriendsFrame:StripTextures(true)

	T.SkinEditBox(AddFriendNameEditBox)
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
	
	T.SkinCloseButton(ChannelFrameDaughterFrameDetailCloseButton,ChannelFrameDaughterFrame)
	T.SkinCloseButton(FriendsFrameCloseButton,FriendsFrame.backdrop)
	if T.toc >= 40300 then
		FriendsFrameCloseButton:ClearAllPoints()
		FriendsFrameCloseButton:SetPoint("TOPRIGHT", 0, 0)	
	end
	T.SkinDropDownBox(WhoFrameDropDown,150)
	T.SkinDropDownBox(FriendsFrameStatusDropDown,70)
	if T.toc >= 40300 then
		T.SkinButton(FriendsTabHeaderSoRButton)
		FriendsTabHeaderSoRButton:StyleButton()
		FriendsTabHeaderSoRButton.icon:SetTexCoord(.08, .92, .08, .92)
		FriendsTabHeaderSoRButton.icon:ClearAllPoints()
		FriendsTabHeaderSoRButton.icon:Point("TOPLEFT", 2, -2)
		FriendsTabHeaderSoRButton.icon:Point("BOTTOMRIGHT", -2, 2)

		ScrollOfResurrectionFrame:StripTextures()
		ScrollOfResurrectionFrameNoteFrame:StripTextures()
		ScrollOfResurrectionFrame:SetTemplate("Transparent")
		ScrollOfResurrectionFrameNoteFrame:SetTemplate("Overlay")
		T.SkinButton(ScrollOfResurrectionFrameAcceptButton)
		T.SkinButton(ScrollOfResurrectionFrameCancelButton)
		T.SkinEditBox(ScrollOfResurrectionFrameTargetEditBox)
		ScrollOfResurrectionFrameTargetEditBox:Height(ScrollOfResurrectionFrameTargetEditBox:GetHeight() - 5)
	end

	--Bottom Tabs
	for i=1, 4 do
		T.SkinTab(_G["FriendsFrameTab"..i])
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
	
	--View Friends BN Frame
	FriendsFriendsFrame:CreateBackdrop("Default")

	T.SkinEditBox(FriendsFriendsList)
	T.SkinEditBox(FriendsFriendsNoteFrame)
	T.SkinDropDownBox(FriendsFriendsFrameDropDown,150)
	
	--Raid Browser Tab
	for i=1, 2 do
		local tab = _G["LFRParentFrameSideTab"..i]
		if tab then
			local icon = tab:GetNormalTexture():GetTexture()

			tab:StripTextures()
			tab:SetNormalTexture(icon)
			tab:GetNormalTexture():SetTexCoord(.08, .92, .08, .92)
			tab:GetNormalTexture():ClearAllPoints()

			tab:GetNormalTexture():Point("TOPLEFT", 2, -2)
			tab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
			
			tab:CreateBackdrop("Default")
			tab.backdrop:SetAllPoints()
			tab:StyleButton(true)			
			
			local point, relatedTo, point2, x, y = tab:GetPoint()
			tab:Point(point, relatedTo, point2, 1, y)
		end
	end
	
	-- 4.3+ only stuff
	if T.toc >= 40300 then
		-- bug on PTR with WhoFrame, fixing them
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
		FriendsFrame:SetTemplate("Default")
	else
		FriendsFrame:CreateBackdrop("Default")
		FriendsFrame.backdrop:Point( "TOPLEFT", FriendsFrame, "TOPLEFT", 11,-12)
		FriendsFrame.backdrop:Point( "BOTTOMRIGHT", FriendsFrame, "BOTTOMRIGHT", -35, 76)
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)