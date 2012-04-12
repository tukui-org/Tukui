if not IsAddOnLoaded("Recount") then return end

local T, C, L = unpack(select(2, ...))
if not C.general.recountreskin then return end

local Recount = _G.Recount

local function SkinFrame(frame)
	frame.bgMain = CreateFrame("Frame", nil, frame)
	frame.bgMain:SetTemplate("Transparent")
	frame.bgMain:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
	frame.bgMain:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
	frame.bgMain:SetPoint("TOP", frame, "TOP", 0, -7)
	frame.bgMain:SetFrameLevel(frame:GetFrameLevel())
	frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -9)
	frame:SetBackdrop(nil)
	frame.TitleBackground = CreateFrame("Frame", nil, frame.bgMain)
	frame.TitleBackground:SetPoint("TOP", 0)
	frame.TitleBackground:SetPoint("LEFT", 0)
	frame.TitleBackground:SetPoint("RIGHT", 0)
	frame.TitleBackground:SetHeight(24)
	frame.TitleBackground:SetTemplate("Default")
	frame.Title:SetFont(C.media.font, 11)
	frame.Title:SetParent(frame.TitleBackground)
	frame.Title:ClearAllPoints()
	frame.Title:SetPoint("LEFT", 4, 0)
	frame.CloseButton:SetNormalTexture("")
	frame.CloseButton:SetPushedTexture("")
	frame.CloseButton:SetHighlightTexture("")
	frame.CloseButton.t = frame.CloseButton:CreateFontString(nil, "OVERLAY")
	frame.CloseButton.t:SetFont(C.media.pixelfont, 12, "MONOCHROME")
	frame.CloseButton.t:SetPoint("CENTER", 0, 1)
	frame.CloseButton.t:SetText("X")
end

Recount.UpdateBarTextures = function(self)
	for k, v in pairs(Recount.MainWindow.Rows) do
		v.StatusBar:SetStatusBarTexture(C["media"].normTex)
		v.StatusBar:GetStatusBarTexture():SetHorizTile(false)
		v.StatusBar:GetStatusBarTexture():SetVertTile(false)
		v.LeftText:SetPoint("LEFT", 4, 1)
		v.LeftText:SetFont(C.media.font, 12)
		v.RightText:SetPoint("RIGHT", -4, 1)
		v.RightText:SetFont(C.media.font, 12)
	end
end
Recount.SetBarTextures = Recount.UpdateBarTextures

-- Fix bar textures as they're created
Recount.SetupBar_ = Recount.SetupBar
Recount.SetupBar = function(self, bar)
	self:SetupBar_(bar)
	bar.StatusBar:SetStatusBarTexture(C["media"].normTex)
end

-- Skin frames when they're created
Recount.CreateFrame_ = Recount.CreateFrame
Recount.CreateFrame = function(self, Name, Title, Height, Width, ShowFunc, HideFunc)
	local frame = self:CreateFrame_(Name, Title, Height, Width, ShowFunc, HideFunc)
	SkinFrame(frame)
	return frame
end

-- Skin some others frame, not available outside Recount
Recount.AddWindow_ = Recount.AddWindow
Recount.AddWindow = function(self, frame)
	Recount:AddWindow_(frame)

	-- try to find the reset window and skin it
	if frame.YesButton then
		frame:SetTemplate("Default")
		T.SkinButton(frame.YesButton)
		T.SkinButton(frame.NoButton)
	end
	
	-- try to find the report button
	if frame.ReportButton then
		T.SkinButton(frame.ReportButton)
	end
end

-- frame we want to skins
local elements = {
	Recount.MainWindow,
	Recount.ConfigWindow,
	Recount.GraphWindow,
	Recount.DetailWindow,
	Recount.ResetFrame,
}

-- skin them
for i = 1, getn(elements) do
	local frame = elements[i]
	if frame then
		SkinFrame(frame)
	end
end

--Update Textures
Recount:UpdateBarTextures()

-- skin dropdown
Recount.MainWindow.FileButton:HookScript("OnClick", function(self)
	if LibDropdownFrame0 then 
		LibDropdownFrame0:SetTemplate()
	end
end)

-- skin the buttons o main window
local PB = Recount.MainWindow.CloseButton
local MWbuttons = {
	Recount.MainWindow.RightButton,
	Recount.MainWindow.LeftButton,
	Recount.MainWindow.ResetButton,
	Recount.MainWindow.FileButton,
	Recount.MainWindow.ConfigButton,
	Recount.MainWindow.ReportButton,
}

for i = 1, getn(MWbuttons) do
	local button = MWbuttons[i]
	if button then
		button:SetTemplate("Default")
		button:SetNormalTexture("")
		button:SetPushedTexture("")	
		button:SetHighlightTexture("")
		button:SetSize(16, 16)
		button:FontString("text", C.media.pixelfont, 12, "MONOCHROME")
		button.text:SetPoint("CENTER", 1, 1)
		button:ClearAllPoints()
		button:SetPoint("RIGHT", PB, "LEFT", -2, 0)
		PB = button
	end
end

-- set our custom text inside main window buttons
Recount.MainWindow.RightButton.text:SetText(">")
Recount.MainWindow.LeftButton.text:SetText("<")
Recount.MainWindow.ResetButton.text:SetText("R")
Recount.MainWindow.FileButton.text:SetText("F")
Recount.MainWindow.ConfigButton.text:SetText("C")
Recount.MainWindow.ReportButton.text:SetText("S")