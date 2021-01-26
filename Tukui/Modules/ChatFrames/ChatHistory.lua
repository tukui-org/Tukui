local T, C, L = select(2, ...):unpack()

local Chat = T["Chat"]
local History = CreateFrame("Frame")
local LogMax
local EntryEvent = 30
local EntryTime = 31
local Events = {
	"CHAT_MSG_INSTANCE_CHAT",
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
	"CHAT_MSG_EMOTE",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_GUILD_ACHIEVEMENT",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_PARTY_LEADER",
	"CHAT_MSG_RAID",
	"CHAT_MSG_RAID_LEADER",
	"CHAT_MSG_RAID_WARNING",
	"CHAT_MSG_SAY",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_YELL",
	
	-- Not sure if I should add this one, it's pretty much always just spam
	-- "CHAT_MSG_CHANNEL",
}

function History:Print()
	local Temp

	History.IsPrinting = true

	for i = #TukuiChatHistory, 1, -1 do
		Temp = TukuiChatHistory[i]

		ChatFrame_MessageEventHandler(ChatFrame1, Temp[EntryEvent], unpack(Temp))
	end

	History.IsPrinting = false
	History.HasPrinted = true
end

function History:Save(event, ...)
	local Temp = {...}

	if Temp[1] then
		Temp[EntryEvent] = event
		Temp[EntryTime] = time()

		table.insert(TukuiChatHistory, 1, Temp)

		for i = LogMax, #TukuiChatHistory do
			table.remove(TukuiChatHistory, LogMax)
		end
	end
end

function History:OnEvent(event, ...)
	if event == "PLAYER_LOGIN" then
		self:UnregisterEvent(event)
		self:Print()
	elseif self.HasPrinted then
		self:Save(event, ...)
	end
end

function History:Enable()
	-- This is the global table where we save chat
	TukuiChatHistory = type(TukuiChatHistory) == "table" and TukuiChatHistory or {}
	
	-- Max number of entries logged
	LogMax = C.Chat.LogMax

	for i = 1, #Events do
		History:RegisterEvent(Events[i])
	end

	if IsLoggedIn() then
		History:OnEvent("PLAYER_LOGIN")
	else
		History:RegisterEvent("PLAYER_LOGIN")
	end
	
	self:SetScript("OnEvent", self.OnEvent)
end

Chat.History = History