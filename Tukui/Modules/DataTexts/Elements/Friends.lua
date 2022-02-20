local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local Popups = T["Popups"]
local BattleNetTable = {}
local FriendsTable = {}
local Games = {
	["WoW"] = "World of Warcraft",
	["S2"] = "StarCraft 2",
	["OSI"] = "Diablo II: Resurrected",
	["D3"] = "Diablo 3",
	["WTCG"] = "Hearthstone",
	["App"] = "Battle.net Desktop App",
	["BSAp"] = "Battle.net Mobile App",
	["Hero"] = "Heroes of the Storm",
	["Pro"] = "Overwatch",
	["CLNT"] = "Battle.net Desktop App",
	["S1"] = "StarCraft: Remastered",
	["DST2"] = "Destiny 2",
	["VIPR"] = "Call of Duty: Black Ops 4",
	["ODIN"] = "Call of Duty: Modern Warfare",
	["LAZR"] = "Call of Duty: Modern Warfare 2",
	["ZEUS"] = "Call of Duty: Black Ops Cold War",
	["W3"] = "Warcraft III: Reforged",
}

local Menu = CreateFrame("Frame", "TukuiFriendRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local Options = {
	{ text = OPTIONS_MENU, isTitle = true, notCheckable = true},
	{ text = INVITE, hasArrow = true, notCheckable = true, menuList = {}},
	{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable = true, menuList = {}},
	{ text = PLAYER_STATUS, hasArrow = true, notCheckable = true,
		menuList = {
			{ text = "|cff2BC226"..AVAILABLE.."|r", notCheckable = true, func = function()
				if IsChatAFK() then
					SendChatMessage("", "AFK")
				elseif IsChatDND() then
					SendChatMessage("", "DND")
				end
			end },

			{ text = "|cffE7E716"..DND.."|r", notCheckable = true, func = function()
				if not IsChatDND() then
					SendChatMessage("", "DND")
				end
			end },

			{ text = "|cffFF0000"..AFK.."|r", notCheckable = true, func = function()
				if not IsChatAFK() then
					SendChatMessage("", "AFK")
				end
			end },
		},
	},
	{ text = BN_BROADCAST_TOOLTIP, notCheckable = true, func = function()
		Popups.ShowPopup("BROADCAST")
	end },
}

Popups.Popup["BROADCAST"] = {
	Question = BN_BROADCAST_TOOLTIP,
	Answer1 = ACCEPT,
	Answer2 = CANCEL,
	Function1 = function(self)
		local Parent = self:GetParent()

		BNSetCustomMessage(Parent.EditBox:GetText())
	end,
	EditBox = true,
}

local EnglishClass = function(class)
	for i, j in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		if class == j then
			return i
		end
	end
end

local RemoveTagNumber = function(tag)
	local symbol = string.find(tag, "#")

	if (symbol) then
		return string.sub(tag, 1, symbol - 1)
	else
		return tag
	end
end

local DisplayBattleNetFriendsOnTooltip = function()
	for i = 1, #BattleNetTable do
		local Friend = BattleNetTable[i]

		if Friend then
			local Account = T.Retail and Friend.gameAccountInfo
			local IsOnline = T.Retail and Account.isOnline or Friend.isOnline

			if IsOnline then
				local Game = T.Retail and Games[Account.clientProgram] or Games[Friend.client] or UNKNOWN

				if Game ~= "Battle.net Desktop App" and Game ~= "Battle.net Mobile App" then
					local BattleTag = RemoveTagNumber(Friend.battleTag)
					local Left = "|cff00ccff"..BattleTag.."|r"
					local Right = "|cffffffff"..Game.."|r"

					if Game == "World of Warcraft" and ((T.Retail and Account.characterName) or (Friend.characterName)) then
						local LevelColor = T.Retail and Account.characterLevel and GetQuestDifficultyColor(Account.characterLevel) or Friend.characterLevel and GetQuestDifficultyColor(Friend.characterLevel) or {r = 1, g = 1, b = 1}
						local LevelHexColor = T.RGBToHex(LevelColor.r, LevelColor.g, LevelColor.b)
						local Level = T.Retail and LevelHexColor..Account.characterLevel.."|r" or LevelHexColor..Friend.characterLevel.."|r"
						local Class = T.Retail and EnglishClass(Account.className) or EnglishClass(Friend.className)
						local ClassHexColor = Class and T.RGBToHex(unpack(T.Colors.class[Class])) or "|cffffffff"
						local Name = T.Retail and ClassHexColor..Account.characterName.."|r" or ClassHexColor..Friend.characterName.."|r"
						local ProjectID = T.Retail and Account.wowProjectID or Friend.wowProjectID

						-- WoW Classic Detected
						if ProjectID == WOW_PROJECT_CLASSIC then
							Right = "|cffffffff"..Game.." Classic|r"
						elseif ProjectID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
							Right = "|cffffffff"..Game.." Classic (TBC)|r"
						end

						Left = Left.." ("..Level.." "..Name..")"
					end

					GameTooltip:AddDoubleLine(Left, Right)
				end
			end
		end
	end
end

local UpdateBattleNetFriendsCache = function(total)
	-- Reset battle.net cache
	wipe(BattleNetTable)

	if T.Retail then
		for i = 1, total do
			local Infos = C_BattleNet.GetFriendAccountInfo(i)

			--[[
				bnetAccountID, number, Unique numeric identifier for the friend's Battle.net account during this session
				accountName, string, A protected string representing the friend's full name or BattleTag name
				battleTag, string, The friend's BattleTag (e.g., "Nickname#0001")
				isFriend, boolean
				isBattleTagFriend, boolean, Whether or not the friend is known by their BattleTag
				lastOnlineTime, number, The number of seconds elapsed since this friend was last online (from the epoch date of January 1, 1970). Returns nil if currently online.
				isAFK, boolean, Whether or not the friend is flagged as Away
				isDND, boolean, Whether or not the friend is flagged as Busy
				isFavorite, boolean, Whether or not the friend is marked as a favorite by you
				appearOffline, boolean
				customMessage, string, The Battle.net broadcast message
				customMessageTime, number, The number of seconds elapsed since the current broadcast message was sent
				note, string, The contents of the player's note about this friend
				rafLinkType, Enum.RafLinkType, Enum.RafLinkType
				gameAccountInfo, BNetGameAccountInfo
			]]

			--[[
				gameAccountID, number, Unique numeric identifier for the friend's Battle.net game account
				clientProgram, string, BNET_CLIENT
				isOnline, boolean
				isGameBusy, boolean
				isGameAFK, boolean
				wowProjectID, number
				characterName, string, The name of the logged in toon/character
				realmName, string, The name of the logged in realm
				realmDisplayName, string
				realmID	number, The ID for the logged in realm
				factionName, string, The englishFaction name (i.e., "Alliance" or "Horde")
				raceName, string, The localized race name (e.g., "Blood Elf")
				className, string, The localized class name (e.g., "Death Knight")
				areaName, string, The localized zone name (e.g., "The Undercity")
				characterLevel, number, The current level (e.g., "90")
				richPresence, string, For WoW, returns "zoneName - realmName". For StarCraft 2 and Diablo 3, returns the location or activity the player is currently engaged in.
				playerGuid, string, A unique numeric identifier for the friend's character during this session.
				isWowMobile, boolean
				canSummon, boolean
				hasFocus, boolean, Whether or not this toon is the one currently being displayed in Blizzard's FriendFrame
			]]

			BattleNetTable[i] = Infos
		end
	end

	if not T.Retail then
		for i = 1, total do
			local bnetIDAccount, accountName, battleTag, isBattleTag, characterName, bnetIDGameAccount, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR, isReferAFriend, canSummonFriend = BNGetFriendInfo(i)
			local realmName, realmID, factionName, className, zoneName, characterLevel, gameText, isGameAFK, isGameBusy, guid, wowProjectID, _

			if isOnline then
				_, _, _, realmName, realmID, factionName, _, className, _, zoneName, characterLevel, gameText, _, _, _, _, _, isGameAFK, isGameBusy, guid, wowProjectID = BNGetGameAccountInfo(bnetIDGameAccount)
			end

			--[[
				[1]=true,
				[2]="Luckyone",
				[3]="WoW",
				[4]="ClassicBetaPvE",
				[5]=4618,
				[6]="Horde",
				[7]="Troll",
				[8]="Hunter",
				[9]="",
				[10]="Hellfire Peninsula",
				[11]="70",
				[12]="WoW Classic - Classic Beta PvE",
				[13]="",
				[14]=0,
				[15]=true,
				[16]=19,
				[17]=17,
				[18]=true,
				[19]=false,
				[20]="Player-4618-000E2B02",
				[21]=2,
				[22]="Classic Beta PvE"
			]]

			BattleNetTable[i] = {
				-- BNET --
				["bnetIDAccount"] = bnetIDAccount,
				["accountName"] = accountName,
				["battleTag"] = battleTag,
				["isBattleTag"] = isBattleTag,
				["characterName"] = characterName,
				["bnetIDGameAccount"] = bnetIDGameAccount,
				["client"] = client,
				["isOnline"] = isOnline,
				["lastOnline"] = lastOnline,
				["isAFK"] = isAFK,
				["isDND"] = isDND,
				["messageText"] = messageText,
				["noteText"] = noteText,
				["isRIDFriend"] = isRIDFriend,
				["messageTime"] = messageTime,
				["canSoR"] = canSoR,
				["isReferAFriend"] = isReferAFriend,
				["canSummonFriend"] = canSummonFriend,
				-- WoW --
				["realmName"] = realmName,
				["realmID"] = realmID,
				["factionName"] = factionName,
				["characterLevel"] = characterLevel,
				["className"] = className,
				["zoneName"] = zoneName,
				["gameText"] = gameText,
				["isGameAFK"] = isGameAFK,
				["isGameBusy"] = isGameBusy,
				["guid"] = guid,
				["wowProjectID"] = wowProjectID,
			}
		end
	end
end

local DisplayFriendsOnTooltip = function()
	for i = 1, #FriendsTable do
		local Friend = FriendsTable[i]

		if Friend then
			local IsConnected = Friend.connected

			if IsConnected then
				local Name = Friend.name
				local Level = Friend.level
				local LevelColor = Level and GetQuestDifficultyColor(Level) or {1, 1, 1}
				local LevelHexColor = T.RGBToHex(LevelColor.r, LevelColor.g, LevelColor.b)
				local Class = EnglishClass(Friend.className)
				local ClassHexColor = Class and T.RGBToHex(unpack(T.Colors.class[Class])) or "|cffffffff"
				local Area = Friend.area or UNKNOWN
				local Left = ClassHexColor..Name.."|r ("..LevelHexColor..Level.."|r)"
				local Right = GetSubZoneText() == Area and "|cff00ff00"..Area.."|r" or "|cffffffff"..Area.."|r"

				GameTooltip:AddDoubleLine(Left, Right)
			end
		end
	end
end

local UpdateFriendsCache = function(total)
	-- Reset WoW friends cache
	wipe(FriendsTable)

	for i = 1, total do
		local Infos = C_FriendList.GetFriendInfoByIndex(i)

		FriendsTable[i] = Infos
	end
end

local OnEnter = function(self)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self:GetTooltipAnchor())

	local OnlineFriends = C_FriendList.GetNumOnlineFriends()
	local FriendsNumber = C_FriendList.GetNumFriends()
	local BNetNumber, OnlineBNet = BNGetNumFriends()
	local TotalOnline = OnlineFriends + OnlineBNet

	if TotalOnline > 0 then
		local ShiftDown = IsShiftKeyDown()

		UpdateBattleNetFriendsCache(BNetNumber)
		UpdateFriendsCache(FriendsNumber)

		if OnlineBNet > 0 then
			GameTooltip:AddDoubleLine("Battle.net:", OnlineBNet .. "/" .. BNetNumber)
			GameTooltip:AddLine(" ")

			DisplayBattleNetFriendsOnTooltip()
		end

		if OnlineBNet > 0 and OnlineFriends > 0 then
			GameTooltip:AddLine(" ")
		end

		if OnlineFriends > 0 then
			GameTooltip:AddDoubleLine("World of Warcraft:", OnlineFriends .. "/" .. FriendsNumber)
			GameTooltip:AddLine(" ")

			DisplayFriendsOnTooltip()
		end

		GameTooltip:Show()
	end
end

local InviteFriend = function(self, name)
	Menu:Hide()

	if type(name) ~= ("number") then
		C_PartyInfo.InviteUnit(name)
	else
		BNInviteFriend(name)
	end
end

local WhisperFriend = function(self, name, bnet)
	Menu:Hide()

	if bnet then
		ChatFrame_SendBNetTell(name)
	else
		SetItemRef("player:"..name, format("|Hplayer:%1$s|h[%1$s]|h", name), "LeftButton")
	end
end

local OnMouseDown = function(self, button)
	if button == "LeftButton" then
		if InCombatLockdown() then
			T.Print(ERR_NOT_IN_COMBAT)

			return
		end

		ToggleFriendsFrame(1)
	end

	if button == "RightButton" then
		local InviteID = 0
		local WhisperID = 0
		local InviteList = Options[2].menuList
		local WhisperList = Options[3].menuList

		-- Reset whisper menu
		wipe(WhisperList)

		-- Reset invite menu
		wipe(InviteList)

		-- Update battle.net menu listing for invites and whispers
		for i = 1, #BattleNetTable do
			local Friend = BattleNetTable[i]

			if Friend then
				local Account = T.Retail and Friend.gameAccountInfo
				local IsOnline = T.Retail and Account.isOnline or Friend.isOnline
				local Faction = T.Retail and Account.factionName or Friend.factionName

				if IsOnline then
					WhisperID = WhisperID + 1

					local Game = T.Retail and Games[Account.clientProgram] or Games[Friend.client]
					local BattleTag = RemoveTagNumber(Friend.battleTag)

					-- Adding Battle.net Whisper
					WhisperList[WhisperID] = {
						text = "|cff00ccff"..BattleTag.."|r",
						arg1 = BattleTag,
						arg2 = true,
						notCheckable = true,
						func = WhisperFriend,
					}

					-- Adding Battle.net Invites
					if Game == "World of Warcraft" and UnitFactionGroup("player") == Faction then
						local ProjectID = T.Retail and Account.wowProjectID or Friend.wowProjectID

						if ProjectID == WOW_PROJECT_ID then
							local AccountID = T.Retail and Account.gameAccountID or Friend.bnetIDAccount
							local Name = T.Retail and Account.characterName or Friend.characterName
							local Level = T.Retail and Account.characterLevel or Friend.characterLevel
							local LevelColor = Level and GetQuestDifficultyColor(Level) or {1, 1, 1}
							local LevelHexColor = T.RGBToHex(LevelColor.r, LevelColor.g, LevelColor.b)
							local Class = T.Retail and EnglishClass(Account.className) or EnglishClass(Friend.className)
							local ClassHexColor = Class and T.RGBToHex(unpack(T.Colors.class[Class])) or "|cffffffff"

							InviteID = InviteID + 1

							InviteList[InviteID] = {
								text = LevelHexColor..Level.."|r "..ClassHexColor..Name.."|r (|cff00ccff"..BattleTag.."|r)",
								arg1 = AccountID,
								notCheckable = true,
								func = InviteFriend,
							}
						end
					end
				end
			end
		end

		-- Update friends menu listing for invites and whispers
		for i = 1, #FriendsTable do
			local Friend = FriendsTable[i]

			if Friend then
				if Friend.connected then
					WhisperID = WhisperID + 1
					InviteID = InviteID + 1

					local Name = Friend.name
					local Level = Friend.level
					local LevelColor = Level and GetQuestDifficultyColor(Level) or {1, 1, 1}
					local LevelHexColor = T.RGBToHex(LevelColor.r, LevelColor.g, LevelColor.b)
					local Class = EnglishClass(Friend.className)
					local ClassHexColor = Class and T.RGBToHex(unpack(T.Colors.class[Class])) or "|cffffffff"

					-- Adding Battle.net Whisper
					WhisperList[WhisperID] = {
						text = ClassHexColor..Name.."|r",
						arg1 = Name,
						arg2 = false,
						notCheckable = true,
						func = WhisperFriend,
					}

					InviteList[InviteID] = {
						text = LevelHexColor..Level.."|r "..ClassHexColor..Name.."|r",
						arg1 = Name,
						notCheckable = true,
						func = InviteFriend,
					}
				end
			end
		end

		T.Miscellaneous.DropDown.Open(Options, Menu, "cursor", 0, 0, "MENU", 2)
	end
end

local Update = function(self, event, ...)
	local OnlineFriends = C_FriendList.GetNumOnlineFriends()
	local FriendsNumber = C_FriendList.GetNumFriends()
	local BNetNumber, OnlineBNet = BNGetNumFriends()
	local TotalOnline = OnlineFriends + OnlineBNet

	self.Text:SetFormattedText("%s %s%s", DataText.NameColor .. FRIENDS .. "|r", DataText.ValueColor, TotalOnline)
end

local Enable = function(self)
	self:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
	self:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
	self:RegisterEvent("BN_FRIEND_INFO_CHANGED")
	self:RegisterEvent("BN_CONNECTED")
	self:RegisterEvent("BN_DISCONNECTED")
	self:RegisterEvent("FRIENDLIST_UPDATE")

	self:SetScript("OnMouseDown", OnMouseDown)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", GameTooltip_Hide)
	self:SetScript("OnEvent", Update)

	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")

	self:UnregisterAllEvents()

	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnEvent", nil)
end

DataText:Register("Friends", Enable, Disable, Update)
