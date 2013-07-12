local T, C, L, G = unpack(select(2, ...)) 
-- here we kill all shit stuff on default UI that we don't need!

local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		if C.tooltip.enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	if addon ~= "Tukui" then return end
	
	-- disable Blizzard party & raid frame if our Raid Frames are loaded
	if C.unitframes.raid then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
		
		-- raid
		CompactRaidFrameManager:SetParent(TukuiUIHider)
		CompactUnitFrameProfiles:UnregisterAllEvents()
			
		for i=1, MAX_PARTY_MEMBERS do
			local member = "PartyMemberFrame" .. i

			_G[member]:UnregisterAllEvents()
			_G[member]:SetParent(TukuiUIHider)
			_G[member]:Hide()
			_G[member .. "HealthBar"]:UnregisterAllEvents()
			_G[member .. "ManaBar"]:UnregisterAllEvents()
			
			local pet = member.."PetFrame"
			
			_G[pet]:UnregisterAllEvents()
			_G[pet]:SetParent(TukuiUIHider)
			_G[pet .. "HealthBar"]:UnregisterAllEvents()
			
			HidePartyFrame()
			ShowPartyFrame = function() return end
			HidePartyFrame = function() return end
		end
	end
		
	StreamingIcon:Kill()
	Advanced_UseUIScale:Kill()
	Advanced_UIScaleSlider:Kill()
	PartyMemberBackground:Kill()
	TutorialFrameAlertButton:Kill()
	GuildChallengeAlertFrame:Kill()
	
	if C.auras.player then
		BuffFrame:Kill()
		TemporaryEnchantFrame:Kill()
		ConsolidatedBuffs:Kill()
		InterfaceOptionsFrameCategoriesButton12:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton12:SetAlpha(0)	
	end

	-- make sure boss or arena frame is always disabled when running tukui
	SetCVar("showArenaEnemyFrames", 0)
	
	if C.unitframes.arena then
		InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton10:SetAlpha(0) 
		InterfaceOptionsUnitFramePanelArenaEnemyFrames:Kill()
		InterfaceOptionsUnitFramePanelArenaEnemyCastBar:Kill()
		InterfaceOptionsUnitFramePanelArenaEnemyPets:Kill()
	end
	
	if C.chat.enable then
		SetCVar("WholeChatWindowClickable", 0)
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
	end
	
	if C.unitframes.enable then
		PlayerFrame:SetParent(TukuiUIHider) -- Just to be sure we are safe
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
	
	if C.nameplate.enable then
		InterfaceOptionsNamesPanelUnitNameplatesNameplateClassColors:Kill()
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
G.Misc.Kill = Kill