local T, C, L = select(2, ...):unpack()

local TukuiVersion = CreateFrame("Frame")
local Version = tonumber(GetAddOnMetadata("Tukui", "Version"))
local SendAddonMessage = SendAddonMessage
local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME
local tonumber = tonumber
local Outdated = L.Version.Outdated

function TukuiVersion:Check(event, prefix, message, channel, sender)
	
	if (event == "CHAT_MSG_ADDON") then
		if (prefix ~= "TukuiVersion") or (sender == T.myname) then
			return
		end
		
		if (tonumber(message) > Version) then -- We recieved a higher version, we're outdated. :(
			T.Print(Outdated)
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		-- Tell everyone what version we use.
		if (not IsInGroup(LE_PARTY_CATEGORY_HOME)) or (not IsInRaid(LE_PARTY_CATEGORY_HOME)) then
			SendAddonMessage("TukuiVersion", Version, "INSTANCE_CHAT")
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("TukuiVersion", Version, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("TukuiVersion", Version, "PARTY")
		elseif IsInGuild() then
			SendAddonMessage("TukuiVersion", Version, "GUILD")
		end
	end
end

TukuiVersion:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiVersion:RegisterEvent("GROUP_ROSTER_UPDATE")
TukuiVersion:RegisterEvent("CHAT_MSG_ADDON")
TukuiVersion:SetScript("OnEvent", TukuiVersion.Check)

RegisterAddonMessagePrefix("TukuiVersion")

T["VersionCheck"] = TukuiVersion