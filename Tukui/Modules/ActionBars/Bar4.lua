local T, C, L = select(2, ...):unpack()

local TukuiActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function TukuiActionBars:CreateBar4()
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local MultiBarRight = MultiBarRight
	local ActionBar4 = T.Panels.ActionBar4
	
	MultiBarRight:SetParent(ActionBar4)
	MultiBarRight:SetScript("OnHide", function() ActionBar4.Backdrop:Hide() end)
	MultiBarRight:SetScript("OnShow", function() ActionBar4.Backdrop:Show() end)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarRightButton"..i]
		local PreviousButton = _G["MultiBarRightButton"..i-1]
		
		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		Button:SetAttribute("flyoutDirection", "UP")
		
		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar4, Spacing, -Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end
		
		ActionBar4["Button"..i] = Button
	end
	
	RegisterStateDriver(ActionBar4, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end