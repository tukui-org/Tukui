local T, C, L, G = unpack(select(2, ...)) 
if C["chat"].enable ~= true then return end

-----------------------------------------------------------------------
-- SETUP TUKUI CHATS
-----------------------------------------------------------------------

local TukuiChat = CreateFrame("Frame", "TukuiChat")
G.Chat.Chat = TukuiChat
for i = 1, NUM_CHAT_WINDOWS do
	G.Chat["ChatFrame"..i] = _G["ChatFrame"..i]
end

local tabalpha = 1
local tabnoalpha = 0
local _G = _G
local origs = {}
local type = type
local strings = {
	INSTANCE_CHAT = L.chat_INSTANCE_CHAT,
	GUILD = L.chat_GUILD_GET,
	PARTY = L.chat_PARTY_GET,
	RAID = L.chat_RAID_GET,
	OFFICER = L.chat_OFFICER_GET,
	INSTANCE_CHAT_LEADER = L.chat_INSTANCE_CHAT_LEADER,
	PARTY_LEADER = L.chat_PARTY_LEADER_GET,
	RAID_LEADER = L.chat_RAID_LEADER_GET,
	
	-- zhCN
	Battleground = L.chat_BATTLEGROUND_GET,
	Guild = L.chat_GUILD_GET,
	raid = L.chat_RAID_GET,
	Party = L.chat_PARTY_GET,
}

-- function to rename channel and other stuff
local function ShortChannel(channel)
	return string.format("|Hchannel:%s|h[%s]|h", channel, strings[channel] or channel:gsub("channel:", ""))
end

local function AddMessage(frame, str, ...)
	str = str:gsub("|Hplayer:(.-)|h%[(.-)%]|h", "|Hplayer:%1|h%2|h")
	str = str:gsub("|HBNplayer:(.-)|h%[(.-)%]|h", "|HBNplayer:%1|h%2|h")
	str = str:gsub("|Hchannel:(.-)|h%[(.-)%]|h", ShortChannel)

	str = str:gsub("^To (.-|h)", "|cffad2424@|r%1")
	str = str:gsub("^(.-|h) whispers", "%1")
	str = str:gsub("^(.-|h) says", "%1")
	str = str:gsub("^(.-|h) yells", "%1")
	str = str:gsub("<"..AFK..">", "|cffFF0000"..L.chat_FLAG_AFK.."|r ")
	str = str:gsub("<"..DND..">", "|cffE7E716"..L.chat_FLAG_DND.."|r ")
	str = str:gsub("^%["..RAID_WARNING.."%]", L.chat_RAID_WARNING_GET)

	return origs[frame](frame, str, ...)
end

-- Hide friends micro button (added in 3.3.5)
FriendsMicroButton:Kill()

-- hide chat bubble menu button
ChatFrameMenuButton:Kill()

local function UpdateEditBoxColor(self)
	local type = self:GetAttribute("chatType")
	local bd = self.backdrop
	
	if bd then
		if ( type == "CHANNEL" ) then
			local id = GetChannelName(self:GetAttribute("channelTarget"))
			if id == 0 then
				bd:SetBackdropBorderColor(unpack(C.media.bordercolor))
			else
				bd:SetBackdropBorderColor(ChatTypeInfo[type..id].r,ChatTypeInfo[type..id].g,ChatTypeInfo[type..id].b)
			end
		else
			bd:SetBackdropBorderColor(ChatTypeInfo[type].r,ChatTypeInfo[type].g,ChatTypeInfo[type].b)
		end	
	end
end

-- update border color according where we talk
hooksecurefunc("ChatEdit_UpdateHeader", function()
	local EditBox = ChatEdit_ChooseBoxForSend()	
	UpdateEditBoxColor(EditBox)
end)
	
-- set the chat style
local function SetChatStyle(frame)
	local id = frame:GetID()
	local chat = frame:GetName()
	local tab = _G[chat.."Tab"]
	G.Chat[chat] = _G[chat]
	G.Chat[tab] = tab
	
	-- always set alpha to 1, don"t fade it anymore
	tab:SetAlpha(1)
	tab.SetAlpha = UIFrameFadeRemoveFrame

	if not C.chat.background then
		-- hide text when setting chat
		_G[chat.."TabText"]:Hide()
		
		-- now show text if mouse is found over tab.
		tab:HookScript("OnEnter", function() _G[chat.."TabText"]:Show() end)
		tab:HookScript("OnLeave", function() _G[chat.."TabText"]:Hide() end)
	end
	
	-- change tab font
	_G[chat.."TabText"]:SetFont(C.media.font, 11)
	
	-- yeah baby
	_G[chat]:SetClampRectInsets(0,0,0,0)
	
	-- Removes crap from the bottom of the chatbox so it can go to the bottom of the screen.
	_G[chat]:SetClampedToScreen(false)
			
	-- Stop the chat chat from fading out
	_G[chat]:SetFading(false)
	
	-- set min height/width to original tukui size
	_G[chat]:SetMinResize(371,111)
	_G[chat]:SetMinResize(T.InfoLeftRightWidth + 1,111)
	
	-- move the chat edit box
	G.Chat.EditBox = _G[chat.."EditBox"]
	_G[chat.."EditBox"]:ClearAllPoints()
	_G[chat.."EditBox"]:Point("TOPLEFT", TukuiTabsLeftBackground or TukuiInfoLeft, 2, -2)
	_G[chat.."EditBox"]:Point("BOTTOMRIGHT", TukuiTabsLeftBackground or TukuiInfoLeft, -2, 2)	
	
	-- Hide textures
	for j = 1, #CHAT_FRAME_TEXTURES do
		_G[chat..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
	end

	-- Removes Default ChatFrame Tabs texture				
	_G[format("ChatFrame%sTabLeft", id)]:Kill()
	_G[format("ChatFrame%sTabMiddle", id)]:Kill()
	_G[format("ChatFrame%sTabRight", id)]:Kill()

	_G[format("ChatFrame%sTabSelectedLeft", id)]:Kill()
	_G[format("ChatFrame%sTabSelectedMiddle", id)]:Kill()
	_G[format("ChatFrame%sTabSelectedRight", id)]:Kill()
	
	_G[format("ChatFrame%sTabHighlightLeft", id)]:Kill()
	_G[format("ChatFrame%sTabHighlightMiddle", id)]:Kill()
	_G[format("ChatFrame%sTabHighlightRight", id)]:Kill()

	-- Killing off the new chat tab selected feature
	_G[format("ChatFrame%sTabSelectedLeft", id)]:Kill()
	_G[format("ChatFrame%sTabSelectedMiddle", id)]:Kill()
	_G[format("ChatFrame%sTabSelectedRight", id)]:Kill()

	-- Kills off the new method of handling the Chat Frame scroll buttons as well as the resize button
	-- Note: This also needs to include the actual frame textures for the ButtonFrame onHover
	_G[format("ChatFrame%sButtonFrameUpButton", id)]:Kill()
	_G[format("ChatFrame%sButtonFrameDownButton", id)]:Kill()
	_G[format("ChatFrame%sButtonFrameBottomButton", id)]:Kill()
	_G[format("ChatFrame%sButtonFrameMinimizeButton", id)]:Kill()
	_G[format("ChatFrame%sButtonFrame", id)]:Kill()

	-- Kills off the retarded new circle around the editbox
	_G[format("ChatFrame%sEditBoxFocusLeft", id)]:Kill()
	_G[format("ChatFrame%sEditBoxFocusMid", id)]:Kill()
	_G[format("ChatFrame%sEditBoxFocusRight", id)]:Kill()

	-- Kill off editbox artwork
	local a, b, c = select(6, _G[chat.."EditBox"]:GetRegions()) a:Kill() b:Kill() c:Kill()
	
	-- bubble tex & glow killing from privates
	if tab.conversationIcon then tab.conversationIcon:Kill() end
				
	-- Disable alt key usage
	_G[chat.."EditBox"]:SetAltArrowKeyMode(false)
	
	-- hide editbox on login
	_G[chat.."EditBox"]:Hide()

	-- script to hide editbox instead of fading editbox to 0.35 alpha via IM Style
	_G[chat.."EditBox"]:HookScript("OnEditFocusLost", function(self) self:Hide() end)
	
	-- hide edit box every time we click on a tab
	_G[chat.."Tab"]:HookScript("OnClick", function() _G[chat.."EditBox"]:Hide() end)
			
	-- create our own texture for edit box
	_G[chat.."EditBox"]:CreateBackdrop()
	_G[chat.."EditBox"].backdrop:ClearAllPoints()
	_G[chat.."EditBox"].backdrop:SetAllPoints(TukuiTabsLeftBackground or TukuiInfoLeft)
	_G[chat.."EditBox"].backdrop:SetFrameStrata("LOW")
	_G[chat.."EditBox"].backdrop:SetFrameLevel(1)
	
	if _G[chat] ~= _G["ChatFrame2"] then	
		origs[_G[chat]] = _G[chat].AddMessage
		_G[chat].AddMessage = AddMessage
	else
		CombatLogQuickButtonFrame_Custom:StripTextures()
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton:SkinCloseButton()
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton.t:SetText("V")
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton.t:ClearAllPoints()
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton.t:Point("RIGHT", -8, 4)
		CombatLogQuickButtonFrame_CustomProgressBar:ClearAllPoints()
		CombatLogQuickButtonFrame_CustomProgressBar:SetPoint("TOPLEFT", CombatLogQuickButtonFrame_Custom, 2, -2)
		CombatLogQuickButtonFrame_CustomProgressBar:SetPoint("BOTTOMRIGHT", CombatLogQuickButtonFrame_Custom, -2, 2)
		CombatLogQuickButtonFrame_CustomProgressBar:SetStatusBarTexture(C.media.normTex)
	end

	frame.isSkinned = true
end

-- Setup chatframes 1 to 10 on login.
local function SetupChat(self)	
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		SetChatStyle(frame)
		FCFTab_UpdateAlpha(frame)
	end
				
	-- Remember last channel
	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1
end

TukuiChat:RegisterEvent("ADDON_LOADED")
TukuiChat:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_CombatLog" then
		self:UnregisterEvent("ADDON_LOADED")
		SetupChat(self)
	end
end)

-- Setup temp chat (BN, WHISPER) when needed.
local function SetupTempChat()
	local frame = FCF_GetCurrentChatFrame()
		
	-- fuck this pet battle window, really... do people really need this shit?
	if _G[frame:GetName().."Tab"]:GetText():match(PET_BATTLE_COMBAT_LOG) then
		FCF_Close(frame)
		return
	end

	-- do a check if we already did a skinning earlier for this temp chat frame
	if frame.isSkinned then return end
	
	-- style it
	frame.temp = true
	SetChatStyle(frame)
end
hooksecurefunc("FCF_OpenTemporaryWindow", SetupTempChat)

for i=1, BNToastFrame:GetNumRegions() do
	if i ~= 10 then
		local region = select(i, BNToastFrame:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetTexture(nil)
		end
	end
end	
BNToastFrame:SetTemplate()
BNToastFrame:CreateShadow()

-- reposition battle.net popup over chat #1
BNToastFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	if C.chat.background and TukuiChatBackgroundLeft then
		self:Point("BOTTOMLEFT", TukuiChatBackgroundLeft, "TOPLEFT", 0, 6)
	else
		self:Point("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 6)
	end
end)

-- reskin Toast Frame Close Button
BNToastFrameCloseButton:SkinCloseButton()

-- kill the default reset button
ChatConfigFrameDefaultButton:Kill()

-- default position of chat #1 (left) and chat #4 (right)
T.SetDefaultChatPosition = function(frame)
	if frame then
		local id = frame:GetID()
		local name = FCF_GetChatWindowInfo(id)
		local fontSize = select(2, frame:GetFont())

		-- well... tukui font under fontsize 12 is unreadable. Just a small protection!
		if fontSize < 12 then		
			FCF_SetChatWindowFontSize(nil, frame, 12)
		else
			FCF_SetChatWindowFontSize(nil, frame, fontSize)
		end
		
		if id == 1 then
			frame:ClearAllPoints()
			frame:Point("BOTTOMLEFT", TukuiInfoLeft, "TOPLEFT", 0, 6)
		elseif id == 4 and name == LOOT then
			if not frame.isDocked then
				frame:ClearAllPoints()
				frame:Point("BOTTOMRIGHT", TukuiInfoRight, "TOPRIGHT", 0, 6)
				frame:SetJustifyH("RIGHT")
			end
		end
		
		-- lock them if unlocked
		if not frame.isLocked then FCF_SetLocked(frame, 1) end
	end
end
hooksecurefunc("FCF_RestorePositionAndDimensions", T.SetDefaultChatPosition)

local function RemoveCurrentRealmName(self, event, msg, author, ...)
	local realmName = string.gsub(GetRealmName(), " ", "")

	if msg:find("-" .. realmName) then
		return false, gsub(msg, "%-"..realmName, ""), author, ...
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", RemoveCurrentRealmName)