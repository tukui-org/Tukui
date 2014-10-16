local parent, ns = ...
local oUF = ns.oUF
if not oUF then return end
if select(2, UnitClass('player')) ~= "ROGUE" then return end

local Colors = { 
	[1] = {.69, .31, .31, 1},
	[2] = {.65, .42, .31, 1},
	[3] = {.65, .63, .35, 1},
	[4] = {.46, .63, .35, 1},
	[5] = {.33, .63, .33, 1},
}

local Update = function(self, event, unit)
	local ab = self.AnticipationBar
	local Anticipation = IsSpellKnown(114015)
	
	if not Anticipation then
		return
	end
	
	local count = select(4, UnitBuff("player", GetSpellInfo(115189))) or 0

	if ab.PreUpdate then
		ab:PreUpdate(self, count)
	end

	if count then
		-- update combos display
		for i = 1, 5 do
			if i <= count then
				ab[i]:SetAlpha(1)
			else
				ab[i]:SetAlpha(.2)
			end
		end
	end
	
	if count > 0 then
		ab:Show()
	else
		ab:Hide()
	end
	
	if ab.PostUpdate then
		ab:PostUpdate(self, count)
	end
end

local Path = function(self, ...)
	return (self.AnticipationBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local Enable = function(self)
	local ab = self.AnticipationBar
	if(ab) then
		ab.__owner = self
		ab.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_AURA', Path)
		
		for i = 1, 5 do
			local Point = ab[i]
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end
			
			Point:SetStatusBarColor(unpack(Colors[i]))
			Point:SetFrameLevel(ab:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
		end
		
		ab:Hide()

		return true
	end
end

local Disable = function(self)
	local ab = self.AnticipationBar
	if(ab) then
		self:UnregisterEvent('UNIT_AURA', Path)
	end
end

oUF:AddElement('AnticipationBar', Path, Enable, Disable)
