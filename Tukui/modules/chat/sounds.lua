local T, C, L, G = unpack(select(2, ...)) 
if C["chat"].enable ~= true then return end

------------------------------------------------------------------------
--	Play sound files system
------------------------------------------------------------------------

if C.chat.whispersound then
	local SoundSys = CreateFrame("Frame")
	SoundSys:RegisterEvent("CHAT_MSG_WHISPER")
	SoundSys:RegisterEvent("CHAT_MSG_BN_WHISPER")
	SoundSys:SetScript("OnEvent", function(self, event, msg, ...)
		if event == "CHAT_MSG_WHISPER" or "CHAT_MSG_BN_WHISPER" then
			if (msg:sub(1,3) == "OQ,") then
				return false, msg, ...
			end
			PlaySoundFile(C["media"].whisper)
		end
	end)
	G.Chat.Sound = SoundSys
end