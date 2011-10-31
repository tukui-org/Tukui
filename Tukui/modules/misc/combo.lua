-- TukuiCombo
local T, C, L = unpack(select(2, ...))
local parent = TukuiPlayer
local MAX_COMBO_POINTS = MAX_COMBO_POINTS

if not parent or not C.unitframes.classbar then return end

local Colors = { 
	[1] = {.69, .31, .31, 1},
	[2] = {.65, .42, .31, 1},
	[3] = {.65, .63, .35, 1},
	[4] = {.46, .63, .35, 1},
	[5] = {.33, .63, .33, 1},
}

local function Update()
	local points = GetComboPoints("player", "target")
	local shadow = parent.shadow
	if points and points > 0 then
		TukuiCombo:Show()
		shadow:Point("TOPLEFT", -4, 12)
		for i = 1, MAX_COMBO_POINTS do
			if i <= points then
				TukuiCombo[i]:SetAlpha(1)
			else
				TukuiCombo[i]:SetAlpha(.2)
			end
		end
	else
		TukuiCombo:Hide()
		shadow:Point("TOPLEFT", -4, 4)
	end
end

-- create the bar
local TukuiCombo = CreateFrame("Frame", "TukuiCombo", parent)
TukuiCombo:SetPoint("TOP", parent, "TOP", 0, 9)
TukuiCombo:SetWidth(parent:GetWidth())
TukuiCombo:SetHeight(8)
TukuiCombo:SetTemplate("Default")
TukuiCombo:SetBackdropBorderColor(unpack(C.media.backdropcolor))
TukuiCombo:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiCombo:RegisterEvent("UNIT_COMBO_POINTS")
TukuiCombo:RegisterEvent("PLAYER_TARGET_CHANGED")
TukuiCombo:SetScript("OnEvent", Update)

-- create combos
for i = 1, 5 do
	TukuiCombo[i]=CreateFrame("StatusBar", "TukuiComboBar"..i, TukuiCombo)
	TukuiCombo[i]:Height(8)
	TukuiCombo[i]:SetStatusBarTexture(C.media.normTex)
	TukuiCombo[i]:GetStatusBarTexture():SetHorizTile(false)
	TukuiCombo[i]:SetFrameLevel(TukuiCombo:GetFrameLevel() + 1)
	TukuiCombo[i]:SetStatusBarColor(unpack(Colors[i]))	
	
	if i == 1 then
		TukuiCombo[i]:Point("LEFT", TukuiCombo, "LEFT", 0, 0)
		TukuiCombo[i]:Width(parent:GetWidth() / 5)
	else
		TukuiCombo[i]:Point("LEFT", TukuiCombo[i-1], "RIGHT", 1, 0)
		TukuiCombo[i]:Width(parent:GetWidth() / 5 - 1)
	end
end