local T, C, L = select(2, ...):unpack()

local Chat = T["Chat"]
local Toast = BNToastFrame
local Noop = function() end
local IsRightChatFound = false

-- Set name for right chat
Chat.RightChatName = OTHER

-- Chat default positions
Chat.Positions = {
	["Frame1"] = {
		["Anchor1"] = "BOTTOMLEFT",
		["Anchor2"] = "BOTTOMLEFT",
		["X"] = 34,
		["Y"] = 50,
		["Width"] = 370,
		["Height"] = 108,
		["IsUndocked"] = false,
	},
	["Frame4"] = {
		["Anchor1"] = "BOTTOMRIGHT",
		["Anchor2"] = "BOTTOMRIGHT",
		["X"] = -34,
		["Y"] = 50,
		["Width"] = 370,
		["Height"] = 108,
		["IsUndocked"] = true,
	},
}

-- Update editbox border color
function Chat:UpdateEditBoxColor()
	local EditBox = ChatEdit_ChooseBoxForSend()
	local ChatType = EditBox:GetAttribute("chatType")
	local Backdrop = EditBox.Backdrop

	if Backdrop then
		if (ChatType == "CHANNEL") then
			local ID = GetChannelName(EditBox:GetAttribute("channelTarget"))

			if (ID == 0) then
				local R, G, B = unpack(C["General"].BorderColor)

				Backdrop:SetBorderColor(R, G, B, 1)
			else
				local R, G, B = ChatTypeInfo[ChatType..ID].r, ChatTypeInfo[ChatType..ID].g, ChatTypeInfo[ChatType..ID].b

				Backdrop:SetBorderColor(R, G, B, 1)
			end
		else
			local R, G, B = ChatTypeInfo[ChatType].r, ChatTypeInfo[ChatType].g, ChatTypeInfo[ChatType].b

			Backdrop:SetBorderColor(R, G, B, 1)
		end
	end
end

function Chat:LockChat()
	T.Print(L.Others.ChatMove)
end

function Chat:MoveAudioButtons()
	ChatFrameChannelButton:Kill()
end

function Chat:NoMouseAlpha()
	local Frame = self:GetName()
	local Tab = _G[Frame .. "Tab"]

	if (Tab.noMouseAlpha == 0.4) or (Tab.noMouseAlpha == 0.2) then
		Tab:SetAlpha(0)
		Tab.noMouseAlpha = 0
	end
end

function Chat:SetChatFont()
	local Font = T.GetFont(C["Chat"].ChatFont)
	local Path, _, Flag = _G[Font]:GetFont()
	local CurrentFont, CurrentSize, CurrentFlag = self:GetFont()

	if (CurrentFont == Path and CurrentFlag == Flag) then
		return
	end

	self:SetFont(Path, CurrentSize, Flag)
end

function Chat:StyleFrame(frame)
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
	local DataTextLeft = T.DataTexts.Panels.Left

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
	Frame:SetFading(C.Chat.TextFading)
	Frame:SetTimeVisible(C.Chat.TextFadingTimer)

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

	_G[format("ChatFrame%sButtonFrameMinimizeButton", ID)]:Kill()
	_G[format("ChatFrame%sButtonFrame", ID)]:Kill()

	_G[format("ChatFrame%sEditBoxLeft", ID)]:Kill()
	_G[format("ChatFrame%sEditBoxMid", ID)]:Kill()
	_G[format("ChatFrame%sEditBoxRight", ID)]:Kill()
	
	if T.Retail then
		_G[format("ChatFrame%sEditBoxFocusLeft", ID)]:Kill()
		_G[format("ChatFrame%sEditBoxFocusMid", ID)]:Kill()
		_G[format("ChatFrame%sEditBoxFocusRight", ID)]:Kill()
	end

	-- Mouse Wheel
	Frame:SetScript("OnMouseWheel", Chat.OnMouseWheel)

	-- Temp Chats
	if (ID > 10) then
		self.SetChatFont(Frame)
	end

	-- Security for font, in case if revert back to WoW default we restore instantly the tukui font default.
	hooksecurefunc(Frame, "SetFont", Chat.SetChatFont)

	Frame.IsSkinned = true
end

function Chat:StyleTempFrame()
	local Frame = FCF_GetCurrentChatFrame()

	-- Make sure it's not skinned already
	if Frame.IsSkinned then
		return
	end

	-- Pass it on
	Chat:StyleFrame(Frame)
end

function Chat:SaveChatFramePositionAndDimensions()
	local Anchor1, Parent, Anchor2, X, Y = self:GetPoint()
	local Width, Height = self:GetSize()
	local ID = self:GetID()
	local IsUndocked
	
	if self.isDocked then
		IsUndocked = false
	else
		IsUndocked = true
	end
	
	TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat.Positions["Frame" .. ID] = {
		["Anchor1"] = Anchor1,
		["Anchor2"] = Anchor2,
		["X"] = X,
		["Y"] = Y,
		["Width"] = Width,
		["Height"] = Height,
		["IsUndocked"] = IsUndocked,
	}
end

function Chat:Dock(frame)
	FCF_DockFrame(frame, #FCFDock_GetChatFrames(GENERAL_CHAT_DOCK) + 1, true)
end

function Chat:Undock(frame)
	FCF_UnDockFrame(frame)
	FCF_SetTabPosition(frame, 0)
end

function Chat:SetChatFramePosition()
	local Frame = self
	local ID = Frame:GetID()
	local Tab = _G["ChatFrame"..ID.."Tab"]
	local IsMovable = Frame:IsMovable()
	local Settings = TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat.Positions["Frame" .. ID]
	
	if Tab:IsShown() then
		if IsRightChatFound and not Frame.isDocked then
			Chat:Dock(Frame)
		end

		if ID == 1 then
			Frame:SetParent(T.DataTexts.Panels.Left)
			Frame:SetUserPlaced(true)
			Frame:ClearAllPoints()
			Frame:SetSize(C.Chat.LeftWidth, C.Chat.LeftHeight - 62)
			Frame:SetPoint("BOTTOMLEFT", T.DataTexts.Panels.Left, "TOPLEFT", 0, 4)
		end

		if ID > 1 and Settings and Settings.IsUndocked and not IsRightChatFound then
			if Frame.isDocked then
				Chat:Undock(Frame)
			end

			Frame:SetParent(T.DataTexts.Panels.Right)
			Frame:SetUserPlaced(true)
			Frame:ClearAllPoints()
			Frame:SetSize(C.Chat.RightWidth, C.Chat.RightHeight - 62)
			Frame:SetPoint("BOTTOMLEFT", T.DataTexts.Panels.Right, "TOPLEFT", 0, 4)

			IsRightChatFound = true
		end

		if C.Chat.RightChatAlignRight and Settings and Settings.IsUndocked then
			Frame:SetJustifyH("RIGHT")
		end
		
		FCF_SavePositionAndDimensions(Frame)
	end
end

function Chat:Reset()
	local IsPublicChannelFound = EnumerateServerChannels()
	
	if not IsPublicChannelFound then
		-- Restart this function until we are able to query public channels
		C_Timer.After(1, Chat.Reset)
		
		return
	end
	
	-- Reset chat database
	TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat.Positions = Chat.Positions
	
	-- Reset right chat frame detection
	IsRightChatFound = false
	
	-- Create our custom chatframes
	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	
	if T.Classic then
		FCF_OpenNewWindow(COMMUNITIES_DEFAULT_CHANNEL_NAME)
	end
	
	FCF_SetLocked(ChatFrame3, 1)
	FCF_DockFrame(ChatFrame3)
	
	FCF_OpenNewWindow(Chat.RightChatName)
	FCF_UnDockFrame(ChatFrame4)
	FCF_OpenNewWindow(NPC_NAMES_DROPDOWN_ALL)
	FCF_SetLocked(ChatFrame5, 1)
	FCF_DockFrame(ChatFrame5)
	
	if T.Retail or T.WotLK then
		FCF_OpenNewWindow(COMMUNITIES_DEFAULT_CHANNEL_NAME)
		FCF_SetLocked(ChatFrame6, 1)
		FCF_DockFrame(ChatFrame6)
		FCF_SetChatWindowFontSize(nil, ChatFrame6, 12)
	end
	
	FCF_SetChatWindowFontSize(nil, ChatFrame1, 12)
	FCF_SetChatWindowFontSize(nil, ChatFrame2, 12)
	FCF_SetChatWindowFontSize(nil, ChatFrame3, 12)
	FCF_SetChatWindowFontSize(nil, ChatFrame4, 12)
	FCF_SetChatWindowFontSize(nil, ChatFrame5, 12)
	FCF_SetWindowName(ChatFrame1, "G, S & W")
	FCF_SetWindowName(ChatFrame2, "Log")

	DEFAULT_CHAT_FRAME:SetUserPlaced(true)

	local ChatGroup = {}
	local Channels = {}
	
	for i=1, select("#", EnumerateServerChannels()), 1 do
		Channels[i] = select(i, EnumerateServerChannels())
	end
	
	-- Remove everything in first 4 chat windows
	for i = 1, 6 do
		if (T.Retail and i ~= 2 and i ~= 3) or (T.BCC and i ~= 2 and i ~= 6) or (T.Classic and i ~= 2 and i ~= 6) or (T.WotLK and i ~= 2 and i ~= 3) then
			local ChatFrame = _G["ChatFrame"..i]

			ChatFrame_RemoveAllMessageGroups(ChatFrame)
			ChatFrame_RemoveAllChannels(ChatFrame)
		end
	end
	
	-- Join public channels
	for i = 1, #Channels do
		SlashCmdList["JOIN"](Channels[i])
	end
	
	-- Fix a editbox texture
	ChatEdit_ActivateChat(ChatFrame1EditBox)
	ChatEdit_DeactivateChat(ChatFrame1EditBox)

	-----------------------
	-- ChatFrame 1 Setup --
	-----------------------
	
	ChatGroup = {"SAY", "EMOTE", "YELL", "GUILD","OFFICER", "GUILD_ACHIEVEMENT", "WHISPER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING", "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER", "BG_HORDE", "BG_ALLIANCE", "BG_NEUTRAL", "AFK", "DND", "ACHIEVEMENT", "BN_WHISPER", "BN_CONVERSATION"}
	
	for _, v in ipairs(ChatGroup) do
		ChatFrame_AddMessageGroup(_G.ChatFrame1, v)
	end
	
	FCF_SelectDockFrame(ChatFrame1)
	
	-----------------------
	-- ChatFrame 3 Setup --
	-----------------------
	
	if T.Classic then
		for i = 1, #Channels do
			ChatFrame_RemoveChannel(ChatFrame1, Channels[i])
			ChatFrame_AddChannel(ChatFrame3, Channels[i])
		end

		-- Adjust Chat Colors
		ChangeChatColor("CHANNEL1", 195/255, 230/255, 232/255)
		ChangeChatColor("CHANNEL2", 232/255, 158/255, 121/255)
		ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255)
		ChangeChatColor("CHANNEL4", 232/255, 228/255, 121/255)
		ChangeChatColor("CHANNEL5", 0/255, 228/255, 121/255)
		ChangeChatColor("CHANNEL6", 0/255, 228/255, 0/255)
	end
	
	-----------------------
	-- ChatFrame 4 Setup --
	-----------------------
	
	local Tab4 = ChatFrame4Tab
	local Chat4 = ChatFrame4

	ChatGroup = {"COMBAT_XP_GAIN", "COMBAT_HONOR_GAIN", "COMBAT_FACTION_CHANGE", "LOOT","MONEY", "SYSTEM", "ERRORS", "IGNORED", "SKILL", "CURRENCY"}
	
	for _, v in ipairs(ChatGroup) do
		ChatFrame_AddMessageGroup(_G.ChatFrame4, v)
	end
	
	-- Set ChatFrame 4 to right
	Tab4:ClearAllPoints()
	
	FCF_RestorePositionAndDimensions(Chat4)
	FCF_SetTabPosition(Chat4, 0)
	
	-----------------------
	-- ChatFrame 5 Setup --
	-----------------------
	
	ChatGroup = {"MONSTER_SAY", "MONSTER_EMOTE", "MONSTER_YELL", "MONSTER_WHISPER", "MONSTER_BOSS_EMOTE", "MONSTER_BOSS_WHISPER"}
	
	for _, v in ipairs(ChatGroup) do
		ChatFrame_AddMessageGroup(_G.ChatFrame5, v)
	end
	
	-----------------------
	-- ChatFrame 6 Setup --
	-----------------------

	if T.Retail or T.WotLK then
		for i = 1, #Channels do
			ChatFrame_RemoveChannel(ChatFrame1, Channels[i])
			ChatFrame_AddChannel(ChatFrame6, Channels[i])
		end

		-- Adjust Chat Colors
		ChangeChatColor("CHANNEL1", 195/255, 230/255, 232/255)
		ChangeChatColor("CHANNEL2", 232/255, 158/255, 121/255)
		ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255)
		ChangeChatColor("CHANNEL4", 232/255, 228/255, 121/255)
		ChangeChatColor("CHANNEL5", 0/255, 228/255, 121/255)
		ChangeChatColor("CHANNEL6", 0/255, 228/255, 0/255)
	end
end

function Chat:OnMouseWheel(delta)
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

function Chat:PlayWhisperSound()
	PlaySoundFile(C.Medias.Whisper)
end

function Chat:SwitchSpokenDialect(button)
	if (IsAltKeyDown() and button == "LeftButton") then
		ToggleFrame(ChatMenu)
	end
end

function Chat:AddMessage(text, ...)
	text = text:gsub("|h%[(%d+)%. .-%]|h", "|h[%1]|h")

	return self.DefaultAddMessage(self, text, ...)
end

function Chat:HideChatFrame(button, id)
	local Background = id == 1 and T.Chat.Panels.LeftChat or T.Chat.Panels.RightChat
	local DataText = id == 1 and T.DataTexts.Panels.Left or T.DataTexts.Panels.Right
	local BG = T.DataTexts.BGFrame

	Background:Hide()

	if C.Misc.ExperienceEnable then
		local XP = T.Miscellaneous.Experience["XPBar"..id]

		if XP then
			XP:Hide()
		end
	end
	
	if BG then
		BG:SetParent(T.Hider)
	end

	DataText:Hide()

	for i = 1, 10 do
		local Chat =  _G["ChatFrame"..i]
		local Tab = _G["ChatFrame"..i.."Tab"]
		local Dock = GeneralDockManager

		if id == 1 and Chat.isDocked then
			Tab:SetParent(T.Hider)
			Dock:SetParent(T.Hider)
		elseif id == 2 and not Chat.isDocked then
			Tab:SetParent(T.Hider)
		end
	end

	button.state = "hidden"
	button.Texture:SetTexture(C.Medias.ArrowUp)

	local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]

	if id == 1 then
		Data.ChatLeftHidden = true
	elseif id == 2 then
		Data.ChatRightHidden = true
	end
end

function Chat:ShowChatFrame(button, id)
	local Background = id == 1 and T.Chat.Panels.LeftChat or T.Chat.Panels.RightChat
	local DataText = id == 1 and T.DataTexts.Panels.Left or T.DataTexts.Panels.Right
	local BG = T.DataTexts.BGFrame

	Background:Show()

	if C.Misc.ExperienceEnable then
		local XP = T.Miscellaneous.Experience["XPBar"..id]
		
		if XP then
			XP:Show()
		end
	end
	
	if BG then
		BG:SetParent(UIParent)
	end

	DataText:Show()

	for i = 1, 10 do
		local Chat =  _G["ChatFrame"..i]
		local Tab = _G["ChatFrame"..i.."Tab"]
		local Dock = GeneralDockManager

		if id == 1 and Chat.isDocked then
			Tab:SetParent(UIParent)
			Dock:SetParent(UIParent)
		elseif id == 2 and not Chat.isDocked then
			Tab:SetParent(UIParent)
		end
	end

	button.state = "show"
	button.Texture:SetTexture(C.Medias.ArrowDown)

	local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]

	if id == 1 then
		Data.ChatLeftHidden = false
	elseif id == 2 then
		Data.ChatRightHidden = false
	end
end

function Chat:ToggleChat()
	if self.state == "show" then
		Chat:HideChatFrame(self, self.id)
	else
		Chat:ShowChatFrame(self, self.id)
	end
end

function Chat:AddToggles()
	for i = 1, 2 do
		local Button = CreateFrame("Button", nil, UIParent)

		if i == 1 then
			Button:SetSize(19, T.Chat.Panels.LeftChat:GetHeight())
			Button:SetPoint("TOPRIGHT", T.Chat.Panels.LeftChat, "TOPLEFT", -6, 0)

			T.Chat.Panels.LeftChatToggle = Button
		else
			Button:SetSize(19, T.Chat.Panels.RightChat:GetHeight())
			Button:SetPoint("TOPLEFT", T.Chat.Panels.RightChat, "TOPRIGHT", 6, 0)

			T.Chat.Panels.RightChatToggle = Button
		end

		Button:CreateBackdrop()
		Button:CreateShadow()
		Button:SetAlpha(0)
		Button.Texture = Button:CreateTexture(nil, "OVERLAY", 8)
		Button.Texture:SetSize(14, 14)
		Button.Texture:SetPoint("CENTER")
		Button.Texture:SetTexture(C.Medias.ArrowDown)
		Button.id = i
		Button.state = "show"

		Button:SetScript("OnClick", self.ToggleChat)
		Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
		Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
	end
end

function Chat:Setup()
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]
		local Tab = _G["ChatFrame"..i.."Tab"]

		Tab.noMouseAlpha = 0
		Tab:SetAlpha(0)
		Tab:HookScript("OnClick", self.SwitchSpokenDialect)
		Tab:SetFrameLevel(6)

		self:StyleFrame(Frame)

		if i == 2 then
			CombatLogQuickButtonFrame_Custom:StripTextures()
		else
			if C.Chat.ShortChannelName then
				Frame.DefaultAddMessage = Frame.AddMessage
				Frame.AddMessage = Chat.AddMessage
			end
		end
	end

	local LeftBG = T.Chat.Panels.LeftChat
	local RightBG = T.Chat.Panels.RightChat
	local BGR, BGG, BGB = LeftBG.Backdrop:GetBackdropColor()

	LeftBG.Backdrop:SetBackdropColor(BGR, BGG, BGB, C.Chat.BackgroundAlpha / 100)
	RightBG.Backdrop:SetBackdropColor(BGR, BGG, BGB, C.Chat.BackgroundAlpha / 100)

	ChatConfigFrameDefaultButton:Kill()
	ChatFrameMenuButton:Kill()
	
	if T.Retail then
		QuickJoinToastButton:Kill()
	end

	ChatMenu:ClearAllPoints()
	ChatMenu:SetPoint("BOTTOMLEFT", LeftBG, "TOPLEFT", -1, 16)

	VoiceChatPromptActivateChannel:CreateBackdrop()
	VoiceChatPromptActivateChannel:CreateShadow()
	VoiceChatPromptActivateChannel.AcceptButton:SkinButton()
	VoiceChatPromptActivateChannel.CloseButton:SkinCloseButton()
	VoiceChatPromptActivateChannel:SetPoint(unpack(Chat.VoiceAlertPosition))
	VoiceChatPromptActivateChannel.ClearAllPoints = Noop
	VoiceChatPromptActivateChannel.SetPoint = Noop

	-- Remember last channel
	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1

	-- Enable nicknames classcolor
	SetCVar("chatClassColorOverride", 0)

	-- Short Channel Names
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
		
		--raids, bgs, dungeons
		CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|hR|h %s: ";
		CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|hRL|h %s: ";

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

	self:AddToggles()
	self:DisplayChat()
end

function Chat:DisplayChat()
	local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]

	if Data.ChatLeftHidden then
		-- Need to delay this one, because of docked tabs
		C_Timer.After(1, function() Chat.ToggleChat(T.Chat.Panels.LeftChatToggle) end)
	end

	if Data.ChatRightHidden then
		C_Timer.After(1, function() Chat.ToggleChat(T.Chat.Panels.RightChatToggle) end)
	end
end

function Chat:AddToast()
	-- TESTING CMD : /run BNToastFrame:AddToast(BN_TOAST_TYPE_ONLINE, 1)
	
	if not self.IsSkinned then
		local Glow = BNToastFrameGlowFrame
		
		self:CreateBackdrop()
		self:CreateShadow()
		self:ClearBackdrop()
		self.CloseButton:SkinCloseButton()
		
		Glow:SetParent(T.Hider)
		
		self.IsSkinned = true
	end

	self:ClearAllPoints()
	self:SetPoint("BOTTOMLEFT", T.Chat.Panels.LeftChat, "TOPLEFT", 0, 16)
end

function Chat:AddHooks()
	hooksecurefunc("ChatEdit_UpdateHeader", Chat.UpdateEditBoxColor)
	hooksecurefunc("FCF_OpenTemporaryWindow", Chat.StyleTempFrame)
	hooksecurefunc("FCF_RestorePositionAndDimensions", Chat.SetChatFramePosition)
	hooksecurefunc("FCF_SavePositionAndDimensions", Chat.SaveChatFramePositionAndDimensions)
	hooksecurefunc("FCFTab_UpdateAlpha", Chat.NoMouseAlpha)
	hooksecurefunc(BNToastFrame, "AddToast", Chat.AddToast)
end

function Chat:AddPanels()
	local LeftChatBG = CreateFrame("Frame", "TukuiChatLeftBackground", T.DataTexts.Panels.Left)
	LeftChatBG:SetSize(T.DataTexts.Panels.Left:GetWidth() + 12, C.Chat.LeftHeight)
	LeftChatBG:SetPoint("BOTTOM", T.DataTexts.Panels.Left, "BOTTOM", 0, -6)
	LeftChatBG:SetFrameLevel(1)
	LeftChatBG:SetFrameStrata("BACKGROUND")
	LeftChatBG:CreateBackdrop("Transparent")
	LeftChatBG.Backdrop:CreateShadow()

	local RightChatBG = CreateFrame("Frame", "TukuiChatRightBackground", T.DataTexts.Panels.Right)
	RightChatBG:SetSize(T.DataTexts.Panels.Right:GetWidth() + 12, C.Chat.RightHeight)
	RightChatBG:SetPoint("BOTTOM", T.DataTexts.Panels.Right, "BOTTOM", 0, -6)
	RightChatBG:SetFrameLevel(1)
	RightChatBG:SetFrameStrata("BACKGROUND")
	RightChatBG:CreateBackdrop("Transparent")
	RightChatBG.Backdrop:CreateShadow()

	local TabsBGLeft = CreateFrame("Frame", nil, LeftChatBG)
	TabsBGLeft:CreateBackdrop()
	TabsBGLeft:SetSize(T.DataTexts.Panels.Left:GetWidth(), 21)
	TabsBGLeft:SetPoint("TOP", LeftChatBG, "TOP", 0, -5)
	TabsBGLeft:SetFrameLevel(5)

	local TabsBGRight = CreateFrame("Frame", nil, RightChatBG)
	TabsBGRight:CreateBackdrop()
	TabsBGRight:SetSize(T.DataTexts.Panels.Right:GetWidth(), 21)
	TabsBGRight:SetPoint("TOP", RightChatBG, "TOP", 0, -5)
	TabsBGRight:SetFrameLevel(5)
	
	self.Panels = {}
	self.Panels.LeftChat = LeftChatBG
	self.Panels.RightChat = RightChatBG
	self.Panels.LeftChatTabs = TabsBGLeft
	self.Panels.RightChatTabs = TabsBGRight
end

function Chat:Enable()
	if (not C.Chat.Enable) then
		self:AddPanels()
		self:AddToggles()
		self:DisplayChat()
		
		return
	end
	
	-- Set default position for Voice Activation Alert
	self.VoiceAlertPosition = {"BOTTOMLEFT", T.DataTexts.Panels.Left, "TOPLEFT", 0, 12}

	self:AddPanels()
	self:Setup()
	self:MoveAudioButtons()
	self:AddHooks()
	
	self.Copy:Enable()
	self.Link:Enable()
	self.Bubbles:Enable()
	self.History:Enable()

	for i = 1, 10 do
		local ChatFrame = _G["ChatFrame"..i]

		self.SetChatFramePosition(ChatFrame)
		self.SetChatFont(ChatFrame)
	end

	FCF_UpdateButtonSide = function() end

	FCF_ToggleLock = self.LockChat
	FCF_ToggleLockOnDockedFrame = self.LockChat

	if (not C.Chat.WhisperSound) then
		return
	end

	local Whisper = CreateFrame("Frame")
	Whisper:RegisterEvent("CHAT_MSG_WHISPER")
	Whisper:RegisterEvent("CHAT_MSG_BN_WHISPER")
	Whisper:SetScript("OnEvent", function(self, event)
		Chat:PlayWhisperSound()
	end)
end