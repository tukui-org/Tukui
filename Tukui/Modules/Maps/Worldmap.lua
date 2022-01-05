local T, C, L = select(2, ...):unpack()

local WorldMap = CreateFrame("Frame")
local WorldMapFrame = WorldMapFrame
local FadeMap = PlayerMovementFrameFader.AddDeferredFrame
local Scaling

if T.Retail then
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
			local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]
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

		Nav:Hide()

		Borders:SetAlpha(0)

		Background:Hide()

		MoveButton:Show()

		CloseButton:ClearAllPoints()
		CloseButton:SetPoint("TOPLEFT", 4, -68)
		CloseButton.Backdrop:Show()
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

			MoveButton:Hide()

			CloseButton:ClearAllPoints()
			CloseButton:SetPoint("TOPRIGHT", 5, 5)
			CloseButton.Backdrop:Hide()
		end
	end

	function WorldMap:CreateCoords()
		self.Coords = CreateFrame("Frame", nil, WorldMapFrame)

		self.Coords:SetFrameLevel(90)

		self.Coords.PlayerText = self.Coords:CreateFontString(nil, "OVERLAY")
		self.Coords.PlayerText:SetFontTemplate(C.Medias.Font, 16)
		self.Coords.PlayerText:SetTextColor(1, 1, 1)
		self.Coords.PlayerText:SetPoint("BOTTOMRIGHT", WorldMapFrame.BorderFrame, "BOTTOMRIGHT", -18, 16)
		self.Coords.PlayerText:SetText("")

		self.Coords.CursorText = self.Coords:CreateFontString(nil, "OVERLAY")
		self.Coords.CursorText:SetFontTemplate(C.Medias.Font, 16)
		self.Coords.CursorText:SetTextColor(1, 1, 1)
		self.Coords.CursorText:SetPoint("BOTTOMRIGHT", WorldMapFrame.BorderFrame, "BOTTOMRIGHT", -18, 34)
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
		Frame.Backdrop:SetPoint("LEFT", 1, 0)
		Frame.Backdrop:SetPoint("RIGHT", -2, 0)
		Frame.Backdrop:SetPoint("TOP", 0, -66)
		Frame.Backdrop:SetPoint("BOTTOM")
		Frame.Backdrop:CreateShadow()
		Frame:EnableMouse(false)

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

		WorldMapFrame:SetMovable(true)
		WorldMapFrame:SetUserPlaced(true)

		WorldMap.MoveButton:SetScript("OnDragStart", function(self)
			WorldMapFrame:StartMoving()
		end)

		WorldMap.MoveButton:SetScript("OnDragStop", function(self)
			WorldMapFrame:StopMovingOrSizing()

			local A1, P, A2, X, Y = WorldMapFrame:GetPoint()
			local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]

			Data.WorldMapPosition = {A1, "UIParent", A2, X, Y}
		end)
	end

	function WorldMap:UpdateMapFading()
		FadeMap(WorldMapFrame, C.Misc.FadeWorldMapAlpha / 100)
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

		WorldMapFrameCloseButton:SetParent(WorldMapFrame)
		WorldMapFrameCloseButton:SetFrameStrata(self.MoveButton:GetFrameStrata())
		WorldMapFrameCloseButton:SetFrameLevel(self.MoveButton:GetFrameLevel())

		WorldMapFrameCloseButton:CreateBackdrop()
		WorldMapFrameCloseButton.Backdrop:SetInside(WorldMapFrameCloseButton, 6, 6)
		WorldMapFrameCloseButton.Backdrop:CreateShadow()
		WorldMapFrameCloseButton.Backdrop:SetFrameLevel(WorldMapFrameCloseButton:GetFrameLevel() + 1)
		WorldMapFrameCloseButton.Backdrop.Texture = WorldMapFrameCloseButton.Backdrop:CreateTexture(nil, "OVERLAY")
		WorldMapFrameCloseButton.Backdrop.Texture:SetSize(12, 12)
		WorldMapFrameCloseButton.Backdrop.Texture:SetPoint("CENTER")
		WorldMapFrameCloseButton.Backdrop.Texture:SetTexture(C.Medias.Close)

		hooksecurefunc(WorldMapFrame, "Maximize", self.SetLargeWorldMap)
		hooksecurefunc(WorldMapFrame, "Minimize", self.SetSmallWorldMap)
		hooksecurefunc(WorldMapFrame, "SynchronizeDisplayState", self.SynchronizeDisplayState)
		hooksecurefunc(WorldMapFrame, "UpdateMaximizedSize", self.UpdateMaximizedSize)
		hooksecurefunc(PlayerMovementFrameFader, "AddDeferredFrame", self.UpdateMapFading)

		-- Always use bigger map on Tukui
		SetCVar("miniWorldMap", 0)

		WorldMapFrameButton:Kill()

		if WorldMapFrame:IsMaximized() then
			WorldMapFrame:UpdateMaximizedSize()
			WorldMap:SetLargeWorldMap()
		end
	end
else
	function WorldMap:OnUpdate(elapsed)
		if not WorldMapFrame:IsShown() then
			return
		end

		WorldMap.Interval = WorldMap.Interval - elapsed

		if WorldMap.Interval < 0 then
			local UnitMap = C_Map.GetBestMapForUnit("player")
			local X, Y = 0, 0
			local MouseX, MouseY = GetCursorPosition()

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

			-- Mouse Coords
			local Scale = WorldMapFrame:GetCanvas():GetEffectiveScale()
			MouseX = MouseX / Scale
			MouseY = MouseY / Scale

			local Width = WorldMapFrame:GetCanvas():GetWidth()
			local Height = WorldMapFrame:GetCanvas():GetHeight()
			local Left = WorldMapFrame:GetCanvas():GetLeft()
			local Top = WorldMapFrame:GetCanvas():GetTop()

			MouseX = math.floor((MouseX - Left) / Width * 100)
			MouseY = math.floor((Top - MouseY) / Height * 100)

			if MouseX ~= 0 and MouseY ~= 0 then
				WorldMap.Coords.CursorText:SetText(MOUSE_LABEL..":   "..MouseX..", "..MouseY)
			else
				WorldMap.Coords.CursorText:SetText(" ")
			end

			WorldMap.Interval = 0.1
		end
	end

	function WorldMap:CreateCoords()
		local Map = WorldMapFrame.ScrollContainer.Child

		self.Coords = CreateFrame("Frame", nil, WorldMapFrame)
		self.Coords:SetFrameLevel(90)
		self.Coords.PlayerText = self.Coords:CreateFontString(nil, "OVERLAY")
		self.Coords.PlayerText:SetFontTemplate(C.Medias.Font, 16)
		self.Coords.PlayerText:SetTextColor(1, 1, 1)
		self.Coords.PlayerText:SetPoint("BOTTOMLEFT", Map, "BOTTOMLEFT", 5, 5)
		self.Coords.PlayerText:SetText("")
		self.Coords.CursorText = self.Coords:CreateFontString(nil, "OVERLAY")
		self.Coords.CursorText:SetFontTemplate(C.Medias.Font, 16)
		self.Coords.CursorText:SetTextColor(1, 1, 1)
		self.Coords.CursorText:SetPoint("BOTTOMRIGHT", Map, "BOTTOMRIGHT", -5, 5)
		self.Coords.CursorText:SetText("")
	end

	function WorldMap:Questie()
		-- For Questie addon lovers
		local QuestieToggle = Questie_Toggle

		if QuestieToggle then
			-- Always hide minimap button, use /questie instead
			Questie.db.profile.minimap.hide = true

			-- Hide original toggle button
			Questie_Toggle:SetParent(T.Hider)

			-- Create our own button
			self.QuestButton = CreateFrame("Button", nil, WorldMapFrame)
			self.QuestButton:SetSize(18, 18)
			self.QuestButton:SetPoint("TOPRIGHT", -62, -79)
			self.QuestButton:SetFrameLevel(WorldMapFrameCloseButton:GetFrameLevel())
			self.QuestButton:SetScript("OnLeave", GameTooltip_Hide)

			self.QuestButton:SetScript("OnClick", function(self, button)
				QuestieToggle:Click()
			end)

			self.QuestButton:SetScript("OnEnter", function(self) 
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -1, 5)
				GameTooltip:AddLine("Toggle Questie")
				GameTooltip:Show()
			end)

			self.QuestButton.Texture = self.QuestButton:CreateTexture(nil, "OVERLAY")
			self.QuestButton.Texture:SetSize(18, 18)
			self.QuestButton.Texture:SetPoint("CENTER")
			self.QuestButton.Texture:SetTexture([[Interface\MINIMAP\TRACKING\QuestBlob]])
		end
	end

	function WorldMap:SkinMap()
		local Frame = WorldMapFrame
		local Blackout = Frame.BlackoutFrame
		local Borders = Frame.BorderFrame
		local Map = Frame.ScrollContainer.Child
		local CloseButton = WorldMapFrameCloseButton
		local ContinentButton = WorldMapContinentDropDown
		local ZoneButton = WorldMapZoneDropDown
		local ZoneMinimapButton = WorldMapZoneMinimapDropDown
		local ZoonButton = WorldMapZoomOutButton
		local MagnifyButton = WorldMapMagnifyingGlassButton
		local QuestieToggleQuest = Questie_Toggle

		Frame:CreateBackdrop()
		Frame.Backdrop:ClearAllPoints()
		Frame.Backdrop:SetAllPoints(Map)
		Frame.Backdrop:CreateShadow()
		Frame:EnableMouse(false)

		Blackout:StripTextures()
		Blackout:EnableMouse(false)

		Borders:SetAlpha(0)

		ContinentButton:SetParent(T.Hider)

		ZoneButton:SetParent(T.Hider)

		ZoneMinimapButton:SetParent(T.Hider)

		WorldMapZoomOutButton:SetParent(T.Hider)

		MagnifyButton:SetParent(T.Hider)

		CloseButton:StripTextures()
		CloseButton:ClearAllPoints()
		CloseButton:SetPoint("TOPRIGHT", -10, -72)
		CloseButton:SetFrameStrata("FULLSCREEN")
		CloseButton:SetFrameLevel(Map:GetFrameLevel() + 1)
		CloseButton:SkinCloseButton()
	end

	function WorldMap:SizeMap()
		local Scale = C.General.WorldMapScale / 100

		WorldMapFrame:SetScale(Scale)

		WorldMapFrame.ScrollContainer.GetCursorPosition = function(self)
		   local X, Y = MapCanvasScrollControllerMixin.GetCursorPosition(self)
		   local Scale = WorldMapFrame:GetScale()

		   return X / Scale, Y / Scale
		end
	end

	function WorldMap:AddMoving()
		self.MoveButton = CreateFrame("Frame", nil, WorldMapFrame)
		self.MoveButton:SetSize(18, 18)
		self.MoveButton:SetPoint("TOPRIGHT", -40, -80)
		self.MoveButton:SetFrameLevel(WorldMapFrameCloseButton:GetFrameLevel())
		self.MoveButton:EnableMouse(true)
		self.MoveButton:RegisterForDrag("LeftButton")
		self.MoveButton:SetScript("OnLeave", GameTooltip_Hide)
		self.MoveButton:SetScript("OnEnter", function(self) 
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -1, 5)
			GameTooltip:AddLine(CLICK_TO_MOVE)
			GameTooltip:Show()
		end)

		self.MoveButton.Texture = self.MoveButton:CreateTexture(nil, "OVERLAY")
		self.MoveButton.Texture:SetSize(18, 18)
		self.MoveButton.Texture:SetPoint("CENTER")
		self.MoveButton.Texture:SetTexture([[Interface\MINIMAP\TRACKING\Innkeeper]])

		self.MoveButton:SetScript("OnDragStart", function(self)
			WorldMapFrame:StartMoving()
		end)

		self.MoveButton:SetScript("OnDragStop", function(self)
			WorldMapFrame:StopMovingOrSizing()

			local A1, P, A2, X, Y = WorldMapFrame:GetPoint()
			local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]

			Data.WorldMapPosition = {A1, "UIParent", A2, X, Y}
		end)

		WorldMapFrame:SetMovable(true)
		WorldMapFrame:SetUserPlaced(true)

		WorldMapFrame.ClearAllPoints = function() end
		WorldMapFrame.SetPoint = function() end
	end

	function WorldMap:AddFading()
		FadeMap(WorldMapFrame, C.Misc.FadeWorldMapAlpha / 100)
	end

	function WorldMap:Enable()
		if not C.Misc.WorldMapEnable then
			return
		end

		local Data = TukuiDatabase.Variables[T.MyRealm][T.MyName]

		if Data.WorldMapPosition then
			WorldMapFrame:SetPoint(unpack(Data.WorldMapPosition))
		end

		self.Interval = 0.1
		self:CreateCoords()
		self:HookScript("OnUpdate", WorldMap.OnUpdate)
		self:SkinMap()
		self:SizeMap()
		self:AddMoving()
		self:Questie()

		if C.Misc.FadeWorldMapAlpha < 100 then
			self:AddFading()
		end

		UIPanelWindows["WorldMapFrame"] = nil
		WorldMapFrame:SetAttribute("UIPanelLayout-area", nil)
		WorldMapFrame:SetAttribute("UIPanelLayout-enabled", false)

		tinsert(UISpecialFrames, "WorldMapFrame")
	end
end

T["Maps"].Worldmap = WorldMap
