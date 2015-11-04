local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Invite = CreateFrame("Frame")
local AutoInvite = CreateFrame("Frame")
local AutoAccept = CreateFrame("Frame")

local strfind = strfind
local strlower = strlower
local strmatch = strmatch
local UnitIsGroupLeader = UnitIsGroupLeader
local UnitIsGroupAssistant = UnitIsGroupAssistant

function Invite:GetQueueStatus()
	-- Battlegrounds / PvP
	local WaitTime = GetBattlefieldEstimatedWaitTime(1)
	if WaitTime ~= 0 then
		return true
	end

	-- LFG / LFR
	for _, instance in pairs({ LE_LFG_CATEGORY_LFD, LE_LFG_CATEGORY_LFR, LE_LFG_CATEGORY_RF, LE_LFG_CATEGORY_SCENARIO, LE_LFG_CATEGORY_FLEXRAID }) do
		local Queued = GetLFGMode(instance)
		if Queued ~= nil then
			return true
		end
	end

	return false
end

function Invite:Enable()
	AutoAccept:RegisterEvent("PARTY_INVITE_REQUEST")
	AutoAccept:RegisterEvent("GROUP_ROSTER_UPDATE")
	AutoAccept:SetScript("OnEvent", function(self, event, ...)
		if event == "PARTY_INVITE_REQUEST" then
			if Invite:GetQueueStatus() or IsInGroup() or InCombatLockdown() then return end -- InCombatLockdown is to prevent losing a Rare Mob while getting an invite. They have to accept the invite manually.
			local LeaderName = ...

			if IsInGuild() then GuildRoster() end

			for guildIndex = 1, GetNumGuildMembers(true) do
				local guildMemberName = gsub(GetGuildRosterInfo(guildIndex), "-.*", "")
				if guildMemberName == LeaderName then
					AcceptGroup()
					self.HideStaticPopup = true
					return
				end
			end

			for bnIndex = 1, BNGetNumFriends() do
				local _, _, _, _, name = BNGetFriendInfo(bnIndex)
				LeaderName = LeaderName:match("(.+)%-.+") or LeaderName
				if name == LeaderName then
					AcceptGroup()
					self.HideStaticPopup = true
					return
				end
			end

			if GetNumFriends() > 0 then ShowFriends() end

			for friendIndex = 1, GetNumFriends() do
				local friendName = gsub(GetFriendInfo(friendIndex),  "-.*", "")
				if friendName == LeaderName then
					AcceptGroup()
					self.HideStaticPopup = true
					return
				end
			end
		elseif event == "GROUP_ROSTER_UPDATE" and self.HideStaticPopup == true then
			StaticPopupSpecial_Hide(LFGInvitePopup)
			StaticPopup_Hide("PARTY_INVITE")
			StaticPopup_Hide("PARTY_INVITE_XREALM")
			self.HideStaticPopup = false
		end
	end)
	
	AutoInvite:RegisterEvent("CHAT_MSG_WHISPER")
	AutoInvite:RegisterEvent("CHAT_MSG_BN_WHISPER")
	AutoInvite:SetScript("OnEvent", function(self, event, ...)
		local message, sender = ...
		if (not UnitExists("party1") or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and strmatch(strlower(message), '^inv') then
			if event == "CHAT_MSG_WHISPER" then
				if Invite:GetQueueStatus() then
					SendChatMessage(L.Miscellaneous.InQueue, "WHISPER", nil, sender)
				else
					InviteUnit(sender)
				end
			else
				local presenceID = select(13, ...)
				if Invite:GetQueueStatus() then
					BNSendWhisper(presenceID, L.Miscellaneous.InQueue)
				else
					BNInviteFriend(presenceID)
				end
			end
		end
	end)
end

Invite.AutoAccept = AutoAccept
Invite.AutoInvite = AutoInvite
Miscellaneous.Invite = Invite