local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- enable or disable an addon via command
SlashCmdList.DISABLE_ADDON = function(addon) local _, _, _, _, _, reason, _ = GetAddOnInfo(addon) if reason ~= "MISSING" then DisableAddOn(addon) ReloadUI() else print("|cffff0000Error, Addon not found.|r") end end
SLASH_DISABLE_ADDON1 = "/disable"
SlashCmdList.ENABLE_ADDON = function(addon) local _, _, _, _, _, reason, _ = GetAddOnInfo(addon) if reason ~= "MISSING" then EnableAddOn(addon) LoadAddOn(addon) ReloadUI() else print("|cffff0000Error, Addon not found.|r") end end
SLASH_ENABLE_ADDON1 = "/enable"

-- switch to heal layout via a command
SLASH_TUKUIHEAL1 = "/heal"
SlashCmdList.TUKUIHEAL = function()
	DisableAddOn("Tukui_Raid")
	EnableAddOn("Tukui_Raid_Healing")
	ReloadUI()
end

-- switch to dps layout via a command
SLASH_TUKUIDPS1 = "/dps"
SlashCmdList.TUKUIDPS = function()
	DisableAddOn("Tukui_Raid_Healing")
	EnableAddOn("Tukui_Raid")
	ReloadUI()
end

-- fix combatlog manually when it broke
SLASH_CLFIX1 = "/clfix"
SlashCmdList.CLFIX = CombatLogClearEntries

-- ready check shortcut
SlashCmdList.RCSLASH = DoReadyCheck
SLASH_RCSLASH1 = "/rc"

SlashCmdList["GROUPDISBAND"] = function()
	if UnitIsRaidOfficer("player") then
		StaticPopup_Show("TUKUIDISBAND_RAID")
	end
end
SLASH_GROUPDISBAND1 = '/rd'

-- Leave party chat command
SlashCmdList["LEAVEPARTY"] = function()
	LeaveParty()
end
SLASH_LEAVEPARTY1 = '/leaveparty'