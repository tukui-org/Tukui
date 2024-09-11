--[=[
	Shows Debuffs on Unit Frames

	Sub Widgets
	.icon			Icon/Texture of the debuff
	.cd 			Cooldown frame
	.count			Number of Stacks
--]=]
local _, ns = ...
local oUF = ns.oUF or oUF


local IsPlayerSpell = _G.IsPlayerSpell
local UnitCanAssist = _G.UnitCanAssist
local playerClass = UnitClassBase("player")
local debuffColor = DebuffTypeColor
local debuffCache = {}

-- dispel priority? magic <- curse <- poison <- disease


-- Holds which dispell types can currently be handled
-- Initialized to false for all types
local dispellist = {
	Magic = false,
	Poison = false,
	Disease = false,
	Curse = false
}


-- Class functions to update the dispell types which can be handled
local CanDispel = {
	DRUID = function()
		dispellist["Magic"]   = IsPlayerSpell(88423)							-- Nature's Cure
		dispellist["Poison"]  = IsPlayerSpell(392378) or IsPlayerSpell(2782)	-- Improved Nature's Cure or Remove Corruption
		dispellist["Disease"] = false
		dispellist["Curse"]   = IsPlayerSpell(392378) or IsPlayerSpell(2782)	-- Improved Nature's Cure or Remove Corruption
	end,
	MAGE = function()
		dispellist["Magic"]   = false
		dispellist["Poison"]  = false
		dispellist["Disease"] = false
		dispellist["Curse"]   = IsPlayerSpell(475)								-- Remove Curse
	end,
	MONK = function()
		dispellist["Magic"]   = IsPlayerSpell(115450)							-- Detox
		dispellist["Poison"]  = IsPlayerSpell(388874) or IsPlayerSpell(218164)	-- Improved Detox or Detox
		dispellist["Disease"] = IsPlayerSpell(388874) or IsPlayerSpell(218164)	-- Improved Detox or Detox
		dispellist["Curse"]   = false
	end,
	PALADIN = function()
		dispellist["Magic"]   = IsPlayerSpell(4987)								-- Cleanse
		dispellist["Poison"]  = IsPlayerSpell(393024) or IsPlayerSpell(213644)	-- Improved Cleanse or Cleanse Toxins
		dispellist["Disease"] = IsPlayerSpell(393024) or IsPlayerSpell(213644)	-- Improved Cleanse or Cleanse Toxins
		dispellist["Curse"]   = false
	end,
	PRIEST = function()
		dispellist["Magic"]   = IsPlayerSpell(527)								-- Purify
		dispellist["Poison"]  = false
		dispellist["Disease"] = IsPlayerSpell(390632) or IsPlayerSpell(213634)	-- Improved Purify or Purify Disease
		dispellist["Curse"]   = false
	end,
	SHAMAN = function()
		dispellist["Magic"]   = IsPlayerSpell(77130)							-- Purify Spirit
		dispellist["Poison"]  = IsPlayerSpell(383013)							-- Poison Cleansing Totem
		dispellist["Disease"] = false
		dispellist["Curse"]   = IsPlayerSpell(383016) or IsPlayerSpell(51886)	-- Improved Purify Spirit or Cleanse Spirit
	end,
	EVOKER = function()
		dispellist["Magic"]   = IsPlayerSpell(360823)							-- Naturalize
		dispellist["Poison"]  = IsPlayerSpell(360823) or IsPlayerSpell(365585) or IsPlayerSpell(374251) -- Naturalize or Expunge or Cauterizing Flame
		dispellist["Disease"] = IsPlayerSpell(374251)							-- Cauterizing Flame
		dispellist["Curse"]   = IsPlayerSpell(374251)							-- Cauterizing Flame
	end
}


-- Event handler for Player Login and Speels Changed
local function UpdateDispelList(self, event)
	if event == "PLAYER_LOGIN" or event == "SPELLS_CHANGED" then
		CanDispel[playerClass]()
	end
end


-- Show the debuff
-- @self		UnitFrame
-- @AuraData	AuraData object provided by UNIT_AURA event
local function Set(self, AuraData)
	local element = self.RaidDebuffs

	local count = AuraData.applications
	local duration = AuraData.duration
	local color = debuffColor[AuraData.dispelName]

	element.icon:SetTexture(AuraData.icon)
	element.Backdrop:SetBorderColor(color.r, color.g, color.b)

	if duration and duration > 0 then
		element.cd:SetCooldown(AuraData.expirationTime - duration, duration)
	end

	if count and count > 1 then
		element.count:SetText(count)
	end

	element:Show()
end


-- Hide the debuff
-- @self 		UnitFrame
local function Reset(self)
	local element = self.RaidDebuffs
	local color = debuffColor["none"]

	element.Backdrop:SetBorderColor(color.r, color.g, color.b)
	element.cd:SetCooldown(0, 0)
	element.count:SetText("")

	element:Hide()
end


-- Event handler for Unit Aura
-- @self		UnitFrame
-- @event		UNIT_AURA
-- @unit		payload of event: unitTarget
-- @updateInfo	payload of event: UnitAuraUpdateInfo
local function Update(self, event, unit, updateInfo)
	-- Exit when unit doesn't match or no updateInfo provided or target can't be assisted
	if event ~= "UNIT_AURA" or self.unit ~= unit or not updateInfo or not UnitCanAssist("player", unit) then return end
	local element = self.RaidDebuffs

	if updateInfo.removedAuraInstanceIDs then
		for _, auraInstanceID in pairs(updateInfo.removedAuraInstanceIDs) do
			if debuffCache[auraInstanceID] then
				debuffCache[auraInstanceID] = nil
				Reset(self)
			end
		end
	end

	if updateInfo.addedAuras then
		for _, AuraData in pairs(updateInfo.addedAuras) do
			if AuraData.dispelName and dispellist[AuraData.dispelName] then
				debuffCache[AuraData.auraInstanceID] = true
				Set(self, AuraData)
			end
		end
	end
end


-- oUF Enable function
local function Enable(self)
	local element = self.RaidDebuffs

	if oUF.isRetail and element and CanDispel[playerClass] then
		element:CreateBackdrop()

		if not element.icon then
			element.icon = element:CreateTexture(nil, "ARTWORK")
			element.icon:SetTexCoord(.1, .9, .1, .9)
			element.icon:SetInside(element)
		end

		if not element.cd then
			element.cd = CreateFrame("Cooldown", nil, element, "CooldownFrameTemplate")
			element.cd:SetInside(element, 1, 0)
			element.cd:SetReverse(true)
			element.cd:SetHideCountdownNumbers(false)
			element.cd:SetAlpha(.7)
		end

		if not element.count then
			element.count = element:CreateFontString(nil, "OVERLAY")
			element.count:SetFont(C.Medias.Font, 12, "OUTLINE")
			element.count:SetPoint("BOTTOMRIGHT", element, "BOTTOMRIGHT", 2, 0)
			element.count:SetTextColor(1, .9, 0)
		end

		-- Update the dispelList at login and whenever spells change (talent or spec change)
		self:RegisterEvent("PLAYER_LOGIN", UpdateDispelList, true)
		self:RegisterEvent("SPELLS_CHANGED", UpdateDispelList, true)
		self:RegisterEvent("UNIT_AURA", Update)

		return true
	end
end


-- oUF Disable function
local function Disable(self)
	local element = self.DebuffHighlight

	if element then
		self:UnregisterEvent("PLAYER_LOGIN", UpdateDispelList, true)
		self:UnregisterEvent("SPELLS_CHANGED", UpdateDispelList, true)
		self:UnregisterEvent("UNIT_AURA", Update)
	end
end


if oUF.isRetail then
	oUF:AddElement("RaidDebuffs", Update, Enable, Disable)
end