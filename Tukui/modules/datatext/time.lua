--------------------------------------------------------------------
-- TIME
--------------------------------------------------------------------
local T, C, L, G = unpack(select(2, ...))

if not C["datatext"].wowtime or C["datatext"].wowtime == 0 then return end

local Stat = CreateFrame("Frame", "TukuiStatTime")
Stat:EnableMouse(true)
Stat:SetFrameStrata("MEDIUM")
Stat:SetFrameLevel(3)
Stat.Option = C.datatext.wowtime
Stat.Color1 = T.RGBToHex(unpack(C.media.datatextcolor1))
Stat.Color2 = T.RGBToHex(unpack(C.media.datatextcolor2))
G.DataText.Time = Stat

local Text = Stat:CreateFontString("TukuiStatTimeText", "OVERLAY")
Text:SetFont(C.media.font, C["datatext"].fontsize)
T.DataTextPosition(C["datatext"].wowtime, Text)
G.DataText.Time.Text = Text

local europeDisplayFormat = string.join("", Stat.Color2.."%02d", ":%02d|r")
local ukDisplayFormat = string.join("", "", Stat.Color2.."%d", ":%02d", " %s|r")
local timerLongFormat = "%d:%02d:%02d"
local timerShortFormat = "%d:%02d"
local lockoutInfoFormat = "%s%s |cffaaaaaa(%s, %s/%s)"
local lockoutInfoFormatNoEnc = "%s%s |cffaaaaaa(%s)"
local formatBattleGroundInfo = "%s: "
local heroicDifficulty = {DUNGEON_DIFFICULTY2, DUNGEON_DIFFICULTY_5PLAYER_HEROIC, RAID_DIFFICULTY3, RAID_DIFFICULTY4, RAID_DIFFICULTY_10PLAYER_HEROIC, RAID_DIFFICULTY_25PLAYER_HEROIC}
local lockoutColorExtended, lockoutColorNormal = { r=0.3,g=1,b=0.3 }, { r=1,g=1,b=1 }
local curHr, curMin, curAmPm
local APM = { TIMEMANAGER_PM, TIMEMANAGER_AM }
local startTimer = GetTime()
local played = 0

local function CalculateTimeValues(tt)
	if tt == nil then tt = false end
	local Hr, Min, AmPm
	if tt == true then
		if C["datatext"].localtime == true then
			Hr, Min = GetGameTime()
			if C["datatext"].time24 == true then
				return Hr, Min, -1
			else
				if Hr>=12 then
					if Hr>12 then Hr = Hr - 12 end
					AmPm = 1
				else
					if Hr == 0 then Hr = 12 end
					AmPm = 2
				end
				return Hr, Min, AmPm
			end			
		else
			local Hr24 = tonumber(date("%H"))
			Hr = tonumber(date("%I"))
			Min = tonumber(date("%M"))
			if C["datatext"].time24 == true then
				return Hr24, Min, -1
			else
				if Hr24>=12 then AmPm = 1 else AmPm = 2 end
				return Hr, Min, AmPm
			end
		end
	else
		if C["datatext"].localtime == true then
			local Hr24 = tonumber(date("%H"))
			Hr = tonumber(date("%I"))
			Min = tonumber(date("%M"))
			if C["datatext"].time24 == true then
				return Hr24, Min, -1
			else
				if Hr24>=12 then AmPm = 1 else AmPm = 2 end
				return Hr, Min, AmPm
			end
		else
			Hr, Min = GetGameTime()
			if C["datatext"].time24 == true then
				return Hr, Min, -1
			else
				if Hr>=12 then
					if Hr>12 then Hr = Hr - 12 end
					AmPm = 1
				else
					if Hr == 0 then Hr = 12 end
					AmPm = 2
				end
				return Hr, Min, AmPm
			end
		end	
	end
end

local function CalculateTimeLeft(time)
		local hour = floor(time / 3600)
		local min = floor(time / 60 - (hour*60))
		local sec = time - (hour * 3600) - (min * 60)
		
		return hour, min, sec
end

local function formatResetTime(sec,table)
	local table = table or {}
	local d,h,m,s = ChatFrame_TimeBreakDown(floor(sec))
	local string = gsub(gsub(format(" %dd %dh %dm "..((d==0 and h==0) and "%ds" or ""),d,h,m,s)," 0[dhms]"," "),"%s+"," ")
	local string = strtrim(gsub(string, "([dhms])", {d=table.days or "d",h=table.hours or "h",m=table.minutes or "m",s=table.seconds or "s"})," ")
	return strmatch(string,"^%s*$") and "0"..(table.seconds or L"s") or string
end

local int = 1
local function Update(self, t)
	int = int - t
	if int > 0 then return end
	
	local Hr, Min, AmPm = CalculateTimeValues()
	
	-- no update quick exit
	if (Hr == curHr and Min == curMin and AmPm == curAmPm) then
		int = 2
		return
	end
	
	curHr = Hr
	curMin = Min
	curAmPm = AmPm
		
	if AmPm == -1 then
		Text:SetFormattedText(europeDisplayFormat, Hr, Min)
	else
		Text:SetFormattedText(ukDisplayFormat, Hr, Min, APM[AmPm])
	end

	self:SetAllPoints(Text)
	int = 2
end

Stat:SetScript("OnEnter", function(self)
	OnLoad = function(self) RequestRaidInfo() end
	local anchor, panel, xoff, yoff = T.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()

	local _, localizedName, isActive, canQueue, startTime, canEnter
	for i = 1, GetNumWorldPVPAreas() do
		_, localizedName, isActive, canQueue, startTime, canEnter = GetWorldPVPAreaInfo(i)
		if canEnter then
			if isActive then
				startTime = WINTERGRASP_IN_PROGRESS
			elseif startTime == nil or startTime == 0 then
				startTime = QUEUE_TIME_UNAVAILABLE
			else
				local hour, min, sec = CalculateTimeLeft(startTime)
				if hour > 0 then 
					startTime = string.format(timerLongFormat, hour, min, sec) 
				else 
					startTime = string.format(timerShortFormat, min, sec)
				end
			end
			GameTooltip:AddDoubleLine(format(formatBattleGroundInfo, localizedName), startTime)	
		end
	end	

	local timeText
	local Hr, Min, AmPm = CalculateTimeValues(true)

	if C["datatext"].localtime == true then
		timeText = L.datatext_servertime
	else
		timeText = L.datatext_localtime
	end
	
	if AmPm == -1 then
		GameTooltip:AddDoubleLine(timeText, string.format(europeDisplayFormat, Hr, Min))
	else
		GameTooltip:AddDoubleLine(timeText, string.format(ukDisplayFormat, Hr, Min, APM[AmPm]))
	end
	
	local actualtime = GetTime()
	played = actualtime - startTimer
	if played > 60 then
		GameTooltip:AddDoubleLine(TIME_PLAYED_MSG..": ", T.FormatTime(played))
	end
	
	GameTooltip:AddDoubleLine(" ", " ")
	
	if UnitLevel("player") == 90 then
		local Sha = IsQuestFlaggedCompleted(32099)
		local Galleon = IsQuestFlaggedCompleted(32098)
		local Oondasta = IsQuestFlaggedCompleted(32519)
		local Nalak = IsQuestFlaggedCompleted(32518)
		
		GameTooltip:AddDoubleLine(L.datatext_sha..": ", Sha and "|cff00ff00"..L.datatext_defeated.."|r" or "|cffff0000"..L.datatext_undefeated.."|r")
		GameTooltip:AddDoubleLine(L.datatext_galleon..": ", Galleon and "|cff00ff00"..L.datatext_defeated.."|r" or "|cffff0000"..L.datatext_undefeated.."|r")
		GameTooltip:AddDoubleLine(L.datatext_oondasta..": ", Oondasta and "|cff00ff00"..L.datatext_defeated.."|r" or "|cffff0000"..L.datatext_undefeated.."|r")
		GameTooltip:AddDoubleLine(L.datatext_nalak..": ", Nalak and "|cff00ff00"..L.datatext_defeated.."|r" or "|cffff0000"..L.datatext_undefeated.."|r")
	end
	
	local oneraid, lockoutColor
	for i = 1, GetNumSavedInstances() do
		local name, _, reset, _, locked, extended, _, isRaid, maxPlayers, difficulty, numEncounters, encounterProgress  = GetSavedInstanceInfo(i)
		local idiff = "N"
		if isRaid and (locked or extended) and name then
			local tr,tg,tb,diff
			if not oneraid then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(L.datatext_savedraid)
				oneraid = true
			end
			if extended then lockoutColor = lockoutColorExtended else lockoutColor = lockoutColorNormal end
			for i, value in pairs(heroicDifficulty) do
				if value == difficulty then
					idiff = "H"
					break
				end
			end
			local formatTime = formatResetTime(reset)
			if (numEncounters and numEncounters > 0) and (encounterProgress and encounterProgress > 0) then
				GameTooltip:AddDoubleLine(format(lockoutInfoFormat, maxPlayers, idiff, name, encounterProgress, numEncounters), formatTime, 1,1,1, lockoutColor.r,lockoutColor.g,lockoutColor.b)
			else
				GameTooltip:AddDoubleLine(format(lockoutInfoFormatNoEnc, maxPlayers, idiff, name), formatTime, 1,1,1, lockoutColor.r,lockoutColor.g,lockoutColor.b)
			end
		end
	end
	GameTooltip:Show()
end)

Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
Stat:SetScript("OnUpdate", Update)
Stat:RegisterEvent("UPDATE_INSTANCE_INFO")
Stat:SetScript("OnMouseDown", function(self, btn)
	if btn == 'RightButton'  then
		ToggleTimeManager()
	else
		GameTimeFrame:Click()
	end
end)
Update(Stat, 10)