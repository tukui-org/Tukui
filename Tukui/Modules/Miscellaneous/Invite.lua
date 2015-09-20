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
local HidePopup = false
local Keyword = "inv"
local _ -- Taint prevention

local StripRealm = function(name)
	if strfind(name, "-") then
		name = strmatch(name, "(%a+)-")
		
		return name
	else
		return name
	end
end

function Invite:Enable()
	AutoAccept:RegisterEvent("PARTY_INVITE_REQUEST")
	AutoAccept:RegisterEvent("GROUP_ROSTER_UPDATE")
	AutoAccept:SetScript("OnEvent", function(self, event, sender)
		local Name
		
		if (event == "PARTY_INVITE_REQUEST") then
			-- We're waiting on a queue
			if QueueStatusMinimapButton:IsShown() then
				return
			end
			
			if (GetNumGroupMembers() > 0 or GetNumGroupMembers() > 0) then
				return
			end
			
			-- Update Guild and Friends
			if (GetNumFriends() > 0) then
				ShowFriends()
			end
			
			if IsInGuild() then
				GuildRoster()
			end
			
			for i = 1, GetNumFriends() do
				Name = GetFriendInfo(i)
				
				if (Name == sender) then
					AcceptGroup()
					HidePopup = true
					return
				end
			end
			
			local PlayerFaction
			
			-- find which faction we play
			if (UnitFactionGroup("player") == "Horde") then
				PlayerFaction = 0
			else
				PlayerFaction = 1
			end
			
			for i = 1, select(2, BNGetNumFriends()) do
				local PresenceID, _, _, Name, _, Client = BNGetFriendInfo(i)
				local Faction = select(5, BNGetToonInfo(PresenceID))
				
				if (Client == "WoW" and Faction == PlayerFaction) then
					if Name == sender then
						AcceptGroup()
						HidePopup = true
						return
					end
				end
			end
			
			for i = 1, GetNumGuildMembers() do
				Name = StripRealm(GetGuildRosterInfo(i))
				
				if (Name == sender) then
					AcceptGroup()
					HidePopup = true
					return
				end
			end
		elseif (event == "GROUP_ROSTER_UPDATE" and HidePopup) then
			StaticPopup_Hide("PARTY_INVITE")
			HidePopup = false
		end
	end)
	
	AutoInvite:RegisterEvent("CHAT_MSG_WHISPER")
	AutoInvite:SetScript("OnEvent", function(self, event, msg, sender)
		if (not IsInGroup() or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and strmatch(strlower(msg), Keyword) then
			InviteUnit(sender)
		end
	end)
end

Invite.AutoAccept = AutoAccept
Invite.AutoInvite = AutoInvite
Miscellaneous.Invite = Invite