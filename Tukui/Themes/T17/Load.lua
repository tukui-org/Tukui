local T, C, L = select(2, ...):unpack()

if not T.Themes then
	T.Themes = {}
end

-- Load what we need
local Themes = T["Themes"]
local Misc = T["Miscellaneous"]
local Chat = T["Chat"]
local Tooltip = T["Tooltip"]
local DataText = T["DataTexts"]

-- Let's go
local Tukz = CreateFrame("Frame")

local ToggleLock = FCF_ToggleLock
local ToggleLockOnDockedFrame = FCF_ToggleLockOnDockedFrame

function Tukz:MoveXPBars()
	local Experience = Misc.Experience

	if C.Misc.ExperienceEnable then
		for i = 1, Experience.NumBars do
			local Bar = Experience["XPBar"..i]
			local RestedBar = Experience["RestedBar"..i]

			Bar:ClearAllPoints()
			Bar:SetOrientation("Vertical")
			Bar:SetSize(8, 100)
			Bar:SetReverseFill(false)
			Bar:SetPoint("TOP", i == 1 and Tukui_Tukz_LeftVerticalLine or Tukui_Tukz_RightVerticalLine, "TOP", 0, i == 1 and -T.DataTexts.Panels.Left:GetHeight() / 2 or -T.DataTexts.Panels.Right:GetHeight() / 2)

			RestedBar:SetOrientation("Vertical")
			RestedBar:SetReverseFill(false)
		end
	end
end

function Tukz:AddLines()
	local BottomLine = CreateFrame("Frame", "Tukui_Tukz_BottomLine", UIParent)
	BottomLine:CreateBackdrop()
	BottomLine:SetSize(2, 2)
	BottomLine:SetPoint("BOTTOMLEFT", 18, 30)
	BottomLine:SetPoint("BOTTOMRIGHT", -18, 30)
	BottomLine:SetFrameStrata("BACKGROUND")
	BottomLine:SetFrameLevel(0)
	BottomLine:CreateShadow()

	local LeftVerticalLine = CreateFrame("Frame", "Tukui_Tukz_LeftVerticalLine", BottomLine)
	LeftVerticalLine:CreateBackdrop()
	LeftVerticalLine:SetSize(2, 130)
	LeftVerticalLine:SetPoint("BOTTOMLEFT", 0, 0)
	LeftVerticalLine:SetFrameLevel(0)
	LeftVerticalLine:SetFrameStrata("BACKGROUND")
	LeftVerticalLine:SetAlpha(1)
	LeftVerticalLine:CreateShadow()

	local RightVerticalLine = CreateFrame("Frame", "Tukui_Tukz_RightVerticalLine", BottomLine)
	RightVerticalLine:CreateBackdrop()
	RightVerticalLine:SetSize(2, 130)
	RightVerticalLine:SetPoint("BOTTOMRIGHT", 0, 0)
	RightVerticalLine:SetFrameLevel(0)
	RightVerticalLine:SetFrameStrata("BACKGROUND")
	RightVerticalLine:SetAlpha(1)
	RightVerticalLine:CreateShadow()

	local CubeLeft = CreateFrame("Frame", "Tukui_Tukz_CubeLeft", LeftVerticalLine)
	CubeLeft:CreateBackdrop()
	CubeLeft:SetSize(10, 10)
	CubeLeft:SetPoint("BOTTOM", LeftVerticalLine, "TOP", 0, 0)
	CubeLeft:SetFrameStrata("BACKGROUND")
	CubeLeft:SetFrameLevel(0)
	CubeLeft:CreateShadow()

	local CubeRight = CreateFrame("Frame", "Tukui_Tukz_CubeRight", RightVerticalLine)
	CubeRight:CreateBackdrop()
	CubeRight:SetSize(10, 10)
	CubeRight:SetPoint("BOTTOM", RightVerticalLine, "TOP", 0, 0)
	CubeRight:SetFrameStrata("BACKGROUND")
	CubeRight:SetFrameLevel(0)
	CubeRight:CreateShadow()
end

function Tukz:NoMouseAlphaOnTab()
	local Frame = self:GetName()
	local Tab = _G[Frame .. "Tab"]

	if (Tab.noMouseAlpha == 0.4) or (Tab.noMouseAlpha == 0.2) then
		Tab:SetAlpha(0)
		Tab.noMouseAlpha = 0
	end
end

function Tukz:SetChatFramePosition()
	local Frame = self
	local ID = Frame:GetID()
	local IsMovable = Frame:IsMovable()
	local Settings = TukuiDatabase.Variables[T.MyRealm][T.MyName].Chat.Positions["Frame" .. ID]

	if Settings and IsMovable then
		Frame:SetUserPlaced(true)
		Frame:ClearAllPoints()

		if ID == 1 then
			Frame:SetParent(T.DataTexts.Panels.Left)
			Frame:SetPoint("BOTTOMLEFT", T.DataTexts.Panels.Left, "TOPLEFT", 0, 4)
			Frame:SetWidth(370)
			Frame:SetHeight(124)
		elseif Settings.IsUndocked then
			Frame:SetParent(T.DataTexts.Panels.Right)
			Frame:SetPoint("BOTTOMRIGHT", T.DataTexts.Panels.Right, "TOPRIGHT", 0, 4)
			Frame:SetWidth(370)
			Frame:SetHeight(124)
		end
	end

	FCF_SavePositionAndDimensions(Frame)
end

function Tukz:SetupChat()
	local LC = T.Chat.Panels.LeftChat
	local RC = T.Chat.Panels.RightChat
	local DTL = T.DataTexts.Panels.Left
	local DTR = T.DataTexts.Panels.Right

	LC:SetAlpha(0)
	RC:SetAlpha(0)
	DTL:CreateShadow()
	DTR:CreateShadow()

	hooksecurefunc("FCFTab_UpdateAlpha", Tukz.NoMouseAlphaOnTab)
	hooksecurefunc(T.Chat, "SetChatFramePosition", Tukz.SetChatFramePosition)
	hooksecurefunc(T.Chat, "Reset", function()
		for i = 1, NUM_CHAT_WINDOWS do
			local ChatFrame = _G["ChatFrame"..i]

			Tukz.SetChatFramePosition(ChatFrame)
		end
	end)

	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = _G["ChatFrame"..i]
		local Tab = _G["ChatFrame"..i.."Tab"]

		Tab.SetAlpha = Frame.SetAlpha
		Tab:SetAlpha(0)

		Tukz.SetChatFramePosition(Frame)
	end

	T.Chat.Panels.LeftChatToggle:SetParent(T.Hider)
	T.Chat.Panels.RightChatToggle:SetParent(T.Hider)

	FCF_ToggleLock = ToggleLock
	FCF_ToggleLockOnDockedFrame = ToggleLockOnDockedFrame

	T.Chat.DisplayChat = function() return end
end

function Tukz:MoveTooltip()
	local Anchor = TukuiTooltipAnchor

	if not Anchor then
		return
	end

	local DataTextRight = T.DataTexts.Panels.Right

	Anchor:ClearAllPoints()
	Anchor:SetPoint("BOTTOMRIGHT", UIParent, -34, 20)
end

function Tukz:GetTooltipAnchor()
	local MapDT = T.DataTexts.Panels.Minimap
	local Position = self.Position
	local From
	local Anchor = "ANCHOR_TOP"
	local X = 0
	local Y = 5

	if (Position >= 1 and Position <= 3) then
		Anchor = "ANCHOR_TOPLEFT"
		From = T.DataTexts.Panels.Left
	elseif (Position >=4 and Position <= 6) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = T.DataTexts.Panels.Right
	elseif (Position == 7 and MapDT) then
		Anchor = "ANCHOR_BOTTOM"
		Y = -5
		From = MapDT
	end

	return From, Anchor, X, Y
end

function Tukz:MoveDataTextTooltip()
	local Texts = DataText.DataTexts

	for Name, Table in pairs(Texts) do
		Table.GetTooltipAnchor = Tukz.GetTooltipAnchor
	end
end

function Tukz:SetDataTextSize()
	TukuiLeftDataTextBox:SetWidth(370)
	TukuiRightDataTextBox:SetWidth(370)

	for i = 1, 6 do
		local DataText = T.DataTexts.Anchors[i]
		local LeftWidth = (TukuiLeftDataTextBox:GetWidth() / 3) - 1
		local RightWidth = (TukuiRightDataTextBox:GetWidth() / 3) - 1

		DataText:SetWidth(i <= 3 and LeftWidth or RightWidth)
	end
end

function Tukz:OnEvent(event)
	if (C.General.Themes.Value == "Tukz") then
		self:SetupChat()
		self:AddLines()
		self:MoveXPBars()
		self:MoveTooltip()
		self:MoveDataTextTooltip()
		self:SetDataTextSize()
	end
end

Tukz:RegisterEvent("PLAYER_LOGIN")
Tukz:SetScript("OnEvent", Tukz.OnEvent)

Themes.Tukz = Tukz
