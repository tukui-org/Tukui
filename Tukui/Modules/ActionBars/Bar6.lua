local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar6()
	local MultiBar5 = MultiBar5
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ButtonsPerRow = C.ActionBars.Bar5ButtonsPerRow
	local NumButtons = C.ActionBars.Bar5NumButtons

	if NumButtons <= ButtonsPerRow then
		ButtonsPerRow = NumButtons
	end

	local NumRow = ceil(NumButtons / ButtonsPerRow)

	if not C.ActionBars.Bar6 then
		Settings.SetValue("PROXY_SHOW_ACTIONBAR_6", false)

		return
	end
	
	Settings.SetValue("PROXY_SHOW_ACTIONBAR_6", true)

	local ActionBar6 = CreateFrame("Frame", "TukuiActionBar6", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar6:SetFrameStrata("LOW")
	ActionBar6:SetFrameLevel(10)
	ActionBar6:SetPoint("RIGHT", UIParent, "RIGHT", -116, 8)
	ActionBar6:SetWidth((Size * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)))
	ActionBar6:SetHeight((Size * NumRow) + (Spacing * (NumRow + 1)))

	if C.ActionBars.ShowBackdrop then
		ActionBar6:CreateBackdrop()
		ActionBar6:CreateShadow()
	end

	MultiBar5:EnableMouse(false)
	MultiBar5:SetParent(ActionBar6)

	MultiBar5.QuickKeybindGlow:SetParent(T.Hider)

	local NumPerRows = ButtonsPerRow
	local NextRowButtonAnchor = _G["MultiBar5Button1"]

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBar5Button"..i]
		local PreviousButton = _G["MultiBar5Button"..i-1]

		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)

		ActionBars:SkinButton(Button)

		if i <= NumButtons then
			if (i == 1) then
				Button:SetPoint("TOPLEFT", ActionBar6, "TOPLEFT", Spacing, -Spacing)
			elseif (i == NumPerRows + 1) then
				Button:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

				NumPerRows = NumPerRows + ButtonsPerRow
				NextRowButtonAnchor = _G["MultiBar5Button"..i]
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
			end
		else
			Button:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end

		ActionBar6["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar6, "visibility", "[vehicleui] hide; show")

	Movers:RegisterFrame(ActionBar6, "Action Bar #6")

	self.Bars.Bar6 = ActionBar6
end
