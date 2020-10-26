local parent, ns = ...
local oUF = ns.oUF

local GetComboPoints = GetComboPoints
local MaxComboPts = 6

local Colors = {
	[1] = {.69, .31, .31, 1},
	[2] = {.65, .42, .31, 1},
	[3] = {.65, .63, .35, 1},
	[4] = {.50, .63, .35, 1},
	[5] = {.33, .63, .33, 1},
	[6] = {.03, .63, .33, 1},
}

local SetMaxCombo = function(self)
	local cpb = self.ComboPointsBar
	local MaxCombo = UnitPowerMax("player", Enum.PowerType.ComboPoints)

	if MaxCombo == MaxComboPts then
		for i = 1, MaxComboPts do
			cpb[i]:SetWidth(cpb[i].Size6Points)
			cpb[i]:Show()
		end
	else
		for i = 1, MaxComboPts do
			cpb[i]:SetWidth(cpb[i].Size5Points)
			
			if i > 5 then
				cpb[i]:Hide()
			else
				cpb[i]:Show()
			end
		end
	end
	
	cpb.MaxCombo = MaxCombo
end

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit and (powerType and (powerType ~= 'COMBO_POINTS'))) then return end

	local cpb = self.ComboPointsBar
	local points
	local max = UnitPowerMax("player", Enum.PowerType.ComboPoints)
	local currentmax = cpb.MaxCombo

	if cpb.PreUpdate then
		cpb:PreUpdate(points)
	end
	
	if max ~= currentmax then
		SetMaxCombo(self)
	end
	
	if UnitHasVehicleUI("player") then
		points = GetComboPoints("vehicle", "target")
	else
		points = GetComboPoints("player", "target")
	end

	if points then
		-- update combos display
		for i = 1, MaxComboPts do
			if i <= points then
				cpb[i]:SetAlpha(1)
			else
				cpb[i]:SetAlpha(.3)
			end
		end
	end

	if points > 0 then
		cpb:Show()
	else
		cpb:Hide()
	end

	if cpb.PostUpdate then
		cpb:PostUpdate(points)
	end
end

local Path = function(self, ...)
	return (self.ComboPointsBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, "COMBO_POINTS")
end

local Enable = function(self, unit)
	local cpb = self.ComboPointsBar
	if(cpb) then
		cpb.__owner = self
		cpb.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER_UPDATE', Path)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', Path, true)
		self:RegisterEvent('PLAYER_TALENT_UPDATE', SetMaxCombo, true)

		for i = 1, MaxComboPts do
			local Point = cpb[i]
			
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end

			Point:SetStatusBarColor(unpack(Colors[i]))
			Point:SetFrameLevel(cpb:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
			
			Point.Width = Point:GetWidth()
		end
		
		cpb:Hide()
		
		SetMaxCombo(self)

		return true
	end
end

local Disable = function(self)
	local cpb = self.ComboPointsBar
	if(cpb) then
		self:UnregisterEvent('UNIT_POWER_UPDATE', Path)
		self:UnregisterEvent('PLAYER_TARGET_CHANGED', Path)
		self:UnregisterEvent('PLAYER_TALENT_UPDATE', SetMaxCombo)
	end
end

oUF:AddElement('ComboPointsBar', Path, Enable, Disable)