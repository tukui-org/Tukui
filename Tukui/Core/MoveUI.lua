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
	if not p then
		p = UIParent
	end
	
	local Data = Movers.Defaults
	local Frame = frame:GetName()

	Data[Frame] = {a1, p:GetName(), a2, x, y}
end

function Movers:RestoreDefaults(button)
	if (self.DragInfo and not self.DragInfo:IsShown()) then 
		local FrameName = self:GetName()
		local Data = Movers.Defaults[FrameName]
		local SavedVariables = TukuiData[GetRealmName()][UnitName("Player")].Move
	
		if (button == "RightButton") and (Data) then
			local Anchor1, ParentName, Anchor2, X, Y = unpack(Data)
			local Frame = _G[FrameName]
			local Parent = _G[ParentName]
		
			Frame:ClearAllPoints()
			Frame:SetPoint(Anchor1, Parent, Anchor2, X, Y)
		
			-- Delete Saved Variable
			SavedVariables[FrameName] = nil
		end
	end
end

function Movers:RegisterFrame(frame)
	tinsert(self.Frames, frame)
	
	frame:HookScript("OnMouseUp", self.RestoreDefaults)
end

function Movers:OnDragStart()
	local Anchor1, Parent, Anchor2, X, Y = self:GetPoint()
	
	self:StartMoving()
	
	Movers:SaveDefaults(self, Anchor1, Parent, Anchor2, X, Y)
end

function Movers:OnDragStop()
	self:StopMovingOrSizing()
	
	local Data = TukuiData[GetRealmName()][UnitName("Player")].Move
	local Anchor1, Parent, Anchor2, X, Y = self:GetPoint()
	local Frame = self:GetName()
	
	if not Parent then
		Parent = UIParent
	end
	
	Data[Frame] = {Anchor1, Parent:GetName(), Anchor2, X, Y}
end

function Movers:CreateDragInfo()
	self.DragInfo = CreateFrame("Frame", nil, self)
	self.DragInfo:SetAllPoints(self)
	self.DragInfo:SetTemplate()
	self.DragInfo:SetBackdropBorderColor(1, 0, 0)
	self.DragInfo:FontString("Text", C.Medias.AltFont, 12)
	self.DragInfo.Text:SetText(self:GetName())
	self.DragInfo.Text:SetPoint("CENTER")
	self.DragInfo.Text:SetTextColor(1, 0, 0)
	self.DragInfo:SetFrameLevel(self:GetFrameLevel() + 100)
	self.DragInfo:SetFrameStrata("HIGH")
	self.DragInfo:Hide()
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
			
			if not Frame:IsMouseEnabled() then
				Frame:EnableMouse(true)
				
				Frame.WasMouseDisabled = true
			end
			
			Frame:SetMovable(true)
			Frame:RegisterForDrag("LeftButton")
			Frame:SetScript("OnDragStart", self.OnDragStart)
			Frame:SetScript("OnDragStop", self.OnDragStop)
			Frame.DragInfo:Show()
			
			if Frame:GetHeight() < 15 then
				Frame.CurrentHeight = Frame:GetHeight()
				Frame:SetHeight(23)
				Frame.OriginalHeight = Frame.SetHeight
				Frame.SetHeight = function() end
			end
		else
			if Frame.unit then
				Frame.unit = Frame.oldunit
				Frame:SetAttribute("unit", Frame.unit)
			end
			
			if Frame.WasMouseDisabled then
				Frame:EnableMouse(false)
				
				Frame.WasMouseDisabled = false
			end

			Frame:SetScript("OnDragStart", nil)
			Frame:SetScript("OnDragStop", nil)
			
			if Frame.DragInfo then
				Frame.DragInfo:Hide()
			end
			
			if Frame.CurrentHeight then
				Frame.SetHeight = Frame.OriginalHeight
				Frame:SetHeight(Frame.CurrentHeight)
				Frame.CurrentHeight = nil
			end
		end		
	end
end

Movers:SetScript("OnEvent", function(self, event)
	if (event == "PLAYER_ENTERING_WORLD") then
		if not TukuiData[GetRealmName()][UnitName("Player")].Move then
			TukuiData[GetRealmName()][UnitName("Player")].Move = {}
		end
	
		local Data = TukuiData[GetRealmName()][UnitName("Player")].Move
	
		for Frame, Position in pairs(Data) do
			local Frame = _G[Frame]
			
			if Frame then
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