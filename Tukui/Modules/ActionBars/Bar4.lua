local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar4()
	local MultiBarRight = MultiBarRight
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	
	if not C.ActionBars.RightBar then
		MultiBarRight:SetShown(false)

		return
	end
	
	local ActionBar4 = CreateFrame("Frame", "TukuiActionBar4", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar4:SetFrameStrata("LOW")
	ActionBar4:SetFrameLevel(10)
	
	if C.ActionBars.RightBarsAtBottom then
		ActionBar4:SetPoint("BOTTOM", UIParent, "BOTTOM", -504, 12)
		ActionBar4:SetWidth((Size * 6) + (Spacing * 7))
		ActionBar4:SetHeight((Size * 2) + (Spacing * 3))
	else
		ActionBar4:SetPoint("RIGHT", UIParent, "RIGHT", -28, 8)
		ActionBar4:SetHeight((Size * 12) + (Spacing * 13))
		ActionBar4:SetWidth((Size * 1) + (Spacing * 2))
	end
	
	if C.ActionBars.ShowBackdrop then
		ActionBar4:CreateBackdrop()
		ActionBar4:CreateShadow()
	end

	MultiBarRight:SetShown(true)
	MultiBarRight:SetParent(ActionBar4)
	MultiBarRight.QuickKeybindGlow:SetParent(T.Hider)

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarRightButton"..i]
		local PreviousButton = _G["MultiBarRightButton"..i-1]

		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)
		Button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
		
		ActionBars:SkinButton(Button)
		
		if C.ActionBars.RightBarsAtBottom then
			if (i == 1) then
				Button:SetPoint("TOPLEFT", ActionBar4, "TOPLEFT", Spacing, -Spacing)
			elseif (i == 7) then
				Button:SetPoint("BOTTOMLEFT", ActionBar4, "BOTTOMLEFT", Spacing, Spacing)
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
			end
		else
			if (i == 1) then
				Button:SetPoint("TOPRIGHT", ActionBar4, "TOPRIGHT", -Spacing, -Spacing)
			else
				Button:SetPoint("TOP", PreviousButton, "BOTTOM", 0, -Spacing)
			end
		end

		ActionBar4["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar4, "visibility", "[vehicleui] hide; show")
	
	Movers:RegisterFrame(ActionBar4)
	
	self.Bars.Bar4 = ActionBar4
end
