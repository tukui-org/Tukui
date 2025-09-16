local T, C, L = unpack((select(2, ...)))

--[[ This datatext is from: SanUI, by Pyrates ]] --
local GameTooltip = _G.GameTooltip

local DataText = T["DataTexts"]

local CurrentLootSpecName
local CurrentCharSpecName

local Update = function(self)
	local CurrentLootSpec = GetLootSpecialization()
	local CurrentSpec = GetSpecialization()

	CurrentLootSpecName = CurrentLootSpec and select(2, GetSpecializationInfoByID(CurrentLootSpec))
	CurrentCharSpecName = CurrentSpec and select(2, GetSpecializationInfo(CurrentSpec))

	local lastSelected = PlayerUtil.GetCurrentSpecID() and C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())
	local selectionID = PlayerSpellsFrame and PlayerSpellsFrame.TalentsFrame and PlayerSpellsFrame.TalentsFrame.LoadSystem and
		PlayerSpellsFrame.TalentsFrame.LoadSystem.GetSelectionID and
		PlayerSpellsFrame.TalentsFrame.LoadSystem:GetSelectionID()

	-- https://warcraft.wiki.gg/wiki/Dragonflight_Talent_System
	-- the priority in authoritativeness is [default UI's dropdown] > [API] > ['ActiveConfigID'] > nil
	-- nil happens when you don't have any spec selected, e.g. on a freshly created character
	local activeConfigID = selectionID or lastSelected or C_ClassTalents.GetActiveConfigID() or nil

	if activeConfigID then
		local configInfo = C_Traits.GetConfigInfo(activeConfigID)
		self.Text:SetText(configInfo["name"])
	else
		self.Text:SetText("+--+")
	end
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
	if T.Retail then
		self:RegisterEvent("PLAYER_TALENT_UPDATE")
	end

	self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("CONFIRM_TALENT_WIPE")
	self:RegisterEvent("TRAIT_CONFIG_UPDATED")

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
