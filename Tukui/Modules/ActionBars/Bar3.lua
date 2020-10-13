local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar3()
	local MultiBarBottomRight = MultiBarBottomRight
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	
	if not C.ActionBars.BottomRightBar then
		MultiBarBottomRight:SetShown(false)
		
		return
	end
	
	-- Bar #3
	local ActionBar3 = CreateFrame("Frame", "TukuiActionBar3", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar3:SetPoint("BOTTOM", UIParent, "BOTTOM", 251, 12)
	ActionBar3:SetFrameStrata("LOW")
	ActionBar3:SetFrameLevel(10)
	ActionBar3:SetWidth((Size * 6) + (Spacing * 7))
	ActionBar3:SetHeight((Size * 2) + (Spacing * 3))
	
	if C.ActionBars.ShowBackdrop then
		ActionBar3:CreateBackdrop()
		ActionBar3:CreateShadow()
	end

	MultiBarBottomRight:SetShown(true)
	MultiBarBottomRight:SetParent(ActionBar3)
	MultiBarBottomRight.QuickKeybindGlow:SetParent(T.Hider)

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomRightButton"..i]
		local PreviousButton = _G["MultiBarBottomRightButton"..i-1]

		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)
		Button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
		
		ActionBars:SkinButton(Button)

		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar3, "TOPLEFT", Spacing, -Spacing)
		elseif (i == 7) then
			Button:SetPoint("BOTTOMLEFT", ActionBar3, "BOTTOMLEFT", Spacing, Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end

		ActionBar3["Button"..i] = Button
	end
	
	RegisterStateDriver(ActionBar3, "visibility", "[vehicleui] hide; show")
	
	Movers:RegisterFrame(ActionBar3)
	
	self.Bars.Bar3 = ActionBar3
end
