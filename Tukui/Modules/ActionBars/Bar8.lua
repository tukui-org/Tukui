local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar8()
	local MultiBar7 = MultiBar7
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ButtonsPerRow = C.ActionBars.Bar5ButtonsPerRow
	local NumButtons = C.ActionBars.Bar5NumButtons

	if NumButtons <= ButtonsPerRow then
		ButtonsPerRow = NumButtons
	end

	local NumRow = ceil(NumButtons / ButtonsPerRow)

	if not C.ActionBars.Bar8 then
		Settings.SetValue("PROXY_SHOW_ACTIONBAR_8", false)

		return
	end
	
	Settings.SetValue("PROXY_SHOW_ACTIONBAR_8", true)

	local ActionBar8 = CreateFrame("Frame", "TukuiActionBar8", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar8:SetFrameStrata("LOW")
	ActionBar8:SetFrameLevel(10)
	ActionBar8:SetPoint("RIGHT", UIParent, "RIGHT", -204, 8)
	ActionBar8:SetWidth((Size * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)))
	ActionBar8:SetHeight((Size * NumRow) + (Spacing * (NumRow + 1)))

	if C.ActionBars.ShowBackdrop then
		ActionBar8:CreateBackdrop()
		ActionBar8:CreateShadow()
	end

	MultiBar7:EnableMouse(false)
	MultiBar7:SetParent(ActionBar8)

	MultiBar7.QuickKeybindGlow:SetParent(T.Hider)

	local NumPerRows = ButtonsPerRow
	local NextRowButtonAnchor = _G["MultiBar7Button1"]

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBar7Button"..i]
		local PreviousButton = _G["MultiBar7Button"..i-1]

		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)

		ActionBars:SkinButton(Button)

		if i <= NumButtons then
			if (i == 1) then
				Button:SetPoint("TOPLEFT", ActionBar8, "TOPLEFT", Spacing, -Spacing)
			elseif (i == NumPerRows + 1) then
				Button:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

				NumPerRows = NumPerRows + ButtonsPerRow
				NextRowButtonAnchor = _G["MultiBar7Button"..i]
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
			end
		else
			Button:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end

		ActionBar8["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar8, "visibility", "[vehicleui] hide; show")

	Movers:RegisterFrame(ActionBar8, "Action Bar #8")

	self.Bars.Bar8 = ActionBar8
end