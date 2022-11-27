local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function ActionBars:CreateBar7()
	local MultiBar6 = MultiBar6
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ButtonsPerRow = C.ActionBars.Bar5ButtonsPerRow
	local NumButtons = C.ActionBars.Bar5NumButtons

	if NumButtons <= ButtonsPerRow then
		ButtonsPerRow = NumButtons
	end

	local NumRow = ceil(NumButtons / ButtonsPerRow)

	if not C.ActionBars.Bar7 then
		Settings.SetValue("PROXY_SHOW_ACTIONBAR_7", false)

		return
	end
	
	Settings.SetValue("PROXY_SHOW_ACTIONBAR_7", true)

	local ActionBar7 = CreateFrame("Frame", "TukuiActionBar7", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar7:SetFrameStrata("LOW")
	ActionBar7:SetFrameLevel(10)
	ActionBar7:SetPoint("RIGHT", UIParent, "RIGHT", -160, 8)
	ActionBar7:SetWidth((Size * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)))
	ActionBar7:SetHeight((Size * NumRow) + (Spacing * (NumRow + 1)))

	if C.ActionBars.ShowBackdrop then
		ActionBar7:CreateBackdrop()
		ActionBar7:CreateShadow()
	end

	MultiBar6:EnableMouse(false)
	MultiBar6:SetParent(ActionBar7)

	MultiBar6.QuickKeybindGlow:SetParent(T.Hider)

	local NumPerRows = ButtonsPerRow
	local NextRowButtonAnchor = _G["MultiBar6Button1"]

	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local Button = _G["MultiBar6Button"..i]
		local PreviousButton = _G["MultiBar6Button"..i-1]

		Button:SetSize(Size, Size)
		Button:ClearAllPoints()
		Button:SetAttribute("showgrid", 1)

		ActionBars:SkinButton(Button)

		if i <= NumButtons then
			if (i == 1) then
				Button:SetPoint("TOPLEFT", ActionBar7, "TOPLEFT", Spacing, -Spacing)
			elseif (i == NumPerRows + 1) then
				Button:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

				NumPerRows = NumPerRows + ButtonsPerRow
				NextRowButtonAnchor = _G["MultiBar6Button"..i]
			else
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
			end
		else
			Button:SetPoint("TOP", UIParent, "TOP", 0, 200)
		end

		ActionBar7["Button"..i] = Button
	end

	RegisterStateDriver(ActionBar7, "visibility", "[vehicleui] hide; show")

	Movers:RegisterFrame(ActionBar7, "Action Bar #7")

	self.Bars.Bar7 = ActionBar7
end