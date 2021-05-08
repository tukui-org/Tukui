local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar5()
	local MultiBarLeft = MultiBarLeft
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ButtonsPerRow = C.ActionBars.Bar5ButtonsPerRow
	local NumButtons = C.ActionBars.Bar5NumButtons
	
	if NumButtons <= ButtonsPerRow then
		ButtonsPerRow = NumButtons
	end
	
	local NumRow = ceil(NumButtons / ButtonsPerRow)
	
	if not C.ActionBars.LeftBar then
		MultiBarLeft:SetShown(false)

		return
	end
	
	local ActionBar5 = CreateFrame("Frame", "TukuiActionBar5", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar5:SetFrameStrata("LOW")
	ActionBar5:SetFrameLevel(10)
	ActionBar5:SetPoint("RIGHT", UIParent, "RIGHT", -72, 8)
	ActionBar5:SetWidth((Size * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)))
	ActionBar5:SetHeight((Size * NumRow) + (Spacing * (NumRow + 1)))
	
	if C.ActionBars.ShowBackdrop then
		ActionBar5:CreateBackdrop()
		ActionBar5:CreateShadow()
	end

	MultiBarLeft:SetShown(true)
	MultiBarLeft:SetParent(ActionBar5)
	
	if T.Retail then
		MultiBarLeft.QuickKeybindGlow:SetParent(T.Hider)
	end
	
	local NumPerRows = ButtonsPerRow
	local NextRowButtonAnchor = _G["MultiBarLeftButton1"]

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBarLeftButton"..i]
		local PreviousButton = _G["MultiBarLeftButton"..i-1]
		
		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)

		if T.Retail then
			Button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
		end

		ActionBars:SkinButton(Button)
		
		if i <= NumButtons then
			if (i == 1) then
				Button:SetPoint("TOPLEFT", ActionBar5, "TOPLEFT", Spacing, -Spacing)
			elseif (i == NumPerRows + 1) then
				Button:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

				NumPerRows = NumPerRows + ButtonsPerRow
				NextRowButtonAnchor = _G["MultiBarLeftButton"..i]
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
			end
		else
			Button:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end

		ActionBar5["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar5, "visibility", "[vehicleui] hide; show")
	
	Movers:RegisterFrame(ActionBar5, "Action Bar #5")
	
	self.Bars.Bar5 = ActionBar5
end
