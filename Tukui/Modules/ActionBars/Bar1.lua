local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local Num = NUM_ACTIONBAR_BUTTONS
local MainMenuBar_OnEvent = MainMenuBar_OnEvent

function ActionBars:CreateBar1()
	local Movers = T["Movers"]
	local Size = C.ActionBars.NormalButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local Druid, Rogue, Warrior, Priest = "", "", "", ""
	local ButtonsPerRow = C.ActionBars.Bar1ButtonsPerRow
	local NumButtons = C.ActionBars.Bar1NumButtons

	if NumButtons <= ButtonsPerRow then
		ButtonsPerRow = NumButtons
	end

	local NumRow = ceil(NumButtons / ButtonsPerRow)

	local ActionBar1 = CreateFrame("Frame", "TukuiActionBar1", T.PetHider, "SecureHandlerStateTemplate")
	ActionBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 12)
	ActionBar1:SetFrameStrata("LOW")
	ActionBar1:SetFrameLevel(10)
	ActionBar1:SetWidth((Size * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)))
	ActionBar1:SetHeight((Size * NumRow) + (Spacing * (NumRow + 1)))

	if C.ActionBars.ShowBackdrop then
		ActionBar1:CreateBackdrop()
		ActionBar1:CreateShadow()
	end

	if (C.ActionBars.SwitchBarOnStance) then
		if T.WotLK then
			Rogue = "[bonusbar:1] 7; [bonusbar:2] 8;"
		else
			Rogue = "[bonusbar:1] 7;"
		end
		if T.Retail then
			Druid = "[bonusbar:1,stealth] 2; [bonusbar:1,nostealth] 7; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;"
		else
			Druid = "[bonusbar:1,stealth] 2; [bonusbar:1,nostealth] 7; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10; [bonusbar:5] 10;"
		end
		Warrior = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;"
		Priest = "[bonusbar:1] 7;"
	end

	ActionBar1.Page = {
		["DRUID"] = Druid,
		["ROGUE"] = Rogue,
		["WARRIOR"] = Warrior,
		["PRIEST"] = Priest,
		["DEFAULT"] = "[bar:6] 6;[bar:5] 5;[bar:4] 4;[bar:3] 3;[bar:2] 2;[overridebar] 14;[shapeshift] 13;[vehicleui] 12;[possessbar] 12;",
	}

	function ActionBar1:GetBar()
		local Condition = ActionBar1.Page["DEFAULT"]
		local Class = select(2, UnitClass("player"))
		local Page = ActionBar1.Page[Class]

		if Page then
			Condition = Condition .. " " .. Page
		end

		Condition = Condition .. " [form] 1; 1"

		return Condition
	end

	for i = 1, Num do
		local Button = _G["ActionButton"..i]

		ActionBar1:SetFrameRef("ActionButton"..i, Button)
	end

	ActionBar1:Execute([[
		Button = table.new()
		for i = 1, 12 do
			table.insert(Button, self:GetFrameRef("ActionButton"..i))
		end
	]])

	ActionBar1:SetAttribute("_onstate-page", [[
		if HasTempShapeshiftActionBar() then
			newstate = GetTempShapeshiftBarIndex() or newstate
		end

		for i, Button in ipairs(Button) do
			Button:SetAttribute("actionpage", tonumber(newstate))
		end
	]])

	RegisterStateDriver(ActionBar1, "page", ActionBar1.GetBar())

	ActionBar1:RegisterEvent("PLAYER_ENTERING_WORLD")

	if T.Retail then
		ActionBar1:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR")
		ActionBar1:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR")
	end

	ActionBar1:SetScript("OnEvent", function(self, event, unit, ...)
		if (event == "PLAYER_ENTERING_WORLD") then
			local NumPerRows = ButtonsPerRow
			local NextRowButtonAnchor = _G["ActionButton1"]

			for i = 1, Num do
				local Button = _G["ActionButton"..i]
				local PreviousButton = _G["ActionButton"..i-1]

				Button:SetSize(Size, Size)
				Button:ClearAllPoints()
				Button:SetParent(self)
				Button:SetAttribute("showgrid", 1)

				if T.Retail then
					Button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_EVENT)
				else
					ActionButton_ShowGrid(Button)
				end

				ActionBars:SkinButton(Button)

				if i <= NumButtons then
					if (i == 1) then
						Button:SetPoint("TOPLEFT", ActionBar1, "TOPLEFT", Spacing, -Spacing)
					elseif (i == NumPerRows + 1) then
						Button:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

						NumPerRows = NumPerRows + ButtonsPerRow
						NextRowButtonAnchor = _G["ActionButton"..i]
					else
						Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
					end
				else
					Button:SetPoint("TOP", UIParent, "TOP", 0, 200)
				end
			end
		elseif (event == "UPDATE_VEHICLE_ACTIONBAR") or (event == "UPDATE_OVERRIDE_ACTIONBAR") then
			for i = 1, 12 do
				local Button = _G["ActionButton"..i]
				local Action = Button.action
				local Icon = Button.icon

				if Action >= 120 then
					local Texture = GetActionTexture(Action)

					if (Texture) then
						Icon:SetTexture(Texture)
						Icon:Show()
					else
						if Icon:IsShown() then
							Icon:Hide()
						end
					end
				end
			end
		end
	end)

	for i = 1, Num do
		local Button = _G["ActionButton"..i]

		ActionBar1["Button"..i] = Button
	end

	Movers:RegisterFrame(ActionBar1, "Action Bar #1")

	self.Bars = {}
	self.Bars.Bar1 = ActionBar1
end
