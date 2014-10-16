local T, C, L = select(2, ...):unpack()

local TukuiActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function TukuiActionBars:CreateBar2()
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local MultiBarBottomLeft = MultiBarBottomLeft
	local ActionBar2 = T.Panels.ActionBar2
	
	MultiBarBottomLeft:SetParent(ActionBar2)
	MultiBarBottomLeft:SetScript("OnHide", function() ActionBar2.Backdrop:Hide() end)
	MultiBarBottomLeft:SetScript("OnShow", function() ActionBar2.Backdrop:Show() end)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local PreviousButton = _G["MultiBarBottomLeftButton"..i-1]
		
		Button:Size(Size)
		Button:ClearAllPoints()
		Button:SetFrameStrata("BACKGROUND")
		Button:SetFrameLevel(15)
		
		if (i == 1) then
			Button:SetPoint("BOTTOMRIGHT", ActionBar2, -Spacing, Spacing)
		elseif (i == 7) then
			Button:SetPoint("TOPRIGHT", ActionBar2, -Spacing, -Spacing)
		else
			Button:SetPoint("RIGHT", PreviousButton, "LEFT", -Spacing, 0)
		end
		
		ActionBar2["Button"..i] = Button
	end

	for i = 7, 12 do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local Button1 = _G["MultiBarBottomLeftButton1"]
		
		Button:SetFrameLevel(Button1:GetFrameLevel() - 2)
	end
	
	Movers:RegisterFrame(ActionBar2)
	
	RegisterStateDriver(ActionBar2, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end