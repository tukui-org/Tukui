if(select(2, UnitClass('player')) ~= 'PALADIN') then return end

local parent, ns = ...
local oUF = ns.oUF

local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER
local COLORS = {228/255,225/255,16/255}

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'HOLY_POWER')) then return end

	local hp = self.HolyPower
	if(hp.PreUpdate) then hp:PreUpdate() end

	local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
	local numMax = UnitPowerMax('player', SPELL_POWER_HOLY_POWER)
	local barWidth = self.HolyPower:GetWidth()
	local spacing = select(4, self.HolyPower[4]:GetPoint())
	local lastBar = 0
	
	if numMax ~= self.HolyPower.maxPower then
		if numMax == 3 then
			self.HolyPower[4]:Hide()
			self.HolyPower[5]:Hide()
			for i = 1, 3 do
				if i ~= 3 then
					self.HolyPower[i]:SetWidth(barWidth / 3)
					lastBar = lastBar + (barWidth / 3 + spacing)
				else
					self.HolyPower[i]:SetWidth(barWidth - lastBar)
				end
			end
		else
			self.HolyPower[4]:Show()
			self.HolyPower[5]:Show()
			for i = 1, 5 do
				self.HolyPower[i]:SetWidth(self.HolyPower[i].width)
			end
		end
		self.HolyPower.maxPower = numMax
	end

	for i = 1, 5 do
		if(i <= num) then
			self.HolyPower[i]:SetAlpha(1)
		else
			self.HolyPower[i]:SetAlpha(.2)
		end
	end

	if(hp.PostUpdate) then
		return hp:PostUpdate(num)
	end
end

local Path = function(self, ...)
	return (self.HolyPower.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'HOLY_POWER')
end

local function Enable(self)
	local hp = self.HolyPower
	if(hp) then
		hp.__owner = self
		hp.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER', Path)
		
		for i = 1, 5 do
			if not hp[i]:GetStatusBarTexture() then
				hp[i]:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end
			
			hp[i].width = hp[i]:GetWidth()
		end

		return true
	end
end

local function Disable(self)
	local hp = self.HolyPower
	if(hp) then
		self:UnregisterEvent('UNIT_POWER', Path)
	end
end

oUF:AddElement('HolyPower', Path, Enable, Disable)
