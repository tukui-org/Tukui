local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local select = select
local UnitAffectingCombat = UnitAffectingCombat
local max = math.max

local PlayerGUID = UnitGUID("player")
local Events = {
	SPELL_HEAL = true,
	SPELL_PERIODIC_HEAL = true
}

local tslu = 1
local TotalHeals = 0
local CombatTime = 0
local AmountHealed = 0
local OverHeals = 0

local GetHPS = function()
	if (TotalHeals == 0) then
		return (DataText.ValueColor.."0.0 |r" .. DataText.NameColor..L.DataText.HPS.."|r")
	else
		return format(DataText.ValueColor.."%.1fk |r" .. DataText.NameColor .. L.DataText.HPS .. "|r", ((TotalHeals or 0) / (CombatTime or 1)) / 1000)
	end
end

-- Awkward workaround to make an event delegation system
local CreateFunctions = function(self)
	function self:COMBAT_LOG_EVENT_UNFILTERED(...)
		if (not Events[select(2, ...)]) then
			return
		end

		--if (event == "PLAYER_REGEN_DISABLED") then return end

		local ID = select(4, ...)

		if (ID == PlayerGUID) then
			AmountHealed = select(15, ...)
			OverHeals = select(16, ...)
			TotalHeals = TotalHeals + max(0, AmountHealed - OverHeals)
		end
	end

	function self:PLAYER_REGEN_ENABLED()
		self.Text:SetText(GetHPS())
	end

	function self:PLAYER_REGEN_DISABLED()
		TotalHeals = 0
		CombatTime = 0
		AmountHealed = 0
		OverHeals = 0
	end

	self.Functions = true
end

local OnUpdate = function(self, t)
	if UnitAffectingCombat("player") then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		CombatTime = CombatTime + t
	else
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end

	tslu = tslu + t

	if (tslu >= 1) then
		tslu = 0
		self.Text:SetText(GetHPS())
	end
end

local Update = function(self, event, ...)
	if (not event) then -- On Enable
		self.Text:SetText(GetHPS())
	else
		self[event](self, ...)
	end
end

local OnMouseDown = function()
	TotalHeals = 0
	CombatTime = 0
	AmountHealed = 0
	OverHeals = 0
end

local Enable = function(self)
	if (not self.Functions) then
		CreateFunctions(self)
	end

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	--self:RegisterEvent("UNIT_PET")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnUpdate", OnUpdate)
	self:SetScript("OnMouseDown", OnMouseDown)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnUpdate", nil)
	self:SetScript("OnMouseDown", nil)
end

DataText:Register("HPS", Enable, Disable, Update)
