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

	local Bar = CreateFrame("Frame", "TukuiStanceBar", T.PetHider, "SecureHandlerStateTemplate")
	Bar:SetSize((PetSize * 10) + (Spacing * 11), PetSize + (Spacing * 2))
	Bar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 28, 233)
	Bar:SetFrameStrata("LOW")
	Bar:SetFrameLevel(10)
	Bar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
	Bar:SetScript("OnEvent", ActionBars.UpdateStanceBar)

	if C.ActionBars.ShowBackdrop then
		Bar:CreateBackdrop()
		Bar:CreateShadow()
	end
	
	self.Bars.Stance = Bar

	StanceBarFrame.ignoreFramePositionManager = true
	StanceBarFrame:StripTextures()
	StanceBarFrame:EnableMouse(false)
	StanceBarFrame:UnregisterAllEvents()

	for i = 1, 10 do
		local Button = _G["StanceButton"..i]
		
		Button:SetParent(Bar)

		if (i ~= 1) then
			local Previous = _G["StanceButton"..i-1]

			Button:ClearAllPoints()
			Button:SetPoint("LEFT", Previous, "RIGHT", Spacing, 0)
		else
			Button:ClearAllPoints()
			Button:SetPoint("BOTTOMLEFT", Bar, "BOTTOMLEFT", Spacing, Spacing)
		end
	end
	
	ActionBars:UpdateStanceBar()
	ActionBars:SkinStanceButtons()

	Movers:RegisterFrame(Bar, "Stance Action Bar")
end