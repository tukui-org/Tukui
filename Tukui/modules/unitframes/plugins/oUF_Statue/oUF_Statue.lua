local T, C, L, G = unpack(select(2, ...)) 
local class = select(2, UnitClass('player'))
if class ~= "MONK" and class ~= "PRIEST" and class ~= "WARRIOR" and class ~= "DEATHKNIGHT" then return end

local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF_Statue was unable to locate oUF install')

local Colors
if class == "MONK" then
	Colors = { 95/255, 222/255,  95/255 }
elseif class == "PRIEST" then
	Colors = { 238/255, 221/255,  130/255 }
elseif class == "WARRIOR" then
	Colors = { 205/255, 92/255,  92/255 }
elseif class == "DEATHKNIGHT" then
	Colors = { .6, .4, 0 }
end

local function UpdateStatueTimer(self, elapsed)
	if not self.expirationTime then return end
	self.expirationTime = self.expirationTime - elapsed
	
	local timeLeft = self.expirationTime
	if timeLeft > 0 then
		self:SetValue(timeLeft)
	else
		self:SetScript("OnUpdate", nil)
	end
end

local function UpdateStatue(self, event)
	local ms = self.Statue
	local slot = 1
	
	if(ms.PreUpdate) then
		ms:PreUpdate(slot)
	end

	local up, name, start, duration, icon = GetTotemInfo(slot)
	if (up) then
		local timeLeft = (start+duration) - GetTime()
		ms.duration = duration
		ms.expirationTime = timeLeft
		ms:SetMinMaxValues(0, duration)
		ms:SetScript('OnUpdate', UpdateStatueTimer)
		
		ms:Show()
	else
		ms:SetValue(0)
		ms:SetScript("OnUpdate", nil)
		
		ms:Hide()
	end
	
	if(ms.PostUpdate) then
		return ms:PostUpdate(slot, up, name, start, duration, icon)
	end
end

local Path = function(self, ...)
	return (self.Statue.Override or UpdateStatue) (self, ...)
end

local Update = function(self, event, ...)
	Path(self, event)
end

local ForceUpdate = function(element)
	return Update(element.__owner, 'ForceUpdate')
end

local function Enable(self, unit)
	local ms = self.Statue
	if ms and unit == "player" then
		ms.__owner = self
		ms.ForceUpdate = ForceUpdate

		self:RegisterEvent("PLAYER_TOTEM_UPDATE", Path, true)		

		if not ms:GetStatusBarTexture() then
			ms:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
		end
		
		ms:SetStatusBarColor(unpack(Colors))
		ms:SetFrameLevel(ms:GetFrameLevel() + 1)
		ms:GetStatusBarTexture():SetHorizTile(false)
		ms:SetMinMaxValues(0, 300)
		ms:SetValue(0)
		
		if ms.bg then
			ms.bg:SetAlpha(0.15)
			ms.bg:SetAllPoints()
			ms.bg:SetTexture(unpack(Colors))
		end
		
		local Destroy = CreateFrame("Button", nil, ms)
		Destroy:SetAllPoints()
		Destroy:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		Destroy.ID = 1
		Destroy:SetScript("OnClick", function(self)
			if IsShiftKeyDown() then
				DestroyTotem(Destroy.ID)
			end
		end)
		
		ms:Hide()

		return true
	end
end

local function Disable(self)
	local ms = self.Statue
	if(ms) then
		self:UnregisterEvent("PLAYER_TOTEM_UPDATE", Path)
	end
end

oUF:AddElement('Statue', Update, Enable, Disable)