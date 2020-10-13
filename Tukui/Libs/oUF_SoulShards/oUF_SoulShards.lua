local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "oUF_WarlockSpecBars was unable to locate oUF install")

if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType  ~= "SOUL_SHARDS")) then return end

	local wsb = self.SoulShards
	local numShards = UnitPower("player", Enum.PowerType.SoulShards)
	local maxShards = UnitPowerMax("player", Enum.PowerType.SoulShards)

	if (wsb.PreUpdate) then
		wsb:PreUpdate(numShards)
	end

	for i = 1, maxShards do
		if i <= numShards then
			wsb[i]:SetAlpha(1)
		else
			wsb[i]:SetAlpha(.3)
		end
	end

	if (wsb.PostUpdate) then
		return wsb:PostUpdate(numShards)
	end
end

local Path = function(self, ...)
	return (self.SoulShards.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit, "SOUL_SHARDS")
end

local function Enable(self)
	local wsb = self.SoulShards
	if(wsb) then
		wsb.__owner = self
		wsb.ForceUpdate = ForceUpdate

		self:RegisterEvent("UNIT_POWER_UPDATE", Path)
		self:RegisterEvent("UNIT_DISPLAYPOWER", Path)

		for i = 1, 5 do
			local Point = wsb[i]
			if not Point:GetStatusBarTexture() then
				Point:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
			end

			Point:SetFrameLevel(wsb:GetFrameLevel() + 1)
			Point:GetStatusBarTexture():SetHorizTile(false)
			Point:SetStatusBarColor(148/255, 0/255, 211/255)

			if Point.bg then
				Point.bg:SetAllPoints()
			end
		end

		return true
	end
end

local function Disable(self)
	local wsb = self.SoulShards
	if(wsb) then
		self:UnregisterEvent("UNIT_POWER_UPDATE", Path)
		self:UnregisterEvent("UNIT_DISPLAYPOWER", Path)
	end
end

oUF:AddElement("SoulShards", Path, Enable, Disable)
