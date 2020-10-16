local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local MicroMenu = CreateFrame("Frame", "TukuiMicroButtonsDropDown", UIParent, "UIDropDownMenuTemplate")

MicroMenu.Panel = CreateFrame("Frame", "TukuiMicroMenuPanel", UIParent)

MicroMenu.Buttons = {
	{
		text = CHARACTER_BUTTON,
		func = function()
			ToggleCharacter("PaperDollFrame")
		end,
		notCheckable = true
	},

	{
		text = SPELLBOOK_ABILITIES_BUTTON,
		func = function()
			ToggleSpellBook(BOOKTYPE_SPELL)
		end,
		notCheckable = true
	},

	{
		text = TALENTS_BUTTON,
		func = function()
			ToggleTalentFrame()
		end,
		notCheckable = true
	},

	{
		text = ACHIEVEMENT_BUTTON,
		func = function()
			ToggleAchievementFrame()
		end,
		notCheckable = true
	},
	
	{
		text = QUESTLOG_BUTTON,
		func = function()
			OpenQuestLog()
		end,
		notCheckable = true
	},

	{
		text = MOUNTS,
		func = function()
			ToggleCollectionsJournal(1)
		end,
		notCheckable = true
	},

	{
		text = PETS,
		func = function()
			ToggleCollectionsJournal(2)
		end,
		notCheckable = true
	},

	{
		text = TOY_BOX,
		func = function()
			ToggleCollectionsJournal(3)
		end,
		notCheckable = true
	},
	{
		text = HEIRLOOMS,
		func = function()
			ToggleCollectionsJournal(4)
		end,
		notCheckable = true
	},
	{
		text = WARDROBE,
		func = function()
			ToggleCollectionsJournal(5)
		end,
		notCheckable = true
	},

	{
		text = SOCIAL_BUTTON,
		func = function()
			ToggleFriendsFrame(1)
		end,
		notCheckable = true
	},

	{
		text = COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE.." / "..COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP,
		func = function()
			PVEFrame_ToggleFrame()
		end,
		notCheckable = true
	},

	{
		text = GUILD .. " / " .. COMMUNITIES,
		func = function()
			ToggleGuildFrame()
		end,
		notCheckable = true
	},

	{
		text = VOICE,
		func = function()
			ToggleChannelFrame()
		end,
		notCheckable = true
	},

	{
		text = RAID,
		func = function()
			ToggleFriendsFrame(3)
		end,
		notCheckable = true
	},

	{
		text = HELP_BUTTON,
		func = function()
			ToggleHelpFrame()
		end,
		notCheckable = true
	},

	{
		text = EVENTS_LABEL,
		func = function()
			SlashCmdList:CALENDAR()
		end,
		notCheckable = true
	},

	{
		text = ADVENTURE_JOURNAL,
		func = function()
			ToggleEncounterJournal()
		end,
		notCheckable = true
	},
}

function MicroMenu:Enable()
	local RightChat = T.Chat.Panels.RightChat
	local Total = #MicroMenu.Buttons
	local Buttons = MicroMenu.Panel
	
	Buttons:SetAllPoints(RightChat)
	Buttons:CreateBackdrop()
	Buttons:SetFrameStrata("HIGH")
	Buttons:SetFrameLevel(50)
	Buttons:Hide()

	for i, Option in pairs(MicroMenu.Buttons) do
		local Text = Option.text
		local Func = Option.func
		
		Buttons[i] = CreateFrame("Button", nil, Buttons)
		Buttons[i]:SetSize((Buttons:GetWidth() / 2) - 1, (((Buttons:GetHeight() / Total) * 2) - 4))
		Buttons[i]:SkinButton()
		Buttons[i]:StyleButton()
		Buttons[i]:CreateShadow()
		Buttons[i]:SetScript("OnClick", Func)
		Buttons[i]:HookScript("OnClick", function() Buttons:Hide() end)
		
		if i == 1 then
			Buttons[i]:SetPoint("TOPLEFT", Buttons, "TOPLEFT", 0, 0)
		elseif i == 10 then
			Buttons[i]:SetPoint("LEFT", Buttons[1], "RIGHT", 2, 0)
		else
			Buttons[i]:SetPoint("TOP", Buttons[i - 1], "BOTTOM", 0, -4)
		end
		
		Buttons[i].Text = Buttons[i]:CreateFontString(nil, "OVERLAY")
		Buttons[i].Text:SetFontTemplate(C.Medias.Font, 12)
		Buttons[i].Text:SetText(Text)
		Buttons[i].Text:SetPoint("CENTER")
		Buttons[i].Text:SetTextColor(1, 1, 1)
	end
	
	-- Allow escape to quit
	tinsert(UISpecialFrames, "TukuiMicroMenuPanel")
end

Miscellaneous.MicroMenu = MicroMenu
