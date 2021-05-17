local T, C, L = select(2, ...):unpack()

--[[ This datatext is from: SanUI, by Pyrates ]] --

local DataText = T["DataTexts"]

local CurrentLootSpecName
local CurrentCharSpecName

local Update = function(self)
	local CurrentLootSpec = GetLootSpecialization()
	local CurrentSpec = GetSpecialization()

	CurrentLootSpecName = CurrentLootSpec and select(2, GetSpecializationInfoByID(CurrentLootSpec))

	CurrentCharSpecName = CurrentSpec and select(2, GetSpecializationInfo(CurrentSpec))

	if (CurrentLootSpec ~=0 and CurrentLootSpecName == nil) or CurrentCharSpecName == nil then
		self.Text:SetText("+--+")

		return
	end

	if CurrentLootSpec == 0 then
		CurrentLootSpecName = CurrentCharSpecName
	end

	self.Text:SetText(CurrentCharSpecName)
end

local OnLeave = function()
	GameTooltip:Hide()
end


local OnEnter = function(self)
	self:Update()

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	GameTooltip:AddDoubleLine(LOOT..": ", CurrentLootSpecName, 1, 1, 1, 0, 1, 0)
	GameTooltip:AddDoubleLine(SPECIALIZATION..": ", CurrentCharSpecName, 1, 1, 1, 0, 1, 0)

	GameTooltip:Show()
end

local OnMouseDown = function()
	if InCombatLockdown() then
		T.Print(ERR_NOT_IN_COMBAT)
		
		return
	end
	
	if not PlayerTalentFrame then
		LoadAddOn("Blizzard_TalentUI")
	end

	if not PlayerTalentFrame:IsShown() then
		ShowUIPanel(PlayerTalentFrame)
	else
		HideUIPanel(PlayerTalentFrame)
	end
end

local Enable = function(self)
	if T.Retail then
		self:RegisterEvent("PLAYER_TALENT_UPDATE")
	end
	
	self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("CONFIRM_TALENT_WIPE")

	self:SetScript("OnEvent", Update)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
	self:SetScript("OnMouseDown", OnMouseDown)

	self:Update()
end

local Disable = function(self)
	self:UnregisterAllEvents()

	self:SetScript("OnEvent", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnMouseDown", nil)

	self.Text:SetText("")
end

if T.Retail then
	DataText:Register("Talents", Enable, Disable, Update)
end