local T, C, L = select(2, ...):unpack()

local _G = _G
local TukuiActionBars = T["ActionBars"]
local Num = NUM_ACTIONBAR_BUTTONS
local MainMenuBar_OnEvent = MainMenuBar_OnEvent

function TukuiActionBars:UpdateBar1()
	local ActionBar1 = T["Panels"].ActionBar1
	local Button

	for i = 1, Num do
		Button = _G["ActionButton"..i]
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
end

function TukuiActionBars:CreateBar1()
	local Panels = T["Panels"]
	local Size = C.ActionBars.NormalButtonSize
	local PetSize = C.ActionBars.PetButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local ActionBar1 = Panels.ActionBar1
	local Druid, Warrior, Priest, Rogue, Warlock, Monk = "", "", "", "", "", ""
	
	if (C.ActionBars.SwitchBarOnStance) then
		if C.ActionBars.OwnWarriorStanceBar then
			Warrior = "[stance:1] 7; [stance:2] 8; [stance:3] 9;"
		end

		if C.ActionBars.OwnShadowDanceBar then
			Rogue = "[stance:3] 10; [bonusbar:1] 7;"
		else
			Rogue = "[bonusbar:1] 7;"
		end

		if C.ActionBars.OwnMetamorphosisBar then
			Warlock = "[stance:1] 10; "
		end
		
		Druid = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10;"
		Priest = "[bonusbar:1] 7;"
		Monk = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9;"
	end

	ActionBar1.Page = {
		["DRUID"] = Druid,
		["WARRIOR"] = Warrior,
		["PRIEST"] = Priest,
		["ROGUE"] = Rogue,
		["WARLOCK"] = Warlock,
		["MONK"] = Monk,
		["DEFAULT"] = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [shapeshift] 13; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;",
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

	TukuiActionBars:UpdateBar1()

	ActionBar1:RegisterEvent("PLAYER_ENTERING_WORLD")
	ActionBar1:RegisterEvent("KNOWN_CURRENCY_TYPES_UPDATE")
	ActionBar1:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	ActionBar1:RegisterEvent("BAG_UPDATE")
	ActionBar1:SetScript("OnEvent", function(self, event, unit, ...)
		if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
			TukuiActionBars:UpdateBar1()
		elseif (event == "PLAYER_ENTERING_WORLD") then
			for i = 1, Num do
				local Button = _G["ActionButton"..i]
				Button:Size(Size)
				Button:ClearAllPoints()
				Button:SetParent(self)
				Button:SetFrameStrata("BACKGROUND")
				Button:SetFrameLevel(15)
				if (i == 1) then
					Button:SetPoint("BOTTOMLEFT", Spacing, Spacing)
				else
					local Previous = _G["ActionButton"..i-1]
					Button:SetPoint("LEFT", Previous, "RIGHT", Spacing, 0)
				end
			end
		else
			MainMenuBar_OnEvent(self, event, ...)
		end
	end)
	
	for i = 1, Num do
		local Button = _G["ActionButton"..i]
		ActionBar1["Button"..i] = Button
	end
end