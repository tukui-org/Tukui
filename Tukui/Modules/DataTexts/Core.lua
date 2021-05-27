local T, C, L = select(2, ...):unpack()
local DataTexts = T["DataTexts"]
local MinimapDataText

DataTexts.DefaultNumAnchors = 6
DataTexts.NumAnchors = DataTexts.DefaultNumAnchors
DataTexts.DataTexts = {}
DataTexts.Anchors = {}
DataTexts.Menu = {}
DataTexts.Panels = {}
DataTexts.StatusColors = {
	"|cff0CD809",
	"|cffE8DA0F",
	"|cffFF9000",
	"|cffD80909"
}

function DataTexts:AddToMenu(name, data)
	if self["DataTexts"][name] then
		return
	end

	self["DataTexts"][name] = data
	tinsert(self.Menu, {text = name, notCheckable = true, func = self.Toggle, arg1 = data})
end

local RemoveData = function(self)
	if self.Data then
		self.Data.Position = 0
		self.Data:Disable()
	end

	self.Data = nil
end

local SetData = function(self, object)
	-- Disable the old data text in use
	if self.Data then
		RemoveData(self)
	end

	local Panels = T.DataTexts.Panels

	-- Set the new data text
	self.Data = object
	self.Data:Enable()
	self.Data.Text:SetPoint("RIGHT", self, 0, 0)
	self.Data.Text:SetPoint("LEFT", self, 0, 0)
	self.Data.Text:SetPoint("TOP", self, 0, 0)
	self.Data.Text:SetPoint("BOTTOM", self, 0, 0)
	self.Data.Position = self.Num
	self.Data:SetAllPoints(self.Data.Text)

	if (Panels.Left and self.Data.Position >= 1 and self.Data.Position <= 3) then
		self.Data:SetParent(Panels.Left)
	elseif (Panels.Right and self.Data.Position >= 4 and self.Data.Position <= 6) then
		self.Data:SetParent(Panels.Right)
	elseif (Panels.Minimap and self.Data.Position == 7) then
		self.Data:SetParent(Panels.Minimap)
	end
end

function DataTexts:CreateAnchors()
	local DataTextLeft = T.DataTexts.Panels.Left
	local DataTextRight = T.DataTexts.Panels.Right
	local MinimapDataText = T.DataTexts.Panels.Minimap

	if (MinimapDataText) then
		self.NumAnchors = self.NumAnchors + 1
	end

	for i = 1, self.NumAnchors do
		local Frame = CreateFrame("Button", nil, UIParent)
		local DataWidth = (DataTextLeft:GetWidth() / 3) - 1

		if i >= 4 and i <= 6 then
			DataWidth = (DataTextRight:GetWidth() / 3) - 1
		end

		Frame:SetSize(DataWidth, DataTextLeft:GetHeight() - 2)
		Frame:SetFrameLevel(DataTextLeft:GetFrameLevel() + 1)
		Frame:SetFrameStrata("HIGH")
		Frame:EnableMouse(false)
		Frame.SetData = SetData
		Frame.RemoveData = RemoveData
		Frame.Num = i

		Frame.Tex = Frame:CreateTexture()
		Frame.Tex:SetAllPoints()
		Frame.Tex:SetColorTexture(0.2, 1, 0.2, 0)

		self.Anchors[i] = Frame

		if (i == 1) then
			Frame:SetPoint("LEFT", DataTextLeft, 1, 0)
		elseif (i == 4) then
			Frame:SetPoint("LEFT", DataTextRight, 1, 0)
		elseif (i == 7) then
			Frame:SetPoint("CENTER", MinimapDataText, 0, 0)
			Frame:SetSize(MinimapDataText:GetWidth() - 2, MinimapDataText:GetHeight() - 2)
		else
			Frame:SetPoint("LEFT", self.Anchors[i-1], "RIGHT", 1, 0)
		end
	end
end

local GetTooltipAnchor = function(self)
	local Position = self.Position
	local MinimapDataText = T.DataTexts.Panels.Minimap
	local From
	local Anchor = "ANCHOR_TOP"
	local X = 0
	local Y = 15

	if (Position >= 1 and Position <= 3) then
		X = 0
		Anchor = "ANCHOR_TOPLEFT"
		From = T.Chat.Panels.LeftChat
	elseif (Position >=4 and Position <= 6) then
		X = 0
		Anchor = "ANCHOR_TOPRIGHT"
		From = T.Chat.Panels.RightChat
	elseif (Position == 7 and MinimapDataText) then
		Anchor = "ANCHOR_BOTTOM"
		Y = -5
		From = MinimapDataText
	end

	return From, Anchor, X, Y
end

function DataTexts:GetDataText(name)
	return self["DataTexts"][name]
end

local OnEnable = function(self)
	if (not self.FontUpdated) then
		self.Text:SetFontObject(T.GetFont(C["DataTexts"].Font))
		self.FontUpdated = true
	end

	self:Show()
	self.Enabled = true
end

local OnDisable = function(self)
	self:Hide()
	self.Enabled = false
end

function DataTexts:Register(name, enable, disable, update)
	local Data = CreateFrame("Frame", nil, UIParent)
	Data:EnableMouse(true)
	Data:SetFrameStrata("MEDIUM")

	Data.Text = Data:CreateFontString(nil, "OVERLAY")
	Data.Text:SetFontObject(T.GetFont(C["DataTexts"].Font))

	Data.Enabled = false
	Data.GetTooltipAnchor = GetTooltipAnchor
	Data.Enable = enable or function() end
	Data.Disable = disable or function() end
	Data.Update = update or function() end

	hooksecurefunc(Data, "Enable", OnEnable)
	hooksecurefunc(Data, "Disable", OnDisable)

	self:AddToMenu(name, Data)
end

function DataTexts:ForceUpdate()
	for _, data in pairs(self.DataTexts) do
		if data.Enabled then
			data:Update(1)
		end
	end
end

function DataTexts:ResetGold()
	local MyRealm = GetRealmName()
	local MyName = UnitName("player")

	TukuiDatabase.Gold = {}
	TukuiDatabase.Gold[MyRealm] = {}
	TukuiDatabase.Gold[MyRealm][MyName] = GetMoney()
end

function DataTexts:Save()
	if (not TukuiDatabase.Variables[GetRealmName()][UnitName("player")]) then
		TukuiDatabase.Variables[GetRealmName()][UnitName("player")] = {}
	end

	local Data = TukuiDatabase.Variables[GetRealmName()][UnitName("player")]

	for Name, DataText in pairs(self.DataTexts) do
		if DataText.Position then
			Data.DataTexts[Name] = {DataText.Enabled, DataText.Position}
		end
	end
end

function DataTexts:AddDefaults()
	TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts = {}

	TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts["Guild"] = {true, 1}
	TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts["Character"] = {true, 2}
	TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts["Friends"] = {true, 3}
	TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts["System"] = {true, 4}
	TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts["MicroMenu"] = {true, 5}
	TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts["Gold"] = {true, 6}
	TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts["Time"] = {true, 7}
end

function DataTexts:Reset()
	for i = 1, self.NumAnchors do
		RemoveData(self.Anchors[i])
	end

	for _, Data in pairs(self.DataTexts) do
		if Data.Enabled then
			Data:Disable()
		end
	end

	self:AddDefaults()

	if (TukuiDatabase.Variables[GetRealmName()][UnitName("player")] and TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts) then
		for Name, Info in pairs(TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts) do
			local Enabled, Num = Info[1], Info[2]

			if (Enabled and (Num and Num > 0)) then
				local Object = self:GetDataText(Name)

				if Object then
					Object:Enable()
					self.Anchors[Num]:SetData(Object)
				else
					T.Print("DataText '" .. Name .. "' not found. Removing. Replace with [|cff00ff00/tukui dt|r]")
					TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts[Name] = {false, 0}
				end
			end
		end
	end
end

function DataTexts:SetTexts()
	self:CreateAnchors()

	if (TukuiDatabase.Variables[GetRealmName()][UnitName("player")] and TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts) then
		for Name, Info in pairs(TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts) do
			local Enabled, Num = Info[1], Info[2]

			if (Enabled and (Num and Num > 0)) then
				local Object = self:GetDataText(Name)

				if self.Anchors[Num] then
					if Object then
						Object:Enable()
						self.Anchors[Num]:SetData(Object)
					else
						T.Print("DataText '" .. Name .. "' not found. Removing. Replace with [|cff00ff00/tukui dt|r]")
						TukuiDatabase.Variables[GetRealmName()][UnitName("player")].DataTexts[Name] = {false, 0}
					end
				end
			end
		end
	end
end

function DataTexts:Enable()
	local DataTextLeft = CreateFrame("Frame", "TukuiLeftDataTextBox", UIParent)
	DataTextLeft:SetSize(C.Chat.LeftWidth, 23)
	DataTextLeft:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 34, 20)
	DataTextLeft:CreateBackdrop()
	DataTextLeft:SetFrameStrata("BACKGROUND")
	DataTextLeft:SetFrameLevel(2)

	local DataTextRight = CreateFrame("Frame", "TukuiRightDataTextBox", UIParent)
	DataTextRight:SetSize(C.Chat.RightWidth, 23)
	DataTextRight:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -34, 20)
	DataTextRight:CreateBackdrop()
	DataTextRight:SetFrameStrata("BACKGROUND")
	DataTextRight:SetFrameLevel(2)
	
	self.Panels.Left = DataTextLeft
	self.Panels.Right = DataTextRight
	
	self.Font = T.GetFont(C["DataTexts"].Font)
	self.NameColor = (C.DataTexts.ClassColor == true and T.RGBToHex(unpack(T.Colors.class[T.MyClass]))) or (T.RGBToHex(unpack(C["DataTexts"].NameColor)))
	self.ValueColor = (C.DataTexts.ClassColor == true and T.RGBToHex(unpack(T.Colors.class[T.MyClass]))) or (T.RGBToHex(unpack(C["DataTexts"].ValueColor)))
	self.HighlightColor = (T.RGBToHex(unpack(C["DataTexts"].HighlightColor)))
	self:SetTexts()
	self:AddRemove()

	if self.BGFrame then
		self.BGFrame:Enable()
	end
	
	T.Movers:RegisterFrame(DataTextLeft, "Left Data Text & Chat")
	T.Movers:RegisterFrame(DataTextRight, "Right Data Text & Chat")
end

DataTexts:RegisterEvent("PLAYER_LOGOUT")
DataTexts:SetScript("OnEvent", function(self, event)
	self:Save()
end)
