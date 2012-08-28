local T, C, L, G = unpack(select(2, ...)) 
if select(2, UnitClass('player')) ~= "PRIEST" then return end

local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF_ShadowOrbsBar was unable to locate oUF install')

local SHADOW_ORBS_SHOW_LEVEL = SHADOW_ORBS_SHOW_LEVEL
local PRIEST_BAR_NUM_ORBS = PRIEST_BAR_NUM_ORBS
local SPELL_POWER_SHADOW_ORBS = SPELL_POWER_SHADOW_ORBS

local Colors = { 212/255, 212/255, 212/255 }

local function Update(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'SHADOW_ORBS')) then return end

	local pb = self.ShadowOrbsBar
	
	if(pb.PreUpdate) then
		pb:PreUpdate(unit)
	end

	local numOrbs = UnitPower("player", SPELL_POWER_SHADOW_ORBS)
	
	for i = 1, PRIEST_BAR_NUM_ORBS do
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

	if spec == SPEC_PRIEST_SHADOW then
		pb:Show()
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
		
		-- why the fuck does PLAYER_TALENT_UPDATE doesnt trigger on initial login when I register to: self
		pb.Visibility = CreateFrame("Frame", nil, pb)
		pb.Visibility:RegisterEvent("PLAYER_TALENT_UPDATE")
		pb.Visibility:SetScript("OnEvent", function(frame, event, unit) Visibility(self, event, unit) end)

		for i = 1, 3 do
			local Point = pb[i]
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end
			
			Point:SetStatusBarColor(unpack(Colors))
			Point:SetFrameLevel(pb:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
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