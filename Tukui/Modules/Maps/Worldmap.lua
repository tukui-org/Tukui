local T, C, L = select(2, ...):unpack()

local WorldMap = CreateFrame("Frame")

function WorldMap:OnUpdate(elapsed)
	WorldMap.Interval = WorldMap.Interval - elapsed

	if WorldMap.Interval < 0 then
		local UnitMap = C_Map.GetBestMapForUnit("player")
		local X, Y = 0, 0

		if UnitMap then
			local GetPlayerMapPosition = C_Map.GetPlayerMapPosition(UnitMap, "player")

			if GetPlayerMapPosition then
				X, Y = C_Map.GetPlayerMapPosition(UnitMap, "player"):GetXY()
			end
		end

		X = math.floor(100 * X)
		Y = math.floor(100 * Y)

		if X ~= 0 and Y ~= 0 then
			WorldMap.Coords.PlayerText:SetText(PLAYER..":   "..X..", "..Y)
		else
			WorldMap.Coords.PlayerText:SetText(" ")
		end

		WorldMap.Interval = WorldMap.UpdateEveryXSeconds
	end
end

function WorldMap:CreateCoords()
	self.Coords = CreateFrame("Frame", nil, WorldMapFrame)

	self.Coords:SetFrameLevel(90)
	self.Coords:FontString("PlayerText", C.Medias.Font, 12, "THINOUTLINE")
	self.Coords.PlayerText:SetTextColor(1, 1, 1)
	self.Coords.PlayerText:SetPoint("BOTTOMLEFT", WorldMapFrame.BorderFrame, "BOTTOMLEFT", 5, 5)
	self.Coords.PlayerText:SetText("Player:   0, 0")
end

function WorldMap:Enable()
	WorldMap.Interval = 2
	WorldMap.UpdateEveryXSeconds = WorldMap.Interval
	WorldMap:CreateCoords()
	WorldMapFrame:HookScript("OnUpdate", WorldMap.OnUpdate)
end

T["Maps"].Worldmap = WorldMap
