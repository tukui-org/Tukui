local parent, ns = ...
local oUF = ns.oUF

local GetComboPoints = GetComboPoints
local MaxComboPts = 6
local Retail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
local BCC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
local Classic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC

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
	local UnitChargedPowerPoints = GetUnitChargedPowerPoints and GetUnitChargedPowerPoints("player")
	local ChargedPoint = UnitChargedPowerPoints and UnitChargedPowerPoints[1]

	if cpb.PreUpdate then
		cpb:PreUpdate(points)
	end
	
	if max ~= currentmax then
		SetMaxCombo(self)
	end
	
	if UnitHasVehicleUI and UnitHasVehicleUI("player") then
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
			
			cpb[i]:SetStatusBarColor(unpack(cpb.Colors[i]))
		end
	end
	
	if ChargedPoint then
		cpb[ChargedPoint]:SetStatusBarColor(unpack(cpb.Colors[7]))
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
		cpb.Colors = {
			[1] = {1, 0, 0, 1}, -- Combo 1
			[2] = {1, 0, 0, 1}, -- Combo 2
			[3] = {1, 0, 0, 1}, -- Combo 3
			[4] = {1, 0, 0, 1}, -- Combo 4
			[5] = {1, 0, 0, 1}, -- Combo 5
			[6] = {1, 0, 0, 1}, -- Combo 6
			[7] = {.33, .73, 1, 1}, -- Echoing Reprimand Highlight
		}

		self:RegisterEvent('UNIT_POWER_UPDATE', Path)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', Path, true)
				
		if Retail then
			self:RegisterEvent('PLAYER_TALENT_UPDATE', SetMaxCombo, true)
			self:RegisterEvent('UNIT_POWER_POINT_CHARGE', Path)
		end

		for i = 1, MaxComboPts do
			local Point = cpb[i]
			
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end

			Point:SetStatusBarColor(unpack(cpb.Colors[i]))
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
		
		if Retail then
			self:UnregisterEvent('PLAYER_TALENT_UPDATE', SetMaxCombo)
			self:UnregisterEvent('UNIT_POWER_POINT_CHARGE', Path)
		end
	end
end

oUF:AddElement('ComboPointsBar', Path, Enable, Disable)