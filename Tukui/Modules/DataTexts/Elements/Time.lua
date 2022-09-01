local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local tonumber = tonumber
local format = format
local date = date
local Interval = 10
local Timer = 0
local RaidFormat1 = "%s - %s (%d/%d)" -- Siege of Orgrimmar - Mythic (10/14)
local RaidFormat2 = "%s - %s" -- Siege of Orgrimmar - Mythic
local DayHourMinute = "%dd, %dh, %dm"
local HourMinute = "%dh, %dm"
local MinuteSecond = "%dm, %ds"

local GetResetTime = function(seconds)
	local Days, Hours, Minutes, Seconds = ChatFrame_TimeBreakDown(floor(seconds))

	if (Days > 0) then
		return format(DayHourMinute, Days, Hours, Minutes) -- 7d, 2h, 5m
	elseif (Hours > 0) then
		return format(HourMinute, Hours, Minutes) -- 12h, 32m
	else
		return format(MinuteSecond, Minutes, Seconds) -- 5m, 42s
	end
end

local Update = function(self, Elapsed)
	Timer = Timer - Elapsed

	if Timer < 0 then
		local LocalTime = GetCVar("timeMgrUseLocalTime") == "1" and true or false
		local MilitaryTime = GetCVar("timeMgrUseMilitaryTime") == "0" and true or false
		local Hour = LocalTime == true and tonumber(date("%H")) or select(1, GetGameTime())
		local Min = LocalTime == true and tonumber(date("%M")) or select(2, GetGameTime())

		local CurrentTime = GameTime_GetFormattedTime(Hour, Min, true)

		self.Text:SetText(DataText.ValueColor .. CurrentTime)

		Timer = Interval
	end
end

local OnEnter = function(self)
	if not T.Retail then
		return
	end

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	local SavedInstances = GetNumSavedInstances()
	local SavedWorldBosses = GetNumSavedWorldBosses()

	if (SavedWorldBosses > 0) then
		GameTooltip:AddLine("World Bosses")

		for i = 1, SavedWorldBosses do
			local Name, _, Reset = GetSavedWorldBossInfo(i)

			if (Name and Reset) then
				local ResetTime = GetResetTime(Reset)

				GameTooltip:AddDoubleLine(Name, ResetTime, 1, 1, 1, 1, 1, 1)
			end
		end
	end

	if ((SavedWorldBosses > 0) and (SavedInstances > 0)) then
		-- Spacing
		GameTooltip:AddLine(" ")
	end

	if (SavedInstances > 0) then
		GameTooltip:AddLine("Saved Raids")

		for i = 1, SavedInstances do
			local Name, _, Reset, _, Locked, Extended, _, IsRaid, _, Difficulty, MaxBosses, DefeatedBosses = GetSavedInstanceInfo(i)

			if (IsRaid and Name and (Locked or Extended)) then
				local ResetTime = GetResetTime(Reset)

				if (MaxBosses and MaxBosses > 0) and (DefeatedBosses and DefeatedBosses > 0) then
					GameTooltip:AddDoubleLine(format(RaidFormat1, Name, Difficulty, DefeatedBosses, MaxBosses), ResetTime, 1, 1, 1, 1, 1, 1)
				else
					GameTooltip:AddDoubleLine(format(RaidFormat2, Name, Difficulty), ResetTime, 1, 1, 1, 1, 1, 1)
				end
			end
		end
	end

	GameTooltip:Show()
end

local OnLeave = function()
	GameTooltip:Hide()
end

local OnMouseUp = function(button, click)
	if click == "RightButton" then
		TimeManager_Toggle()
	else
		if InCombatLockdown() then
			T.Print(ERR_NOT_IN_COMBAT)

			return
		end

		if T.Retail or T.WotLK then
			GameTimeFrame_OnClick()
		else
			Stopwatch_Toggle()
		end
	end
end

local Enable = function(self)
	self:SetScript("OnUpdate", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseUp", OnMouseUp)
end

local Disable = function(self)
	self:SetScript("OnUpdate", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnMouseUp", nil)
end

DataText:Register("Time", Enable, Disable, Update)
