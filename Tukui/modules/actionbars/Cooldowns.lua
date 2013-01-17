local T, C, L, G = unpack(select(2, ...)) 
--[[
        An edited lightweight OmniCC for Tukui
                A featureless, 'pure' version of OmniCC.
                This version should work on absolutely everything, but I've removed pretty much all of the options
--]]

if IsAddOnLoaded("OmniCC") or IsAddOnLoaded("ncCooldown") or C["cooldown"].enable ~= true then return end

--constants!
OmniCC = true --hack to work around detection from other addons for OmniCC
local ICON_SIZE = 36 --the normal size for an icon (don't change this)
local DAY, HOUR, MINUTE = 86400, 3600, 60 --used for formatting text
local DAYISH, HOURISH, MINUTEISH = 3600 * 23.5, 60 * 59.5, 59.5 --used for formatting text at transition points
local HALFDAYISH, HALFHOURISH, HALFMINUTEISH = DAY/2 + 0.5, HOUR/2 + 0.5, MINUTE/2 + 0.5 --used for calculating next update times

--configuration settings
T.SetDefaultActionButtonCooldownFont = C["media"].font --what font to use
T.SetDefaultActionButtonCooldownFontSize = 20 --the base font size to use at a scale of 1
T.SetDefaultActionButtonCooldownMinScale = 0.5 --the minimum scale we want to show cooldown counts at, anything below this will be hidden
T.SetDefaultActionButtonCooldownMinDuration = 2.5 --the minimum duration to show cooldown text for
local EXPIRING_DURATION = C["cooldown"].treshold --the minimum number of seconds a cooldown must be to use to display in the expiring format

local EXPIRING_FORMAT = T.RGBToHex(1, 0, 0)..'%.1f|r' --format for timers that are soon to expire
local SECONDS_FORMAT = T.RGBToHex(1, 1, 0)..'%d|r' --format for timers that have seconds remaining
local MINUTES_FORMAT = T.RGBToHex(1, 1, 1)..'%dm|r' --format for timers that have minutes remaining
local HOURS_FORMAT = T.RGBToHex(0.4, 1, 1)..'%dh|r' --format for timers that have hours remaining
local DAYS_FORMAT = T.RGBToHex(0.4, 0.4, 1)..'%dh|r' --format for timers that have days remaining

--local bindings!
local floor = math.floor
local min = math.min
local GetTime = GetTime

--returns both what text to display, and how long until the next update
local function getTimeText(s)
	--format text as seconds when below a minute
	if s < MINUTEISH then
		local seconds = tonumber(T.Round(s))
		if seconds > EXPIRING_DURATION then
			return SECONDS_FORMAT, seconds, s - (seconds - 0.51)
		else
			return EXPIRING_FORMAT, s, 0.051
		end
	--format text as minutes when below an hour
	elseif s < HOURISH then
		local minutes = tonumber(T.Round(s/MINUTE))
		return MINUTES_FORMAT, minutes, minutes > 1 and (s - (minutes*MINUTE - HALFMINUTEISH)) or (s - MINUTEISH)
	--format text as hours when below a day
	elseif s < DAYISH then
		local hours = tonumber(T.Round(s/HOUR))
		return HOURS_FORMAT, hours, hours > 1 and (s - (hours*HOUR - HALFHOURISH)) or (s - HOURISH)
	--format text as days
	else
		local days = tonumber(T.Round(s/DAY))
		return DAYS_FORMAT, days,  days > 1 and (s - (days*DAY - HALFDAYISH)) or (s - DAYISH)
	end
end

--stops the timer
local function Timer_Stop(self)
	self.enabled = nil
	self:Hide()
end

--forces the given timer to update on the next frame
local function Timer_ForceUpdate(self)
	self.nextUpdate = 0
	self:Show()
end

--adjust font size whenever the timer's parent size changes
--hide if it gets too tiny
local function Timer_OnSizeChanged(self, width, height)
	local fontScale = T.Round(width) / ICON_SIZE
	if fontScale == self.fontScale then
		return
	end

	self.fontScale = fontScale
	if fontScale < T.SetDefaultActionButtonCooldownMinScale then
		self:Hide()
	else
		self.text:SetFont(T.SetDefaultActionButtonCooldownFont, fontScale * T.SetDefaultActionButtonCooldownFontSize, 'OUTLINE')
		self.text:SetShadowColor(0, 0, 0, 0.5)
		self.text:SetShadowOffset(2, -2)
		if self.enabled then
			Timer_ForceUpdate(self)
		end
	end
end

--update timer text, if it needs to be
--hide the timer if done
local function Timer_OnUpdate(self, elapsed)
	if self.nextUpdate > 0 then
		self.nextUpdate = self.nextUpdate - elapsed
	else
		local remain = self.duration - (GetTime() - self.start)
		if tonumber(T.Round(remain)) > 0 then
			if (self.fontScale * self:GetEffectiveScale() / UIParent:GetScale()) < T.SetDefaultActionButtonCooldownMinScale then
				self.text:SetText('')
				self.nextUpdate  = 1
			else
				local formatStr, time, nextUpdate = getTimeText(remain)
				self.text:SetFormattedText(formatStr, time)
				self.nextUpdate = nextUpdate
			end
		else
			Timer_Stop(self)
		end
	end
end

--returns a new timer object
local function Timer_Create(self)
	--a frame to watch for OnSizeChanged events
	--needed since OnSizeChanged has funny triggering if the frame with the handler is not shown
	local scaler = CreateFrame('Frame', nil, self)
	scaler:SetAllPoints(self)

	local timer = CreateFrame('Frame', nil, scaler); timer:Hide()
	timer:SetAllPoints(scaler)
	timer:SetScript('OnUpdate', Timer_OnUpdate)

	local text = timer:CreateFontString(nil, 'OVERLAY')
	text:Point("CENTER", 2, 0)
	text:SetJustifyH("CENTER")
	timer.text = text

	Timer_OnSizeChanged(timer, scaler:GetSize())
	scaler:SetScript('OnSizeChanged', function(self, ...) Timer_OnSizeChanged(timer, ...) end)

	self.timer = timer
	return timer
end

--hook the SetCooldown method of all cooldown frames
--ActionButton1Cooldown is used here since its likely to always exist
--and I'd rather not create my own cooldown frame to preserve a tiny bit of memory
local function Timer_Start(self, start, duration, charges, maxCharges)
	if self.noOCC then return end
	
	--start timer
	if start > 0 and duration > T.SetDefaultActionButtonCooldownMinDuration then
		local timer = self.timer or Timer_Create(self)
		local num = charges or 0
		timer.start = start
		timer.duration = duration
		timer.charges = num
		timer.maxCharges = maxCharges
		timer.enabled = true
		timer.nextUpdate = 0
		if timer.fontScale >= T.SetDefaultActionButtonCooldownMinScale and timer.charges < 1 then
			timer:Show()
		end
	--stop timer
	else
		local timer = self.timer
		if timer then
			Timer_Stop(timer)
		end
	end
end

hooksecurefunc(getmetatable(_G["ActionButton1Cooldown"]).__index, "SetCooldown", Timer_Start)

local active = {}
local hooked = {}

local function cooldown_OnShow(self)
	active[self] = true
end

local function cooldown_OnHide(self)
	active[self] = nil
end

T.UpdateActionButtonCooldown = function(self)
	local button = self:GetParent()
	local start, duration, enable = GetActionCooldown(button.action)
	local charges, maxCharges, chargeStart, chargeDuration = GetActionCharges(button.action)

	Timer_Start(self, start, duration, charges, maxCharges)
end

local EventWatcher = CreateFrame("Frame")
EventWatcher:Hide()
EventWatcher:SetScript("OnEvent", function(self, event)
	for cooldown in pairs(active) do
		T.UpdateActionButtonCooldown(cooldown)
	end
end)
EventWatcher:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")

local function actionButton_Register(frame)
	local cooldown = frame.cooldown
	if not hooked[cooldown] then
		cooldown:HookScript("OnShow", cooldown_OnShow)
		cooldown:HookScript("OnHide", cooldown_OnHide)
		hooked[cooldown] = true
	end
end

if _G["ActionBarButtonEventsFrame"].frames then
	for i, frame in pairs(_G["ActionBarButtonEventsFrame"].frames) do
		actionButton_Register(frame)
	end
end

hooksecurefunc("ActionBarButtonEventsFrame_RegisterFrame", actionButton_Register)