local T, C, L = select(2, ...):unpack()

local _G = _G
local Miscellaneous = T["Miscellaneous"]
local Maps = T["Maps"]
local Elapsed = 0

Minimap.ZoneColors = {
	["friendly"] = {0.1, 1.0, 0.1},
	["sanctuary"] = {0.41, 0.8, 0.94},
	["arena"] = {1.0, 0.1, 0.1},
	["hostile"] = {1.0, 0.1, 0.1},
	["contested"] = {1.0, 0.7, 0.0},
}

function Minimap:DisableMinimapElements()
	local North = _G["MinimapNorthTag"]
	local HiddenFrames = {
		"MinimapCluster",
		"MinimapBorder",
		"MinimapBorderTop",
		"MinimapZoomIn",
		"MinimapZoomOut",
		"MiniMapVoiceChatFrame",
		"MinimapNorthTag",
		"MinimapZoneTextButton",
		"MiniMapTracking",
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
end

function Minimap:OnMove(enabled)
	if enabled then
		self:SetBackdropBorderColor(1, 0, 0)
		Map:Hide()
	else
		self:SetBackdropBorderColor(unpack(C["General"].BorderColor))
		Map:Show()
	end
end

function Minimap:OnMouseClick(button)
	if (IsShiftKeyDown() and button == "RightButton") or (button == "MiddleButton") then
		EasyMenu(Miscellaneous.MicroMenu.Buttons, Miscellaneous.MicroMenu, "cursor", T.Scale(-160), 0, "MENU", 2)
	elseif (button == "RightButton") then
		ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, self, 0, T.Scale(-3))	
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
	
	self:SetMaskTexture(C.Medias.Blank)
	self:CreateBackdrop()
	self:SetScript("OnMouseUp", Minimap.OnMouseClick)
	
	self.Ticket = CreateFrame("Frame", nil, Minimap)
	self.Ticket:SetTemplate()
	self.Ticket:Size(Minimap:GetWidth() + 4, 24)
	self.Ticket:SetFrameLevel(Minimap:GetFrameLevel() + 4)
	self.Ticket:SetFrameStrata(Minimap:GetFrameStrata())
	self.Ticket:Point("BOTTOM", 0, -47)
	self.Ticket:FontString("Text", C.Medias.Font, 12)
	self.Ticket.Text:SetPoint("CENTER")
	self.Ticket.Text:SetText(HELP_TICKET_EDIT)
	self.Ticket:SetAlpha(0)
	
	Mail:ClearAllPoints()
	Mail:Point("TOPRIGHT", 3, 3)
	Mail:SetFrameLevel(self:GetFrameLevel() + 2)
	MailBorder:Hide()
	MailIcon:SetTexture("Interface\\AddOns\\Tukui\\Medias\\Textures\\mail")
	
	QueueStatusMinimapButton:SetParent(Minimap)
	QueueStatusMinimapButton:ClearAllPoints()
	QueueStatusMinimapButton:SetPoint("BOTTOMRIGHT", 0, 0)
	QueueStatusMinimapButtonBorder:Kill()
	QueueStatusFrame:StripTextures()
	QueueStatusFrame:SetTemplate()

	MiniMapInstanceDifficulty:ClearAllPoints()
	MiniMapInstanceDifficulty:SetParent(Minimap)
	MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
	
	GuildInstanceDifficulty:ClearAllPoints()
	GuildInstanceDifficulty:SetParent(Minimap)
	GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
	
	HelpOpenTicketButton:SetParent(Minimap.Ticket)
	HelpOpenTicketButton:SetFrameLevel(Minimap.Ticket:GetFrameLevel() + 1)
	HelpOpenTicketButton:SetFrameStrata(Minimap.Ticket:GetFrameStrata())
	HelpOpenTicketButton:ClearAllPoints()
	HelpOpenTicketButton:SetAllPoints()
	HelpOpenTicketButton:SetHighlightTexture(nil)
	HelpOpenTicketButton:SetAlpha(0)
	HelpOpenTicketButton:HookScript("OnShow", function(self) Minimap.Ticket:SetAlpha(1) end)
	HelpOpenTicketButton:HookScript("OnHide", function(self) Minimap.Ticket:SetAlpha(0) end)
end

function Minimap:PositionMinimap()
	local Movers = T["Movers"]
	
	self:SetParent(T["Panels"].PetBattleHider)
	self:Point("TOPRIGHT", UIParent, "TOPRIGHT", -30, -30)
	self:SetMovable(true)
	
	Movers:RegisterFrame(self)
end

function Minimap:AddMinimapDataTexts()
	local Panels = T["Panels"]

	local MinimapDataTextOne = CreateFrame("Frame", nil, self)
	MinimapDataTextOne:Size(self:GetWidth() / 2 + 2, 19)
	MinimapDataTextOne:SetPoint("TOPLEFT", self, "BOTTOMLEFT", -2, -3)
	MinimapDataTextOne:SetTemplate()
	MinimapDataTextOne:SetFrameStrata("LOW")
	
	local MinimapDataTextTwo = CreateFrame("Frame", nil, self)
	MinimapDataTextTwo:Size(self:GetWidth() / 2 + 1, 19)
	MinimapDataTextTwo:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 2, -3)
	MinimapDataTextTwo:SetTemplate()
	MinimapDataTextTwo:SetFrameStrata("LOW")
	
	Panels.MinimapDataTextOne = MinimapDataTextOne
	Panels.MinimapDataTextTwo = MinimapDataTextTwo
end

function GetMinimapShape() 
	return "SQUARE"
end

function Minimap:AddZoneAndCoords()
	local MinimapZone = CreateFrame("Frame", "TukuiMinimapZone", self)
	MinimapZone:SetTemplate()
	MinimapZone:Size(self:GetWidth() + 4, 22)
	MinimapZone:Point("TOP", self, 0, 2)
	MinimapZone:SetFrameStrata(self:GetFrameStrata())
	MinimapZone:SetAlpha(0)
	
	MinimapZone.Text = MinimapZone:CreateFontString("TukuiMinimapZoneText", "OVERLAY")
	MinimapZone.Text:SetFont(C["Medias"].Font, 12)
	MinimapZone.Text:Point("TOP", 0, -1)
	MinimapZone.Text:SetPoint("BOTTOM")
	MinimapZone.Text:Height(12)
	MinimapZone.Text:Width(MinimapZone:GetWidth() - 6)
	
	local MinimapCoords = CreateFrame("Frame", "TukuiMinimapCoord", self)
	MinimapCoords:SetTemplate()
	MinimapCoords:Size(40, 22)
	MinimapCoords:Point("BOTTOMLEFT", self, "BOTTOMLEFT", 2, 2)
	MinimapCoords:SetFrameStrata(self:GetFrameStrata())
	MinimapCoords:SetAlpha(0)
	
	MinimapCoords.Text = MinimapCoords:CreateFontString("TukuiMinimapCoordText", "OVERLAY")
	MinimapCoords.Text:SetFont(C["Medias"].Font, 12)
	MinimapCoords.Text:Point("Center", 0, -1)
	MinimapCoords.Text:SetText("0, 0")
	
	-- Update zone text
	MinimapZone:RegisterEvent("PLAYER_ENTERING_WORLD")
	MinimapZone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	MinimapZone:RegisterEvent("ZONE_CHANGED")
	MinimapZone:RegisterEvent("ZONE_CHANGED_INDOORS")
	MinimapZone:SetScript("OnEvent", Minimap.UpdateZone)
	
	-- Update coordinates
	MinimapCoords:SetScript("OnUpdate", Minimap.UpdateCoords)
	
	Minimap.MinimapZone = MinimapZone
	Minimap.MinimapCoords = MinimapCoords
end

function Minimap:UpdateCoords(t)
	Elapsed = Elapsed - t
	
	if (Elapsed > 0) then
		return
	end
	
	local X, Y = GetPlayerMapPosition("player")
	local XText, YText
	
	X = math.floor(100 * X)
	Y = math.floor(100 * Y)
	
	if (X == 0 and Y == 0) then
		Minimap.MinimapCoords.Text:SetText("x, x")
	else
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
	
	Elapsed = 0.5
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
		Minimap.MinimapZone:SetAnimation("FadeIn", 0.3)
		Minimap.MinimapCoords:SetAnimation("FadeIn", 0.3)
	end)

	self:SetScript("OnLeave", function()
		Minimap.MinimapZone:SetAnimation("FadeOut", 0.3)
		Minimap.MinimapCoords:SetAnimation("FadeOut", 0.3)
	end)
end

function Minimap:Enable()
	local Time = _G["TimeManagerClockButton"]
	
	self:DisableMinimapElements()
	self:StyleMinimap()
	self:PositionMinimap()
	self:AddMinimapDataTexts()
	self:AddZoneAndCoords()
	self:EnableMouseOver()
	
	-- Fix a Blizzard Bug, which mouse wheel zoom was not working.
	self:EnableMouseWheel(true)
	self:SetScript("OnMouseWheel", function(self, delta)
		if (delta > 0) then
			MinimapZoomIn:Click()
		elseif (delta < 0) then
			MinimapZoomOut:Click()
		end
	end)
	
	if Time then
		Time:Kill()
	end
end

T["Maps"].Minimap = Minimap
