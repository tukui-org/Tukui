local T, C, L = select(2, ...):unpack()

if not T.Themes then
	T.Themes = {}
end

-- Load what we need
local Themes = T["Themes"]
local Panels = T["Panels"]
local Misc = T["Miscellaneous"]
local Chat = T["Chat"]
local Tooltip = T["Tooltip"]
local DataTexts = T["DataTexts"]

-- Let's go
local T17 = CreateFrame("Frame")

function T17:MoveXPBars()
	local Experience = Misc.Experience
	local Reputation = Misc.Reputation
	
	for i = 1, Experience.NumBars do
		local Bar = Experience["XPBar"..i]
		local RestedBar = Experience["RestedBar"..i]
		
		Bar:ClearAllPoints()
		Bar:SetOrientation("Vertical")
		Bar:Size(8, 100)
		Bar:SetReverseFill(false)
		Bar:Point("TOP", i == 1 and Tukui_T17_LeftVerticalLine or Tukui_T17_RightVerticalLine, "TOP", 0, i == 1 and -Panels.DataTextLeft:GetHeight() / 2 or -Panels.DataTextRight:GetHeight() / 2)
		
		RestedBar:SetOrientation("Vertical")
		RestedBar:SetReverseFill(false)
	end
	
	for i = 1, Reputation.NumBars do
		local Bar = Reputation["RepBar"..i]
		
		Bar:SetOrientation("Vertical")
		Bar:SetReverseFill(false)
	end
end

function T17:AddLines()
	local BottomLine = CreateFrame("Frame", "Tukui_T17_BottomLine", UIParent)
	BottomLine:SetTemplate()
	BottomLine:Size(2)
	BottomLine:Point("BOTTOMLEFT", 18, 30)
	BottomLine:Point("BOTTOMRIGHT", -18, 30)
	BottomLine:SetFrameStrata("BACKGROUND")
	BottomLine:SetFrameLevel(0)
	BottomLine:CreateShadow()
	
	local LeftVerticalLine = CreateFrame("Frame", "Tukui_T17_LeftVerticalLine", BottomLine)
	LeftVerticalLine:SetTemplate()
	LeftVerticalLine:Size(2, 130)
	LeftVerticalLine:Point("BOTTOMLEFT", 0, 0)
	LeftVerticalLine:SetFrameLevel(0)
	LeftVerticalLine:SetFrameStrata("BACKGROUND")
	LeftVerticalLine:SetAlpha(1)
	LeftVerticalLine:CreateShadow()

	local RightVerticalLine = CreateFrame("Frame", "Tukui_T17_RightVerticalLine", BottomLine)
	RightVerticalLine:SetTemplate()
	RightVerticalLine:Size(2, 130)
	RightVerticalLine:Point("BOTTOMRIGHT", 0, 0)
	RightVerticalLine:SetFrameLevel(0)
	RightVerticalLine:SetFrameStrata("BACKGROUND")
	RightVerticalLine:SetAlpha(1)
	RightVerticalLine:CreateShadow()
	
	local CubeLeft = CreateFrame("Frame", "Tukui_T17_CubeLeft", LeftVerticalLine)
	CubeLeft:SetTemplate()
	CubeLeft:Size(10)
	CubeLeft:Point("BOTTOM", LeftVerticalLine, "TOP", 0, 0)
	CubeLeft:SetFrameStrata("BACKGROUND")
	CubeLeft:SetFrameLevel(0)
	CubeLeft:CreateShadow()

	local CubeRight = CreateFrame("Frame", "Tukui_T17_CubeRight", RightVerticalLine)
	CubeRight:SetTemplate()
	CubeRight:Size(10)
	CubeRight:Point("BOTTOM", RightVerticalLine, "TOP", 0, 0)
	CubeRight:SetFrameStrata("BACKGROUND")
	CubeRight:SetFrameLevel(0)
	CubeRight:CreateShadow()
end

function T17:NoMouseAlphaOnTab()
	local Frame = self:GetName()
	local Tab = _G[Frame .. "Tab"]

	if (Tab.noMouseAlpha == 0.4) or (Tab.noMouseAlpha == 0.2) then
		Tab:SetAlpha(0)
		Tab.noMouseAlpha = 0
	end
end

function T17:SetupChat()
	local LC = Panels.LeftChatBG
	local RC = Panels.RightChatBG
	local DTL = Panels.DataTextLeft
	local DTR = Panels.DataTextRight

	LC:SetAlpha(0)
	RC:SetAlpha(0)
	DTL:CreateShadow()
	DTR:CreateShadow()
	
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]
		local Tab = _G["ChatFrame"..i.."Tab"]

		Tab.SetAlpha = Frame.SetAlpha
		Tab:SetAlpha(0)
	end
	
	hooksecurefunc("FCFTab_UpdateAlpha", T17.NoMouseAlphaOnTab)
end

function T17:MoveTooltip()
	local Anchor = TukuiTooltipAnchor
	local DataTextRight = Panels.DataTextRight

	Anchor:ClearAllPoints()
	Anchor:SetPoint("BOTTOMRIGHT", DataTextRight, 0, 2)
end

function T17:GetTooltipAnchor()
	local MapDT = Panels.MinimapDataText
	local Position = self.Position
	local From
	local Anchor = "ANCHOR_TOP"
	local X = 0
	local Y = T.Scale(5)

	if (Position >= 1 and Position <= 3) then
		Anchor = "ANCHOR_TOPLEFT"
		From = T.Panels.DataTextLeft
	elseif (Position >=4 and Position <= 6) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = T.Panels.DataTextRight
	elseif (Position == 7 and MapDT) then
		Anchor = "ANCHOR_BOTTOMLEFT"
		Y = T.Scale(-5)
		From = MapDT
	end

	return From, Anchor, X, Y
end

function T17:MoveDataTextTooltip()
	local Texts = DataTexts.Texts
	
	for Name, Table in pairs(Texts) do
		Table.GetTooltipAnchor = T17.GetTooltipAnchor
	end
end

function T17:OnEvent(event)
	if (C.General.Themes.Value == "Tukui 17") then
		self:SetupChat()
		self:AddLines()
		self:MoveXPBars()
		self:MoveTooltip()
		self:MoveDataTextTooltip()
	end
end

T17:RegisterEvent("PLAYER_LOGIN")
T17:SetScript("OnEvent", T17.OnEvent)

Themes.T17 = T17
