local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]

function ActionBars:CreateStanceBar()
	local PetSize = C.ActionBars.PetButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local Movers = T["Movers"]

	if (not C.ActionBars.ShapeShift) then
		return
	end
	
	local StanceBarFrame = T.Retail and StanceBar or StanceBarFrame

	local StanceBar = CreateFrame("Frame", "TukuiStanceBar", T.PetHider, "SecureHandlerStateTemplate")
	StanceBar:SetSize((PetSize * 10) + (Spacing * 11), PetSize + (Spacing * 2))
	StanceBar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 28, 233)
	StanceBar:SetFrameStrata("LOW")
	StanceBar:SetFrameLevel(10)
	
	self.Bars.Stance = StanceBar

	if C.ActionBars.ShowBackdrop then
		StanceBar:CreateBackdrop()
		StanceBar:CreateShadow()
	end
	
	if T.Retail then
		StanceBarFrame:ResetToDefaultPosition()
	end

	StanceBarFrame.ignoreFramePositionManager = true
	StanceBarFrame:StripTextures()
	StanceBarFrame:SetParent(StanceBar)
	StanceBarFrame:ClearAllPoints()
	StanceBarFrame:SetPoint("TOPLEFT", StanceBar, "TOPLEFT", -7, 0)
	StanceBarFrame:EnableMouse(false)

	for i = 1, 10 do
		local Button = _G["StanceButton"..i]
		
		Button:SetParent(StanceBarFrame)
		Button:Show()

		if (i ~= 1) then
			local Previous = _G["StanceButton"..i-1]

			Button:ClearAllPoints()
			Button:SetPoint("LEFT", Previous, "RIGHT", Spacing, 0)
		else
			Button:ClearAllPoints()
			Button:SetPoint("BOTTOMLEFT", StanceBar, "BOTTOMLEFT", Spacing, Spacing)
		end
	end
	
	ActionBars:UpdateStanceBar()
	ActionBars:SkinStanceButtons()

	Movers:RegisterFrame(StanceBar, "Stance Action Bar")
end