local T, C, L, G = unpack(select(2, ...)) 

local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent, "SecureHandlerStateTemplate")
TukuiBar1:SetTemplate()
TukuiBar1:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar1:SetHeight((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 14)
TukuiBar1:SetFrameStrata("BACKGROUND")
TukuiBar1:SetFrameLevel(1)
G.ActionBars.Bar1 = TukuiBar1

local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent, "SecureHandlerStateTemplate")
TukuiBar2:SetTemplate()
TukuiBar2:Point("BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -6, 0)
TukuiBar2:SetWidth((T.buttonsize * 6) + (T.buttonspacing * 7))
TukuiBar2:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar2:SetFrameStrata("BACKGROUND")
TukuiBar2:SetFrameLevel(3)
TukuiBar2:SetAlpha(0)
if T.lowversion then
	TukuiBar2:SetAlpha(0)
else
	TukuiBar2:SetAlpha(1)
end
G.ActionBars.Bar2 = TukuiBar2

local TukuiBar3 = CreateFrame("Frame", "TukuiBar3", UIParent, "SecureHandlerStateTemplate")
TukuiBar3:SetTemplate()
TukuiBar3:Point("BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 6, 0)
TukuiBar3:SetWidth((T.buttonsize * 6) + (T.buttonspacing * 7))
TukuiBar3:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar3:SetFrameStrata("BACKGROUND")
TukuiBar3:SetFrameLevel(3)
if T.lowversion then
	TukuiBar3:SetAlpha(0)
else
	TukuiBar3:SetAlpha(1)
end
G.ActionBars.Bar3 = TukuiBar3

local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent, "SecureHandlerStateTemplate")
TukuiBar4:SetTemplate()
TukuiBar4:Point("BOTTOM", UIParent, "BOTTOM", 0, 14)
TukuiBar4:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar4:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar4:SetFrameStrata("BACKGROUND")
TukuiBar4:SetFrameLevel(3)
G.ActionBars.Bar4 = TukuiBar4

local TukuiBar5 = CreateFrame("Frame", "TukuiBar5", UIParent, "SecureHandlerStateTemplate")
TukuiBar5:SetTemplate()
TukuiBar5:SetPoint("RIGHT", UIParent, "RIGHT", -23, -14)
TukuiBar5:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar5:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar5:SetFrameStrata("BACKGROUND")
TukuiBar5:SetFrameLevel(2)
TukuiBar5:SetAlpha(0)
G.ActionBars.Bar5 = TukuiBar5

local TukuiBar6 = CreateFrame("Frame", "TukuiBar6", UIParent, "SecureHandlerStateTemplate")
TukuiBar6:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar6:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar6:SetPoint("LEFT", TukuiBar5, "LEFT", 0, 0)
TukuiBar6:SetFrameStrata("BACKGROUND")
TukuiBar6:SetFrameLevel(2)
TukuiBar6:SetAlpha(0)
G.ActionBars.Bar6 = TukuiBar6

local TukuiBar7 = CreateFrame("Frame", "TukuiBar7", UIParent, "SecureHandlerStateTemplate")
TukuiBar7:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar7:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar7:SetPoint("TOP", TukuiBar5, "TOP", 0 , 0)
TukuiBar7:SetFrameStrata("BACKGROUND")
TukuiBar7:SetFrameLevel(2)
TukuiBar7:SetAlpha(0)
G.ActionBars.Bar7 = TukuiBar7

local petbg = CreateFrame("Frame", "TukuiPetBar", UIParent, "SecureHandlerStateTemplate")
petbg:SetTemplate()
petbg:SetSize(T.petbuttonsize + (T.petbuttonspacing * 2), (T.petbuttonsize * 10) + (T.petbuttonspacing * 11))
petbg:SetPoint("RIGHT", TukuiBar5, "LEFT", -6, 0)
G.ActionBars.Pet = petbg

local ltpetbg1 = CreateFrame("Frame", "TukuiLineToPetActionBarBackground", petbg)
ltpetbg1:SetTemplate()
ltpetbg1:Size(24, 265)
ltpetbg1:Point("LEFT", petbg, "RIGHT", 0, 0)
ltpetbg1:SetParent(petbg)
ltpetbg1:SetFrameStrata("BACKGROUND")
ltpetbg1:SetFrameLevel(0)
G.ActionBars.Pet.BackgroundLink = ltpetbg1

-- INVISIBLE FRAME COVERING BOTTOM ACTIONBARS JUST TO PARENT UF CORRECTLY
local invbarbg = CreateFrame("Frame", "InvTukuiActionBarBackground", UIParent)
if T.lowversion then
	invbarbg:SetPoint("TOPLEFT", TukuiBar4)
	invbarbg:SetPoint("BOTTOMRIGHT", TukuiBar1)
	TukuiBar2:Hide()
	TukuiBar3:Hide()
else
	invbarbg:SetPoint("TOPLEFT", TukuiBar2)
	invbarbg:SetPoint("BOTTOMRIGHT", TukuiBar3)
end
G.Panels.BottomPanelOverActionBars = invbarbg

-- LEFT VERTICAL LINE
local ileftlv = CreateFrame("Frame", "TukuiInfoLeftLineVertical", UIParent)
ileftlv:SetTemplate()
ileftlv:Size(2, 130)
ileftlv:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 22, 30)
ileftlv:SetFrameLevel(1)
ileftlv:SetFrameStrata("BACKGROUND")
G.Panels.BottomLeftVerticalLine = ileftlv

-- RIGHT VERTICAL LINE
local irightlv = CreateFrame("Frame", "TukuiInfoRightLineVertical", UIParent)
irightlv:SetTemplate()
irightlv:Size(2, 130)
irightlv:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -22, 30)
irightlv:SetFrameLevel(1)
irightlv:SetFrameStrata("BACKGROUND")
G.Panels.BottomRightVerticalLine = irightlv

if not C.chat.background then
	-- CUBE AT LEFT, ACT AS A BUTTON (CHAT MENU)
	local cubeleft = CreateFrame("Frame", "TukuiCubeLeft", UIParent)
	cubeleft:SetTemplate()
	cubeleft:Size(10)
	cubeleft:Point("BOTTOM", ileftlv, "TOP", 0, 0)
	cubeleft:EnableMouse(true)
	cubeleft:SetFrameLevel(1)
	cubeleft:SetScript("OnMouseDown", function(self, btn)
		if TukuiInfoLeftBattleGround and UnitInBattleground("player") then
			if btn == "RightButton" then
				if TukuiInfoLeftBattleGround:IsShown() then
					TukuiInfoLeftBattleGround:Hide()
				else
					TukuiInfoLeftBattleGround:Show()
				end
			end
		end
		
		if btn == "LeftButton" then	
			ToggleFrame(ChatMenu)
		end
	end)
	G.Panels.BottomLeftCube = cubeleft
	

	-- CUBE AT RIGHT, ACT AS A BUTTON (CONFIGUI or BG'S)
	local cuberight = CreateFrame("Frame", "TukuiCubeRight", UIParent)
	cuberight:SetTemplate()
	cuberight:Size(10)
	cuberight:SetFrameLevel(1)
	cuberight:Point("BOTTOM", irightlv, "TOP", 0, 0)
	if C["bags"].enable then
		cuberight:EnableMouse(true)
		cuberight:SetScript("OnMouseDown", function(self)
			ToggleAllBags()
		end)
	end
	G.Panels.BottomRightCube = cuberight
end

-- HORIZONTAL LINE LEFT
local ltoabl = CreateFrame("Frame", "TukuiLineToABLeft", UIParent)
ltoabl:SetTemplate()
ltoabl:Size(5, 2)
ltoabl:ClearAllPoints()
ltoabl:Point("BOTTOMLEFT", ileftlv, "BOTTOMLEFT", 0, 0)
ltoabl:Point("RIGHT", TukuiBar1, "BOTTOMLEFT", -1, 17)
ltoabl:SetFrameStrata("BACKGROUND")
ltoabl:SetFrameLevel(1)
G.Panels.BottomLeftLine = ltoabl

-- HORIZONTAL LINE RIGHT
local ltoabr = CreateFrame("Frame", "TukuiLineToABRight", UIParent)
ltoabr:SetTemplate()
ltoabr:Size(5, 2)
ltoabr:Point("LEFT", TukuiBar1, "BOTTOMRIGHT", 1, 17)
ltoabr:Point("BOTTOMRIGHT", irightlv, "BOTTOMRIGHT", 0, 0)
ltoabr:SetFrameStrata("BACKGROUND")
ltoabr:SetFrameLevel(1)
G.Panels.BottomRightLine = ltoabr

-- MOVE/HIDE SOME ELEMENTS IF CHAT BACKGROUND IS ENABLED
local movechat = 0
if C.chat.background then movechat = 10 ileftlv:SetAlpha(0) irightlv:SetAlpha(0) end

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "TukuiInfoLeft", UIParent)
ileft:SetTemplate()
ileft:Size(T.InfoLeftRightWidth, 23)
ileft:SetPoint("LEFT", ltoabl, "LEFT", 14 - movechat, 0)
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")
G.Panels.DataTextLeft = ileft

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "TukuiInfoRight", UIParent)
iright:SetTemplate()
iright:Size(T.InfoLeftRightWidth, 23)
iright:SetPoint("RIGHT", ltoabr, "RIGHT", -14 + movechat, 0)
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")
G.Panels.DataTextRight = iright

if C.chat.background then
	-- Alpha horizontal lines because all panels is dependent on this frame.
	ltoabl:SetAlpha(0)
	ltoabr:SetAlpha(0)
	
	-- CHAT BG LEFT
	local chatleftbg = CreateFrame("Frame", "TukuiChatBackgroundLeft", TukuiInfoLeft)
	chatleftbg:SetTemplate("Transparent")
	chatleftbg:Size(T.InfoLeftRightWidth + 12, 177)
	chatleftbg:Point("BOTTOM", TukuiInfoLeft, "BOTTOM", 0, -6)
	chatleftbg:SetFrameLevel(1)
	G.Panels.LeftChatBackground = chatleftbg

	-- CHAT BG RIGHT
	local chatrightbg = CreateFrame("Frame", "TukuiChatBackgroundRight", TukuiInfoRight)
	chatrightbg:SetTemplate("Transparent")
	chatrightbg:Size(T.InfoLeftRightWidth + 12, 177)
	chatrightbg:Point("BOTTOM", TukuiInfoRight, "BOTTOM", 0, -6)
	chatrightbg:SetFrameLevel(1)
	G.Panels.RightChatBackground = chatrightbg
	
	-- LEFT TAB PANEL
	local tabsbgleft = CreateFrame("Frame", "TukuiTabsLeftBackground", UIParent)
	tabsbgleft:SetTemplate()
	tabsbgleft:Size(T.InfoLeftRightWidth, 23)
	tabsbgleft:Point("TOP", chatleftbg, "TOP", 0, -6)
	tabsbgleft:SetFrameLevel(2)
	tabsbgleft:SetFrameStrata("BACKGROUND")
	G.Panels.LeftChatTabsBackground = tabsbgleft
		
	-- RIGHT TAB PANEL
	local tabsbgright = CreateFrame("Frame", "TukuiTabsRightBackground", UIParent)
	tabsbgright:SetTemplate()
	tabsbgright:Size(T.InfoLeftRightWidth, 23)
	tabsbgright:Point("TOP", chatrightbg, "TOP", 0, -6)
	tabsbgright:SetFrameLevel(2)
	tabsbgright:SetFrameStrata("BACKGROUND")
	G.Panels.RightChatTabsBackground = tabsbgright

	-- [[ Create new horizontal line for chat background ]] --
	-- HORIZONTAL LINE LEFT
	local ltoabl2 = CreateFrame("Frame", "TukuiLineToABLeftAlt", UIParent)
	ltoabl2:SetTemplate()
	ltoabl2:Size(5, 2)
	ltoabl2:Point("RIGHT", TukuiBar1, "LEFT", 0, 16)
	ltoabl2:Point("BOTTOMLEFT", chatleftbg, "BOTTOMRIGHT", 0, 16)
	ltoabl2:SetFrameStrata("BACKGROUND")
	ltoabl2:SetFrameLevel(1)
	G.Panels.LeftDataTextToActionBarLine = ltoabl2

	-- HORIZONTAL LINE RIGHT
	local ltoabr2 = CreateFrame("Frame", "TukuiLineToABRightAlt", UIParent)
	ltoabr2:SetTemplate()
	ltoabr2:Size(5, 2)
	ltoabr2:Point("LEFT", TukuiBar1, "RIGHT", 0, 16)
	ltoabr2:Point("BOTTOMRIGHT", chatrightbg, "BOTTOMLEFT", 0, 16)
	ltoabr2:SetFrameStrata("BACKGROUND")
	ltoabr2:SetFrameLevel(1)
	G.Panels.RightDataTextToActionBarLine = ltoabr2
end

if TukuiMinimap then
	local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", TukuiMinimap)
	minimapstatsleft:SetTemplate()
	minimapstatsleft:Size(((TukuiMinimap:GetWidth() + 4) / 2) -3, 19)
	minimapstatsleft:Point("TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -2)
	G.Panels.DataTextMinimapLeft = minimapstatsleft

	local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", TukuiMinimap)
	minimapstatsright:SetTemplate()
	minimapstatsright:Size(((TukuiMinimap:GetWidth() + 4) / 2) -3, 19)
	minimapstatsright:Point("TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, -2)
	G.Panels.DataTextMinimapRight = minimapstatsright
end

--BATTLEGROUND STATS FRAME
if C["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	bgframe:SetTemplate()
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
	G.Panels.BattlegroundDataText = bgframe
end
