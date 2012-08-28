local T, C, L, G = unpack(select(2, ...)) 

-- enable or disable an addon via command
SlashCmdList.DISABLE_ADDON = function(addon) local _, _, _, _, _, reason, _ = GetAddOnInfo(addon) if reason ~= "MISSING" then DisableAddOn(addon) ReloadUI() else print("|cffff0000Error, Addon not found.|r") end end
SLASH_DISABLE_ADDON1 = "/disable"
SlashCmdList.ENABLE_ADDON = function(addon) local _, _, _, _, _, reason, _ = GetAddOnInfo(addon) if reason ~= "MISSING" then EnableAddOn(addon) LoadAddOn(addon) ReloadUI() else print("|cffff0000Error, Addon not found.|r") end end
SLASH_ENABLE_ADDON1 = "/enable"

-- ready check shortcut
SlashCmdList.RCSLASH = DoReadyCheck
SLASH_RCSLASH1 = "/rc"

T.CreatePopup["TUKUIDISBAND_RAID"] = {
	question = L.disband,
	answer1 = ACCEPT,
	answer2 = CANCEL,
	function1 = function()
		if InCombatLockdown() then return end -- Prevent user error in combat
		
		SendChatMessage(ERR_GROUP_DISBANDED, "RAID" or "PARTY")
		if UnitInRaid("player") then
			for i = 1, GetNumGroupMembers() do
				local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
				if online and name ~= T.myname then
					UninviteUnit(name)
				end
			end
		else
			for i = MAX_PARTY_MEMBERS, 1, -1 do
				if GetPartyMember(i) then
					UninviteUnit(UnitName("party"..i))
				end
			end
		end
		LeaveParty()	
	end,
}

SlashCmdList["GROUPDISBAND"] = function()
	if UnitIsRaidOfficer("player") then
		T.ShowPopup("TUKUIDISBAND_RAID")
	end
end
SLASH_GROUPDISBAND1 = '/rd'

-- Leave party chat command
SlashCmdList["LEAVEPARTY"] = function()
	LeaveParty()
end
SLASH_LEAVEPARTY1 = '/leaveparty'