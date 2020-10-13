local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local Class = select(2, UnitClass("player"))

local Update = function(self)
	local Value, Spell
	local Base, PosBuff, NegBuff = UnitAttackPower("player")
	local Effective = Base + PosBuff + NegBuff
	local RangedBase, RangedPosBuff, RangedNegBuff = UnitRangedAttackPower("player")
	local RangedEffective = RangedBase + RangedPosBuff + RangedNegBuff
	local SpellPower = GetSpellBonusDamage(7)
	local AttackPower = Effective
	local Text = L.DataText.AttackPower

	if (AttackPower > SpellPower and Class ~= "HUNTER") then
		Value = AttackPower
	elseif (Class == "HUNTER") then
		Value = RangedEffective
	else
		Value = SpellPower
		Text = L.DataText.Spell
	end

	self.Text:SetFormattedText("%s %s", DataText.NameColor .. Text .. "|r", DataText.ValueColor .. T.Comma(Value) .. "|r")
end

local Enable = function(self)
	self:RegisterEvent("UNIT_AURA")
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

DataText:Register("Power", Enable, Disable, Update)
