local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local MicroMenu = CreateFrame("Frame", "TukuiMicroButtonsDropDown", UIParent, "UIDropDownMenuTemplate")

MicroMenu.Buttons = {
	{text = CHARACTER_BUTTON,
	func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON,
	func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON,
	func = function() 
		if (not PlayerTalentFrame) then 
			TalentFrame_LoadUI()
		end
		
		ShowUIPanel(PlayerTalentFrame)
	end},
	{text = ACHIEVEMENT_BUTTON,
	func = function() ToggleAchievementFrame() end},
	{text = WORLD_MAP.." / "..QUESTLOG_BUTTON,
	func = function() ShowUIPanel(WorldMapFrame) end},
	{text = MOUNTS.." / "..PETS.." / "..TOY_BOX,
	func = function() TogglePetJournal(1) end},
	{text = SOCIAL_BUTTON,
	func = function() ToggleFriendsFrame(1) end},
	{text = COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE.." / "..COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP,
	func = function() PVEFrame_ToggleFrame() end},
	{text = ACHIEVEMENTS_GUILD_TAB,
	func = function() 
		if IsInGuild() then
			if (not GuildFrame) then
				GuildFrame_LoadUI()
			end 
			
			GuildFrame_Toggle() 
		else 
			if (not LookingForGuildFrame) then
				LookingForGuildFrame_LoadUI()
			end 
			
			LookingForGuildFrame_Toggle() 
		end
	end},
	{text = RAID, func = function() ToggleFriendsFrame(4) end},
	{text = HELP_BUTTON, func = function() ToggleHelpFrame() end},
	{text = CALENDAR_VIEW_EVENT, 
	func = function()
		if (not CalendarFrame) then
			LoadAddOn("Blizzard_Calendar")
		end
		
		Calendar_Toggle()
	end},
	{text = ENCOUNTER_JOURNAL, func = function() ToggleEncounterJournal() end},
	{text = GARRISON_LANDING_PAGE_TITLE, func = function() GarrisonLandingPageMinimapButton_OnClick() end},
}

--[[  do we really need this for WoD? 
local TaintFix = CreateFrame("Frame")
TaintFix:RegisterEvent("ADDON_LOADED")
TaintFix:SetScript("OnEvent", function(self, event, addon)
	if (addon ~= "Tukui") then
		return
	end
	
	ToggleFrame(SpellBookFrame)
	PetJournal_LoadUI()
end)
--]]

Miscellaneous.MicroMenu = MicroMenu