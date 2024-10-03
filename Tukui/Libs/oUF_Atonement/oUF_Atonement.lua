--[[
# Element: Atonement Indicator

	Provides an indication of active Atonement buffs on units.

## Widget

	Atonement - A 'StatusBar' indicating the presence of an Atonement buff.

## Sub-Widgets

	.Backdrop - A 'Texture' used as background.

## Notes

	A background will be created if not provided.

## Examples

	-- position and size
	local Atonement = CreateFrame("StatusBar", nil, Health)
	Atonement:SetHeight(6)
	Atonement:SetPoint("BOTTOMLEFT", Health, "BOTTOMLEFT")
	Atonement:SetPoint("BOTTOMRIGHT", Health, "BOTTOMRIGHT")
	Atonement:SetStatusBarTexture(healthTexture)
	Atonement:SetFrameLevel(Health:GetFrameLevel() + 1)

	-- Register it with oUF
	self.Atonement = Atonement
]]
local _, ns = ...
local oUF = ns.oUF or _G.oUF
assert(oUF, "oUF_Atonement cannot find an instance of oUF. If your oUF is embedded into a layout, it may not be embedded properly.")

local UnitCanAssist					= _G.UnitCanAssist
local GetSpecialization				= _G.GetSpecialization
local AuraUtil						= _G.AuraUtil
local GetAuraDataByIndex			= _G.C_UnitAuras.GetAuraDataByIndex
local GetAuraDataByAuraInstanceID	= _G.C_UnitAuras.GetAuraDataByAuraInstanceID
local NewTicker						= _G.C_Timer.NewTicker
local GetTime						= _G.GetTime
local playerClass					= _G.UnitClassBase("player")

local ATONEMENT_ID = 194384
local ATONEMENT_PVP_ID = 214206

local Active = false

-- Filter function to find the Atonement buffs.
-- Returns true, if no further scanning needed (found or no more data) to shorten a full update.
local function FindAtonement(self, unit, AuraData)
	local element = self.Atonement

	if not AuraData then
		-- no more auras to check
		return true
	elseif AuraData.spellId == ATONEMENT_ID or AuraData.spellId == ATONEMENT_PVP_ID then
		element:SetMinMaxValues(0, AuraData.duration)
		element:Show()

		if element.ticker then element.ticker:Cancel() end
		element.ticker = NewTicker(.1, function(ticker)
			local remaining = AuraData.expirationTime - GetTime()
			if remaining > 0 then
				element:SetValue(remaining)
			else
				ticker:Cancel()
				element:SetValue(0)
				element:Hide()
			end
		end)

		-- found, no further scanning needed
		return true
	end
end

-- Full scan when isFullUpdate.
local function FullUpdate(self, unit)
	if AuraUtil then
		AuraUtil.ForEachAura(unit, "HELPFUL|PLAYER", nil,
			function(AuraData)
				return FindAtonement(self, unit, AuraData)
			end,
		true)
	else
		local i = 1
		while not FindAtonement(self, unit, GetAuraDataByIndex(unit, i, "HELPFUL|PLAYER")) do
			i = i + 1
		end
	end
end

-- Activate element for Discipline.
local function CheckSpec(self, event)
	local element = self.Atonement
	local SpecIndexDiscipline = 1

	if GetSpecialization() == SpecIndexDiscipline then
		Active = true
	else
		if element.ticker then element.ticker:Cancel() end
		element:SetValue(0)
		element:Hide()

		Active = false
	end
end

local function Update(self, event, unit, updateInfo)
	-- Exit when unit doesn't match or target can't be assisted
	if not Active or event ~= "UNIT_AURA" or self.unit ~= unit or not UnitCanAssist("player", unit) then return end

	if not updateInfo or updateInfo.isFullUpdate then
		FullUpdate(self, unit)
		return
	end

	-- not needed: if updateInfo.removedAuraInstanceIDs then ___ end

	if updateInfo.updatedAuraInstanceIDs then
		for _, auraInstanceID in pairs(updateInfo.updatedAuraInstanceIDs) do
				FindAtonement(self, unit, GetAuraDataByAuraInstanceID(unit, auraInstanceID))
		end
	end

	if updateInfo.addedAuras then
		for _, AuraData in pairs(updateInfo.addedAuras) do
			FindAtonement(self, unit, AuraData)
		end
	end
end

local function Enable(self)
	local element = self.Atonement

	-- need for Atonement buff to transfer healing was only introduced after MoP
	if element and oUF.isRetail and playerClass == "PRIEST" then
		self:RegisterEvent("SPELLS_CHANGED", CheckSpec, true)
		self:RegisterEvent("UNIT_AURA", Update)

		element:SetMinMaxValues(0, 15)
		element:SetValue(0)
		element:SetStatusBarColor(207/255, 181/255, 59/255)

		if not element.Backdrop then
			element.Backdrop = self.Atonement:CreateTexture(nil, "BACKGROUND")
			element.Backdrop:SetAllPoints()
			element.Backdrop:SetColorTexture(207/255 * 0.2, 181/255 * 0.2, 59/255 * 0.2)
		end

		element:Hide()

		return true
	end
end

local function Disable(self)
	local element = self.Atonement

	if element then
		self:UnregisterEvent("SPELLS_CHANGED", CheckSpec)
		self:UnregisterEvent("UNIT_AURA", Update)
	end
end

oUF:AddElement("Atonement", Update, Enable, Disable)
