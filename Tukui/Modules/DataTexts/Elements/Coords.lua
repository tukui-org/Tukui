local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local tonumber = tonumber
local format = format
local date = date
local Interval = 1
local Timer = 0

local Update = function(self, Elapsed)
	Timer = Timer - Elapsed

	if Timer < 0 then
		local UnitMap = C_Map.GetBestMapForUnit("player")
		local X, Y = 0, 0

		if UnitMap then
			local GetPlayerMapPosition = C_Map.GetPlayerMapPosition(UnitMap, "player")

			if GetPlayerMapPosition then
				X, Y = C_Map.GetPlayerMapPosition(UnitMap, "player"):GetXY()
			end
		end

		if X == 0 and Y == 0 then
			local Name = GetInstanceInfo()

			self.Text:SetText(DataText.ValueColor..Name.."|r")
		else
			X = 100 * math.floor(X * 10000) / 10000
			Y = 100 * math.floor(Y * 10000) / 10000

			self.Text:SetText(DataText.ValueColor..X..", |r"..DataText.ValueColor..Y.."|r")
		end

		Timer = Interval
	end
end

local Enable = function(self)
	self:SetScript("OnUpdate", Update)
end

local Disable = function(self)
	self:SetScript("OnUpdate", nil)
end

DataText:Register("Coords", Enable, Disable, Update)
