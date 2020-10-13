local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local Value = select(2, UnitArmor("player"))

local Update = function(self)
	self.Text:SetFormattedText("%s %s", DataText.NameColor .. RESISTANCE0_NAME .. "|r", DataText.ValueColor .. T.Comma(Value) .. "|r")
end

local OnEnter = function(self)
	self.Text:SetFormattedText("%s %s", DataText.HighlightColor .. RESISTANCE0_NAME .. "|r", DataText.HighlightColor .. T.Comma(Value) .. "|r")
end

local OnLeave = function(self)
	self.Text:SetFormattedText("%s %s", DataText.NameColor .. RESISTANCE0_NAME .. "|r", DataText.ValueColor .. T.Comma(Value) .. "|r")
end

local Enable = function(self)
	self:RegisterEvent("UNIT_STATS")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:SetScript("OnEvent", Update)
	self:Update()
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
end

DataText:Register("Armor", Enable, Disable, Update)