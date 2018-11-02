local T, C, L = select(2, ...):unpack()

local TukuiActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function TukuiActionBars:CreateBar3()
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local MultiBarBottomRight = MultiBarBottomRight
	local ActionBar3 = T.Panels.ActionBar3

	MultiBarBottomRight:SetParent(ActionBar3)
	MultiBarBottomRight:SetScript("OnHide", function() ActionBar3.Backdrop:Hide() end)
	MultiBarBottomRight:SetScript("OnShow", function() ActionBar3.Backdrop:Show() end)

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomRightButton"..i]
		local PreviousButton = _G["MultiBarBottomRightButton"..i-1]

		Button:Size(Size)
		Button:ClearAllPoints()
		Button.noGrid = false
		Button:SetAttribute("showgrid", 1)

		if (i == 1) then
			Button:SetPoint("BOTTOMLEFT", ActionBar3, Spacing, Spacing)

			ActionBar3:SetWidth((Button:GetWidth() * 6) + (Spacing * 7))
			ActionBar3:SetHeight((Button:GetWidth() * 2) + (Spacing * 3))
		elseif (i == 7) then
			Button:SetPoint("TOPLEFT", ActionBar3, Spacing, -Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end

		ActionBar3["Button"..i] = Button
	end

	Movers:RegisterFrame(ActionBar3)

	RegisterStateDriver(ActionBar3, "visibility", "[vehicleui][petbattle][overridebar] hide; show")
end
