local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local tonumber = tonumber
local format = format
local date = date
local Interval = 10
local Timer = 0

local Update = function(self, Elapsed)
	Timer = Timer - Elapsed

	if Timer < 0 then
		local String = C.DataTexts.Hour24 and "%H:%M|r" or "%I:%M|r %p"

		self.Text:SetFormattedText("%s", date(DataText.ValueColor .. String))

		Timer = Interval
	end
end

local Enable = function(self)
	self:SetScript("OnUpdate", Update)
end

local Disable = function(self)
	self:SetScript("OnUpdate", nil)
end

DataText:Register("Time", Enable, Disable, Update)
