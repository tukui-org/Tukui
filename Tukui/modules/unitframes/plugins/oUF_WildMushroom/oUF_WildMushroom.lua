local T, C, L, G = unpack(select(2, ...)) 
if select(2, UnitClass('player')) ~= "DRUID" then return end

local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF_WildMushroom was unable to locate oUF install')

local Colors = { 95/255, 222/255,  95/255 }

local function UpdateMushroomTimer(self, elapsed)
	if not self.expirationTime then return end
	self.expirationTime = self.expirationTime - elapsed
	
	local timeLeft = self.expirationTime
	if timeLeft > 0 then
		self:SetValue(timeLeft)
	else
		self:SetScript("OnUpdate", nil)
	end
end

local function UpdateMushroom(self, event, slot)
	local m = self.WildMushroom
	local bar = m[slot]
	
	if not bar then return end
	
	if(m.PreUpdate) then
		m:PreUpdate(slot)
	end

	local up, name, start, duration, icon = GetTotemInfo(slot)
	if (up) then
		local timeLeft = (start+duration) - GetTime()
		bar.duration = duration
		bar.expirationTime = timeLeft
		bar:SetMinMaxValues(0, duration)
		bar:SetScript('OnUpdate', UpdateMushroomTimer)
	else
		bar:SetValue(0)
		bar:SetScript("OnUpdate", nil)
	end
	
	if(m.PostUpdate) then
		return m:PostUpdate(slot, up, name, start, duration, icon)
	end
end

local Path = function(self, ...)
	return (self.WildMushroom.Override or UpdateMushroom) (self, ...)
end

local Update = function(self, event)
	for i = 1, 3 do
		Path(self, event, i)
	end
end

local ForceUpdate = function(element)
	return Update(element.__owner, 'ForceUpdate')
end

local function Visibility(self, event, unit)
	local m = self.WildMushroom
	local spec = GetSpecialization()
	
	if spec == 1 or spec == 4 then
		m:Show()
	else
		m:Hide()
	end
end

local function Enable(self, unit)
	local m = self.WildMushroom
	if m and unit == "player" then
		m.__owner = self
		m.ForceUpdate = ForceUpdate

		self:RegisterEvent("PLAYER_TOTEM_UPDATE", Path, true)		
		
		-- why the fuck does PLAYER_TALENT_UPDATE doesnt trigger on initial login when I register to: self
		m.Visibility = CreateFrame("Frame", nil, m)
		m.Visibility:RegisterEvent("PLAYER_TALENT_UPDATE")
		m.Visibility:SetScript("OnEvent", function(frame, event, unit) Visibility(self, event, unit) end)

		for i = 1, 3 do
			local Point = m[i]
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end
			
			Point:SetStatusBarColor(unpack(Colors))
			Point:SetFrameLevel(m:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
			Point:SetMinMaxValues(0, 300)
			Point:SetValue(0)
			
			if Point.bg then
				Point.bg:SetAlpha(0.15)
				Point.bg:SetAllPoints()
				Point.bg:SetTexture(unpack(Colors))
			end	
		end

		return true
	end
end

local function Disable(self)
	local m = self.WildMushroom
	if(m) then
		self:UnregisterEvent("PLAYER_TOTEM_UPDATE", Path)
		m.Visibility:UnregisterEvent("PLAYER_TALENT_UPDATE")
	end
end

oUF:AddElement('WildMushroom', Update, Enable, Disable)