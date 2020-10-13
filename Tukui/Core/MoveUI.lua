local T, C, L = select(2, ...):unpack()

-- Register a frame with: Movers:RegisterFrame(FrameName)
-- Note 1: Registered Frames need a Global name
-- Note 2: Drag values is saved in Tukui Saved Variables.

local Movers = CreateFrame("Frame")
Movers:RegisterEvent("PLAYER_ENTERING_WORLD")
Movers:RegisterEvent("PLAYER_REGEN_DISABLED")

Movers.Frames = {}
Movers.Defaults = {}

function Movers:SaveDefaults(frame, a1, p, a2, x, y)
	if not a1 then
		return
	end

	if not p then
		p = UIParent
	end

	local Data = Movers.Defaults
	local Frame = frame:GetName()

	Data[Frame] = {a1, p:GetName(), a2, x, y}
end

function Movers:RestoreDefaults(button)
	local FrameName = self.Parent:GetName()
	local Data = Movers.Defaults[FrameName]
	local SavedVariables = TukuiData[T.MyRealm][T.MyName].Move

	if (button == "RightButton") and (Data) then
		local Anchor1, ParentName, Anchor2, X, Y = unpack(Data)
		local Frame = _G[FrameName]
		local Parent = _G[ParentName]

		if not Parent then
			Parent = UIParent
		end

		Frame:ClearAllPoints()
		Frame:SetPoint(Anchor1, Parent, Anchor2, X, Y)

		Frame.DragInfo:ClearAllPoints()
		Frame.DragInfo:SetAllPoints(Frame)

		-- Delete Saved Variable
		SavedVariables[FrameName] = nil
	end
end

function Movers:RegisterFrame(frame)
	local Anchor1, Parent, Anchor2, X, Y = frame:GetPoint()

	tinsert(self.Frames, frame)

	self:SaveDefaults(frame, Anchor1, Parent, Anchor2, X, Y)
end

function Movers:OnDragFollowMe()
	local Anchor1, Parent, Anchor2, X, Y = self:GetPoint()

	if not Parent then
		Parent = UIParent
	end
	
	self.Parent:ClearAllPoints()
	self.Parent:SetPoint(Anchor1, Parent, Anchor2, X, Y)
end

function Movers:OnDragStart()
	GameTooltip_Hide()

	self:SetScript("OnUpdate", Movers.OnDragFollowMe)
	self:StartMoving()
end

function Movers:OnDragStop()
	self:StopMovingOrSizing()
	self:SetScript("OnUpdate", nil)

	local Data = TukuiData[T.MyRealm][T.MyName].Move
	local Anchor1, Parent, Anchor2, X, Y = self:GetPoint()
	local FrameName = self.Parent:GetName()
	local Frame = self.Parent
	
	if not Parent then
		Parent = UIParent
	end

	Frame:ClearAllPoints()
	Frame:SetPoint(Anchor1, Parent, Anchor2, X, Y)

	Data[FrameName] = {Anchor1, Parent:GetName(), Anchor2, X, Y}

	Movers:OnEnter()
end

function Movers:OnEnter()
	GameTooltip:SetOwner(self)
	GameTooltip:SetAnchorType("ANCHOR_CURSOR")
	GameTooltip:AddLine("Hold left click to drag") -- LOCALIZE ME PLZ
	GameTooltip:AddLine("Right click to reset default") -- LOCALIZE ME PLZ
	GameTooltip:Show()
end

function Movers:OnLeave()
	GameTooltip_Hide()
end

function Movers:CreateDragInfo()
	self.DragInfo = CreateFrame("Button", nil, self)
	self.DragInfo:SetAllPoints(self)
	self.DragInfo:CreateBackdrop()
	self.DragInfo.Backdrop:SetBorderColor(0, 1, 0)
	self.DragInfo.Backdrop:SetBackdropColor(0, 1, 0, .2)
	self.DragInfo.Text = self.DragInfo:CreateFontString(nil, "OVERLAY")
	self.DragInfo.Text:SetFontTemplate(C.Medias.UnitFrameFont, 16)
	self.DragInfo.Text:SetText(self:GetName())
	self.DragInfo.Text:SetPoint("CENTER")
	self.DragInfo.Text:SetTextColor(1, 0, 0)
	self.DragInfo:SetFrameLevel(100)
	self.DragInfo:SetFrameStrata("HIGH")
	self.DragInfo:SetMovable(true)
	self.DragInfo:RegisterForDrag("LeftButton")
	self.DragInfo:SetClampedToScreen(true)
	self.DragInfo:Hide()
	self.DragInfo:SetScript("OnMouseUp", Movers.RestoreDefaults)
	self.DragInfo:SetScript("OnEnter", Movers.OnEnter)
	self.DragInfo:SetScript("OnLeave", Movers.OnLeave)

	self.DragInfo.Parent = self.DragInfo:GetParent()
end

function Movers:StartOrStopMoving()
	if InCombatLockdown() then
		return T.Print(ERR_NOT_IN_COMBAT)
	end

	if not self.IsEnabled then
		self.IsEnabled = true
	else
		self.IsEnabled = false
	end

	for i = 1, #self.Frames do
		local Frame = Movers.Frames[i]

		if self.IsEnabled then
			if not Frame.DragInfo then
				self.CreateDragInfo(Frame)
			end

			if Frame.unit then
				Frame.oldunit = Frame.unit
				Frame.unit = "player"
				Frame:SetAttribute("unit", "player")
			end

			Frame.DragInfo:SetScript("OnDragStart", self.OnDragStart)
			Frame.DragInfo:SetScript("OnDragStop", self.OnDragStop)
			Frame.DragInfo:SetParent(UIParent)
			Frame.DragInfo:Show()

			if Frame.DragInfo:GetFrameLevel() ~= 100 then
				Frame.DragInfo:SetFrameLevel(100)
			end

			if Frame.DragInfo:GetFrameStrata() ~= "HIGH" then
				Frame.DragInfo:SetFrameStrata("HIGH")
			end

			if Frame.DragInfo:GetHeight() < 15 then
				Frame.DragInfo:ClearAllPoints()
				Frame.DragInfo:SetWidth(Frame:GetWidth())
				Frame.DragInfo:SetHeight(23)
				Frame.DragInfo:SetPoint("TOP", Frame)
			end
		else
			if Frame.unit then
				Frame.unit = Frame.oldunit
				Frame:SetAttribute("unit", Frame.unit)
			end

			if Frame.DragInfo then
				Frame.DragInfo:SetParent(Frame.DragInfo.Parent)
				Frame.DragInfo:Hide()
				Frame.DragInfo:SetScript("OnDragStart", nil)
				Frame.DragInfo:SetScript("OnDragStop", nil)

				if Frame.DragInfo.CurrentHeight then
					Frame.DragInfo:ClearAllPoints()
					Frame.DragInfo:SetAllPoints(Frame)
				end
			end
		end
	end
end

function Movers:IsRegisteredFrame(frame)
	local Match = false

	for i = 1, #self.Frames do
		if self.Frames[i] == frame then
			Match = true
		end
	end

	return Match
end

Movers:SetScript("OnEvent", function(self, event)
	if (event == "PLAYER_ENTERING_WORLD") then
		T.VerifyDataTable()
			
		local Data = TukuiData[T.MyRealm][T.MyName].Move

		for Frame, Position in pairs(Data) do
			local Frame = _G[Frame]
			local IsRegistered = self:IsRegisteredFrame(Frame)

			if Frame and IsRegistered then
				local Anchor1, Parent, Anchor2, X, Y = Frame:GetPoint()

				self:SaveDefaults(Frame, Anchor1, Parent, Anchor2, X, Y)

				Anchor1, Parent, Anchor2, X, Y = unpack(Position)

				Frame:ClearAllPoints()
				Frame:SetPoint(Anchor1, _G[Parent], Anchor2, X, Y)
			end
		end
	elseif (event == "PLAYER_REGEN_DISABLED") then
		if self.IsEnabled then
			self:StartOrStopMoving()
		end
	end
end)

T["Movers"] = Movers
