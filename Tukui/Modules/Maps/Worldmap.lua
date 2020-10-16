local T, C, L = select(2, ...):unpack()

local WorldMap = CreateFrame("Frame")
local FadeMap = PlayerMovementFrameFader.AddDeferredFrame
local Scaling

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
		
		if X and Y and X > 0 and Y > 0 then
			WorldMap.Coords.PlayerText:SetFormattedText("%s:   %.2f, %.2f", PLAYER, X * 100, Y * 100)
		else
			WorldMap.Coords.PlayerText:SetText(" ")
		end
		
		-- Mouse Coords
		local MouseX, MouseY = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
		local MouseX, MouseY = MouseX * 100, MouseY * 100

		if MouseX and MouseY and MouseX > 0 and MouseY > 0 and MouseX < 100 and MouseY < 100 then
			WorldMap.Coords.CursorText:SetFormattedText("%s:   %.2f, %.2f", MOUSE_LABEL, MouseX, MouseY)
		else
			WorldMap.Coords.CursorText:SetText(" ")
		end

		WorldMap.Interval = WorldMap.UpdateEveryXSeconds
	end
end

function WorldMap:UpdateMaximizedSize()
	local WorldMapFrame = _G.WorldMapFrame
	local width, height = WorldMapFrame:GetSize()
	local magicNumber = (1 - Scaling) * 100
	
	WorldMapFrame:SetSize((width * Scaling) - (magicNumber + 2), (height * Scaling) - 2)
end

function WorldMap:SynchronizeDisplayState()
	if WorldMapFrame:IsMaximized() then
		local Data = TukuiData[T.MyRealm][T.MyName]
		local A1, P, A2, X, Y = "CENTER", UIParent, "CENTER", 0, 30
		
		if Data.WorldMapPosition then
			A1, P, A2, X, Y = unpack(Data.WorldMapPosition)
		end

		WorldMapFrame:ClearAllPoints()
		WorldMapFrame:SetPoint(A1, P, A2, X, Y)
	end
end

function WorldMap:SetLargeWorldMap()
	local Nav = WorldMapFrame.NavBar
	local Borders = WorldMapFrame.BorderFrame
	local Background = WorldMapFrameBg
	local CloseButton = WorldMapFrameCloseButton
	local MoveButton = WorldMap.MoveButton
	
	WorldMapFrame:SetParent(UIParent)
	WorldMapFrame:SetScale(1)
	WorldMapFrame.ScrollContainer.Child:SetScale(Scaling)

	if WorldMapFrame:GetAttribute("UIPanelLayout-area") ~= "center" then
		SetUIPanelAttribute(WorldMapFrame, "area", "center");
	end

	if WorldMapFrame:GetAttribute("UIPanelLayout-allowOtherPanels") ~= true then
		SetUIPanelAttribute(WorldMapFrame, "allowOtherPanels", true)
	end

	WorldMapFrame:OnFrameSizeChanged()
	
	if WorldMapFrame:GetMapID() then
		WorldMapFrame.NavBar:Refresh()
	end
	
	Nav:Hide()
	
	Borders:SetAlpha(0)
	
	Background:Hide()
	
	CloseButton:Hide()
	
	MoveButton:Show()
end

function WorldMap:SetSmallWorldMap()
	if not WorldMapFrame:IsMaximized() then
		local Nav = WorldMapFrame.NavBar
		local Borders = WorldMapFrame.BorderFrame
		local Background = WorldMapFrameBg
		local CloseButton = WorldMapFrameCloseButton
		local MoveButton = WorldMap.MoveButton
		
		WorldMapFrame:ClearAllPoints()
		WorldMapFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 16, -94)
		
		Nav:Show()
		
		Borders:SetAlpha(1)
		
		Background:Show()
		
		CloseButton:Show()
		
		MoveButton:Hide()
	end
end

function WorldMap:CreateCoords()
	self.Coords = CreateFrame("Frame", nil, WorldMapFrame)
	
	self.Coords:SetFrameLevel(90)
	
	self.Coords.PlayerText = self.Coords:CreateFontString(nil, "OVERLAY")
	self.Coords.PlayerText:SetFontTemplate(C.Medias.Font, 16)
	self.Coords.PlayerText:SetTextColor(1, 1, 1)
	self.Coords.PlayerText:SetPoint("BOTTOMLEFT", WorldMapFrame.BorderFrame, "BOTTOMLEFT", 18, 16)
	self.Coords.PlayerText:SetText("")
	
	self.Coords.CursorText = self.Coords:CreateFontString(nil, "OVERLAY")
	self.Coords.CursorText:SetFontTemplate(C.Medias.Font, 16)
	self.Coords.CursorText:SetTextColor(1, 1, 1)
	self.Coords.CursorText:SetPoint("BOTTOMLEFT", WorldMapFrame.BorderFrame, "BOTTOMLEFT", 18, 34)
	self.Coords.CursorText:SetText("")
end

function WorldMap:SkinOverlayFrames()
	for Index, Button in pairs(WorldMapFrame.overlayFrames) do
		local GetType = type(Button)
		
		if GetType == "table" then
			if Button.Icon then
				local Texture = Button.Icon:GetTexture()
				
				if Texture then
					-- it's a button
					Button.Border:SetAlpha(0)
					Button.Background:SetAlpha(0)
				else
					-- it's a dropdown, and we don't need them
					Button:StripTextures()
					Button.Text:Hide()
					Button.Button:Hide()
				end
			end
		end
	end
end

function WorldMap:SkinMap()
	local Frame = WorldMapFrame
	local Blackout = Frame.BlackoutFrame
	local Scroll = Frame.ScrollContainer
	local Child = Scroll.Child
	local MinimizeButton = WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton
	
	Frame:CreateBackdrop()
	Frame.Backdrop:ClearAllPoints()
	Frame.Backdrop:SetOutside(Child)
	Frame.Backdrop:CreateShadow()
	Frame:EnableMouse(false)
	
	Scroll:EnableMouseWheel(false)

	Blackout:StripTextures()
	Blackout:EnableMouse(false)
	
	MinimizeButton:SetParent(T.Hider)
	
	self:SkinOverlayFrames()
end

function WorldMap:AddMoving()
	WorldMap.MoveButton = CreateFrame("Frame", nil, WorldMapFrame)
	WorldMap.MoveButton:SetSize(16, 16)
	WorldMap.MoveButton:SetPoint("TOPRIGHT", -78, -77)
	WorldMap.MoveButton:SetFrameLevel(WorldMapFrameCloseButton:GetFrameLevel())
	WorldMap.MoveButton:EnableMouse(true)
	WorldMap.MoveButton:RegisterForDrag("LeftButton")
	
    WorldMap.MoveButton.Texture = WorldMap.MoveButton:CreateTexture(nil, "OVERLAY")
    WorldMap.MoveButton.Texture:SetSize(16, 16)
    WorldMap.MoveButton.Texture:SetPoint("CENTER")
	WorldMap.MoveButton.Texture:SetTexture([[Interface\Buttons\UI-RefreshButton]])
	
	--[[ WORKLATER - TAINTING IN COMBAT ]]
	--WorldMap.ExitButton = CreateFrame("Button", nil, WorldMapFrame)
	--WorldMap.ExitButton:SetSize(16, 16)
	--WorldMap.ExitButton:SetPoint("TOPRIGHT", -104, -78)
	--WorldMap.ExitButton:SetFrameLevel(WorldMapFrameCloseButton:GetFrameLevel())
	--WorldMap.ExitButton:SetScript("OnClick", ToggleWorldMap)
	
    --WorldMap.ExitButton.Texture = WorldMap.ExitButton:CreateTexture(nil, "OVERLAY")
    --WorldMap.ExitButton.Texture:SetSize(16, 16)
    --WorldMap.ExitButton.Texture:SetPoint("CENTER")
	--WorldMap.ExitButton.Texture:SetTexture([[Interface\Buttons\UI-SortArrow]])

	WorldMapFrame:SetMovable(true)
	WorldMapFrame:SetUserPlaced(true)

	WorldMap.MoveButton:SetScript("OnDragStart", function(self)
		WorldMapFrame:StartMoving()
	end)

	WorldMap.MoveButton:SetScript("OnDragStop", function(self)
		WorldMapFrame:StopMovingOrSizing()

		local A1, P, A2, X, Y = WorldMapFrame:GetPoint()
		local Data = TukuiData[T.MyRealm][T.MyName]

		Data.WorldMapPosition = {A1, "UIParent", A2, X, Y}
	end)
end

function WorldMap:Enable()
	if not C.Misc.WorldMapEnable then
		return
	end
	
	-- Set Scaling
	Scaling = C.General.WorldMapScale / 100
	
	self:SkinMap()
	self:AddMoving()
	
	WorldMap.Interval = 0.1
	WorldMap.UpdateEveryXSeconds = WorldMap.Interval
	WorldMap:CreateCoords()
	WorldMapFrame:HookScript("OnUpdate", WorldMap.OnUpdate)
	
	WorldMapFrame.BlackoutFrame.Blackout:SetTexture()
	WorldMapFrame.BlackoutFrame:EnableMouse(false)
	
	hooksecurefunc(WorldMapFrame, "Maximize", self.SetLargeWorldMap)
	hooksecurefunc(WorldMapFrame, "Minimize", self.SetSmallWorldMap)
	hooksecurefunc(WorldMapFrame, "SynchronizeDisplayState", self.SynchronizeDisplayState)
	hooksecurefunc(WorldMapFrame, "UpdateMaximizedSize", self.UpdateMaximizedSize)

	-- Always use bigger map on Tukui
	SetCVar("miniWorldMap", 0)
	
	WorldMapFrameButton:Kill()
	
	if WorldMapFrame:IsMaximized() then
		WorldMapFrame:UpdateMaximizedSize()
		WorldMap:SetLargeWorldMap()
	end
end

T["Maps"].Worldmap = WorldMap