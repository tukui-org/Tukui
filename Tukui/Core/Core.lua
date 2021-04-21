local T, C, L = select(2, ...):unpack()

-- Hydra note: Since this file is going to be doing a lot of math/formatting, lets use locals for speed/cpu usage
-- This means no calling functions as methods :P ("string"):format(...) or ("string"):gsub(...) should be format("string", ...) and gsub("string", ...) etc.

local Infinity = math.huge
local reverse = string.reverse
local match = string.match
local modf = math.modf
local select = select
local format = format
local floor = floor
local gsub = gsub
local ceil = ceil

T.Print = function(...)
	print("|cffff8000Tukui|r:", ...)
end

-- Want HEX color instead of RGB?
T.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0

	return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

-- Return short value of a number!
T.ShortValue = function(v)
	if (v >= 1e6) then
		return gsub(format("%.1fm", v / 1e6), "%.?0+([km])$", "%1")
	elseif (v >= 1e3 or v <= -1e3) then
		return gsub(format("%.1fk", v / 1e3), "%.?0+([km])$", "%1")
	else
		return v
	end
end

-- Add comma's to a number
T.Comma = function(num)
	local Left, Number, Right = match(num, "^([^%d]*%d)(%d*)(.-)$")

	return 	Left .. reverse(gsub(reverse(Number), "(%d%d%d)", "%1,")) .. Right
end

T.Round = function(number, decimals)
	if (not decimals) then
		decimals = 0
	end

	return format(format("%%.%df", decimals), number)
end

-- Format seconds to min/hour/day
T.FormatTime = function(s)
	if s == Infinity then
		return
	end

	local Day, Hour, Minute = 86400, 3600, 60

	if (s >= Day) then
		return format("%dd", ceil(s / Day))
	elseif (s >= Hour) then
		return format("%dh", ceil(s / Hour))
	elseif (s >= Minute) then
		return format("%dm", ceil(s / Minute))
	elseif (s >= Minute / 12) then
		return ceil(s)
	end

	return format("%.1f", s)
end

-- Icon coordinates template
T.IconCoord = {0.08, 0.92, 0.08, 0.92}

-- Our hider frame
T.Hider:Hide()

-- Our pet hider frame
T.PetHider:SetAllPoints()
T.PetHider:SetFrameStrata("LOW")

RegisterStateDriver(T.PetHider, "visibility", "[petbattle] hide; show")

-- Color Gradient
T.ColorGradient = function(a, b, ...)
	local Percent

	if(b == 0) then
		Percent = 0
	else
		Percent = a / b
	end

	if (Percent >= 1) then
		local R, G, B = select(select("#", ...) - 2, ...)

		return R, G, B
	elseif (Percent <= 0) then
		local R, G, B = ...

		return R, G, B
	end

	local Num = (select("#", ...) / 3)
	local Segment, RelPercent = modf(Percent * (Num - 1))
	local R1, G1, B1, R2, G2, B2 = select((Segment * 3) + 1, ...)

	return R1 + (R2 - R1) * RelPercent, G1 + (G2 - G1) * RelPercent, B1 + (B2 - B1) * RelPercent
end

local TimerParent = CreateFrame("Frame")
T.UnusedTimers = {}

local TimerOnFinished = function(self)
	self.Func(unpack(self.Args))
	tinsert(T.UnusedTimers, self)
end

T.NewTimer = function()
	local Parent = TimerParent:CreateAnimationGroup()
	local Timer = Parent:CreateAnimation("Alpha")

	Timer:SetScript("OnFinished", TimerOnFinished)
	Timer.Parent = Parent

	return Timer
end