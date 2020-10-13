local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format

local tthead, ttsubh, ttoff = {r = 0.4, g = 0.78, b = 1}, {r = 0.75, g = 0.9, b = 1}, {r = .3, g = 1, b = .3}
local activezone, inactivezone = {r = 0.3, g = 1.0, b = 0.3}, {r = 0.65, g = 0.65, b = 0.65}
local guildInfoString = "%s [%d]"
local guildInfoString2 = "%s %d/%d"
local guildMotDString = "  %s |cffaaaaaa- |cffffffff%s"
local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s"
local levelNameStatusString = "|cff%02x%02x%02x%d|r %s %s"
local nameRankString = "%s |cff999999-|cffffffff %s"
local noteString = "  '%s'"
local officerNoteString = "  o: '%s'"

local guildTable, guildXP, guildMotD = {}, {}, ""
local totalOnline = 0
local classc = {}

local function BuildGuildTable()
	totalOnline = 0
	wipe(guildTable)
	local _, name, server, name_server, rank, level, zone, note, officernote, connected, status, class, isMobile
	for i = 1, GetNumGuildMembers() do
		name_server, rank, _, level, _, zone, note, officernote, connected, status, class, _, _, isMobile = GetGuildRosterInfo(i)
		server = string.gsub(GetRealmName("player"), "%s+", "")
		name = string.gsub(name_server, "-"..server, "")

		if status == 1 then
			status = "|cffff0000["..AFK.."]|r"
		elseif status == 2 then
			status = "|cffff0000["..DND.."]|r"
		else
			status = ""
		end

		guildTable[i] = { name, rank, level, zone, note, officernote, connected, status, class, isMobile }
		if connected then totalOnline = totalOnline + 1 end
	end
	table.sort(guildTable, function(a, b)
		if a and b then
			return a[1] < b[1]
		end
	end)
end

local function UpdateGuildMessage()
	guildMotD = GetGuildRosterMOTD()
end

local menuFrame = CreateFrame("Frame", "TukuiGuildRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
	{ text = OPTIONS_MENU, isTitle = true, notCheckable=true},
	{ text = INVITE, hasArrow = true, notCheckable=true, menuList = {}},
	{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable=true, menuList = {}}
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

local OnMouseUp = function(self, btn)
	if btn ~= "RightButton" or not IsInGuild() then return end

	GameTooltip_Hide()

	wipe(classc)
	local levelc, grouped
	local menuCountWhispers = 0
	local menuCountInvites = 0

	wipe(menuList[2].menuList)
	wipe(menuList[3].menuList)

	for i = 1, #guildTable do
		if (guildTable[i][7] and (guildTable[i][1] ~= UnitName("player") and guildTable[i][1] ~= UnitName("player").."-"..GetRealmName())) then
			levelc = GetQuestDifficultyColor(guildTable[i][3])
			classc.r, classc.g, classc.b = unpack(T.Colors.class[guildTable[i][9]])

			if UnitInParty(guildTable[i][1]) or UnitInRaid(guildTable[i][1]) then
				grouped = "|cffaaaaaa*|r"
			else
				grouped = ""
				if not guildTable[i][10] then
					menuCountInvites = menuCountInvites + 1
					menuList[2].menuList[menuCountInvites] = {text = string.format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, guildTable[i][3], classc.r*255,classc.g*255,classc.b*255, guildTable[i][1], ""), arg1 = guildTable[i][1],notCheckable=true, func = inviteClick}
				end
			end
			menuCountWhispers = menuCountWhispers + 1
			menuList[3].menuList[menuCountWhispers] = {text = string.format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, guildTable[i][3], classc.r*255,classc.g*255,classc.b*255, guildTable[i][1], grouped), arg1 = guildTable[i][1],notCheckable=true, func = whisperClick}
		end
	end

	T.Miscellaneous.DropDown.Open(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
end

local OnEnter = function(self)
	if InCombatLockdown() or not IsInGuild() then return end

	UpdateGuildMessage()
	BuildGuildTable()

	local name, rank, level, zone, note, officernote, connected, status, class, isMobile
	local zonec, levelc
	wipe(classc)
	local online = totalOnline
	local GuildInfo, GuildRank, GuildLevel = GetGuildInfo("player")

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	if GuildInfo and GuildLevel then
		GameTooltip:AddDoubleLine(string.format(guildInfoString, GuildInfo, GuildLevel), string.format(guildInfoString2, ACHIEVEMENTS_GUILD_TAB, online, #guildTable),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
	end

	if guildMotD ~= "" then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(string.format(guildMotDString, GUILD_MOTD, guildMotD), ttsubh.r, ttsubh.g, ttsubh.b, 1)
	end

	-- local col = T.RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b) -- Unused??

	if online > 1 then
		local Count = 0

		GameTooltip:AddLine(" ")
		for i = 1, #guildTable do
			if online <= 1 then
				break
			end

			name, rank, level, zone, note, officernote, connected, status, class, isMobile = unpack(guildTable[i])

			if connected and name ~= UnitName("player") then
				if GetRealZoneText() == zone then zonec = activezone else zonec = inactivezone end
				levelc = GetQuestDifficultyColor(level)
				classc.r, classc.g, classc.b = unpack(T.Colors.class[class])

				if isMobile then zone = "" end

				if IsShiftKeyDown() then
					GameTooltip:AddDoubleLine(string.format(nameRankString, name, rank), zone, classc.r, classc.g, classc.b, zonec.r, zonec.g, zonec.b)
					if note ~= "" then GameTooltip:AddLine(string.format(noteString, note), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
					if officernote ~= "" then GameTooltip:AddLine(string.format(officerNoteString, officernote), ttoff.r, ttoff.g, ttoff.b ,1) end
				else
					GameTooltip:AddDoubleLine(string.format(levelNameStatusString, levelc.r*255, levelc.g*255, levelc.b*255, level, name, status), zone, classc.r,classc.g,classc.b, zonec.r,zonec.g,zonec.b)
				end

				Count = Count + 1
			end

			local MaxOnlineGuildMembersToDisplay = floor((T.ScreenHeight / 100) * 2)

			if Count > MaxOnlineGuildMembersToDisplay then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(format("+ "..INSPECT_GUILD_NUM_MEMBERS, online - Count),ttsubh.r,ttsubh.g,ttsubh.b)

				break -- too many members online
			end
		end
	end
	GameTooltip:Show()
end

local OnMouseDown = function(self, btn)
	if btn ~= "LeftButton" then return end

	if IsInGuild() then
		ToggleGuildFrame()
	end
end


local Update = function(self)
	if (not IsInGuild()) then
		self.Text:SetText(DataText.NameColor .. L.DataText.NoGuild .. "|r") -- I need a string :(

		return
	end

	totalOnline = select(3, GetNumGuildMembers())

	self.Text:SetFormattedText("%s %s", DataText.NameColor .. GUILD .. "|r", DataText.ValueColor .. totalOnline .. "|r")
end

local Enable = function(self)
	--self:RegisterEvent("GUILD_ROSTER_SHOW") -- This event is removed
	self:RegisterEvent("GUILD_ROSTER_UPDATE")
	self:RegisterEvent("PLAYER_GUILD_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self:SetScript("OnMouseDown", OnMouseDown)
	self:SetScript("OnMouseUp", OnMouseUp)
	self:SetScript("OnLeave", GameTooltip_Hide)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnEvent", Update)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnMouseUp", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnEvent", nil)
end

DataText:Register("Guild", Enable, Disable, Update)
