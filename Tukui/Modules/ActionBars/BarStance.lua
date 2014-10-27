local T, C, L = select(2, ...):unpack()

local _G = _G
local TukuiActionBars = T["ActionBars"]

function TukuiActionBars:CreateStanceBar()
	if (not C.ActionBars.ShapeShift) then
		return
	end
	
	local Panels = T["Panels"]
	local PetSize = C.ActionBars.PetButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local StanceBar = Panels.StanceBar
	local Movers = T["Movers"]

	StanceBar:ClearAllPoints()
	StanceBar:Point("BOTTOMLEFT", UIParent, 47, 199)

	StanceBarFrame.ignoreFramePositionManager = true
	StanceBarFrame:StripTextures()
	StanceBarFrame:SetParent(StanceBar)
	StanceBarFrame:ClearAllPoints()
	StanceBarFrame:SetPoint("TOPLEFT", StanceBar, "TOPLEFT", -7, 0)
	StanceBarFrame:EnableMouse(false)

	for i = 1, NUM_STANCE_SLOTS do
		local Button = _G["StanceButton"..i]

		Button:SetFrameStrata("LOW")
		Button:Show()

		if (i ~= 1) then
			local Previous = _G["StanceButton"..i-1]

			Button:ClearAllPoints()
			Button:Point("LEFT", Previous, "RIGHT", Spacing, 0)
		else
			Button:ClearAllPoints()
			Button:Point("BOTTOMLEFT", StanceBar, "BOTTOMLEFT", Spacing, Spacing)		
		end
	end

	RegisterStateDriver(StanceBar, "visibility", "[vehicleui][petbattle] hide; show")

	StanceBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	StanceBar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
	StanceBar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
	StanceBar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
	StanceBar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	StanceBar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
	StanceBar:RegisterEvent("PLAYER_TALENT_UPDATE")
	StanceBar:RegisterEvent("SPELLS_CHANGED")
	StanceBar:SetScript("OnEvent", function(self, event, ...)
		if (event == "UPDATE_SHAPESHIFT_FORMS") then

		elseif (event == "PLAYER_ENTERING_WORLD") then
			TukuiActionBars.UpdateStanceBar(self)
			TukuiActionBars.SkinStanceButtons()
		else
			TukuiActionBars.UpdateStanceBar(self)
		end
	end)
	
	Movers:RegisterFrame(StanceBar)
	
	RegisterStateDriver(StanceBar, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end