local T, C, L = select(2, ...):unpack()

local _G = _G
local format = format
local Noop = function() end
local Toast = BNToastFrame
local ToastCloseButton = BNToastFrameCloseButton
local TukuiChat = T["Chat"]
local UIFrameFadeRemoveFrame = UIFrameFadeRemoveFrame

-- Update editbox border color
function TukuiChat:UpdateEditBoxColor()
	local EditBox = ChatEdit_ChooseBoxForSend()	
	local ChatType = EditBox:GetAttribute("chatType")
	local Backdrop = EditBox.Backdrop
	
	if Backdrop then
		if (ChatType == "CHANNEL") then
			local ID = GetChannelName(EditBox:GetAttribute("channelTarget"))
			
			if (ID == 0) then
				Backdrop:SetAnimation("Gradient", "Border", 0, 0.5, unpack(C["General"].BorderColor))
			else
				Backdrop:SetAnimation("Gradient", "Border", 0, 0.5, ChatTypeInfo[ChatType..ID].r, ChatTypeInfo[ChatType..ID].g, ChatTypeInfo[ChatType..ID].b)
			end
		else
			Backdrop:SetAnimation("Gradient", "Border", 0, 0.5, ChatTypeInfo[ChatType].r, ChatTypeInfo[ChatType].g, ChatTypeInfo[ChatType].b)
		end
	end
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
	local CurrentFont, CurrentSize = self:GetFont()

	if (CurrentFont == Path) then
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
	
	-- Style the tab font
	TabText:SetFont(TabFont, TabFontSize, TabFontFlags)
	TabText.SetFont = Noop
	
	if C.Chat.Background then
		-- Tabs Alpha
		Tab:SetAlpha(1)
		Tab.SetAlpha = UIFrameFadeRemoveFrame
	end
	
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

	_G[format("ChatFrame%sButtonFrameUpButton", ID)]:Kill()
	_G[format("ChatFrame%sButtonFrameDownButton", ID)]:Kill()
	_G[format("ChatFrame%sButtonFrameBottomButton", ID)]:Kill()
	_G[format("ChatFrame%sButtonFrameMinimizeButton", ID)]:Kill()
	_G[format("ChatFrame%sButtonFrame", ID)]:Kill()

	_G[format("ChatFrame%sEditBoxFocusLeft", ID)]:Kill()
	_G[format("ChatFrame%sEditBoxFocusMid", ID)]:Kill()
	_G[format("ChatFrame%sEditBoxFocusRight", ID)]:Kill()

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
	ToastCloseButton:SkinCloseButton()
	Toast:ClearAllPoints()
	Toast:SetFrameStrata("Medium")
	Toast:SetFrameLevel(20)
	
	if C.Chat.Background then
		local Backdrop = T["Panels"].LeftChatBG
		
		Toast:Point("BOTTOMLEFT", Backdrop, "TOPLEFT", 0, 6)
	else
		Toast:Point("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 6)
	end
end

function TukuiChat:SetDefaultChatFramesPositions()
	if (not TukuiDataPerChar.Chat) then
		TukuiDataPerChar.Chat = {}
	end
	
	local Width = T["Panels"].DataTextLeft:GetWidth()

	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]
		local ID = Frame:GetID()
		
		-- Set font size and chat frame size
		Frame:Size(Width, 111)
		
		-- Set default chat frame position
		if (ID == 1) then
			Frame:ClearAllPoints()
			Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 47, 45)
		elseif (C.Chat.LootFrame and ID == 4) then
			if (not Frame.isDocked) then
				Frame:ClearAllPoints()
				Frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -47, 45)
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
		TukuiDataPerChar.Chat["Frame" .. i] = {Anchor1, Anchor2, X, Y, Width, 111}
	end
end

function TukuiChat:SaveChatFramePositionAndDimensions()
	local Anchor1, _, Anchor2, X, Y = self:GetPoint()
	local Width, Height = self:GetSize()
	local ID = self:GetID()
	
	if not (TukuiDataPerChar.Chat) then
		TukuiDataPerChar.Chat = {}
	end
	
	TukuiDataPerChar.Chat["Frame" .. ID] = {Anchor1, Anchor2, X, Y, Width, Height}
end

function TukuiChat:SetChatFramePosition()
	if (not TukuiDataPerChar.Chat) then
		return
	end
	
	local Frame = self
	
	if not Frame:IsMovable() then
		return
	end
	
	local ID = Frame:GetID()
	local Settings = TukuiDataPerChar.Chat["Frame" .. ID]

	if Settings then
		local Anchor1, Anchor2, X, Y, Width, Height = unpack(Settings)

		Frame:SetUserPlaced(true)
		Frame:ClearAllPoints()
		Frame:SetPoint(Anchor1, UIParent, Anchor2, X, Y)
		Frame:SetSize(Width, Height)
	end
	
	if (not C.Chat.LootFrame) then
		if (FCF_GetChatWindowInfo(ID) == LOOT) then
			FCF_Close(Frame)
		end
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

	if C.Chat.LootFrame then
		FCF_OpenNewWindow(LOOT)
		FCF_UnDockFrame(ChatFrame4)
		ChatFrame4:Show()
	end

	-- Set more chat groups
	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	ChatFrame_RemoveChannel(ChatFrame1, TRADE)
	ChatFrame_RemoveChannel(ChatFrame1, GENERAL)
	ChatFrame_RemoveChannel(ChatFrame1, L.ChatFrames.LocalDefense)
	ChatFrame_RemoveChannel(ChatFrame1, L.ChatFrames.GuildRecruitment)
	ChatFrame_RemoveChannel(ChatFrame1, L.ChatFrames.LookingForGroup)
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
	ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame1, "DND")
	ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
	
	-- Setup the spam chat frame
	ChatFrame_RemoveAllMessageGroups(ChatFrame3)
	ChatFrame_AddChannel(ChatFrame3, TRADE)
	ChatFrame_AddChannel(ChatFrame3, GENERAL)
	ChatFrame_AddChannel(ChatFrame3, L.ChatFrames.LocalDefense)
	ChatFrame_AddChannel(ChatFrame3, L.ChatFrames.GuildRecruitment)
	ChatFrame_AddChannel(ChatFrame3, L.ChatFrames.LookingForGroup)
	
	-- Setup the right chat
	if C.Chat.LootFrame then
		ChatFrame_RemoveAllMessageGroups(ChatFrame4)
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame4, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame4, "MONEY")
	end
	
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

function TukuiChat:Setup()
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]
		local Tab = _G["ChatFrame"..i.."Tab"]
		
		Tab.noMouseAlpha = 0
		Tab:SetAlpha(0)
		
		self:StyleFrame(Frame)
	end
	
	local CubeLeft = T["Panels"].CubeLeft
	
	-- Remember last channel
	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1
	
	if (not C.Chat.Background) then
		CubeLeft:SetScript("OnMouseDown", function(self, Button)
			if (Button == "LeftButton") then	
				ToggleFrame(ChatMenu)
			end
		end)
	end
	
	ChatConfigFrameDefaultButton:Kill()
	ChatFrameMenuButton:Kill()
	FriendsMicroButton:Kill()
end

function TukuiChat:AddHooks()
	hooksecurefunc("ChatEdit_UpdateHeader", TukuiChat.UpdateEditBoxColor)
	hooksecurefunc("FCF_OpenTemporaryWindow", TukuiChat.StyleTempFrame)
	hooksecurefunc("FCF_RestorePositionAndDimensions", TukuiChat.SetChatFramePosition)
	hooksecurefunc("FCF_SavePositionAndDimensions", TukuiChat.SaveChatFramePositionAndDimensions)
	
	if not C.Chat.Background then
		hooksecurefunc("FCFTab_UpdateAlpha", TukuiChat.NoMouseAlpha)
	end
end