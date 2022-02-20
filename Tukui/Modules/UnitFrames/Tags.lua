local T, C, L = select(2, ...):unpack()
local AddOn, Plugin = ...
local oUF = Plugin.oUF or oUF
local UnitFrames = T["UnitFrames"]
local DEAD = DEAD
local CHAT_FLAG_AFK = CHAT_FLAG_AFK

UnitFrames.ShortNameLength = 10

if T.Retail then
	oUF.Tags.Events["Tukui:GetRaidNameColor"] = "RAID_ROSTER_UPDATE GROUP_ROSTER_UPDATE"
	oUF.Tags.Methods["Tukui:GetRaidNameColor"] = function(unit)
		local Role = UnitGroupRolesAssigned(unit)
		local R, G, B

		if Role == "TANK" then
			R, G, B = 0.4, 0.7, 1 -- Blue for tanks
		elseif Role == "HEALER" then
			R, G, B = 0, 1, 0 -- Green for healers
		else
			R, G, B = 1, 1, 1 -- White for DPS or unknown role
		end

		return string.format("|cff%02x%02x%02x", R * 255, G * 255, B * 255)
	end
	
	oUF.Tags.Events["Tukui:Role"] = "PLAYER_ROLES_ASSIGNED GROUP_ROSTER_UPDATE"
	oUF.Tags.Methods["Tukui:Role"] = function(unit)
		local Role = UnitGroupRolesAssigned(unit)
		local String = ""

		if Role == "TANK" then
			String = "|cff0099CC(" .. TANK .. ")|r"
		elseif Role == "HEALER" then
			String = "|cff00FF00(" .. HEALER .. ")|r"
		end

		return String
	end
end

oUF.Tags.Events["Tukui:GetNameColor"] = "UNIT_POWER_UPDATE"
oUF.Tags.Methods["Tukui:GetNameColor"] = function(unit)
	local Reaction = UnitReaction(unit, "player")

	if (UnitIsPlayer(unit)) then
		return _TAGS["raidcolor"](unit)
	elseif (Reaction) then
		local c = T.Colors.reaction[Reaction]

		return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
	else
		return string.format("|cff%02x%02x%02x", 1, 1, 1)
	end
end

oUF.Tags.Events["Tukui:GetNameHostilityColor"] = "UNIT_POWER_UPDATE"
oUF.Tags.Methods["Tukui:GetNameHostilityColor"] = function(unit)
	local Reaction = UnitReaction(unit, "player")

	if (Reaction) then
		local c = T.Colors.reaction[Reaction]

		return string.format("|cff%02x%02x%02x", c[1] * 255, c[2] * 255, c[3] * 255)
	else
		return string.format("|cff%02x%02x%02x", 1, 1, 1)
	end
end

oUF.Tags.Events["Tukui:DiffColor"] = "UNIT_LEVEL PLAYER_LEVEL_UP"
oUF.Tags.Methods["Tukui:DiffColor"] = function(unit)
	local Level = UnitLevel(unit)
	local Color = Level and GetQuestDifficultyColor(Level) or {r = 1, g = 1, b = 1}

	return string.format("|cff%02x%02x%02x", Color.r * 255, Color.g * 255, Color.b * 255)
end

oUF.Tags.Events["Tukui:NameShort"] = "UNIT_NAME_UPDATE PARTY_LEADER_CHANGED GROUP_ROSTER_UPDATE"
oUF.Tags.Methods["Tukui:NameShort"] = function(unit)
	local Name = UnitName(unit) or "???"
	local IsLeader = UnitIsGroupLeader(unit)
	local IsAssistant = UnitIsGroupAssistant(unit) or UnitIsRaidOfficer(unit)
	local Assist, Lead = IsAssistant and "[A] " or "", IsLeader and "[L] " or ""

	return UnitFrames.UTF8Sub(Lead..Assist..Name, UnitFrames.ShortNameLength, false)
end

oUF.Tags.Events["Tukui:NameMedium"] = "UNIT_NAME_UPDATE"
oUF.Tags.Methods["Tukui:NameMedium"] = function(unit)
	local Name = UnitName(unit) or "???"
	return UnitFrames.UTF8Sub(Name, 15, true)
end

oUF.Tags.Events["Tukui:NameLong"] = "UNIT_NAME_UPDATE"
oUF.Tags.Methods["Tukui:NameLong"] = function(unit)
	local Name = UnitName(unit) or "???"
	return UnitFrames.UTF8Sub(Name, 20, true)
end

oUF.Tags.Events["Tukui:Dead"] = "UNIT_HEALTH"
oUF.Tags.Methods["Tukui:Dead"] = function(unit)
	if UnitIsDeadOrGhost(unit) then
		return DEAD
	end
end

oUF.Tags.Events["Tukui:CurrentHP"] = "UNIT_HEALTH"
oUF.Tags.Methods["Tukui:CurrentHP"] = function(unit)
	local HP = UnitFrames.ShortValue(UnitHealth(unit))
	
	return HP
end

oUF.Tags.Events["Tukui:MaxHP"] = "UNIT_HEALTH"
oUF.Tags.Methods["Tukui:MaxHP"] = function(unit)
	local HP = UnitFrames.ShortValue(UnitHealthMax(unit))
	
	return HP
end

oUF.Tags.Events["Tukui:AFK"] = "PLAYER_FLAGS_CHANGED"
oUF.Tags.Methods["Tukui:AFK"] = function(unit)
	if UnitIsAFK(unit) then
		return CHAT_FLAG_AFK
	end
end

oUF.Tags.Events["Tukui:Classification"] = "UNIT_CLASSIFICATION_CHANGED"
oUF.Tags.Methods["Tukui:Classification"] = function(unit)
	local C = UnitClassification(unit)

	if(C == "rare") then
		return "|cffffff00R |r"
	elseif(C == "rareelite") then
		return "|cFFFF4500R+ |r"
	elseif(C == "elite") then
		return "|cFFFFA500+ |r"
	elseif(C == "worldboss") then
		return "|cffff0000B |r"
	elseif(C == "minus") then
		return "|cff888888- |r"
	end
end

UnitFrames.Tags = oUF.Tags
