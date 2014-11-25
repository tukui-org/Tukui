local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local MicroMenu = CreateFrame("Frame", "TukuiMicroButtonsDropDown", UIParent, "UIDropDownMenuTemplate")

MicroMenu.Buttons = {
	{text = CHARACTER_BUTTON,
	func = function() ToggleCharacter("PaperDollFrame") end,
	notCheckable = true},
	{text = SPELLBOOK_ABILITIES_BUTTON,
	func = function() ToggleFrame(SpellBookFrame) end,
	notCheckable = true},
	{text = TALENTS_BUTTON,
	func = function() 
		if (not PlayerTalentFrame) then 
			TalentFrame_LoadUI()
		end
		
		ShowUIPanel(PlayerTalentFrame)
	end,
	notCheckable = true},
	{text = ACHIEVEMENT_BUTTON,
	func = function() ToggleAchievementFrame() end,
	notCheckable = true},
	{text = WORLD_MAP.." / "..QUESTLOG_BUTTON,
	func = function() ShowUIPanel(WorldMapFrame) end,
	notCheckable = true},
	{text = MOUNTS.." / "..PETS.." / "..TOY_BOX,
	func = function() TogglePetJournal(1) end,
	notCheckable = true},
	{text = SOCIAL_BUTTON,
	func = function() ToggleFriendsFrame(1) end,
	notCheckable = true},
	{text = COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE.." / "..COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP,
	func = function() PVEFrame_ToggleFrame() end,
	notCheckable = true},
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
	end,
	notCheckable = true},
	{text = RAID, func = function() ToggleFriendsFrame(4) end,
	notCheckable = true},
	{text = HELP_BUTTON, func = function() ToggleHelpFrame() end,
	notCheckable = true},
	{text = CALENDAR_VIEW_EVENT, 
	func = function()
		if (not CalendarFrame) then
			LoadAddOn("Blizzard_Calendar")
		end
		
		Calendar_Toggle()
	end,
	notCheckable = true},
	{text = ENCOUNTER_JOURNAL, func = function() ToggleEncounterJournal() end,
	notCheckable = true},
	{text = GARRISON_LANDING_PAGE_TITLE, func = function() GarrisonLandingPageMinimapButton_OnClick() end,
	notCheckable = true},
}

Miscellaneous.MicroMenu = MicroMenu