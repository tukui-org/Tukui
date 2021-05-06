local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local GuildMembers = {}
local Menu = CreateFrame("Frame", "TukuiGuildRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local Options = {
	{ text = OPTIONS_MENU, isTitle = true, notCheckable = true },
	{ text = INVITE, hasArrow = true, notCheckable=true, menuList = {} },
	{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable = true, menuList = {} }
}

local EnglishClass = function(class)
	for i, j in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		if class == j then
			return i
		end
	end
end

local function InviteFriend(self, name)
	Menu:Hide()
	
	C_PartyInfo.InviteUnit(name)
end

local function WhisperFriend(self, name)
	Menu:Hide()
	
	SetItemRef("player:"..name, ("|Hplayer:%1$s|h[%1$s]|h"):format(name), "LeftButton" )
end

local OnMouseDown = function(self, button)
	if button == "LeftButton" then
		if InCombatLockdown() then
			T.Print(ERR_NOT_IN_COMBAT)

			return
		end
		
		if T.Retail then
			ToggleGuildFrame()
		else
			ToggleFriendsFrame(3)
		end
	end
	
	if button == "RightButton" and IsInGuild() then
		T.Miscellaneous.DropDown.Open(Options, Menu, "cursor", 0, 0, "MENU", 2)
	end
end

local OnEnter = function(self)
	local NumTotalMembers, NumOnlineMaxLevelMembers, NumOnlineMembers = GetNumGuildMembers()
	
	if not IsInGuild() or NumOnlineMembers <= 0 then
		return
	end
	
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	local GuildName, GuildRank, GuildLevel = GetGuildInfo("player")
	local InviteList = Options[2].menuList
	local WhisperList = Options[3].menuList
	
	-- Reset whisper menu
	wipe(WhisperList)
	
	-- Reset invite menu
	wipe(InviteList)

	GameTooltip:AddDoubleLine(GuildName, "|cff00ff00"..FRIENDS_LIST_ONLINE.."|r |cffffffff("..NumOnlineMembers..")|r")
	GameTooltip:AddLine(" ")
	
	local InviteID = 0
	local WhisperID = 0
	
	-- List the character
	for i = 1, NumTotalMembers do
		local Name, Rank, RankIndex, Level, Class, Zone, Note, OfficerNote, Online, Status, ClassFileName, AchievementPoints, AchievementRank, IsMobile, IsSoReligible, StandingID = GetGuildRosterInfo(i)
		
		-- Remove server from string
		Name = string.gsub(Name, "-"..T.MyRealm, "")
		
		if Online then
			if Name ~= T.MyName then
				local Area = Zone or UNKNOWN
				local Class = EnglishClass(Class)
				local ClassHexColor = Class and T.RGBToHex(unpack(T.Colors.class[Class])) or "|cffffffff"
				local LevelColor = Level and GetQuestDifficultyColor(Level) or {1, 1, 1}
				local LevelHexColor = T.RGBToHex(LevelColor.r, LevelColor.g, LevelColor.b)
				local Left = LevelHexColor..Level.." "..ClassHexColor..Name.."|r"
				local Right = GetSubZoneText() == Area and "|cff00ff00"..Area.."|r" or "|cffffffff"..Area.."|r"

				GameTooltip:AddDoubleLine(Left, Right)
				
				-- Add click invites
				InviteID = InviteID + 1
				
				InviteList[InviteID] = {
					text = LevelHexColor..Level.."|r "..ClassHexColor..Name.."|r",
					arg1 = Name,
					notCheckable = true, 
					func = InviteFriend,
				}
				
				-- Add click whispers
				WhisperID = WhisperID + 1
				
				WhisperList[WhisperID] = {
					text = LevelHexColor..Level.."|r "..ClassHexColor..Name.."|r", 
					arg1 = Name, 
					notCheckable = true, 
					func = WhisperFriend,
				}
			end
		end
	end
	
	GameTooltip:Show()
end

local Update = function(self)
	if (not IsInGuild()) then
		self.Text:SetText(DataText.NameColor .. L.DataText.NoGuild .. "|r")

		return
	end

	self.Text:SetFormattedText("%s %s", DataText.NameColor .. GUILD .. "|r", DataText.ValueColor .. select(3, GetNumGuildMembers()) .. "|r")
end

local Enable = function(self)
	self:RegisterEvent("GUILD_ROSTER_UPDATE")
	self:RegisterEvent("PLAYER_GUILD_UPDATE")

	self:SetScript("OnMouseDown", OnMouseDown)
	self:SetScript("OnLeave", GameTooltip_Hide)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnEvent", Update)
	
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	
	self:UnregisterAllEvents()
	
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnEvent", nil)
end

DataText:Register("Guild", Enable, Disable, Update)
