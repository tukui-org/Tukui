local T, C, L = select(2, ...):unpack()

local WorldMap = CreateFrame("Frame")

function WorldMap:OnUpdate(elapsed)
	WorldMap.Interval = WorldMap.Interval - elapsed
	
	if WorldMap.Interval < 0 then
			local InInstance, _ = IsInInstance()
			local X, Y = GetPlayerMapPosition("player")
			
			X = math.floor(100 * X)
			Y = math.floor(100 * Y)
			
			if X ~= 0 and Y ~= 0 then
				WorldMap.Coords.PlayerText:SetText(PLAYER..":   "..X..", "..Y)
			else
				WorldMap.Coords.PlayerText:SetText(" ")
			end
			

			local Scale = WorldMapDetailFrame:GetEffectiveScale()
			local Width = WorldMapDetailFrame:GetWidth()
			local Height = WorldMapDetailFrame:GetHeight()
			local CenterX, CenterY = WorldMapDetailFrame:GetCenter()
			
			X, Y = GetCursorPosition()
			
			local AdjustedX = (X / Scale - (CenterX - (Width / 2))) / Width
			local AdjustedY = (CenterY + (Height / 2 ) - Y / Scale) / Height	

			if (AdjustedX >= 0  and AdjustedY >= 0 and AdjustedX <= 1 and AdjustedY <= 1) then
				AdjustedX = math.floor(100 * AdjustedX)
				AdjustedY = math.floor(100 * AdjustedY)
				
				WorldMap.Coords.MouseText:SetText(MOUSE_LABEL..":   "..AdjustedX..", "..AdjustedY)
			else
				WorldMap.Coords.MouseText:SetText(" ")
			end
		
		WorldMap.Interval = WorldMap.UpdateEveryXSeconds
	end
end

function WorldMap:CreateCoords()
	self.Coords = CreateFrame("Frame", nil, WorldMapFrame)
	
	self.Coords:SetFrameLevel(90)
	self.Coords:FontString("PlayerText", C.Medias.Font, 12, "THINOUTLINE")
	self.Coords:FontString("MouseText", C.Medias.Font, 12, "THINOUTLINE")
	self.Coords.PlayerText:SetTextColor(1, 1, 1)
	self.Coords.MouseText:SetTextColor(1, 1, 1)
	self.Coords.PlayerText:SetPoint("BOTTOMLEFT", WorldMapDetailFrame, "BOTTOMLEFT", 5, 5)
	self.Coords.PlayerText:SetText("Player:   0, 0")
	self.Coords.MouseText:SetPoint("BOTTOMLEFT", self.Coords.PlayerText, "TOPLEFT", 0, 5)
	self.Coords.MouseText:SetText("Mouse:   0, 0")
end

function WorldMap:Enable()
	WorldMap.Interval = 0.2
	WorldMap.UpdateEveryXSeconds = WorldMap.Interval
	WorldMap:CreateCoords()
	WorldMapFrame:HookScript("OnUpdate", WorldMap.OnUpdate)
end

T["Maps"].Worldmap = WorldMap