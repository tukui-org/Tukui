local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]

local menuFrame = CreateFrame("Frame", "TukuiVoiceClickMenu", UIParent, "UIDropDownMenuTemplate")

local IsMicrophoneEnabled = function()
	if C_VoiceChat.IsMuted() then
		return false
	else
		return true
	end
end

local IsVoiceChatEnabled = function()
	if C_VoiceChat.IsDeafened() then
		return false
	else
		return true
	end
end

local menuList = {
	{
		text = ENABLE_MICROPHONE,

		func = function(self)
			C_VoiceChat.ToggleMuted()
		end,

		checked = IsMicrophoneEnabled,

		isNotRadio = true,
	},
	{
		text = ENABLE_VOICECHAT,

		func = function(self)
			C_VoiceChat.ToggleDeafened()
		end,

		checked = IsVoiceChatEnabled,

		isNotRadio = true,
	},
}

local OnMouseUp = function(self, btn)
	if btn == "RightButton" then
		T.Miscellaneous.DropDown.Open(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	else
		if InCombatLockdown() then
			T.Print(ERR_NOT_IN_COMBAT)

			return
		end
		
		ToggleChannelFrame()
	end
end

local OnEnter = function(self)
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	local VoiceMode = C_VoiceChat.GetCommunicationMode()

	if VoiceMode == Enum.CommunicationMode.PushToTalk then
		local Key = C_VoiceChat.GetPushToTalkBinding()

		GameTooltip:AddDoubleLine(VOICE_CHAT_MODE, "|cffff0000["..PUSH_TO_TALK.."]|r")
		GameTooltip:AddLine(" ")

		if Key then
			GameTooltip:AddLine(VOICE_CHAT_NOTIFICATION_COMMS_MODE_PTT:format(GetBindingText(CreateKeyChordStringFromTable(Key))))
		else
			GameTooltip:AddLine(VOICE_CHAT_NOTIFICATION_COMMS_MODE_PTT_UNBOUND)
		end
	elseif VoiceMode == Enum.CommunicationMode.OpenMic then
		GameTooltip:AddDoubleLine(VOICE_CHAT_MODE, "|cffff0000["..VOICE_CHAT_NOTIFICATION_COMMS_MODE_VOICE_ACTIVATED.."]|r")
	end

	local UseNotBound = true
	local UseParentheses = true
	local BindingText = GetBindingKeyForAction("TOGGLECHATTAB", UseNotBound, UseParentheses)
	local Tip = string.sub(VOICE_CHAT_CHANNEL_MANAGEMENT_TIP, 6)

	if BindingText and BindingText ~= "" then
		local AnnounceText = Tip:format("", BindingText)

		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(AnnounceText)
	end

	GameTooltip:Show()
end

local Enable = function(self)
	self.Text:SetFormattedText("%s", DataText.NameColor .. BINDING_HEADER_VOICE_CHAT .. "|r")
	self:SetScript("OnMouseUp", OnMouseUp)
	self:SetScript("OnEnter", GameTooltip_Hide)
	self:SetScript("OnLeave", OnLeave)
end

local Disable = function(self)
	self.Text:SetText("")
	self:SetScript("OnMouseUp", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register("Voice Chat", Enable, Disable)
