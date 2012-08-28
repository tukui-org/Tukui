local _, ns = ...
local oUF = ns.oUF or oUF
if not oUF then return end

if select(2, UnitClass('player')) ~= "MAGE" then return end

local Colors = { 104/255, 205/255, 255/255 }

local function UpdateBar(self, elapsed)
	if not self.expirationTime then return end
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed >= 0.5 then	
		local timeLeft = self.expirationTime - GetTime()
		if timeLeft > 0 then
			self:SetValue(timeLeft)
		else
			self:SetScript("OnUpdate", nil)
		end
	end		
end

local Update = function(self, event)
	local unit = self.unit or 'player'
	local bar = self.ArcaneChargeBar
	if(bar.PreUpdate) then bar:PreUpdate(event) end
	
	local arcaneCharges, maxCharges, duration, expirationTime = 0, 6
	if bar:IsShown() then
		for i = 1, 40 do
			local count, _, start, timeLeft, _, _, _, spellID = select(4, UnitDebuff(unit, i))
			if spellID == 36032 then
				arcaneCharges = count or 0
				duration = start
				expirationTime = timeLeft
			end
		end	

		for i = 1, maxCharges do
			if duration and expirationTime then
				bar[i]:SetMinMaxValues(0, duration)
				bar[i].duration = duration
				bar[i].expirationTime = expirationTime
			end
			
			if i <= arcaneCharges then
				bar[i]:SetValue(duration)
				bar[i]:SetScript('OnUpdate', UpdateBar)
			else
				bar[i]:SetValue(0)
				bar[i]:SetScript('OnUpdate', nil)
			end
		end		
	end
	
	if(bar.PostUpdate) then
		return bar:PostUpdate(event, arcaneCharges, maxCharges)
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
end

local Path = function(self, ...)
	return (self.ArcaneChargeBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self, unit)
	local bar = self.ArcaneChargeBar

	if(bar) then
		bar.__owner = self
		bar.ForceUpdate = ForceUpdate
		
		self:RegisterEvent("UNIT_AURA", Path)
		
		-- why the fuck does PLAYER_TALENT_UPDATE doesnt trigger on initial login when I register to: self or self.PluginName
		bar.Visibility = CreateFrame("Frame", nil, bar)
		bar.Visibility:RegisterEvent("PLAYER_TALENT_UPDATE")
		bar.Visibility:SetScript("OnEvent", function(frame, event, unit) Visibility(self, event, unit) end)

		for i = 1, 6 do
			if not bar[i]:GetStatusBarTexture() then
				bar[i]:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end

			bar[i]:SetFrameLevel(bar:GetFrameLevel() + 1)
			bar[i]:GetStatusBarTexture():SetHorizTile(false)
			bar[i]:SetStatusBarColor(unpack(Colors))
			bar[i]:SetMinMaxValues(0, 1)
			bar[i]:SetValue(0)
			
			if bar[i].bg then
				bar[i].bg:SetAlpha(0.15)
				bar[i].bg:SetAllPoints()
				bar[i].bg:SetTexture(unpack(Colors))
			end	
		end
		
		return true
	end	
end

local function Disable(self,unit)
	local bar = self.ArcaneChargeBar

	if(bar) then
		self:UnregisterEvent("UNIT_AURA", Path)
		bar.Visibility:UnregisterEvent("PLAYER_TALENT_UPDATE")
	end
end
			
oUF:AddElement("ArcaneChargeBar",Path,Enable,Disable)