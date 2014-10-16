-- BROKEN 6.0 : Priest can now have 5 Orbs instead of 3, Glyph?

local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF_ShadowOrbsBar was unable to locate oUF install')

local SHADOW_ORBS_SHOW_LEVEL = SHADOW_ORBS_SHOW_LEVEL
local PRIEST_BAR_NUM_LARGE_ORBS = PRIEST_BAR_NUM_LARGE_ORBS
local PRIEST_BAR_NUM_SMALL_ORBS = PRIEST_BAR_NUM_SMALL_ORBS
local SPELL_POWER_SHADOW_ORBS = SPELL_POWER_SHADOW_ORBS
local SHADOW_ORB_MINOR_TALENT_ID = SHADOW_ORB_MINOR_TALENT_ID
local SHADOW_ORBS_SHOW_LEVEL = SHADOW_ORBS_SHOW_LEVEL

local Colors = { 148/255, 130/255, 201/255 }

local function UpdateOrbs(self)
	
end

local function Update(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'SHADOW_ORBS')) then return end

	local pb = self.ShadowOrbsBar
	
	if(pb.PreUpdate) then
		pb:PreUpdate(unit)
	end

	local numOrbs = UnitPower("player", SPELL_POWER_SHADOW_ORBS)
	local totalOrbs = IsSpellKnown(SHADOW_ORB_MINOR_TALENT_ID) and 5 or 3
	
	for i = 1, totalOrbs do
		if i <= numOrbs then
			pb[i]:SetAlpha(1)
		else
			pb[i]:SetAlpha(.2)
		end
	end
	
	if(pb.PostUpdate) then
		return pb:PostUpdate(numOrbs)
	end
end

local Path = function(self, ...)
	return (self.ShadowOrbsBar.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'SHADOW_ORBS')
end

local function Visibility(self, event, unit)
	local pb = self.ShadowOrbsBar
	local spec = GetSpecialization()

	if (UnitLevel("player") >= SHADOW_ORBS_SHOW_LEVEL and spec == SPEC_PRIEST_SHADOW) then
		pb:Show()
		
		-- Here we set the number of orbs show
		local totalOrbs = IsSpellKnown(SHADOW_ORB_MINOR_TALENT_ID) and 5 or 3
		local totalWidth = pb:GetWidth()
		
		if totalOrbs == 5 then
			for i = 1, totalOrbs do				
				pb[i]:Show()
				pb[i]:Width(pb[i].OriginalWidth)
				pb[i]:Point("LEFT", i == 1 and pb or pb[i-1], i == 1 and "LEFT" or "RIGHT", i == 1 and 0 or 1, 0)
			end
		else
			pb[4]:Hide()
			pb[5]:Hide()
			
			for i = 1, totalOrbs do
				local Width = totalWidth / totalOrbs
				
				if i == 3 then
					pb[i]:SetPoint("RIGHT", pb, "RIGHT", 0, 0)
					pb[i]:SetPoint("LEFT", pb[i-1], "RIGHT", 1, 0)
				else
					pb[i]:Width(Width)
					pb[i]:Point("LEFT", i == 1 and pb or pb[i-1], i == 1 and "LEFT" or "RIGHT", i == 1 and 0 or 1, 0)
				end
			end		
		end
	else
		pb:Hide()
	end
end

local function Enable(self, unit)
	local pb = self.ShadowOrbsBar
	if pb and unit == "player" then
		pb.__owner = self
		pb.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER", Path)
		self:RegisterEvent("UNIT_DISPLAYPOWER", Path)	
		self:RegisterEvent("PLAYER_ENTERING_WORLD", Visibility)
		self:RegisterEvent("PLAYER_TALENT_UPDATE", Visibility)
		self:RegisterEvent("PLAYER_LEVEL_UP", Visibility)

		for i = 1, 5 do
			local Point = pb[i]
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end
			
			Point:SetStatusBarColor(unpack(Colors))
			Point:SetFrameLevel(pb:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
			Point.OriginalWidth = Point:GetWidth()
		end
		
		pb:Hide()
		
		return true
	end
end

local function Disable(self)
	local pb = self.ShadowOrbsBar
	if(pb) then
		self:UnregisterEvent("UNIT_POWER", Path)
		self:UnregisterEvent("UNIT_DISPLAYPOWER", Path)
		pb.Visibility:UnregisterEvent("PLAYER_TALENT_UPDATE")
	end
end

oUF:AddElement('ShadowOrbsBar', Update, Enable, Disable)