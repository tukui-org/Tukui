local T, C, L = select(2, ...):unpack()

local _G = _G
local format = format
local Noop = function() end
local Toast = BNToastFrame
local ToastCloseButton = BNToastFrameCloseButton
local TukuiChat = T["Chat"]
local UIFrameFadeRemoveFrame = UIFrameFadeRemoveFrame

-- Set default position for Voice Activation Alert
TukuiChat.VoiceAlertPosition = {"BOTTOMLEFT", T.Panels.LeftChatBG, "TOPLEFT", 0, 14}

-- Update editbox border color
function TukuiChat:UpdateEditBoxColor()
	local EditBox = ChatEdit_ChooseBoxForSend()
	local ChatType = EditBox:GetAttribute("chatType")
	local Backdrop = EditBox.Backdrop

	if Backdrop then
		if (ChatType == "CHANNEL") then
			local ID = GetChannelName(EditBox:GetAttribute("channelTarget"))

			if (ID == 0) then
				Backdrop.Anim:SetChange(unpack(C["General"].BorderColor))
			else
				Backdrop.Anim:SetChange(ChatTypeInfo[ChatType..ID].r, ChatTypeInfo[ChatType..ID].g, ChatTypeInfo[ChatType..ID].b)
			end
		else
			Backdrop.Anim:SetChange(ChatTypeInfo[ChatType].r, ChatTypeInfo[ChatType].g, ChatTypeInfo[ChatType].b)
		end

		Backdrop.Anim:Play()
	end
end

function TukuiChat:MoveAudioButtons()
	ChatFrameChannelButton:Kill()
	ChatFrameToggleVoiceDeafenButton:Kill()
	ChatFrameToggleVoiceMuteButton:Kill()
end

function TukuiChat:NoMouseAlpha()
	local Frame = self:GetName()
	local Tab = _G[Frame .. "Tab"]

	if (Tab.noMouseAlpha == 0.4) or (Tab.noMouseAlpha == 0.2) then
		Tab:SetAlpha(0)
		Tab.noMouseAlpha = 0
	end
end

function TukuiChat:SetChatFont()
	local Font = T.GetFont(C["Chat"].ChatFont)
	local Path, _, Flag  = _G[Font]:GetFont()
	local CurrentFont, CurrentSize, CurrentFlag = self:GetFont()

	if (CurrentFont == Path and CurrentFlag == Flag) then
		return
	end

	self:SetFont(Path, CurrentSize, Flag)
end

function TukuiChat:StyleFrame(frame)
	if frame.IsSkinned then
		return
	end

	local Frame = frame
	local ID = frame:GetID()
	local FrameName = frame:GetName()
	local Tab = _G[FrameName.."Tab"]
	local TabText = _G[FrameName.."TabText"]
	local Scroll = frame.ScrollBar
	local ScrollBottom = frame.ScrollToBottomButton
	local ScrollTex = _G[FrameName.."ThumbTexture"]
	local EditBox = _G[FrameName.."EditBox"]
	local GetTabFont = T.GetFont(C["Chat"].TabFont)
	local TabFont, TabFontSize, TabFontFlags = _G[GetTabFont]:GetFont()
	local DataTextLeft = T.Panels.DataTextLeft

	if Tab.conversationIcon then
		Tab.conversationIcon:Kill()
	end
	
	-- Hide editbox every time we click on a tab
	Tab:HookScript("OnClick", function()
		EditBox:Hide()
	end)
	
	-- Kill Scroll Bars
	if Scroll then
		Scroll:Kill()
		ScrollBottom:Kill()
		ScrollTex:Kill()
	end

	-- Style the tab font
	TabText:SetFont(TabFont, TabFontSize, TabFontFlags)
	TabText.SetFont = Noop

	Tab:SetAlpha(1)
	Tab.SetAlpha = UIFrameFadeRemoveFrame

	Frame:SetClampRectInsets(0, 0, 0, 0)
	Frame:SetClampedToScreen(false)
	Frame:SetFading(false)

	-- Move the edit box
	EditBox:ClearAllPoints()
	EditBox:SetInside(DataTextLeft)

	-- Disable alt key usage
	EditBox:SetAltArrowKeyMode(false)

	-- Hide editbox on login
	EditBox:Hide()

	-- Hide editbox instead of fading
	EditBox:HookScript("OnEditFocusLost", function(self)
		self:Hide()
	end)

	-- Create our own texture for edit box
	EditBox:CreateBackdrop()
	EditBox.Backdrop:ClearAllPoints()
	EditBox.Backdrop:SetAllPoints(DataTextLeft)
	EditBox.Backdrop:SetFrameStrata("LOW")
	EditBox.Backdrop:SetFrameLevel(1)
	EditBox.Backdrop:SetBackdropColor(unpack(C["General"].BackdropColor))

	EditBox.Backdrop.Anim = CreateAnimationGroup(EditBox.Backdrop):CreateAnimation("Color")
	EditBox.Backdrop.Anim:SetDuration(0.5)
	EditBox.Backdrop.Anim:SetSmoothing("InOut")
	EditBox.Backdrop.Anim:SetColorType("Border")

	-- Hide textures
	for i = 1, #CHAT_FRAME_TEXTURES do
		_G[FrameName..CHAT_FRAME_TEXTURES[i]]:SetTexture(nil)
	end

	-- Remove default chatframe tab textures
	_G[format("ChatFrame%sTabLeft", ID)]:Kill()
	_G[format("ChatFrame%sTabMiddle", ID)]:Kill()
	_G[format("ChatFrame%sTabRight", ID)]:Kill()

	_G[format("ChatFrame%sTabSelectedLeft", ID)]:Kill()
	_G[format("ChatFrame%sTabSelectedMiddle", ID)]:Kill()
	_G[format("ChatFrame%sTabSelectedRight", ID)]:Kill()

	_G[format("ChatFrame%sTabHighlightLeft", ID)]:Kill()
	_G[format("ChatFrame%sTabHighlightMiddle", ID)]:Kill()
	_G[format("ChatFrame%sTabHighlightRight", ID)]:Kill()

	_G[format("ChatFrame%sTabSelectedLeft", ID)]:Kill()
	_G[format("ChatFrame%sTabSelectedMiddle", ID)]:Kill()
	_G[format("ChatFrame%sTabSelectedRight", ID)]:Kill()

	--_G[format("ChatFrame%sButtonFrameUpButton", ID)]:Kill()
	--_G[format("ChatFrame%sButtonFrameDownButton", ID)]:Kill()
	--_G[format("ChatFrame%sButtonFrameBottomButton", ID)]:Kill()
	_G[format("ChatFrame%sButtonFrameMinimizeButton", ID)]:Kill()
	_G[format("ChatFrame%sButtonFrame", ID)]:Kill()

	_G[format("ChatFrame%sEditBoxFocusLeft", ID)]:Kill()
	_G[format("ChatFrame%sEditBoxFocusMid", ID)]:Kill()
	_G[format("ChatFrame%sEditBoxFocusRight", ID)]:Kill()

	_G[format("ChatFrame%sEditBoxLeft", ID)]:Kill()
	_G[format("ChatFrame%sEditBoxMid", ID)]:Kill()
	_G[format("ChatFrame%sEditBoxRight", ID)]:Kill()

	-- Kill off editbox artwork
	local A, B, C = select(6, EditBox:GetRegions())
	A:Kill()
	B:Kill()
	C:Kill()

	-- Justify loot frame text at the right
	if (not Frame.isDocked and ID == 4 and TabText:GetText() == LOOT) then
		Frame:SetJustifyH("RIGHT")
	end

	-- Mouse Wheel
	Frame:SetScript("OnMouseWheel", TukuiChat.OnMouseWheel)

	-- Temp Chats
	if (ID > 10) then
		self.SetChatFont(Frame)
	end

	-- Security for font, in case if revert back to WoW default we restore instantly the tukui font default.
	hooksecurefunc(Frame, "SetFont", TukuiChat.SetChatFont)

	Frame.IsSkinned = true
end

function TukuiChat:KillPetBattleCombatLog(Frame)
	if (_G[Frame:GetName().."Tab"]:GetText():match(PET_BATTLE_COMBAT_LOG)) then
		return FCF_Close(Frame)
	end
end

function TukuiChat:StyleTempFrame()
	local Frame = FCF_GetCurrentChatFrame()

	TukuiChat:KillPetBattleCombatLog(Frame)

	-- Make sure it's not skinned already
	if Frame.IsSkinned then
		return
	end

	-- Pass it on
	TukuiChat:StyleFrame(Frame)
end

function TukuiChat:SkinToastFrame()
	Toast:SetTemplate()
	Toast:CreateShadow()
	Toast.CloseButton:SkinCloseButton()
end

function TukuiChat:SetDefaultChatFramesPositions()
	if (not TukuiData[GetRealmName()][UnitName("Player")].Chat) then
		TukuiData[GetRealmName()][UnitName("Player")].Chat = {}
	end

	local Width = T["Panels"].DataTextLeft:GetWidth()

	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]
		local ID = Frame:GetID()

		-- Set font size and chat frame size
		Frame:Size(Width, 119)

		-- Set default chat frame position
		if (ID == 1) then
			Frame:ClearAllPoints()
			Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 34, 50)
		elseif (ID == 4) then
			if (not Frame.isDocked) then
				Frame:ClearAllPoints()
				Frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -34, 50)
			end
		end

		if (ID == 1) then
			FCF_SetWindowName(Frame, "G, S & W")
		end

		if (ID == 2) then
			FCF_SetWindowName(Frame, "Log")
		end

		if (not Frame.isLocked) then
			FCF_SetLocked(Frame, 1)
		end

		local Anchor1, Parent, Anchor2, X, Y = Frame:GetPoint()
		TukuiData[GetRealmName()][UnitName("Player")].Chat["Frame" .. i] = {Anchor1, Anchor2, X, Y, Width, 108}
	end
end

function TukuiChat:SaveChatFramePositionAndDimensions()
	local Anchor1, _, Anchor2, X, Y = self:GetPoint()
	local Width, Height = self:GetSize()
	local ID = self:GetID()

	if not (TukuiData[GetRealmName()][UnitName("Player")].Chat) then
		TukuiData[GetRealmName()][UnitName("Player")].Chat = {}
	end

	TukuiData[GetRealmName()][UnitName("Player")].Chat["Frame" .. ID] = {Anchor1, Anchor2, X, Y, Width, Height}
end

function TukuiChat:SetChatFramePosition()
	if (not TukuiData[GetRealmName()][UnitName("Player")].Chat) then
		return
	end

	local Frame = self

	if not Frame:IsMovable() then
		return
	end

	local ID = Frame:GetID()
	local Settings = TukuiData[GetRealmName()][UnitName("Player")].Chat["Frame" .. ID]

	if Settings then
		local Anchor1, Anchor2, X, Y, Width, Height = unpack(Settings)

		Frame:SetUserPlaced(true)
		Frame:ClearAllPoints()
		Frame:SetPoint(Anchor1, UIParent, Anchor2, X, Y)
		Frame:SetSize(Width, Height)
	end
end

function TukuiChat:Install()
	-- Create our custom chatframes
	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	FCF_OpenNewWindow(GENERAL)
	FCF_SetLocked(ChatFrame3, 1)
	FCF_DockFrame(ChatFrame3)
	FCF_OpenNewWindow(LOOT)
	FCF_UnDockFrame(ChatFrame4)
	--ChatFrame4:Show()

	-- Set more chat groups
	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	ChatFrame_RemoveChannel(ChatFrame1, TRADE)
	ChatFrame_RemoveChannel(ChatFrame1, GENERAL)
	ChatFrame_RemoveChannel(ChatFrame1, L.ChatFrames.LocalDefense)
	ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
	ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
	ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT")
	ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
	ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame1, "DND")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")

	-- Move ChatFrame1 Globals Channels to ChatFrame3
	ChatFrame_RemoveAllMessageGroups(ChatFrame3)

	-- ChatFrame 3
	ChatFrame_AddChannel(ChatFrame3, "General")
	ChatFrame_AddChannel(ChatFrame3, "Trade")
	ChatFrame_AddChannel(ChatFrame3, "LocalDefense")

	-- Setup the right chat
	ChatFrame_RemoveAllMessageGroups(ChatFrame4)
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_FACTION_CHANGE")
	ChatFrame_AddMessageGroup(ChatFrame4, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame4, "MONEY")
	ChatFrame_AddMessageGroup(ChatFrame4, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame4, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame4, "IGNORED")

	-- Enable Classcolor
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")

	DEFAULT_CHAT_FRAME:SetUserPlaced(true)

	self:SetDefaultChatFramesPositions()
end

function TukuiChat:OnMouseWheel(delta)
	if (delta < 0) then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		else
			for i = 1, (C.Chat.ScrollByX or 3) do
				self:ScrollDown()
			end
		end
	elseif (delta > 0) then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		else
			for i = 1, (C.Chat.ScrollByX or 3) do
				self:ScrollUp()
			end
		end
	end
end

function TukuiChat:PlayWhisperSound()
	PlaySoundFile(C.Medias.Whisper)
end

function TukuiChat:SwitchSpokenDialect(button)
	if (IsAltKeyDown() and button == "LeftButton") then
		ToggleFrame(ChatMenu)
	end
end

function TukuiChat:Setup()
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]
		local Tab = _G["ChatFrame"..i.."Tab"]

		Tab.noMouseAlpha = 0
		Tab:SetAlpha(0)
		Tab:HookScript("OnClick", self.SwitchSpokenDialect)

		self:StyleFrame(Frame)
		
		if i == 2 then
			CombatLogQuickButtonFrame_Custom:StripTextures()
		else
			if C.Chat.ShortChannelName then
				local am = Frame.AddMessage

				Frame.AddMessage = function(frame, text, ...)
					return am(frame, text:gsub('|h%[(%d+)%. .-%]|h', '|h%1|h'), ...)
				end
			end
		end
	end

	local CubeLeft = T["Panels"].CubeLeft

	-- Remember last channel
	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1

	ChatConfigFrameDefaultButton:Kill()
	ChatFrameMenuButton:Kill()
	
	QuickJoinToastButton:ClearAllPoints()
	QuickJoinToastButton:SetPoint("BOTTOMLEFT", T.Panels.LeftChatBG, "TOPLEFT", -1, -18)
	QuickJoinToastButton:EnableMouse(false)
	QuickJoinToastButton.ClearAllPoints = Noop
	QuickJoinToastButton.SetPoint = Noop
	QuickJoinToastButton:SetAlpha(0)
	
	ChatMenu:ClearAllPoints()
	ChatMenu:SetPoint("BOTTOMLEFT", T.Panels.LeftChatBG, "TOPLEFT", 0, 16)
	
	VoiceChatPromptActivateChannel:SetTemplate()
	VoiceChatPromptActivateChannel:CreateShadow()
	VoiceChatPromptActivateChannel.AcceptButton:SkinButton()
	VoiceChatPromptActivateChannel.CloseButton:SkinCloseButton()
	VoiceChatPromptActivateChannel:SetPoint(unpack(TukuiChat.VoiceAlertPosition))
	VoiceChatPromptActivateChannel.ClearAllPoints = Noop
	VoiceChatPromptActivateChannel.SetPoint = Noop
	
	if C.Chat.ShortChannelName then
		--guild
		CHAT_GUILD_GET = "|Hchannel:GUILD|hG|h %s "
		CHAT_OFFICER_GET = "|Hchannel:OFFICER|hO|h %s "

		--raid
		CHAT_RAID_GET = "|Hchannel:RAID|hR|h %s "
		CHAT_RAID_WARNING_GET = "RW %s "
		CHAT_RAID_LEADER_GET = "|Hchannel:RAID|hRL|h %s "

		--party
		CHAT_PARTY_GET = "|Hchannel:PARTY|hP|h %s "
		CHAT_PARTY_LEADER_GET ="|Hchannel:PARTY|hPL|h %s "
		CHAT_PARTY_GUIDE_GET ="|Hchannel:PARTY|hPG|h %s "

		--bg
		CHAT_BATTLEGROUND_GET = "|Hchannel:BATTLEGROUND|hB|h %s "
		CHAT_BATTLEGROUND_LEADER_GET = "|Hchannel:BATTLEGROUND|hBL|h %s "

		--whisper
		CHAT_WHISPER_INFORM_GET = "to %s "
		CHAT_WHISPER_GET = "from %s "
		CHAT_BN_WHISPER_INFORM_GET = "to %s "
		CHAT_BN_WHISPER_GET = "from %s "

		--say / yell
		CHAT_SAY_GET = "%s "
		CHAT_YELL_GET = "%s "

		--flags
		CHAT_FLAG_AFK = "[AFK] "
		CHAT_FLAG_DND = "[DND] "
		CHAT_FLAG_GM = "[GM] "
	end
end

function TukuiChat:AddHooks()
	hooksecurefunc("ChatEdit_UpdateHeader", TukuiChat.UpdateEditBoxColor)
	hooksecurefunc("FCF_OpenTemporaryWindow", TukuiChat.StyleTempFrame)
	hooksecurefunc("FCF_RestorePositionAndDimensions", TukuiChat.SetChatFramePosition)
	hooksecurefunc("FCF_SavePositionAndDimensions", TukuiChat.SaveChatFramePositionAndDimensions)
	hooksecurefunc("FCFTab_UpdateAlpha", TukuiChat.NoMouseAlpha)
end
