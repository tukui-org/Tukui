--------------------------------------------------------------------
-- GUILD ROSTER
--------------------------------------------------------------------
local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

if not C["datatext"].guild or C["datatext"].guild == 0 then return end

local tthead, ttsubh, ttoff = {r=0.4, g=0.78, b=1}, {r=0.75, g=0.9, b=1}, {r=.3,g=1,b=.3}
local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
local displayString = string.join("", "%s: ", "|cffFFFFFF", "%d|r")
local guildInfoString = "%s [%d]"
local guildInfoString2 = "%s: %d/%d"
local guildMotDString = "  %s |cffaaaaaa- |cffffffff%s"
local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s"
local levelNameStatusString = "|cff%02x%02x%02x%d|r %s %s"
local nameRankString = "%s |cff999999-|cffffffff %s"
local noteString = "  '%s'"
local officerNoteString = "  o: '%s'"

local guildTable, guildXP, guildMotD = {}, {}, ""
local totalOnline = 0

local Stat = CreateFrame("Frame")
Stat:EnableMouse(true)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat.update = false

local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
Text:SetFont(C.media.font, C["datatext"].fontsize)
T.PP(C["datatext"].guild, Text)

local function BuildGuildTable()
	totalOnline = 0
	wipe(guildTable)
	local name, rank, level, zone, note, officernote, connected, status, class
	for i = 1, GetNumGuildMembers() do
		name, rank, _, level, _, zone, note, officernote, connected, status, class = GetGuildRosterInfo(i)
		guildTable[i] = { name, rank, level, zone, note, officernote, connected, status, class }
		if connected then totalOnline = totalOnline + 1 end
	end
	table.sort(guildTable, function(a, b)
		if a and b then
			return a[1] < b[1]
		end
	end)
end

local function UpdateGuildXP()
	local currentXP, remainingXP, dailyXP, maxDailyXP = UnitGetGuildXP("player")
	local nextLevelXP = currentXP + remainingXP
	local percentTotal = tostring(math.ceil((currentXP / nextLevelXP) * 100))
	local percentDaily = tostring(math.ceil((dailyXP / maxDailyXP) * 100))
	
	guildXP[0] = { currentXP, nextLevelXP, percentTotal }
	guildXP[1] = { dailyXP, maxDailyXP, percentDaily }
end

local function UpdateGuildMessage()
	guildMotD = GetGuildRosterMOTD()
end

local function Update(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if IsInGuild() and not GuildFrame then LoadAddOn("Blizzard_GuildUI") end
	end
	
	if IsInGuild() then
		totalOnline = 0
		local name, rank, level, zone, note, officernote, connected, status, class
		for i = 1, GetNumGuildMembers() do
			local connected = select(9, GetGuildRosterInfo(i))
			if connected then totalOnline = totalOnline + 1 end
		end	
		Text:SetFormattedText(displayString, L.datatext_guild, totalOnline)
	else
		Text:SetText(L.datatext_noguild)
	end
	
	self:SetAllPoints(Text)
end
	
local menuFrame = CreateFrame("Frame", "TukuiGuildRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
	{ text = OPTIONS_MENU, isTitle = true,notCheckable=true},
	{ text = INVITE, hasArrow = true,notCheckable=true,},
	{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true,notCheckable=true,}
}

local function inviteClick(self, arg1, arg2, checked)
	menuFrame:Hide()
	InviteUnit(arg1)
end

local function whisperClick(self,arg1,arg2,checked)
	menuFrame:Hide()
	SetItemRef( "player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton" )
end

local function ToggleGuildFrame()
	if IsInGuild() then 
		if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end 
		GuildFrame_Toggle()
		GuildFrame_TabClicked(GuildFrameTab2)
	else 
		if not LookingForGuildFrame then LoadAddOn("Blizzard_LookingForGuildUI") end 
		LookingForGuildFrame_Toggle() 
	end
end

Stat:SetScript("OnMouseUp", function(self, btn)
	if btn ~= "RightButton" or not IsInGuild() then return end
	
	GameTooltip:Hide()

	local classc, levelc, grouped
	local menuCountWhispers = 0
	local menuCountInvites = 0

	menuList[2].menuList = {}
	menuList[3].menuList = {}

	for i = 1, #guildTable do
		if guildTable[i][7] and guildTable[i][1] ~= T.myname then
			local classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[guildTable[i][9]], GetQuestDifficultyColor(guildTable[i][3])

			if UnitInParty(guildTable[i][1]) or UnitInRaid(guildTable[i][1]) then
				grouped = "|cffaaaaaa*|r"
			else
				menuCountInvites = menuCountInvites +1
				grouped = ""
				menuList[2].menuList[menuCountInvites] = {text = string.format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, guildTable[i][3], classc.r*255,classc.g*255,classc.b*255, guildTable[i][1], ""), arg1 = guildTable[i][1],notCheckable=true, func = inviteClick}
			end
			menuCountWhispers = menuCountWhispers + 1
			menuList[3].menuList[menuCountWhispers] = {text = string.format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, guildTable[i][3], classc.r*255,classc.g*255,classc.b*255, guildTable[i][1], grouped), arg1 = guildTable[i][1],notCheckable=true, func = whisperClick}
		end
	end

	EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
end)

Stat:SetScript("OnEnter", function(self)
	if InCombatLockdown() or not IsInGuild() then return end
	
	UpdateGuildMessage()
	BuildGuildTable()
		
	local name, rank, level, zone, note, officernote, connected, status, class
	local zonec, classc, levelc
	local online = totalOnline
		
	local anchor, panel, xoff, yoff = T.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine(string.format(guildInfoString, GetGuildInfo('player'), GetGuildLevel()), string.format(guildInfoString2, L.datatext_guild, online, #guildTable),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
	
	if guildMotD ~= "" then GameTooltip:AddLine(' ') GameTooltip:AddLine(string.format(guildMotDString, GUILD_MOTD, guildMotD), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
	
	local col = T.RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b)
	GameTooltip:AddLine' '
	if GetGuildLevel() ~= 25 then
		UpdateGuildXP()
		
		local currentXP, nextLevelXP, percentTotal = unpack(guildXP[0])
		local dailyXP, maxDailyXP, percentDaily = unpack(guildXP[1])
		
		if currentXP ~= 0 then
			GameTooltip:AddLine(string.format(col..GUILD_EXPERIENCE_CURRENT, "|r |cFFFFFFFF"..T.ShortValue(currentXP), T.ShortValue(nextLevelXP), percentTotal))
			GameTooltip:AddLine(string.format(col..GUILD_EXPERIENCE_DAILY, "|r |cFFFFFFFF"..T.ShortValue(dailyXP), T.ShortValue(maxDailyXP), percentDaily))
		end
	end
	
	local _, _, standingID, barMin, barMax, barValue = GetGuildFactionInfo()
	if standingID ~= 8 then -- Not Max Rep
		barMax = barMax - barMin
		barValue = barValue - barMin
		barMin = 0
		GameTooltip:AddLine(string.format("%s:|r |cFFFFFFFF%s/%s (%s%%)",col..COMBAT_FACTION_CHANGE, T.ShortValue(barValue), T.ShortValue(barMax), math.ceil((barValue / barMax) * 100)))
	end
	
	if online > 1 then
		GameTooltip:AddLine(' ')
		for i = 1, #guildTable do
			if online <= 1 then
				if online > 1 then GameTooltip:AddLine(format("+ %d More...", online - modules.Guild.maxguild),ttsubh.r,ttsubh.g,ttsubh.b) end
				break
			end

			name, rank, level, zone, note, officernote, connected, status, class = unpack(guildTable[i])
			if connected and name ~= T.myname then
				if GetRealZoneText() == zone then zonec = activezone else zonec = inactivezone end
				classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
				
				if IsShiftKeyDown() then
					GameTooltip:AddDoubleLine(string.format(nameRankString, name, rank), zone, classc.r, classc.g, classc.b, zonec.r, zonec.g, zonec.b)
					if note ~= "" then GameTooltip:AddLine(string.format(noteString, note), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
					if officernote ~= "" then GameTooltip:AddLine(string.format(officerNoteString, officernote), ttoff.r, ttoff.g, ttoff.b ,1) end
				else
					GameTooltip:AddDoubleLine(string.format(levelNameStatusString, levelc.r*255, levelc.g*255, levelc.b*255, level, name, status), zone, classc.r,classc.g,classc.b, zonec.r,zonec.g,zonec.b)
				end
			end
		end
	end
	GameTooltip:Show()
end)

Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
Stat:SetScript("OnMouseDown", function(self, btn)
	if btn ~= "LeftButton" then return end
	ToggleGuildFrame()
end)

Stat:RegisterEvent("GUILD_ROSTER_SHOW")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:RegisterEvent("GUILD_ROSTER_UPDATE")
Stat:RegisterEvent("PLAYER_GUILD_UPDATE")
Stat:SetScript("OnEvent", Update)