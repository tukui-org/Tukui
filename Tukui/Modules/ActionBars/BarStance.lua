local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]

function ActionBars:CreateStanceBar()
	local PetSize = C.ActionBars.PetButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local Movers = T["Movers"]
	
	if (not C.ActionBars.ShapeShift) then
		return
	end
	
	local StanceBar = CreateFrame("Frame", "TukuiStanceBar", T.PetHider, "SecureHandlerStateTemplate")
	StanceBar:SetSize((PetSize * 10) + (Spacing * 11), PetSize + (Spacing * 2))
	StanceBar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 28, 233)
	StanceBar:SetFrameStrata("LOW")
	StanceBar:SetFrameLevel(10)
	
	if C.ActionBars.ShowBackdrop then
		StanceBar:CreateBackdrop()
		StanceBar:CreateShadow()
	end

	StanceBarFrame.ignoreFramePositionManager = true
	StanceBarFrame:StripTextures()
	StanceBarFrame:SetParent(StanceBar)
	StanceBarFrame:ClearAllPoints()
	StanceBarFrame:SetPoint("TOPLEFT", StanceBar, "TOPLEFT", -7, 0)
	StanceBarFrame:EnableMouse(false)

	for i = 1, NUM_STANCE_SLOTS do
		local Button = _G["StanceButton"..i]

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

	StanceBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	StanceBar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	StanceBar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
	StanceBar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
	StanceBar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	StanceBar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
	StanceBar:RegisterEvent("SPELLS_CHANGED")
	StanceBar:SetScript("OnEvent", function(self, event, ...)
		if (event == "UPDATE_SHAPESHIFT_FORMS") then

		elseif (event == "PLAYER_ENTERING_WORLD") then
			ActionBars:UpdateStanceBar()
			ActionBars:SkinStanceButtons()
		else
			ActionBars:UpdateStanceBar()
		end
	end)

	Movers:RegisterFrame(StanceBar, "Stance Action Bar")
	
	self.Bars.Stance = StanceBar
end
