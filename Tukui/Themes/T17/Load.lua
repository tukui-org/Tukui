local T, C, L = select(2, ...):unpack()

if not T.Themes then
	T.Themes = {}
end

-- Load what we need
local Themes = T["Themes"]
local Panels = T["Panels"]
local Misc = T["Miscellaneous"]
local Chat = T["Chat"]

-- Let's go
local T17 = CreateFrame("Frame")

function T17:MoveXPBars()
	local Bars = Misc.Experience
	local Bar1 = Bars.XPBar1
	local Bar2 = Bars.XPBar2
	
	if Bar1 then
		Bar1:ClearAllPoints()
		Bar1:SetOrientation("Vertical")
		Bar1:Size(8, 100)
		Bar1:Point("TOP", Tukui_Minimalist_LeftVerticalLine, "TOP", 0, -Panels.DataTextLeft:GetHeight() / 2)
	end
	
	if Bar2 then
		Bar2:ClearAllPoints()
		Bar2:SetOrientation("Vertical")
		Bar2:SetReverseFill(false)
		Bar2:Size(8, 100)
		Bar2:Point("TOP", Tukui_Minimalist_RightVerticalLine, "TOP", 0, -Panels.DataTextRight:GetHeight() / 2)
	end
end

function T17:AddLines()
	local BottomLine = CreateFrame("Frame", "Tukui_Minimalist_BottomLine", UIParent)
	BottomLine:SetTemplate()
	BottomLine:Size(2)
	BottomLine:Point("BOTTOMLEFT", 18, 30)
	BottomLine:Point("BOTTOMRIGHT", -18, 30)
	BottomLine:SetFrameStrata("BACKGROUND")
	BottomLine:SetFrameLevel(0)
	BottomLine:CreateShadow()
	
	local LeftVerticalLine = CreateFrame("Frame", "Tukui_Minimalist_LeftVerticalLine", BottomLine)
	LeftVerticalLine:SetTemplate()
	LeftVerticalLine:Size(2, 130)
	LeftVerticalLine:Point("BOTTOMLEFT", 0, 0)
	LeftVerticalLine:SetFrameLevel(0)
	LeftVerticalLine:SetFrameStrata("BACKGROUND")
	LeftVerticalLine:SetAlpha(1)
	LeftVerticalLine:CreateShadow()

	local RightVerticalLine = CreateFrame("Frame", "Tukui_Minimalist_RightVerticalLine", BottomLine)
	RightVerticalLine:SetTemplate()
	RightVerticalLine:Size(2, 130)
	RightVerticalLine:Point("BOTTOMRIGHT", 0, 0)
	RightVerticalLine:SetFrameLevel(0)
	RightVerticalLine:SetFrameStrata("BACKGROUND")
	RightVerticalLine:SetAlpha(1)
	RightVerticalLine:CreateShadow()
	
	local CubeLeft = CreateFrame("Frame", "Tukui_Minimalist_CubeLeft", LeftVerticalLine)
	CubeLeft:SetTemplate()
	CubeLeft:Size(10)
	CubeLeft:Point("BOTTOM", LeftVerticalLine, "TOP", 0, 0)
	CubeLeft:SetFrameStrata("BACKGROUND")
	CubeLeft:SetFrameLevel(0)
	CubeLeft:CreateShadow()

	local CubeRight = CreateFrame("Frame", "Tukui_Minimalist_CubeRight", RightVerticalLine)
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

function T17:OnEvent(event)
	if (C.General.Themes.Value == "Tukui 17") then
		self:SetupChat()
		self:AddLines()
		self:MoveXPBars()
	end
end

T17:RegisterEvent("PLAYER_LOGIN")
T17:SetScript("OnEvent", T17.OnEvent)

Themes.T17 = T17
