local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local Popups = T["Popups"]
local format = format

local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r"
local clientLevelNameString = "|cffffffff%s|r (|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s) |cff%02x%02x%02x%s|r"
local levelNameClassString = "|cff%02x%02x%02x%d|r %s%s%s"
local worldOfWarcraftString = "World of Warcraft"
local battleNetString = "Battle.NET"
local wowString = "WoW"
local totalOnlineString = L.DataText.Online .. "%s/%s"
local tthead, ttsubh, ttoff = {r = 0.4, g = 0.78, b = 1}, {r = 0.75, g = 0.9, b = 1}, {r = .3, g = 1, b = .3}
local activezone, inactivezone = {r = 0.3, g = 1.0, b = 0.3}, {r = 0.65, g = 0.65, b = 0.65}
local statusTable = { "|cffff0000[AFK]|r", "|cffff0000[DND]|r", "" }
local groupedTable = { "|cffaaaaaa*|r", "" }
local BNTable = {}
local WoWTable = {}
local BNTotalOnline = 0
local BNGetGameAccountInfo = BNGetGameAccountInfo
local GetFriendInfo = GetFriendInfo
local BNGetFriendInfo = BNGetFriendInfo
local C_FriendList_GetNumFriends = C_FriendList.GetNumFriends
local C_FriendList_GetNumOnlineFriends = C_FriendList.GetNumOnlineFriends
local C_FriendList_GetFriendInfoByIndex = C_FriendList.GetFriendInfoByIndex
local classc = {r=1, g=1, b=1}

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

local menuFrame = CreateFrame("Frame", "TukuiFriendRightClickMenu", UIParent, "UIDropDownMenuTemplate")

local menuList = {
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

local function GetTableIndex(table, fieldIndex, value)
	for k, v in ipairs(table) do
		if v[fieldIndex] == value then
			return k
		end
	end

	return -1
end

local function RemoveTagNumber(tag)
	local symbol = string.find(tag, "#")

	if (symbol) then
		return string.sub(tag, 1, symbol - 1)
	else
		return tag
	end
end

local function inviteClick(self, arg1, arg2, checked)
	menuFrame:Hide()

	if type(arg1) ~= ("number") then
		InviteUnit(arg1)
	else
		BNInviteFriend(arg1);
	end
end

local function whisperClick(self, name, bnet)
	menuFrame:Hide()

	if bnet then
		ChatFrame_SendBNetTell(name)
	else
		SetItemRef("player:"..name, format("|Hplayer:%1$s|h[%1$s]|h",name), "LeftButton")
	end
end

local function BuildBNTable(total)
	BNTotalOnline = 0
	wipe(BNTable)

	for i = 1, total do
		local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
		if accountInfo then
			local class = accountInfo.gameAccountInfo.className

			for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
				if class == v then
					class = k
				end
			end

			BNTable[i] = { accountInfo.bnetAccountID, accountInfo.accountName, accountInfo.battleTag, accountInfo.gameAccountInfo.characterName, accountInfo.gameAccountInfo.gameAccountID, accountInfo.gameAccountInfo.clientProgram, accountInfo.gameAccountInfo.isOnline, accountInfo.isAFK, accountInfo.isDND, accountInfo.note, accountInfo.gameAccountInfo.realmName, accountInfo.gameAccountInfo.factionName, accountInfo.gameAccountInfo.raceName, class, accountInfo.gameAccountInfo.areaName, accountInfo.gameAccountInfo.characterLevel, accountInfo.isBattleTagFriend, accountInfo.gameAccountInfo.wowProjectID }

			if accountInfo.gameAccountInfo.isOnline then
				BNTotalOnline = BNTotalOnline + 1
			end
		end
	end
end

local function UpdateBNTable(total)
	BNTotalOnline = 0

	for i = 1, #BNTable do
		local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
		if accountInfo then
			-- get the correct index in our table
			local index = GetTableIndex(BNTable, 1, accountInfo.bnetAccountID)
			local class = accountInfo.gameAccountInfo.className

			-- we cannot find a BN member in our table, so rebuild it
			if index == -1 then
				BuildBNTable(total)
				return
			end

			for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
				if class == v then
					class = k
				end
			end

			-- update on-line status for all members
			BNTable[index][7] = accountInfo.gameAccountInfo.isOnline

			-- update information only for on-line members
			if accountInfo.gameAccountInfo.isOnline then
				BNTable[index][2] = accountInfo.accountName
				BNTable[index][3] = accountInfo.battleTag
				BNTable[index][4] = accountInfo.gameAccountInfo.characterName
				BNTable[index][5] = accountInfo.gameAccountInfo.gameAccountID
				BNTable[index][6] = accountInfo.gameAccountInfo.clientProgram
				BNTable[index][8] = accountInfo.isAFK
				BNTable[index][9] = accountInfo.isDND
				BNTable[index][10] = accountInfo.note
				BNTable[index][11] = accountInfo.gameAccountInfo.realmName
				BNTable[index][12] = accountInfo.gameAccountInfo.factionName
				BNTable[index][13] = accountInfo.gameAccountInfo.raceName
				BNTable[index][14] = class
				BNTable[index][15] = accountInfo.gameAccountInfo.areaName
				BNTable[index][16] = accountInfo.gameAccountInfo.characterLevel
				BNTable[index][17] = accountInfo.isBattleTagFriend
				BNTable[index][18] = accountInfo.gameAccountInfo.wowProjectID

				BNTotalOnline = BNTotalOnline + 1
			end
		end
	end
end

local OnMouseUp = function(self, btn)
	if btn ~= "RightButton" then
		return
	end

	if not BNConnected() then
		return
	end

	GameTooltip_Hide()

	local menuCountWhispers = 0
	local menuCountInvites = 0

	wipe(menuList[2].menuList)
	wipe(menuList[3].menuList)
	wipe(classc)

	if BNTotalOnline > 0 then
		local realID, grouped

		for i = 1, #BNTable do
			if (BNTable[i][7]) then
				realID = BNTable[i][2]
				menuCountWhispers = menuCountWhispers + 1
				menuList[3].menuList[menuCountWhispers] = {text = "|cff00ccff"..RemoveTagNumber(BNTable[i][3].."|r"), arg1 = realID, arg2 = true, notCheckable=true, func = whisperClick}

				if BNTable[i][6] == wowString and UnitFactionGroup("player") == BNTable[i][12] and BNTable[i][11] == string.gsub(T.MyRealm, "%s+", "") then
					local levelc = GetQuestDifficultyColor(BNTable[i][16])

					if T.Colors.class[BNTable[i][14]] then
						classc.r, classc.g, classc.b = unpack(T.Colors.class[BNTable[i][14]])
					else
						classc.r, classc.g, classc.b = 1, 1, 1
					end

					if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then
						grouped = 1
					else
						grouped = 2
					end

					menuCountInvites = menuCountInvites + 1
					menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,BNTable[i][16],classc.r*255,classc.g*255,classc.b*255,BNTable[i][4]), arg1 = BNTable[i][5],notCheckable=true, func = inviteClick}
				end
			end
		end

		if #WoWTable > 0 then
			-- add a separator
			menuCountWhispers = menuCountWhispers + 1

			menuList[3].menuList[menuCountWhispers] = {text = "----------", arg1 = nil, arg2 = nil, notCheckable=true, func = nil}
		end

		for i = 1, #WoWTable do
			if WoWTable[i].connected then
				local Class = WoWTable[i].className
				local R, G, B = unpack(T.Colors.class[Class])
				local Hex = T.RGBToHex(R, G, B)
				local levelc = GetQuestDifficultyColor(WoWTable[i].level)
				local levelhex = T.RGBToHex(levelc.r, levelc.g, levelc.b)

				menuCountWhispers = menuCountWhispers + 1

				menuList[3].menuList[menuCountWhispers] = {text = WoWTable[i].hex..WoWTable[i].name.."|r", arg1 = WoWTable[i].name, arg2 = false, notCheckable=true, func = whisperClick}

				menuCountInvites = menuCountInvites + 1

				menuList[2].menuList[menuCountInvites] = {text = levelhex..WoWTable[i].level.."|r "..Hex..WoWTable[i].name.."|r", arg1 = WoWTable[i].name, notCheckable=true, func = inviteClick}
			end
		end
	end

	T.Miscellaneous.DropDown.Open(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
end

local OnMouseDown = function(self, btn)
	if btn == "LeftButton" then
		ToggleFriendsFrame()
	end
end

local OnEnter = function(self)
	if InCombatLockdown() then
		return
	end

	if not BNConnected() then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		GameTooltip:AddLine(BN_CHAT_DISCONNECTED)
		GameTooltip:Show()

		return
	end

	local totalonline = BNTotalOnline
	local wowonline = C_FriendList_GetNumFriends()
	local zonec, levelc, realmc, grouped
	wipe(classc)
	local DisplayLimit = floor((T.ScreenHeight / 100) * 2)

	if (totalonline > 0) then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine("Battle.net:", format(totalOnlineString, totalonline, #BNTable),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
		GameTooltip:AddLine(" ")

		if BNTotalOnline > 0 then
			local status = 0
			local count = 0

			for i = 1, #BNTable do
				local BNName = RemoveTagNumber(BNTable[i][3])

				if BNTable[i][7] then
					if C.DataTexts.HideFriendsNotPlaying and (BNTable[i][6] == "BSAp" or BNTable[i][6] == "App") then
						-- ignore them on tooltip, not playing any game.
					else
						if (count <= DisplayLimit) then
							if BNTable[i][6] == wowString then
								local isBattleTag = BNTable[i][17]
								local ProjectID = (BNTable[i][18] == 1 and "World of Warcraft") or (BNTable[i][18] == 2 and "World of Warcraft Classic") or UNKNOWN

								if (BNTable[i][8] == true) then
									status = 1
								elseif (BNTable[i][9] == true) then
									status = 2
								else
									status = 3
								end

								if T.Colors.class[BNTable[i][14]] then
									classc.r, classc.g, classc.b = unpack(T.Colors.class[BNTable[i][14]])
								else
									classc.r, classc.g, classc.b = 1, 1, 1
								end

								levelc = GetQuestDifficultyColor(BNTable[i][16])

								if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then
									grouped = 1
								else
									grouped = 2
								end

								GameTooltip:AddDoubleLine(format(clientLevelNameString, BNName, levelc.r * 255, levelc.g * 255, levelc.b * 255, BNTable[i][16], classc.r * 255, classc.g * 255, classc.b * 255, BNTable[i][4], groupedTable[grouped], 255, 0, 0, statusTable[status]), ProjectID)

								if IsShiftKeyDown() and CanCooperateWithGameAccount(BNTable[i][5]) then
									if GetRealZoneText() == BNTable[i][15] then
										zonec = activezone
									else
										zonec = inactivezone
									end

									if GetRealmName() == BNTable[i][11] then
										realmc = activezone
									else
										realmc = inactivezone
									end

									GameTooltip:AddDoubleLine("  "..BNTable[i][15], BNTable[i][11], zonec.r, zonec.g, zonec.b, realmc.r, realmc.g, realmc.b)
								end
							end

							if BNTable[i][6] == "BSAp" or BNTable[i][6] == "App" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "Battle.net")
							end

							if BNTable[i][6] == "D3" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "Diablo 3")
							end

							if BNTable[i][6] == "Hero" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "Heroes of the Storm")
							end

							if BNTable[i][6] == "S1" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "StarCraft: Remastered")
							end

							if BNTable[i][6] == "S2" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "StarCraft 2")
							end

							if BNTable[i][6] == "WTCG" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "Hearthstone")
							end

							if BNTable[i][6] == "Pro" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "Overwatch")
							end

							if BNTable[i][6] == "DST2" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "Destiny 2")
							end

							if BNTable[i][6] == "VIPR" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "Call of Duty: Black Ops 4")
							end

							if BNTable[i][6] == "ODIN" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNName.."|r", "Call of Duty: Modern Warfare")
							end

							count = count + 1
						elseif count == DisplayLimit + 1 then
							GameTooltip:AddLine(" ")
							GameTooltip:AddDoubleLine(" ", "List is too big to display them all...")

							count = 5000
						end
					end
				end
			end
		end

		---- Add wow friends listing
		wipe(WoWTable)

		local WoWFriendCount = 0

		for i = 1, wowonline do
			local friendinfo = C_FriendList_GetFriendInfoByIndex(i)

			WoWTable[i] = friendinfo

			if friendinfo and friendinfo.connected then
				local name = friendinfo.name
				local level = friendinfo.level
				local class = friendinfo.className
				local area = friendinfo.area

				for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
					if class == v then
						class = k

						WoWTable[i].className = class
					end
				end

				local R, G, B = 1, 1, 1
				
				if (T.Colors.class[class]) then
					R, G, B = unpack(T.Colors.class[class])
				end
				
				local Hex = T.RGBToHex(R, G, B)
				local levelc = GetQuestDifficultyColor(level)
				local levelhex = T.RGBToHex(levelc.r, levelc.g, levelc.b)

				WoWTable[i].hex = Hex
				WoWFriendCount = WoWFriendCount + 1

				if WoWFriendCount == 1 then
					GameTooltip:AddLine(" ")
					GameTooltip:AddDoubleLine("|cffff8000World of Warcraft:|r", "|cffff8000"..C_FriendList.GetNumOnlineFriends().."/"..C_FriendList.GetNumFriends().."|r")
					GameTooltip:AddLine(" ")
				end

				GameTooltip:AddDoubleLine(Hex..name.."|r ("..levelhex..level.."|r)", area)
			end
		end

		GameTooltip:Show()
	else
		GameTooltip_Hide()
	end
end

local Update = function(self, event)
	if not BNConnected() then
		self.Text:SetFormattedText("%s %s%s", DataText.NameColor .. FRIENDS .. "|r", DataText.ValueColor, NOT_APPLICABLE)

		return
	end

	local BNTotal = BNGetNumFriends()

	if BNTotal == #BNTable then
		UpdateBNTable(BNTotal)
	else
		BuildBNTable(BNTotal)
	end

	self.Text:SetFormattedText("%s %s%s", DataText.NameColor .. FRIENDS .. "|r", DataText.ValueColor, BNTotalOnline + C_FriendList.GetNumOnlineFriends())
end

local Enable = function(self)
	self:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
	self:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
	self:RegisterEvent("FRIENDLIST_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("IGNORELIST_UPDATE")
	self:RegisterEvent("MUTELIST_UPDATE")
	self:RegisterEvent("PLAYER_FLAGS_CHANGED")
	self:RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED")
	self:RegisterEvent("BN_FRIEND_INFO_CHANGED")
	self:RegisterEvent("BN_FRIEND_INVITE_LIST_INITIALIZED")
	self:RegisterEvent("BN_FRIEND_INVITE_ADDED")
	self:RegisterEvent("BN_FRIEND_INVITE_REMOVED")
	self:RegisterEvent("BN_BLOCK_LIST_UPDATED")
	self:RegisterEvent("BN_CONNECTED")
	self:RegisterEvent("BN_DISCONNECTED")
	self:RegisterEvent("BN_INFO_CHANGED")
	self:RegisterEvent("BATTLETAG_INVITE_SHOW")
	--self:RegisterEvent("PARTY_REFER_A_FRIEND_UPDATED")

	self:SetScript("OnMouseDown", OnMouseDown)
	self:SetScript("OnMouseUp", OnMouseUp)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", GameTooltip_Hide)
	self:SetScript("OnEvent", Update)

	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnMouseDown", nil)
	self:SetScript("OnMouseUp", nil)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	self:SetScript("OnEvent", nil)
end

DataText:Register("Friends", Enable, Disable, Update)
