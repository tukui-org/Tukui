--[[
# Element: Debuff Indicator

	Shows a Debuff icon, duration and debuff type indication for debuffs the player can dispel.

## Widget

	RaidDebuffs    - A 'Frame' used to display the debuff.

## Sub-Widgets

	.icon          - The 'Texture' of the debuff
	.cd            - A 'Frame' with 'CooldownFrameTemplate'
	.timer         - A 'FontString' showing the remaining duration
	.count         - A 'FontString' showing the number of stacks
	.Backdrop      - Backdrops border is used to indicate the debuff type

## Notes

	Sub-Widgets will be created if not provided. The font options are only used in that case.
	Font defaults to (NumberFontNormal, 12, nil)

## Options

	.font          - Font used for timer and stacks (Font?)
	.fontheight    - Font height (number?)
	.fontFlags     - Font flags (string?)

## Examples

	-- position and size
	local RaidDebuffs = CreateFrame("Frame", nil, Health)
	RaidDebuffs:SetHeight(DebuffSize)
	RaidDebuffs:SetWidth(DebuffSize)
	RaidDebuffs:SetPoint("CENTER", Health)
	RaidDebuffs:SetFrameLevel(Health:GetFrameLevel() + 10)

	-- Register it with oUF
	self.RaidDebuffs = RaidDebuffs
--]]
local _, ns = ...
local oUF = ns.oUF or oUF

local IsPlayerSpell					= _G.IsPlayerSpell
local UnitCanAssist					= _G.UnitCanAssist
local GetTime						= _G.GetTime
local playerClass					= _G.UnitClassBase("player")
local GetAuraDataByAuraInstanceID	= _G.C_UnitAuras.GetAuraDataByAuraInstanceID
local GetAuraDataByIndex			= _G.C_UnitAuras.GetAuraDataByIndex
local ForEachAura					= _G.AuraUtil.ForEachAura
local NewTicker						= _G.C_Timer.NewTicker
local debuffColor					= _G.DebuffTypeColor

local cacheWrite

-- Holds the dispel priority list.
local priorityList = {
	Magic = 4,
	Curse = 3,
	Poison = 2,
	Disease = 1,
}

-- Holds which dispel types can currently be handled. Initialized to false for all.
local dispelList = {
	Magic = false,
	Poison = false,
	Disease = false,
	Curse = false,
}

-- Class functions to update the dispel types which can be handled.
local canDispel = {
	DRUID = {
		retail = function()
			dispelList["Magic"]		= IsPlayerSpell(88423)							-- Nature's Cure
			dispelList["Poison"]	= IsPlayerSpell(392378) or IsPlayerSpell(2782)	-- Improved Nature's Cure or Remove Corruption
			dispelList["Disease"]	= false
			dispelList["Curse"]		= IsPlayerSpell(392378) or IsPlayerSpell(2782)	-- Improved Nature's Cure or Remove Corruption
		end,
		classic = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= IsPlayerSpell(8946) or IsPlayerSpell(2893)	-- Cure Poison or Abolish Poison
			dispelList["Disease"]	= false
			dispelList["Curse"]		= IsPlayerSpell(2782)							-- Remove Curse
		end,
		other = function()
			dispelList["Magic"]		= IsPlayerSpell(88423)							-- Nature's Cure
			dispelList["Poison"]	= IsPlayerSpell(2782)							-- Remove Corruption
			dispelList["Disease"]	= false
			dispelList["Curse"]		= IsPlayerSpell(2782)							-- Remove Corruption
		end
	},
	MAGE = {
		retail = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= false
			dispelList["Disease"]	= false
			dispelList["Curse"]		= IsPlayerSpell(475)	-- Remove Curse
		end,
		classic = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= false
			dispelList["Disease"]	= false
			dispelList["Curse"]		= IsPlayerSpell(475)	-- Remove Curse
		end,
		other = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= false
			dispelList["Disease"]	= false
			dispelList["Curse"]		= IsPlayerSpell(475)	-- Remove Curse
		end
	},
	MONK = {
		retail = function()
			dispelList["Magic"]		= IsPlayerSpell(115450)								-- Detox
			dispelList["Poison"]	= IsPlayerSpell(388874) or IsPlayerSpell(218164)	-- Improved Detox or Detox
			dispelList["Disease"]	= IsPlayerSpell(388874) or IsPlayerSpell(218164)	-- Improved Detox or Detox
			dispelList["Curse"]		= false
		end,
		classic = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= false
			dispelList["Disease"]	= false
			dispelList["Curse"]		= false
		end,
		other = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= false
			dispelList["Disease"]	= false
			dispelList["Curse"]		= false
		end
	},
	PALADIN = {
		retail = function()
			dispelList["Magic"]		= IsPlayerSpell(4987)								-- Cleanse
			dispelList["Poison"]	= IsPlayerSpell(393024) or IsPlayerSpell(213644)	-- Improved Cleanse or Cleanse Toxins
			dispelList["Disease"]	= IsPlayerSpell(393024) or IsPlayerSpell(213644)	-- Improved Cleanse or Cleanse Toxins
			dispelList["Curse"]		= false
		end,
		classic = function()
			dispelList["Magic"]		= IsPlayerSpell(4987)								-- Cleanse
			dispelList["Poison"]	= IsPlayerSpell(4987) or IsPlayerSpell(1152)		-- Cleanse or Purify
			dispelList["Disease"]	= IsPlayerSpell(4987) or IsPlayerSpell(1152)		-- Cleanse or Purify
			dispelList["Curse"]		= false
		end,
		other = function()
			dispelList["Magic"]		= IsPlayerSpell(53551)								-- Sacred Cleansing
			dispelList["Poison"]	= IsPlayerSpell(4987) 								-- Cleanse
			dispelList["Disease"]	= IsPlayerSpell(4987)								-- Cleanse
			dispelList["Curse"]		= false
		end
	},
	PRIEST = {
		retail = function()
			dispelList["Magic"]		= IsPlayerSpell(527) or IsPlayerSpell(32375)							-- Purify or Mass Dispel
			dispelList["Poison"]	= false
			dispelList["Disease"]	= IsPlayerSpell(390632) or IsPlayerSpell(213634)						-- Improved Purify or Purify Disease
			dispelList["Curse"]		= false
		end,
		classic = function()
			dispelList["Magic"]		= IsPlayerSpell(988)													-- Dispel Magic
			dispelList["Poison"]	= false
			dispelList["Disease"]	= IsPlayerSpell(528) or IsPlayerSpell(552)								-- Cure Disease or Abolish Disease
			dispelList["Curse"]		= false
		end,
		other = function()
			dispelList["Magic"]		= IsPlayerSpell(527) and IsPlayerSpell(33167) or IsPlayerSpell(32375)	-- Dispel Magic and Absolution or Mass Dispel
			dispelList["Poison"]	= false
			dispelList["Disease"]	= IsPlayerSpell(528)													-- Cure Disease
			dispelList["Curse"]		= false
		end
	},
	SHAMAN = {
		retail = function()
			dispelList["Magic"]		= IsPlayerSpell(77130)							-- Purify Spirit
			dispelList["Poison"]	= IsPlayerSpell(383013)							-- Poison Cleansing Totem
			dispelList["Disease"]	= false
			dispelList["Curse"]		= IsPlayerSpell(383016) or IsPlayerSpell(51886)	-- Improved Purify Spirit or Cleanse Spirit
		end,
		classic = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= IsPlayerSpell(526) or IsPlayerSpell(8166)		-- Cure Poison or Poison Cleansing Totem
			dispelList["Disease"]	= IsPlayerSpell(2870) or IsPlayerSpell(8170)	-- Cure Disease or Disease Cleansing Totem
			dispelList["Curse"]		= false
		end,
		other = function()
			dispelList["Magic"]		= IsPlayerSpell(77130)							-- Improved Cleanse Spirit
			dispelList["Poison"]	= false
			dispelList["Disease"]	= false
			dispelList["Curse"]		= IsPlayerSpell(51886)							-- Cleanse Spirit
		end
	},
	EVOKER = {
		retail = function()
			dispelList["Magic"]		= IsPlayerSpell(360823)														-- Naturalize
			dispelList["Poison"]	= IsPlayerSpell(360823) or IsPlayerSpell(365585) or IsPlayerSpell(374251)	-- Naturalize or Expunge or Cauterizing Flame
			dispelList["Disease"]	= IsPlayerSpell(374251)														-- Cauterizing Flame
			dispelList["Curse"]		= IsPlayerSpell(374251)														-- Cauterizing Flame
		end,
		classic = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= false
			dispelList["Disease"]	= false
			dispelList["Curse"]		= false
		end,
		other = function()
			dispelList["Magic"]		= false
			dispelList["Poison"]	= false
			dispelList["Disease"]	= false
			dispelList["Curse"]		= false
		end
	}
}

-- Event handler for SPELLS_CHANGED.
-- Only fires for a player frame.
local function UpdateDispelList(self, event)
	if event == "SPELLS_CHANGED" then
		local project = (oUF.isRetail and "retail") or (oUF.isClassic and "classic") or "other"
		canDispel[playerClass][project]()
	end
end

-- Returns a format string for timers.
local function timeFormat(time)
	if time < 3 then
		return "%.1f"
	elseif time < 60 then
		return "%d"
	else
		return ""
	end
end

-- Show the debuff element for auraInstanceID.
local function ShowElement(self, unit, auraInstanceID)
	local element = self.RaidDebuffs
	local debuffCache = element.debuffCache
	local AuraData = debuffCache[auraInstanceID].AuraData
	local count = AuraData.applications
	local duration = AuraData.duration
	local expirationTime = AuraData.expirationTime
	local color = debuffColor[AuraData.dispelName]

	element.icon:SetTexture(AuraData.icon)
	element.Backdrop:SetBorderColor(color.r, color.g, color.b)
	element:Show()

	if duration and duration > 0 then
		local start = expirationTime - duration
		element.cd:SetCooldown(start, duration)

		if element.ticker then element.ticker:Cancel() end
		element.ticker = NewTicker(.1, function(ticker)
			local remaining = expirationTime - GetTime()
			if remaining > 0 then
				element.timer:SetFormattedText(timeFormat(remaining), remaining)
			else
				-- aura expired but we got no event for it
				ticker:Cancel()
				cacheWrite(self, unit, auraInstanceID, nil, nil)
			end
		end)
	end

	if count and count > 1 then
		element.count:SetText(count)
	end
end

-- Hide the debuff element.
local function HideElement(self, unit)
	local element = self.RaidDebuffs
	local color = debuffColor["none"]

	if element.ticker then element.ticker:Cancel() end

	element.Backdrop:SetBorderColor(color.r, color.g, color.b)
	element.cd:SetCooldown(0, 0)
	element.timer:SetText("")
	element.count:SetText("")

	element:Hide()
end

-- Select the Debuff with highest priority to display, hide element when none left.
local function SelectPrioDebuff(self, unit)
	local debuffCache = self.RaidDebuffs.debuffCache
	local auraInstanceID = nil
	local priority = 0

	-- find debuff with highest priority
	for id, debuff in pairs(debuffCache) do
		if priority < debuff.priority then
			auraInstanceID = id
			priority = debuff.priority
		end
	end

	if auraInstanceID then
		ShowElement(self, unit, auraInstanceID)
	else
		HideElement(self, unit)
	end
end

-- After each write to the cache the display also needs to be updated.
-- Struncture of the cache is: table<auraInstanceID, aura<priority, AuraData>>
cacheWrite = function(self, unit, auraInstanceID, priority, AuraData)
	local debuffCache = self.RaidDebuffs.debuffCache

	if not priority or not AuraData then
		debuffCache[auraInstanceID] = nil
	else
		debuffCache[auraInstanceID] = {
			priority = priority,
			AuraData = AuraData
		}
	end

	SelectPrioDebuff(self, unit)
end

-- Filter for dispellable debuffs and update the cache.
local function FilterAura(self, unit, auraInstanceID, AuraData)
	local debuffCache = self.RaidDebuffs.debuffCache

	if AuraData then -- added aura or valid update
		if AuraData.isHarmful then
			local dispelName = AuraData.dispelName

			if dispelName and dispelList[dispelName] then
				cacheWrite(self, unit, auraInstanceID, priorityList[dispelName], AuraData)
			end
		end
	elseif debuffCache[auraInstanceID] then -- removed aura or invalid update
		cacheWrite(self, unit, auraInstanceID, nil, nil)
	end -- aura we dont care about
end

-- Reset cache and full scan when isFullUpdate.
local function FullUpdate(self, unit)
	table.wipe(self.RaidDebuffs.debuffCache)
	HideElement(self, unit)

	if ForEachAura then
		-- Mainline iteration-style.
		ForEachAura(unit, "HARMFUL", nil,
			function(AuraData)
				FilterAura(self, unit, AuraData.auraInstanceID, AuraData)
			end,
		true)
	else
		-- Classic iteration-style.
		local AuraData
		local i = 1
		repeat
			AuraData = GetAuraDataByIndex(unit, i, "HARMFUL")
			if AuraData then
				FilterAura(self, unit, AuraData.auraInstanceID, AuraData)
			end
			i = i + 1
		until not AuraData
	end
end

-- Event handler for UNIT_AURA.
local function Update(self, event, unit, updateInfo)
	-- Exit when unit doesn't match or target can't be assisted
	if event ~= "UNIT_AURA" or self.unit ~= unit or not UnitCanAssist("player", unit) then return end

	if not updateInfo or updateInfo.isFullUpdate then
		FullUpdate(self, unit)
		return
	end

	if updateInfo.removedAuraInstanceIDs then
		for _, auraInstanceID in pairs(updateInfo.removedAuraInstanceIDs) do
			FilterAura(self, unit, auraInstanceID, nil)
		end
	end

	if updateInfo.updatedAuraInstanceIDs then
		for _, auraInstanceID in pairs(updateInfo.updatedAuraInstanceIDs) do
			FilterAura(self, unit, auraInstanceID, GetAuraDataByAuraInstanceID(unit, auraInstanceID))
		end
	end

	if updateInfo.addedAuras then
		for _, AuraData in pairs(updateInfo.addedAuras) do
			FilterAura(self, unit, AuraData.auraInstanceID, AuraData)
		end
	end
end

local function Enable(self)
	local element = self.RaidDebuffs

	if element and canDispel[playerClass] then
		element.debuffCache = {}

		element.font = element.font or NumberFontNormal
		element.fontHeight = element.fontHeight or 12
		element.fontFlags = element.fontFlags or ""

		-- Create missing Sub-Widgets
		if not element.icon then
			element.icon = element:CreateTexture(nil, "ARTWORK")
			element.icon:SetTexCoord(.1, .9, .1, .9)
			element.icon:SetInside(element)
		end

		if not element.cd then
			element.cd = CreateFrame("Cooldown", nil, element, "CooldownFrameTemplate")
			element.cd:SetInside(element, 1, 0)
			element.cd:SetReverse(true)
			element.cd:SetHideCountdownNumbers(true)
			element.cd:SetAlpha(.7)
		end

		if not element.timer then
			element.timer = element:CreateFontString(nil, "OVERLAY")
			element.timer:SetFont(element.font, element.fontHeight, element.fontFlags)
			element.timer:SetPoint("CENTER", element, 1, 0)
		end

		if not element.count then
			element.count = element:CreateFontString(nil, "OVERLAY")
			element.count:SetFont(element.font, element.fontHeight, element.fontFlags)
			element.count:SetPoint("BOTTOMRIGHT", element, "BOTTOMRIGHT", 2, 0)
			element.count:SetTextColor(1, .9, 0)
		end

		if not element.Backdrop then
			element:CreateBackdrop()
		end

		-- Update the dispelList at login and whenever spells change (only fires for a player frame)
		self:RegisterEvent("SPELLS_CHANGED", UpdateDispelList, true)
		self:RegisterEvent("UNIT_AURA", Update)

		HideElement(self, self.unit)

		return true
	end
end

local function Disable(self)
	local element = self.RaidDebuffs

	if element then
		element.debuffCache = nil
		self:UnregisterEvent("SPELLS_CHANGED", UpdateDispelList)
		self:UnregisterEvent("UNIT_AURA", Update)
	end
end

oUF:AddElement("RaidDebuffs", Update, Enable, Disable)
