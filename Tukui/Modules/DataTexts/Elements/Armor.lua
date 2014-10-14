local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format

local Update = function(self)
	local Value = select(2, UnitArmor("player"))
	
	self.Text:SetFormattedText("%s: %s", DataText.NameColor .. L.DataText.Armor .. "|r", DataText.ValueColor .. T.Comma(Value) .. "|r")
end

local Enable = function(self)
	self:RegisterEvent("UNIT_STATS")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:SetScript("OnEvent", Update)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
end

DataText:Register(L.DataText.Armor, Enable, Disable, Update)