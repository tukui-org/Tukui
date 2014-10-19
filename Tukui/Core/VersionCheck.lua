local T, C, L = select(2, ...):unpack()

local TukuiVersion = CreateFrame("Frame")
local Version = tonumber(GetAddOnMetadata("Tukui", "Version"))
local MyName = UnitName("player") .. "-" .. GetRealmName()
MyName = gsub(MyName, "%s+", "")

function TukuiVersion:Check(event, prefix, message, channel, sender)
	if (event == "CHAT_MSG_ADDON") then
		if (prefix ~= "TukuiVersion") or (sender == MyName) then
			return
		end
		
		if (tonumber(message) > Version) then -- We recieved a higher version, we're outdated. :(
			T.Print(L.Version.Outdated)
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		-- Tell everyone what version we use.
		local Channel
		
		if IsInRaid() then
			Channel = (not IsInRaid(LE_PARTY_CATEGORY_HOME) and IsInRaid(LE_PARTY_CATEGORY_INSTANCE)) and "INSTANCE_CHAT" or "RAID"
		elseif IsInGroup() then
			Channel = (not IsInGroup(LE_PARTY_CATEGORY_HOME) and IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) and "INSTANCE_CHAT" or "PARTY"
		elseif IsInGuild() then
			Channel = "GUILD"
		end
		
		if Channel then -- Putting a small delay on the call just to be certain it goes out.
			T.Delay(2, SendAddonMessage, "TukuiVersion", Version, Channel)
		end
	end
end

TukuiVersion:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiVersion:RegisterEvent("GROUP_ROSTER_UPDATE")
TukuiVersion:RegisterEvent("CHAT_MSG_ADDON")
TukuiVersion:SetScript("OnEvent", TukuiVersion.Check)

RegisterAddonMessagePrefix("TukuiVersion")

T["VersionCheck"] = TukuiVersion