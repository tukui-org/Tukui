local parent, ns = ...
local oUF = ns.oUF

--[[
	By Tukz, for Tukui

	.Thickness : Thickness of the statusbar
	.Tracker : Table of buffs spell id to track
	.Texture : Texture you want to use for status bars

	Example:
		local StatusTrack = CreateFrame("Frame", nil, Health)
		StatusTrack:SetAllPoints()
		StatusTrack.Texture = C.Medias.Normal

		self.StatusTrack = StatusTrack
]]

-- Note to me, need to update colors, taken from t18 for now
local Tracker = {
	--[[ PRIEST ]]
	[194384] = {1, 1, 0.66}, -- Atonement
	[214206] = {1, 1, 0.66}, -- Atonement PVP
	[41635] = {0.2, 0.7, 0.2}, -- Prayer of mending
	[193065] = {0.54, 0.21, 0.78}, -- Masochism
	[139] = {0.4, 0.7, 0.2}, -- Renew
	[17] = {0, 1, 0}, -- Power Word: Shield
	[47788] = {0.86, 0.45, 0}, -- Guardian Spirit
	[33206] = {0.47, 0.35, 0.74}, -- Pain Supression
	
	--[[ DRUID ]]
	[774] = {0.8, 0.4, 0.8}, -- Rejuvenation
	[155777] = {0.8, 0.4, 0.8}, -- Germination
	[8936] = {0.2, 0.8, 0.2}, -- Regrowth
	[33763] = {0.4, 0.8, 0.2}, -- Lifebloom
	[48438] = {0.8, 0.4, 0}, -- Wild Growth
	[207386] = {0.4, 0.2, 0.8}, -- Spring Blossoms
	[102351] = {0.2, 0.8, 0.8},  -- Cenarion Ward (Initial Buff)
	[102352] = {0.2, 0.8, 0.8}, -- Cenarion Ward (HoT)
	[200389] = {1, 1, 0.4}, -- Cultivation
	
	--[[ PALADIN ]]
	[53563] = {0.7, 0.3, 0.7}, -- Beacon of Light
	[156910] = {0.7, 0.3, 0.7}, -- Beacon of Faith
	[200025] = {0.7, 0.3, 0.7}, -- Beacon of Virtue
	[1022] = {0.2, 0.2, 1}, -- Hand of Protection
	[1044] = {0.89, 0.45, 0}, -- Hand of Freedom
	[6940] = {0.89, 0.1, 0.1}, -- Hand of Sacrifice
	[223306] = {0.7, 0.7, 0.3}, -- Bestow Faith
	
	--[[ SHAMAN ]]
	[61295] = {0.7, 0.3, 0.7}, -- Riptide
	[974] = {0.2, 0.2, 1}, -- Earth Shield
	
	--[[ MONK ]]
	[119611] = {0.3, 0.8, 0.6}, -- Renewing Mist
	[116849] = {0.2, 0.8, 0.2}, -- Life Cocoon
	[124682] = {0.8, 0.8, 0.25}, -- Enveloping Mist
	[191840] = {0.27, 0.62, 0.7}, -- Essence Font
	
	--[[ ROGUE ]]
	[57934] = {0.89, 0.09, 0.05}, -- Tricks of the Trade
	
	--[[ WARRIOR ]]
	[114030] = {0.2, 0.2, 1}, -- Vigilance
	[122506] = {0.89, 0.09, 0.05}, -- Intervene
}

local OnUpdate = function(self)
	local Time = GetTime()
	local Timeleft = self.Expiration - Time
	local Duration = self.Duration
	
	self:SetMinMaxValues(0, Duration)
	self:SetValue(Timeleft)
	
	if Timeleft <= 0 then
		self:SetScript("OnUpdate", nil)
		self:Hide()
	end
end

local UpdateBars = function(self, unit, spellID, id, expiration, duration)
	local StatusTrack = self.StatusTrack
	local r, g, b = unpack(Tracker[spellID])
	local Orientation = self.Health:GetOrientation()
	local Position = (id * StatusTrack.Thickness) - StatusTrack.Thickness
	local X = Orientation == "VERTICAL" and -Position or 0
	local Y = Orientation == "HORIZONTAL" and -Position or 0
	local SizeX = Orientation == "VERTICAL" and StatusTrack.Thickness or StatusTrack:GetWidth()
	local SizeY = Orientation == "VERTICAL" and StatusTrack:GetHeight() or StatusTrack.Thickness

	if not StatusTrack[id] then
		StatusTrack[id] = CreateFrame("StatusBar", nil, StatusTrack)
		
		StatusTrack[id]:SetSize(SizeX, SizeY)
		StatusTrack[id]:SetPoint("TOPRIGHT", X, Y)
		
		if Orientation == "VERTICAL" then
			StatusTrack[id]:SetOrientation("VERTICAL")
		end
		
		StatusTrack[id].Backdrop = StatusTrack[id]:CreateTexture(nil, "BACKGROUND")
		StatusTrack[id].Backdrop:SetAllPoints()
		StatusTrack[id].Backdrop:SetColorTexture(r * 0.2, g * 0.2, b * 0.2)
	end
	
	StatusTrack[id].Expiration = expiration
	StatusTrack[id].Duration = duration
	StatusTrack[id]:SetStatusBarTexture(StatusTrack.Texture)
	StatusTrack[id]:SetStatusBarColor(r, g, b)
	StatusTrack[id]:SetScript("OnUpdate", OnUpdate)
	StatusTrack[id]:Show()
end

local Update = function(self, event, unit)
	local ID = 1
	
	for i = 1, 40 do
		local name, texture, count, debuffType, duration, expiration, caster, isStealable,
			nameplateShowSelf, spellID, canApply, isBossDebuff, casterIsPlayer, nameplateShowAll,
			timeMod, effect1, effect2, effect3 = UnitAura(unit, i, "HELPFUL")
		
		if self.StatusTrack.Tracker[spellID] and caster == "player" then
			UpdateBars(self, unit, spellID, ID, expiration, duration)
			
			ID = ID + 1
		end
	end
	
	for i = ID + 1, 8 do
		if self.StatusTrack[ID] and self.StatusTrack[ID]:IsShown() then
			self.StatusTrack[ID]:SetScript("OnUpdate", nil)
			self.StatusTrack[ID]:Hide()
		end
	end
end

local Path = function(self, ...)
	return (self.StatusTrack.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, "ForceUpdate", element.__owner.unit)
end

local function Enable(self)
	local StatusTrack = self.StatusTrack
	
	if (StatusTrack) then
		StatusTrack.__owner = self
		StatusTrack.ForceUpdate = ForceUpdate
		
		StatusTrack.Tracker = StatusTrack.Tracker or Tracker
		StatusTrack.Thickness = StatusTrack.Thickness or 5
		StatusTrack.Texture = StatusTrack.Texture or [[Interface\\TargetingFrame\\UI-StatusBar]]

		self:RegisterEvent("UNIT_AURA", Path)

		return true
	end
end

local function Disable(self)
	local StatusTrack = self.StatusTrack
	
	if (StatusTrack) then
		self:UnregisterEvent("UNIT_AURA", Path)
	end
end

oUF:AddElement("StatusTrack", Path, Enable, Disable)