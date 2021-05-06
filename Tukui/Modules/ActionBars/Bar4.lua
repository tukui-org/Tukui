local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar4()
	local MultiBarRight = MultiBarRight
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ButtonsPerRow = C.ActionBars.Bar4ButtonsPerRow
	local NumButtons = C.ActionBars.Bar4NumButtons
	
	if NumButtons <= ButtonsPerRow then
		ButtonsPerRow = NumButtons
	end
	
	local NumRow = ceil(NumButtons / ButtonsPerRow)
	
	if not C.ActionBars.RightBar then
		MultiBarRight:SetShown(false)

		return
	end
	
	local ActionBar4 = CreateFrame("Frame", "TukuiActionBar4", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar4:SetFrameStrata("LOW")
	ActionBar4:SetFrameLevel(10)
	ActionBar4:SetPoint("RIGHT", UIParent, "RIGHT", -28, 8)
	ActionBar4:SetWidth((Size * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)))
	ActionBar4:SetHeight((Size * NumRow) + (Spacing * (NumRow + 1)))
	
	if C.ActionBars.ShowBackdrop then
		ActionBar4:CreateBackdrop()
		ActionBar4:CreateShadow()
	end

	MultiBarRight:SetShown(true)
	MultiBarRight:SetParent(ActionBar4)
	
	if T.Retail then
		MultiBarRight.QuickKeybindGlow:SetParent(T.Hider)
	end
	
	local NumPerRows = ButtonsPerRow
	local NextRowButtonAnchor = _G["MultiBarRightButton1"]

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarRightButton"..i]
		local PreviousButton = _G["MultiBarRightButton"..i-1]
		
		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)
		
		if T.Retail then
			Button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
		end

		ActionBars:SkinButton(Button)
		
		if i <= NumButtons then
			if (i == 1) then
				Button:SetPoint("TOPLEFT", ActionBar4, "TOPLEFT", Spacing, -Spacing)
			elseif (i == NumPerRows + 1) then
				Button:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

				NumPerRows = NumPerRows + ButtonsPerRow
				NextRowButtonAnchor = _G["MultiBarRightButton"..i]
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
			end
		else
			Button:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end

		ActionBar4["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar4, "visibility", "[vehicleui] hide; show")
	
	Movers:RegisterFrame(ActionBar4, "Action Bar #4")
	
	self.Bars.Bar4 = ActionBar4
end
