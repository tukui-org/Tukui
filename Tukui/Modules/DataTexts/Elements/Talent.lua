local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format
local CharacterSpec = ""
local LootSpec = ""

local Update = function(self)
	local Tree = GetSpecialization()

	if (not Tree) then
		self.Text:SetText(L.DataText.NoTalent) 
	else
		local Spec = select(2, GetSpecializationInfo(Tree)) or ""
		local Loot = GetLootSpecialization()
		
		if (Loot == 0) then
			Loot = select(2, GetSpecializationInfo(Tree))
		else
			Loot = select(2, GetSpecializationInfoByID(Loot))
		end
		
		CharacterSpec = Spec
		LootSpec = Loot
		
		self.Text:SetText(DataText.NameColor.."S:|r "..DataText.ValueColor..Spec.."|r")
	end
end

local OnEnter = function(self)
	if InCombatLockdown() then
		return
	end
	
	if ((CharacterSpec == "") or (LootSpec == "")) then
		return
	end
	
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	
	GameTooltip:AddLine(format(LOOT_SPECIALIZATION_DEFAULT, CharacterSpec))
	GameTooltip:AddLine(format(ERR_LOOT_SPEC_CHANGED_S, LootSpec))
	
	GameTooltip:Show()
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local OnMouseDown = function()
	local Group = GetActiveSpecGroup(false, false)
	
	SetActiveSpecGroup(Group == 1 and 2 or 1)
end

local Enable = function(self)
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:RegisterEvent("CONFIRM_TALENT_WIPE")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseDown", OnMouseDown)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
end

DataText:Register(L.DataText.Talents, Enable, Disable, Update)