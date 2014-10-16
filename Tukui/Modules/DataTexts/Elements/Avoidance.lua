local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local abs = abs

local Dodge, Parry, Block, Avoidance, TargetLevel, PlayerLevel, BaseMissChance, LevelDifference
local MyRace = select(2, UnitRace("Player"))
local GetBlockChance = GetBlockChance
local GetParryChance = GetParryChance
local GetDodgeChance = GetDodgeChance

local Update = function(self)
	TargetLevel = UnitLevel("target")
	PlayerLevel = UnitLevel("player")
	local BaseMissChance, LevelDifference, Avoidance
	
	if TargetLevel == -1 then
		BaseMissChance = (5 - (3*.2))  --Boss Value
		LevelDifference = 3
	elseif TargetLevel > PlayerLevel then
		BaseMissChance = (5 - ((TargetLevel - PlayerLevel)*.2)) --Mobs above player level
		LevelDifference = (TargetLevel - PlayerLevel)
	elseif TargetLevel < PlayerLevel and TargetLevel > 0 then
		BaseMissChance = (5 + ((PlayerLevel - TargetLevel)*.2)) --Mobs below player level
		LevelDifference = (TargetLevel - PlayerLevel)
	else
		BaseMissChance = 5 --Sets miss chance of attacker level if no target exists, lv80=5, 81=4.2, 82=3.4, 83=2.6
		LevelDifference = 0
	end
	
	if (MyRace == "NightElf") then
		BaseMissChance = BaseMissChance + 2
	end

	if (LevelDifference >= 0) then
		Dodge = (GetDodgeChance() - LevelDifference * 0.2)
		Parry = (GetParryChance() - LevelDifference * 0.2)
		Block = (GetBlockChance() - LevelDifference * 0.2)
		Avoidance = (Dodge + Parry + Block)
		
		self.Text:SetText(DataText.NameColor..L.DataText.AvoidanceShort.."|r"..DataText.ValueColor..format("%.2f", Avoidance).."|r")
	else
		Dodge = (GetDodgeChance() + abs(LevelDifference * 0.2))
		Parry = (GetParryChance() + abs(LevelDifference * 0.2))
		Block = (GetBlockChance() + abs(LevelDifference * 0.2))
		Avoidance = (Dodge + Parry + Block)
		
		self.Text:SetText(DataText.NameColor..L.DataText.AvoidanceShort.."|r"..DataText.ValueColor..format("%.2f", Avoidance).."|r")
	end
end

local OnEnter = function(self)
	if (not InCombatLockdown()) then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		
		if (TargetLevel > 1) then
			GameTooltip:AddDoubleLine(L.DataText.AvoidanceBreakdown.." ("..L.DataText.Level.." "..TargetLevel..")")
		elseif (TargetLevel == -1) then
			GameTooltip:AddDoubleLine(L.DataText.AvoidanceBreakdown.." ("..L.DataText.Boss..")")
		else
			GameTooltip:AddDoubleLine(L.DataText.AvoidanceBreakdown.." ("..L.DataText.Level.." "..TargetLevel..")")
		end
		
		GameTooltip:AddDoubleLine(L.DataText.Dodge, format("%.2f", Dodge) .. "%", 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(L.DataText.Parry, format("%.2f", Parry) .. "%", 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(L.DataText.Block, format("%.2f", Block) .. "%", 1, 1, 1, 1, 1, 1)
		GameTooltip:Show()
	end
end

local OnLeave = function()
	GameTooltip:Hide()
end

local Enable = function(self)
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register(L.DataText.Avoidance, Enable, Disable, Update)