local T, C, L = unpack((select(2, ...)))

local DataText = T["DataTexts"]
local format = format
local Class = select(2, UnitClass("player"))

local Update = function(self)
	local Melee = GetCritChance()
	local Spell = GetSpellCritChance(1)
	local Ranged = GetRangedCritChance()
	local Value

	if (Spell > Melee) then
		Value = Spell
	elseif (Class == "HUNTER") then
		Value = Ranged
	else
		Value = Melee
	end

	self.Text:SetFormattedText("%s %s%.2f%%", DataText.NameColor .. L.DataText.Crit .. "|r", DataText.ValueColor, Value)
end

local Enable = function(self)
	self:RegisterEvent("UNIT_STATS")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", Update)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
end

DataText:Register("Crit", Enable, Disable, Update)
