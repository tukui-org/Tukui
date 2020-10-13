local T, C, L = select(2, ...):unpack()

local Chat = T["Chat"]
local gsub = gsub
local strsub = strsub
local Link = CreateFrame("Frame")
local CurrentLink
local SetHyperlink = ItemRefTooltip.SetHyperlink

function Link:Create(url)
	if C.Chat.LinkBrackets then
		url = T.RGBToHex(unpack(C.Chat.LinkColor)).."|Hurl:"..url.."|h["..url.."]|h|r "
	else
		url = T.RGBToHex(unpack(C.Chat.LinkColor)).."|Hurl:"..url.."|h"..url.."|h|r "
	end

	return url
end

function Link:Find(event, msg, ...)
	local NewMsg, Found = gsub(msg, "(%a+)://(%S+)%s?", Link:Create("%1://%2"))

	if (Found > 0) then
		return false, NewMsg, ...
	end

	NewMsg, Found = gsub(msg, "www%.([_A-Za-z0-9-]+)%.(%S+)%s?", Link:Create("www.%1.%2"))

	if (Found > 0) then
		return false, NewMsg, ...
	end

	NewMsg, Found = gsub(msg, "([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-]+)(%.+)([_A-Za-z0-9-%.]+)%s?", Link:Create("%1@%2%3%4"))

	if (Found > 0) then
		return false, NewMsg, ...
	end
end

function Link:SetHyperlink(data, ...)
	if (strsub(data, 1, 3) == "url") then
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()

		CurrentLink = (data):sub(5)

		if (not ChatFrameEditBox:IsShown()) then
			ChatEdit_ActivateChat(ChatFrameEditBox)
		end

		ChatFrameEditBox:Insert(CurrentLink)
		ChatFrameEditBox:HighlightText()
		CurrentLink = nil
	else
		SetHyperlink(self, data, ...)
	end
end

function Link:Enable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND_LEADER", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", self.Find)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_CONVERSATION", self.Find)

	ItemRefTooltip.SetHyperlink = self.SetHyperlink
end

Chat.Link = Link