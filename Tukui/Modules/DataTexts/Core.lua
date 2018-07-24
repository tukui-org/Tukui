local T, C, L = select(2, ...):unpack()

local pairs = pairs
local unpack = unpack
local CreateFrame = CreateFrame
local TukuiDT = CreateFrame("Frame")

local DataTextLeft
local DataTextRight
local MinimapDataText

TukuiDT.DefaultNumAnchors = 6
TukuiDT.NumAnchors = TukuiDT.DefaultNumAnchors
TukuiDT.Texts = {}
TukuiDT.Anchors = {}
TukuiDT.Menu = {}

function TukuiDT:AddToMenu(name, data)
	if self["Texts"][name] then
		return
	end

	self["Texts"][name] = data
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

	local Panels = T["Panels"]

	-- Set the new data text
	self.Data = object
	self.Data:Enable()
	self.Data.Text:Point("RIGHT", self, 0, 0)
	self.Data.Text:Point("LEFT", self, 0, 0)
	self.Data.Text:Point("TOP", self, 0, -1)
	self.Data.Text:Point("BOTTOM", self, 0, -1)
	self.Data.Position = self.Num
	self.Data:SetAllPoints(self.Data.Text)

	if (Panels.DataTextLeft and self.Data.Position >= 1 and self.Data.Position <= 3) then
		self.Data:SetParent(Panels.DataTextLeft)
	elseif (Panels.DataTextRight and self.Data.Position >= 4 and self.Data.Position <= 6) then
		self.Data:SetParent(Panels.DataTextRight)
	elseif (Panels.MinimapDataText and self.Data.Position == 7) then
		self.Data:SetParent(Panels.MinimapDataText)
	end
end

function TukuiDT:CreateAnchors()
	local Panels = T["Panels"]
	DataTextLeft = Panels.DataTextLeft
	DataTextRight = Panels.DataTextRight
	MinimapDataText = Panels.MinimapDataText

	if (MinimapDataText) then
		self.NumAnchors = self.NumAnchors + 1
	end

	for i = 1, self.NumAnchors do
		local Frame = CreateFrame("Button", nil, UIParent)
		Frame:Size((DataTextLeft:GetWidth() / 3) - 1, DataTextLeft:GetHeight() - 2)
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
			Frame:Point("LEFT", DataTextLeft, 1, 0)
		elseif (i == 4) then
			Frame:Point("LEFT", DataTextRight, 1, 0)
		elseif (i == 7) then
			Frame:Point("CENTER", MinimapDataText, 0, 0)
			Frame:Size(MinimapDataText:GetWidth() - 2, MinimapDataText:GetHeight() - 2)
		else
			Frame:Point("LEFT", self.Anchors[i-1], "RIGHT", 1, 0)
		end
	end
end

local GetTooltipAnchor = function(self)
	local Position = self.Position
	local From
	local Anchor = "ANCHOR_TOP"
	local X = 0
	local Y = T.Scale(16)

	if (Position >= 1 and Position <= 3) then
		X = -1
		Anchor = "ANCHOR_TOPLEFT"
		From = T.Panels.LeftChatBG
	elseif (Position >=4 and Position <= 6) then
		X = 1
		Anchor = "ANCHOR_TOPRIGHT"
		From = T.Panels.RightChatBG
	elseif (Position == 7 and MinimapDataText) then
		Anchor = "ANCHOR_BOTTOMLEFT"
		Y = T.Scale(-5)
		From = MinimapDataText
	end

	return From, Anchor, X, Y
end

function TukuiDT:GetDataText(name)
	return self["Texts"][name]
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

function TukuiDT:Register(name, enable, disable, update)
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

function TukuiDT:ForceUpdate()
	for _, data in pairs(self.Texts) do
		if data.Enabled then
			data:Update(1)
		end
	end
end

function TukuiDT:ResetGold()
	local Realm = GetRealmName()
	local Name = UnitName("player")

	TukuiData.Gold = {}
	TukuiData.Gold[Realm] = {}
	TukuiData.Gold[Realm][Name] = GetMoney()
end

function TukuiDT:Save()
	if (not TukuiData[GetRealmName()][UnitName("player")]) then
		TukuiData[GetRealmName()][UnitName("player")] = {}
	end

	local Data = TukuiData[GetRealmName()][UnitName("player")]

	if (not Data.Texts) then
		Data.Texts = {}
	end

	for Name, DataText in pairs(self.Texts) do
		if DataText.Position then
			Data.Texts[Name] = {DataText.Enabled, DataText.Position}
		end
	end
end

function TukuiDT:AddDefaults()
	TukuiData[GetRealmName()][UnitName("player")].Texts = {}

	TukuiData[GetRealmName()][UnitName("player")].Texts[L.DataText.Guild] = {true, 1}
	TukuiData[GetRealmName()][UnitName("player")].Texts[L.DataText.Voice] = {true, 2}
	TukuiData[GetRealmName()][UnitName("player")].Texts[L.DataText.Friends] = {true, 3}
	TukuiData[GetRealmName()][UnitName("player")].Texts[L.DataText.FPSAndMS] = {true, 4}
	TukuiData[GetRealmName()][UnitName("player")].Texts[L.DataText.Memory] = {true, 5}
	TukuiData[GetRealmName()][UnitName("player")].Texts[L.DataText.Gold] = {true, 6}
	TukuiData[GetRealmName()][UnitName("player")].Texts[L.DataText.Time] = {true, 7}
end

function TukuiDT:Reset()
	for i = 1, self.NumAnchors do
		RemoveData(self.Anchors[i])
	end

	for _, Data in pairs(self.Texts) do
		if Data.Enabled then
			Data:Disable()
		end
	end

	self:AddDefaults()

	if (TukuiData[GetRealmName()][UnitName("player")] and TukuiData[GetRealmName()][UnitName("player")].Texts) then
		for Name, Info in pairs(TukuiData[GetRealmName()][UnitName("player")].Texts) do
			local Enabled, Num = Info[1], Info[2]

			if (Enabled and (Num and Num > 0)) then
				local Object = self:GetDataText(Name)

				if Object then
					Object:Enable()
					self.Anchors[Num]:SetData(Object)
				else
					T.Print("DataText '" .. Name .. "' not found. Removing from cache.")
					TukuiData[GetRealmName()][UnitName("player")].Texts[Name] = {false, 0}
				end
			end
		end
	end
end

function TukuiDT:Load()
	self:CreateAnchors()

	if (not TukuiData[GetRealmName()][UnitName("player")]) then
		TukuiData[GetRealmName()][UnitName("player")] = {}
	end

	if (not TukuiData[GetRealmName()][UnitName("player")].Texts) then
		TukuiDT:AddDefaults()
	end

	if (TukuiData[GetRealmName()][UnitName("player")] and TukuiData[GetRealmName()][UnitName("player")].Texts) then
		for Name, Info in pairs(TukuiData[GetRealmName()][UnitName("player")].Texts) do
			local Enabled, Num = Info[1], Info[2]

			if (Enabled and (Num and Num > 0)) then
				local Object = self:GetDataText(Name)

				if self.Anchors[Num] then
					if Object then
						Object:Enable()
						self.Anchors[Num]:SetData(Object)
					else
						T.Print("DataText '" .. Name .. "' not found. Removing from cache.")
						TukuiData[GetRealmName()][UnitName("player")].Texts[Name] = {false, 0}
					end
				end
			end
		end
	end
end

function TukuiDT:Enable()
	self.Font = T.GetFont(C["DataTexts"].Font)
	self.NameColor = T.RGBToHex(unpack(C["DataTexts"].NameColor))
	self.ValueColor = T.RGBToHex(unpack(C["DataTexts"].ValueColor))
	self:Load()
	self:AddRemove()
	self.BGFrame:Enable()
end

TukuiDT:RegisterEvent("PLAYER_LOGOUT")
TukuiDT:SetScript("OnEvent", function(self, event)
	self:Save()
end)

T["DataTexts"] = TukuiDT
