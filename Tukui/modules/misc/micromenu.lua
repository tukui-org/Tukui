local T, C, L = unpack(select(2, ...))

local menuFrame = CreateFrame("Frame", "TukuiMicroButtonsDropDown", UIParent, "UIDropDownMenuTemplate")
T.MicroMenu = {
	{text = CHARACTER_BUTTON,
	func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON,
	func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON,
	func = function() 
		if not PlayerTalentFrame then 
			LoadAddOn("Blizzard_TalentUI") 
		end 

		if not GlyphFrame then 
			LoadAddOn("Blizzard_GlyphUI") 
		end 
		PlayerTalentFrame_Toggle() 
	end},
	{text = ACHIEVEMENT_BUTTON,
	func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON,
	func = function() ToggleFrame(QuestLogFrame) end},
	{text = SOCIAL_BUTTON,
	func = function() ToggleFriendsFrame(1) end},
	{text = PLAYER_V_PLAYER,
	func = function() ToggleFrame(PVPFrame) end},
	{text = ACHIEVEMENTS_GUILD_TAB,
	func = function() 
		if IsInGuild() then 
			if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end 
			GuildFrame_Toggle() 
		else 
			if not LookingForGuildFrame then LoadAddOn("Blizzard_LookingForGuildUI") end 
			LookingForGuildFrame_Toggle() 
		end
	end},
	{text = LFG_TITLE,
	func = function() ToggleFrame(LFDParentFrame) end},		
	{text = RAID,
	func = function() if T.toc >= 40300 then ToggleFrame(RaidParentFrame) else ToggleFriendsFrame(4) end end},
	{text = HELP_BUTTON,
	func = function() ToggleHelpFrame() end},
	{text = CALENDAR_VIEW_EVENT,
	func = function()
	if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
		Calendar_Toggle()
	end},
	{text = ENCOUNTER_JOURNAL,
	func = function() if T.toc >= 40200 then if T.toc >= 40300 then ToggleEncounterJournal() else ToggleFrame(EncounterJournal) end end end},
}
	
-- spellbook need at least 1 opening else it taint in combat
local taint = CreateFrame("Frame")
taint:RegisterEvent("PLAYER_ENTERING_WORLD")
taint:SetScript("OnEvent", function(self)
	ToggleFrame(SpellBookFrame)
	ToggleFrame(SpellBookFrame)
end)