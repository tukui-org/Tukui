local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- here we kill all shit stuff on default UI that we don't need!

local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		if C.tooltip.enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end
	
	-- disable Blizzard party & raid frame if our Raid Frames are loaded
	if addon == "Tukui_Raid" or addon == "Tukui_Raid_Healing" then   
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)

		local function KillRaidFrame()
			CompactRaidFrameManager:UnregisterAllEvents()
			if not InCombatLockdown() then CompactRaidFrameManager:Hide() end

			local shown = CompactRaidFrameManager_GetSetting("IsShown")
			if shown and shown ~= "0" then
				CompactRaidFrameManager_SetSetting("IsShown", "0")
			end
		end

		hooksecurefunc("CompactRaidFrameManager_UpdateShown", function()
			KillRaidFrame()
		end)

		KillRaidFrame()

		-- kill party 1 to 5
		local function KillPartyFrame()
			CompactPartyFrame:Kill()

			for i=1, MEMBERS_PER_RAID_GROUP do
				local name = "CompactPartyFrameMember" .. i
				local frame = _G[name]
				frame:UnregisterAllEvents()
			end			
		end
			
		for i=1, MAX_PARTY_MEMBERS do
			local name = "PartyMemberFrame" .. i
			local frame = _G[name]

			frame:Kill()

			_G[name .. "HealthBar"]:UnregisterAllEvents()
			_G[name .. "ManaBar"]:UnregisterAllEvents()
		end
		
		if CompactPartyFrame then
			KillPartyFrame()
		elseif CompactPartyFrame_Generate then -- 4.1
			hooksecurefunc("CompactPartyFrame_Generate", KillPartyFrame)
		end		
	end
	
	if addon ~= "Tukui" then return end
		
	StreamingIcon:Kill()
	Advanced_UseUIScale:Kill()
	Advanced_UIScaleSlider:Kill()
	PartyMemberBackground:Kill()
	TutorialFrameAlertButton:Kill()
	GuildChallengeAlertFrame:Kill()
	
	if C.auras.player or C.unitframes.playerauras then
		BuffFrame:Kill()
		TemporaryEnchantFrame:Kill()
		ConsolidatedBuffs:Kill()
		-- kill the module in default interface option
		InterfaceOptionsFrameCategoriesButton12:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton12:SetAlpha(0)	
	end
	
	InterfaceOptionsUnitFramePanelPartyBackground:Kill()

	-- make sure boss or arena frame is always disabled when running tukui
	SetCVar("showArenaEnemyFrames", 0)
	
	if C.arena.unitframes then
		InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton10:SetAlpha(0) 
		InterfaceOptionsUnitFramePanelArenaEnemyFrames:Kill()
		InterfaceOptionsUnitFramePanelArenaEnemyCastBar:Kill()
		InterfaceOptionsUnitFramePanelArenaEnemyPets:Kill()
	end
	
	if C.chat.enable then
		SetCVar("WholeChatWindowClickable", 0)
		SetCVar("ConversationMode", "inline")
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
		InterfaceOptionsSocialPanelConversationMode:Kill()
	end
	
	if C.unitframes.enable then
		PlayerFrame:Kill() -- Just to be sure we are safe
		InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)	
	end
	
	if C.actionbar.enable then
		InterfaceOptionsActionBarsPanelBottomLeft:Kill()
		InterfaceOptionsActionBarsPanelBottomRight:Kill()
		InterfaceOptionsActionBarsPanelRight:Kill()
		InterfaceOptionsActionBarsPanelRightTwo:Kill()
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
	end
	
	if C["nameplate"].enable == true and C["nameplate"].enhancethreat == true then
		InterfaceOptionsDisplayPanelAggroWarningDisplay:Kill()
	end

	-- I'm seriously tired of this Blizzard taint, little hack, we don't care about SearchLFGLeave()
	-- This taint is blaming every addon even if we are not calling SearchLFGLeave() function in our addon ...
	--[[ TAINT LOG
			10/18 21:46:01.774  An action was blocked because of taint from Tukui - SearchLFGLeave()
			10/18 21:46:01.774      Interface\FrameXML\LFRFrame.lua:395 LFRBrowseFrame_OnUpdateAlways()
			10/18 21:46:01.774      UIParent:OnUpdate()
	--]]
	local TaintFix = CreateFrame("Frame")
	TaintFix:SetScript("OnUpdate", function(self, elapsed)
		if LFRBrowseFrame.timeToClear then
			LFRBrowseFrame.timeToClear = nil 
		end 
	end)
end)