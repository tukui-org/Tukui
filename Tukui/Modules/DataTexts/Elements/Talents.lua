local T, C, L = unpack((select(2, ...)))

-- Specializations don't exist in Classic/BCC
if not C_SpecializationInfo then
	return
end

--[[ This datatext is from: SanUI, by Pyrates ]] --
local GameTooltip = _G.GameTooltip
local C_SpecializationInfo = _G.C_SpecializationInfo

local DataText = T["DataTexts"]

local CurrentCharSpecName
local CurrentLootSpecName

local Update = function(self)
	local CurrentSpec = C_SpecializationInfo.GetSpecialization()
	local CurrentLootSpec = GetLootSpecialization()

	CurrentCharSpecName = CurrentSpec and select(2, C_SpecializationInfo.GetSpecializationInfo(CurrentSpec))
	CurrentLootSpecName = CurrentLootSpec and select(2, GetSpecializationInfoByID(CurrentLootSpec))

	if CurrentCharSpecName then
		self.Text:SetFormattedText("S %s - L %s", CurrentCharSpecName, CurrentLootSpecName or CurrentCharSpecName)
	else
		self.Text:SetText("+--+")
	end
end

local OnLeave = function()
	GameTooltip:Hide()
end

local OnEnter = function(self)
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	GameTooltip:AddDoubleLine(SPECIALIZATION..": ", CurrentCharSpecName, 1, 1, 1, 0, 1, 0)
	GameTooltip:AddDoubleLine(LOOT..": ", CurrentLootSpecName, 1, 1, 1, 0, 1, 0)

	GameTooltip:Show()
end

local OnMouseDown = function(self, button)
	if InCombatLockdown() then
		T.Print(ERR_NOT_IN_COMBAT)

		return
	end

	if button == "LeftButton" then
		-- Opens Specialization pane
		PlayerSpellsUtil.TogglePlayerSpellsFrame(1)
	else
		-- Opens Talents pane
		PlayerSpellsUtil.TogglePlayerSpellsFrame(2)
	end
end

local Enable = function(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")

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
