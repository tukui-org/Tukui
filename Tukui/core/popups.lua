local T, C, L = unpack(select(2, ...))

------------------------------------------------------------------------
--	General Popups
------------------------------------------------------------------------

StaticPopupDialogs["TUKUIDISABLE_UI"] = {
	text = L.popup_disableui,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() DisableAddOn("Tukui") ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs["TUKUIDISABLE_RAID"] = {
	text = L.popup_2raidactive,
	button1 = "DPS - TANK",
	button2 = "HEAL",
	OnAccept = function() DisableAddOn("Tukui_Raid_Healing") EnableAddOn("Tukui_Raid") ReloadUI() end,
	OnCancel = function() EnableAddOn("Tukui_Raid_Healing") DisableAddOn("Tukui_Raid") ReloadUI() end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs["TUKUIDISBAND_RAID"] = {
	text = L.disband,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function()
		if InCombatLockdown() then return end -- Prevent user error in combat
		
		SendChatMessage(ERR_GROUP_DISBANDED, "RAID" or "PARTY")
		if UnitInRaid("player") then
			for i = 1, GetNumRaidMembers() do
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
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs["TUKUI_FIX_AB"] = {
	text = L.popup_fix_ab,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = ReloadUI,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}