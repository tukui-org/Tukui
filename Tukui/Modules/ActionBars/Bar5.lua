local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar5()
	local MultiBarLeft = MultiBarLeft
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	
	if not C.ActionBars.LeftBar then
		MultiBarLeft:SetShown(false)

		return
	end
	
	local ActionBar5 = CreateFrame("Frame", "TukuiActionBar5", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar5:SetFrameStrata("LOW")
	ActionBar5:SetFrameLevel(10)
	
	if C.ActionBars.RightBarsAtBottom then
		ActionBar5:SetPoint("BOTTOM", UIParent, "BOTTOM", 504, 12)
		ActionBar5:SetWidth((Size * 6) + (Spacing * 7))
		ActionBar5:SetHeight((Size * 2) + (Spacing * 3))
	else
		ActionBar5:SetPoint("RIGHT", UIParent, "RIGHT", -72, 8)
		ActionBar5:SetHeight((Size * 12) + (Spacing * 13))
		ActionBar5:SetWidth((Size * 1) + (Spacing * 2))
	end
	
	if C.ActionBars.ShowBackdrop then
		ActionBar5:CreateBackdrop()
		ActionBar5:CreateShadow()
	end

	MultiBarLeft:SetShown(true)
	MultiBarLeft:SetParent(ActionBar5)
	MultiBarLeft.QuickKeybindGlow:SetParent(T.Hider)

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarLeftButton"..i]
		local PreviousButton = _G["MultiBarLeftButton"..i-1]

		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)
		Button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
		
		ActionBars:SkinButton(Button)

		if C.ActionBars.RightBarsAtBottom then
			if (i == 1) then
				Button:SetPoint("TOPLEFT", ActionBar5, "TOPLEFT", Spacing, -Spacing)
			elseif (i == 7) then
				Button:SetPoint("BOTTOMLEFT", ActionBar5, "BOTTOMLEFT", Spacing, Spacing)
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
			end
		else
			if (i == 1) then
				Button:SetPoint("TOPRIGHT", ActionBar5, "TOPRIGHT", -Spacing, -Spacing)
			else
				Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, -Spacing)
			end
		end

		ActionBar5["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar5, "visibility", "[vehicleui] hide; show")
	
	Movers:RegisterFrame(ActionBar5)
	
	self.Bars.Bar5 = ActionBar5
end
