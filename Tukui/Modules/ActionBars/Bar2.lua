local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar2()
	local MultiBarBottomLeft = MultiBarBottomLeft
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	
	if not C.ActionBars.BottomLeftBar then
		MultiBarBottomLeft:SetShown(false)
		
		return
	end
	
	local ActionBar2 = CreateFrame("Frame", "TukuiActionBar2", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar2:SetPoint("BOTTOM", UIParent, "BOTTOM", -251, 12)
	ActionBar2:SetFrameStrata("LOW")
	ActionBar2:SetFrameLevel(10)
	ActionBar2:SetWidth((Size * 6) + (Spacing * 7))
	ActionBar2:SetHeight((Size * 2) + (Spacing * 3))
	
	if C.ActionBars.ShowBackdrop then
		ActionBar2:CreateBackdrop()
		ActionBar2:CreateShadow()
	end

	MultiBarBottomLeft:SetShown(true)
	MultiBarBottomLeft:SetParent(ActionBar2)
	MultiBarBottomLeft.QuickKeybindGlow:SetParent(T.Hider)

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local PreviousButton = _G["MultiBarBottomLeftButton"..i-1]

		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)
		Button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
		
		ActionBars:SkinButton(Button)

		if (i == 1) then
			Button:SetPoint("TOPLEFT", ActionBar2, "TOPLEFT", Spacing, -Spacing)
		elseif (i == 7) then
			Button:SetPoint("BOTTOMLEFT", ActionBar2, "BOTTOMLEFT", Spacing, Spacing)
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end

		ActionBar2["Button"..i] = Button
	end

	for i = 7, 12 do
		local Button = _G["MultiBarBottomLeftButton"..i]
		local Button1 = _G["MultiBarBottomLeftButton1"]

		Button:SetFrameLevel(Button1:GetFrameLevel() - 2)
	end
	
	RegisterStateDriver(ActionBar2, "visibility", "[vehicleui] hide; show")

	Movers:RegisterFrame(ActionBar2)
	
	self.Bars.Bar2 = ActionBar2
end
