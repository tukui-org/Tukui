local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Maps = T["Maps"]
local Interval = 2

Minimap.ZoneColors = {
	["friendly"] = {0.1, 1.0, 0.1},
	["sanctuary"] = {0.41, 0.8, 0.94},
	["arena"] = {1.0, 0.1, 0.1},
	["hostile"] = {1.0, 0.1, 0.1},
	["contested"] = {1.0, 0.7, 0.0},
}

function Minimap:DisableMinimapElements()
	local Time = _G["TimeManagerClockButton"]
	local North = _G["MinimapNorthTag"]
	local HiddenFrames = {
		"MinimapCluster",
		"MinimapBorder",
		"MinimapBorderTop",
		"MinimapZoomIn",
		"MinimapZoomOut",
		"MinimapNorthTag",
		"MinimapZoneTextButton",
		"GameTimeFrame",
		"MiniMapWorldMapButton",
		"GarrisonLandingPageMinimapButton",
	}

	for i, FrameName in pairs(HiddenFrames) do
		local Frame = _G[FrameName]
		Frame:Hide()

		if Frame.UnregisterAllEvents then
			Frame:UnregisterAllEvents()
		end
	end

	North:SetTexture(nil)

	if Time then
		Time:Kill()
	end
end

function Minimap:OnMouseClick(button)
	if (button == "RightButton") or (button == "MiddleButton") then
		Miscellaneous.DropDown.Open(Miscellaneous.MicroMenu.Buttons, Miscellaneous.MicroMenu, "cursor", -160, 0, "MENU", 2)
	else
		Minimap_OnClick(self)
	end
end

function Minimap:StyleMinimap()
	local Mail = MiniMapMailFrame
	local MailBorder = MiniMapMailBorder
	local MailIcon = MiniMapMailIcon
	local QueueStatusMinimapButton = QueueStatusMinimapButton
	local QueueStatusFrame = QueueStatusFrame
	local MiniMapInstanceDifficulty = MiniMapInstanceDifficulty
	local GuildInstanceDifficulty = GuildInstanceDifficulty
	local HelpOpenTicketButton = HelpOpenTicketButton
	local Tracking = MiniMapTrackingButton

	self:SetMaskTexture(C.Medias.Blank)
	self:CreateBackdrop()
	self:SetScript("OnMouseUp", Minimap.OnMouseClick)

	self.Backdrop:SetOutside(Minimap)
	self.Backdrop:SetFrameStrata("BACKGROUND")
	self.Backdrop:SetFrameLevel(2)
	self.Backdrop:CreateShadow()

	self.Ticket = CreateFrame("Frame", nil, Minimap)
	self.Ticket:CreateBackdrop()
	self.Ticket:SetSize(Minimap:GetWidth() + 2, 24)
	self.Ticket:SetFrameLevel(Minimap:GetFrameLevel() + 4)
	self.Ticket:SetFrameStrata(Minimap:GetFrameStrata())
	self.Ticket:SetPoint("BOTTOM", 0, -47)
	self.Ticket.Text = self.Ticket:CreateFontString(nil, "OVERLAY")
	self.Ticket.Text:SetFontTemplate(C.Medias.Font, 12)
	self.Ticket.Text:SetPoint("CENTER")
	self.Ticket.Text:SetText(HELP_TICKET_EDIT)
	self.Ticket:SetAlpha(0)
	self.Ticket:CreateShadow()
	
	QueueStatusMinimapButton:SetParent(Minimap)
	QueueStatusMinimapButton:ClearAllPoints()
	QueueStatusMinimapButton:SetPoint("BOTTOMRIGHT", 0, 0)
	QueueStatusMinimapButtonBorder:Kill()
		 
	QueueStatusFrame:StripTextures()
	QueueStatusFrame:CreateBackdrop()
	QueueStatusFrame:CreateShadow()

	Mail:ClearAllPoints()
	Mail:SetPoint("TOPRIGHT", 12, 29)
	Mail:SetFrameLevel(self:GetFrameLevel() + 2)
	MailBorder:Hide()
	MailIcon:SetTexture("Interface\\AddOns\\Tukui\\Medias\\Textures\\Others\\Mail")
	
	MiniMapInstanceDifficulty:ClearAllPoints()
	MiniMapInstanceDifficulty:SetParent(Minimap)
	MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

	GuildInstanceDifficulty:ClearAllPoints()
	GuildInstanceDifficulty:SetParent(Minimap)
	GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
end

function Minimap:PositionMinimap()
	local Movers = T["Movers"]

	self:SetParent(T.PetHider)
	self:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -28, -28)
	self:SetMovable(true)

	Movers:RegisterFrame(self)
end

function Minimap:AddMinimapDataTexts()
	local Backdrop = self.Backdrop

	local MinimapDataText = CreateFrame("Frame", nil, self)
	MinimapDataText:SetSize(self.Backdrop:GetWidth(), 19)
	MinimapDataText:SetPoint("TOPLEFT", self.Backdrop, "BOTTOMLEFT", 0, 0)
	MinimapDataText:CreateBackdrop()
	MinimapDataText:CreateShadow()

	T.DataTexts.Panels.Minimap = MinimapDataText
end

function GetMinimapShape()
	return "SQUARE"
end

function Minimap:AddZoneAndCoords()
	local MinimapZone = CreateFrame("Button", "TukuiMinimapZone", self)
	local MinimapCoords = CreateFrame("Frame", "TukuiMinimapCoord", self)

	MinimapZone:CreateBackdrop()
	MinimapZone:SetSize(self:GetWidth() + 2, 19)
	MinimapZone:SetPoint("TOP", self, 0, 2)
	MinimapZone:SetFrameStrata(self:GetFrameStrata())
	MinimapZone:SetAlpha(0)
	MinimapZone:EnableMouse()

	MinimapZone.Text = MinimapZone:CreateFontString("TukuiMinimapZoneText", "OVERLAY")
	MinimapZone.Text:SetFont(C["Medias"].Font, 10)
	MinimapZone.Text:SetPoint("TOP", 0, -1)
	MinimapZone.Text:SetPoint("BOTTOM")
	MinimapZone.Text:SetHeight(12)
	MinimapZone.Text:SetWidth(MinimapZone:GetWidth() - 6)

	MinimapZone.Anim = CreateAnimationGroup(MinimapZone):CreateAnimation("Fade")
	MinimapZone.Anim:SetDuration(0.3)
	MinimapZone.Anim:SetEasing("inout")
	MinimapZone.Anim:SetChange(1)

	MinimapCoords:CreateBackdrop()
	MinimapCoords:SetSize(40, 19)
	MinimapCoords:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 2, 2)
	MinimapCoords:SetFrameStrata(self:GetFrameStrata())
	MinimapCoords:SetAlpha(0)

	MinimapCoords.Text = MinimapCoords:CreateFontString("TukuiMinimapCoordText", "OVERLAY")
	MinimapCoords.Text:SetFont(C["Medias"].Font, 10)
	MinimapCoords.Text:SetPoint("Center", 0, -1)
	MinimapCoords.Text:SetText("0, 0")

	MinimapCoords.Anim = CreateAnimationGroup(MinimapCoords):CreateAnimation("Fade")
	MinimapCoords.Anim:SetDuration(0.3)
	MinimapCoords.Anim:SetEasing("inout")
	MinimapCoords.Anim:SetChange(1)

	-- Update zone text
	MinimapZone:RegisterEvent("PLAYER_ENTERING_WORLD")
	MinimapZone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	MinimapZone:RegisterEvent("ZONE_CHANGED")
	MinimapZone:RegisterEvent("ZONE_CHANGED_INDOORS")
	MinimapZone:SetScript("OnEvent", Minimap.UpdateZone)

	-- Update coordinates
	MinimapCoords:SetScript("OnUpdate", Minimap.UpdateCoords)
	
	-- Put tracking button over zone
	MiniMapTracking:Kill()
	MiniMapTrackingButtonBorder:Kill()
	MiniMapTrackingButton:SetParent(MinimapZone)
	MiniMapTrackingButton:ClearAllPoints()
	MiniMapTrackingButton:SetAllPoints()
	MiniMapTrackingButton:StripTextures()

	-- Register
	Minimap.MinimapZone = MinimapZone
	Minimap.MinimapCoords = MinimapCoords
end

function Minimap:UpdateCoords(t)
	if (Minimap.MinimapCoords:GetAlpha() == 0) then
		Interval = 0

		return
	end

	Interval = Interval - t

	if (Interval < 0) then
		local UnitMap = C_Map.GetBestMapForUnit("player")
		local X, Y = 0, 0

		if UnitMap then
			local GetPlayerMapPosition = C_Map.GetPlayerMapPosition(UnitMap, "player")

			if GetPlayerMapPosition then
				X, Y = C_Map.GetPlayerMapPosition(UnitMap, "player"):GetXY()
			end
		end

		local XText, YText

		X = math.floor(100 * X)
		Y = math.floor(100 * Y)

		if (X == 0 and Y == 0) then
			Minimap.MinimapCoords:Hide()
		else
			Minimap.MinimapCoords:Show()

			if (X < 10) then
				XText = "0"..X
			else
				XText = X
			end

			if (Y < 10) then
				YText = "0"..Y
			else
				YText = Y
			end

			Minimap.MinimapCoords.Text:SetText(XText .. ", " .. YText)
		end

		Interval = 2
	end
end

function Minimap:UpdateZone()
	local Info = GetZonePVPInfo()

	if Minimap.ZoneColors[Info] then
		local Color = Minimap.ZoneColors[Info]

		Minimap.MinimapZone.Text:SetTextColor(Color[1], Color[2], Color[3])
	else
		Minimap.MinimapZone.Text:SetTextColor(1.0, 1.0, 1.0)
	end

	Minimap.MinimapZone.Text:SetText(GetMinimapZoneText())
end

function Minimap:EnableMouseOver()
	self:SetScript("OnEnter", function()
		Minimap.MinimapZone.Anim:Stop()
		Minimap.MinimapZone.Anim:SetChange(1)
		Minimap.MinimapZone.Anim:Play()
		
		Minimap.MinimapCoords.Anim:Stop()
		Minimap.MinimapCoords.Anim:SetChange(1)	
		Minimap.MinimapCoords.Anim:Play()
	end)

	self:SetScript("OnLeave", function()
		Minimap.MinimapZone.Anim:Stop()
		Minimap.MinimapZone.Anim:SetChange(0)
		Minimap.MinimapZone.Anim:Play()
		
		Minimap.MinimapCoords.Anim:Stop()
		Minimap.MinimapCoords.Anim:SetChange(0)
		Minimap.MinimapCoords.Anim:Play()
	end)
	
	MiniMapTrackingButton:SetScript("OnEnter", function()
		Minimap.MinimapZone.Anim:Stop()
		Minimap.MinimapZone.Anim:SetChange(1)
		Minimap.MinimapZone.Anim:Play()
		
		Minimap.MinimapCoords.Anim:Stop()
		Minimap.MinimapCoords.Anim:SetChange(1)
		Minimap.MinimapCoords.Anim:Play()
	end)

	MiniMapTrackingButton:SetScript("OnLeave", function()
		Minimap.MinimapZone.Anim:Stop()
		Minimap.MinimapZone.Anim:SetChange(0)
		Minimap.MinimapZone.Anim:Play()
			
		Minimap.MinimapCoords.Anim:Stop()
		Minimap.MinimapCoords.Anim:SetChange(0)
		Minimap.MinimapCoords.Anim:Play()
	end)
end

function Minimap:SizeMinimap()
	local X, Y = self:GetSize()
	local Scale = C.General.MinimapScale / 100

	self:SetSize(X * Scale, Y * Scale)
end

function Minimap:EnableMouseWheelZoom()
	self:EnableMouseWheel(true)
	self:SetScript("OnMouseWheel", function(self, delta)
		if (delta > 0) then
			MinimapZoomIn:Click()
		elseif (delta < 0) then
			MinimapZoomOut:Click()
		end
	end)
end

function Minimap:TaxiExitOnEvent(event)
	if CanExitVehicle() then
		if (UnitOnTaxi("player")) then
			self.Text:SetText("|cffFF0000" .. TAXI_CANCEL .. "|r")
		else
			self.Text:SetText("|cffFF0000" .. BINDING_NAME_VEHICLEEXIT .. "|r")
		end

		self:Show()
	else
		self:Hide()
	end
end

function Minimap:TaxiExitOnClick()
	if (UnitOnTaxi("player")) then
		TaxiRequestEarlyLanding()
	else
		VehicleExit()
	end
	
	Minimap.EarlyExitButton:Hide()
end

function Minimap:AddTaxiEarlyExit()
	Minimap.EarlyExitButton = CreateFrame("Button", nil, self)
	Minimap.EarlyExitButton:SetAllPoints(T.DataTexts.Panels.Minimap)
	Minimap.EarlyExitButton:SetSize(T.DataTexts.Panels.Minimap:GetWidth(), T.DataTexts.Panels.Minimap:GetHeight())
	Minimap.EarlyExitButton:SkinButton()
	Minimap.EarlyExitButton:ClearAllPoints()
	Minimap.EarlyExitButton:SetAllPoints(T.DataTexts.Panels.Minimap)
	Minimap.EarlyExitButton:SetFrameLevel(T.DataTexts.Panels.Minimap:GetFrameLevel() + 2)
	Minimap.EarlyExitButton:RegisterForClicks("AnyUp")
	Minimap.EarlyExitButton:SetScript("OnClick", Minimap.TaxiExitOnClick)
	Minimap.EarlyExitButton:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
	Minimap.EarlyExitButton:RegisterEvent("PLAYER_ENTERING_WORLD")
	Minimap.EarlyExitButton:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	Minimap.EarlyExitButton:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR")
	Minimap.EarlyExitButton:RegisterEvent("UNIT_ENTERED_VEHICLE")
	Minimap.EarlyExitButton:RegisterEvent("UNIT_EXITED_VEHICLE")
	Minimap.EarlyExitButton:RegisterEvent("VEHICLE_UPDATE")
	Minimap.EarlyExitButton:RegisterEvent("PLAYER_ENTERING_WORLD")
	Minimap.EarlyExitButton:SetScript("OnEvent", Minimap.TaxiExitOnEvent)
	Minimap.EarlyExitButton:Hide()

	Minimap.EarlyExitButton.Text = Minimap.EarlyExitButton:CreateFontString(nil, "OVERLAY")
	Minimap.EarlyExitButton.Text:SetFont(C.Medias.Font, 12)
	Minimap.EarlyExitButton.Text:SetPoint("CENTER", 0, 0)
	Minimap.EarlyExitButton.Text:SetShadowOffset(1.25, -1.25)
end

function Minimap:Enable()
	self:DisableMinimapElements()
	self:StyleMinimap()
	self:PositionMinimap()
	self:AddMinimapDataTexts()
	self:AddZoneAndCoords()
	self:EnableMouseOver()
	self:EnableMouseWheelZoom()
	self:AddTaxiEarlyExit()
end

-- Need to be sized as soon as possible, because of LibDBIcon10
Minimap:RegisterEvent("VARIABLES_LOADED")
Minimap:SetScript("OnEvent", function(self, event)
	if event == "VARIABLES_LOADED" then
		self:SizeMinimap()
		self:UnregisterEvent("VARIABLES_LOADED")
	end
end)

T["Maps"].Minimap = Minimap
