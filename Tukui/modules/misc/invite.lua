local T, C, L, G = unpack(select(2, ...)) 

------------------------------------------------------------------------
-- Auto accept invite
------------------------------------------------------------------------

if C["invite"].autoaccept then
	local holder = CreateFrame("Frame")
	holder:RegisterEvent("PARTY_INVITE_REQUEST")
	holder:RegisterEvent("GROUP_ROSTER_UPDATE")
	G.Misc.AutoAcceptInvite = holder
	
	local hidestatic -- used to hide static popup when auto-accepting
	holder:SetScript("OnEvent", function(self, event, leader)
		local ingroup = false
		
		if event == "PARTY_INVITE_REQUEST" then
			if QueueStatusMinimapButton:IsShown() then return end
			if GetNumGroupMembers() > 0 or GetNumGroupMembers() > 0 then return end
			hidestatic = true
		
			-- Update Guild and Friendlist
			if GetNumFriends() > 0 then ShowFriends() end
			if IsInGuild() then GuildRoster() end
			
			for friendindex = 1, GetNumFriends() do
				local friendname = GetFriendInfo(friendindex)
				if friendname == leader then
					AcceptGroup()
					ingroup = true
					break
				end
			end
			
			-------------------------------------------------------------------
			-- friend not found in friend index, so we look now into battle.net
			-------------------------------------------------------------------
			
			local playerFaction
			
			-- find which faction we play
			if select(1, UnitFactionGroup("player")) == "Horde" then playerFaction = 0 else playerFaction = 1 end
			
			if not ingroup then
				for i = 1, select(2, BNGetNumFriends()) do
					local presenceID, givenName, surname, toonName, toonID, client, isOnline = BNGetFriendInfo(i)
					local _, _, _, realmName, faction, race, class, _, zoneName, level = BNGetToonInfo(presenceID)

					if client == "WoW" and faction == playerFaction then
						if toonName == leader then
							AcceptGroup()
							ingroup = true
							break
						end
					end
				end
			end
			
			-----------------------------------------------------------------------------
			-- friend not found in battle.net friend index, so we look now into our guild
			-----------------------------------------------------------------------------
			
			if not ingroup then
				for guildindex = 1, GetNumGuildMembers(true) do
					local guildmembername = GetGuildRosterInfo(guildindex)
					if guildmembername == leader then
						AcceptGroup()
						break
					end
				end
			end
			
		elseif event == "GROUP_ROSTER_UPDATE" and hidestatic == true then
			StaticPopup_Hide("PARTY_INVITE")
			hidestatic = false
		end
	end)
end

------------------------------------------------------------------------
-- Auto invite by whisper
------------------------------------------------------------------------

local ainvenabled = false
local ainvkeyword = "invite"

local autoinvite = CreateFrame("frame")
autoinvite:RegisterEvent("CHAT_MSG_WHISPER")
autoinvite:SetScript("OnEvent", function(self,event,arg1,arg2)
	if ((not UnitExists("party1") or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and arg1:lower():match(ainvkeyword)) and ainvenabled == true then
		InviteUnit(arg2)
	end
end)
G.Misc.AutoInvite = autoinvite

function SlashCmdList.AUTOINVITE(msg, editbox)
	if msg == "off" then
		ainvenabled = false
		print(L.core_autoinv_disable)
	elseif msg == "" then
		ainvenabled = true
		print(L.core_autoinv_enable)
		ainvkeyword = "invite"
	else
		ainvenabled = true
		print(L.core_autoinv_enable_c .. msg)
		ainvkeyword = msg
	end
end
SLASH_AUTOINVITE1 = "/ainv"
