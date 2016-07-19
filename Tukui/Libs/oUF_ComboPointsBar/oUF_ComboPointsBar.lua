local parent, ns = ...
local oUF = ns.oUF

local GetComboPoints = GetComboPoints

local Colors = {
	[1] = {.69, .31, .31, 1},
	[2] = {.65, .42, .31, 1},
	[3] = {.65, .63, .35, 1},
	[4] = {.46, .63, .35, 1},
	[5] = {.33, .63, .33, 1},
	[6] = {.33, .63, .33, 1},
	[7] = {.33, .63, .33, 1},
	[8] = {.33, .63, .33, 1},
}

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit and (powerType and (powerType ~= 'COMBO_POINTS'))) then return end

	local cpb = self.ComboPointsBar
	local points

	if UnitHasVehicleUI("player") then
		points = GetComboPoints("vehicle", "target")
	else
		points = GetComboPoints("player", "target")
	end

	if points then
		-- update combos display
		for i = 1, 8 do
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
		cpb:PostUpdate(self, points)
	end
end

local SetMaxCombo = function(self)
	local Anticipation = select(4, GetTalentInfo(3, 2, 1))
	local Deeper = select(4, GetTalentInfo(3, 1, 1))
	local cpb = self.ComboPointsBar

	if Anticipation then
		for i = 1, 8 do
			cpb[i]:SetWidth(cpb[i].Anticipation)
			cpb[i]:Show()
		end
	elseif Deeper then
		for i = 1, 8 do
			cpb[i]:SetWidth(cpb[i].Deeper)
			
			if i > 6 then
				cpb[i]:Hide()
			else
				cpb[i]:Show()
			end
		end
	else
		for i = 1, 8 do
			cpb[i]:SetWidth(cpb[i].None)
			
			if i > 5 then
				cpb[i]:Hide()
			else
				cpb[i]:Show()
			end
		end
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

		self:RegisterEvent('UNIT_POWER', Path, true)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', Path, true)
		self:RegisterEvent('PLAYER_TALENT_UPDATE', SetMaxCombo, true)

		for i = 1, 8 do
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
		self:UnregisterEvent('UNIT_POWER', Path)
		self:UnregisterEvent('PLAYER_TARGET_CHANGED', Path)
		self:UnregisterEvent('PLAYER_TALENT_UPDATE', SetMaxCombo)
	end
end

oUF:AddElement('ComboPointsBar', Path, Enable, Disable)
