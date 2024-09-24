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

local AtonementID = 194384
local AtonementIDPvP = 214206

--[[ Find the Atonement buffs.

* self				- oUF UnitFrame
* unit				- Tracked unit
* AuraData			- (optional) UNIT_AURA event payload

* returns			true, if no further scanning needed (found or no more data)
]]
local function FindAtonement(self, unit, AuraData)
	local element = self.Atonement

	if not AuraData then
		-- no more auras to check
		return true
	elseif AuraData.spellId == AtonementID or AuraData.spellId == AtonementIDPvP then
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

--[[ Full scan when isFullUpdate.

* self				- oUF UnitFrame
* unit				- Tracked unit
]]
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

local function Update(self, event, unit, updateInfo)
	-- Exit when unit doesn't match or target can't be assisted
	if event ~= "UNIT_AURA" or self.unit ~= unit or not UnitCanAssist("player", unit) then return end

	if not updateInfo or updateInfo.isFullUpdate then
		FullUpdate(self, unit)
		return
	end

	-- not needed: if updateInfo.removedAuraInstanceIDs then ___ end

	if updateInfo.updatedAuraInstanceIDs then
		for _, auraInstanceID in pairs(updateInfo.updatedAuraInstanceIDs) do
			if auraInstanceID then
				FindAtonement(self, unit, GetAuraDataByAuraInstanceID(unit, auraInstanceID))
			end
		end
	end

	if updateInfo.addedAuras then
		for _, AuraData in pairs(updateInfo.addedAuras) do
			FindAtonement(self, unit, AuraData)
		end
	end
end

--[[ Activate updates when Discipline. ]]
local function CheckSpec(self, event)
	local element = self.Atonement
	local SpecIndexDiscipline = 1

	if GetSpecialization() == SpecIndexDiscipline then
		self:RegisterEvent("UNIT_AURA", Update)
	else
		if element.ticker then element.ticker:Cancel() end
		element:SetValue(0)
		element:Hide()

		self:UnregisterEvent("UNIT_AURA", Update)
	end
end

local function Enable(self)
	local element = self.Atonement

	-- need for Atonement buff to transfer healing was only introduced after MoP
	if element and oUF.isRetail and playerClass == "PRIEST" then
		self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", CheckSpec, true)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", CheckSpec, true)

		element:SetMinMaxValues(0, 15)
		element:SetValue(0)
		element:SetStatusBarColor(207/255, 181/255, 59/255)

		if not element.Backdrop then
			element.Backdrop = self.Atonement:CreateTexture(nil, "BACKGROUND")
			element.Backdrop:SetAllPoints()
			element.Backdrop:SetColorTexture(207/255 * 0.2, 181/255 * 0.2, 59/255 * 0.2)
		end

		return true
	end
end

local function Disable(self)
	local element = self.Atonement

	if element then
		self:UnregisterEvent("UNIT_AURA", Update)
		self:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED", CheckSpec)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", CheckSpec)
	end
end

oUF:AddElement("Atonement", Update, Enable, Disable)
