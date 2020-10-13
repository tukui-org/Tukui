local _, ns = ...
local oUF = ns.oUF or oUF
if not oUF then return end

if select(2, UnitClass('player')) ~= "MAGE" then return end

local Colors = { 104/255, 205/255, 255/255 }

local Update = function(self, event, unit, powerType)
	if unit ~= "player" and powerType ~= "ARCANE_CHARGES" then
		return
	end

	local bar = self.ArcaneChargeBar
	local power = UnitPower("player", Enum.PowerType.ArcaneCharges, true)
	

	if(bar.PreUpdate) then bar:PreUpdate(power) end

	if bar:IsShown() then
		for i = 1, 4 do
			if i <= power then
				bar[i]:SetAlpha(1)
			else
				bar[i]:SetAlpha(.3)
			end
		end
	end

	if(bar.PostUpdate) then
		return bar:PostUpdate(power)
	end
end

local function Visibility(self, event, unit)
	local bar = self.ArcaneChargeBar
	local spec = GetSpecialization()

	if spec == 1 then
		bar:Show()
	else
		bar:Hide()
	end
	
	Update(self, nil, "player", "ARCANE_CHARGES")
end

local Path = function(self, ...)
	return (self.ArcaneChargeBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, "ARCANE_CHARGES")
end

local function Enable(self, unit)
	local bar = self.ArcaneChargeBar

	if(bar) then
		bar.__owner = self
		bar.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER_UPDATE", Path)
		self:RegisterEvent("PLAYER_TALENT_UPDATE", Visibility, true)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Visibility, true)

		for i = 1, 4 do
			if not bar[i]:GetStatusBarTexture() then
				bar[i]:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end

			bar[i]:SetFrameLevel(bar:GetFrameLevel() + 1)
			bar[i]:GetStatusBarTexture():SetHorizTile(false)
			bar[i]:SetStatusBarColor(unpack(Colors))
		end

		bar:Hide()

		return true
	end
end

local function Disable(self,unit)
	local bar = self.ArcaneChargeBar

	if(bar) then
		self:UnregisterEvent("UNIT_POWER_UPDATE", Path)
		self:UnregisterEvent("PLAYER_TALENT_UPDATE", Visibility)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", Visibility)
	end
end

oUF:AddElement("ArcaneChargeBar",Path,Enable,Disable)
