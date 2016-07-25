local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local Popups = T["Popups"]
local format = format

local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r"
local clientLevelNameString = "%s (|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s) |cff%02x%02x%02x%s|r"
local levelNameClassString = "|cff%02x%02x%02x%d|r %s%s%s"
local worldOfWarcraftString = "World of Warcraft"
local battleNetString = "Battle.NET"
local wowString = "WoW"
local totalOnlineString = L.DataText.Online .. "%s/%s"
local tthead, ttsubh, ttoff = {r=0.4, g=0.78, b=1}, {r=0.75, g=0.9, b=1}, {r=.3,g=1,b=.3}
local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
local statusTable = { "|cffff0000[AFK]|r", "|cffff0000[DND]|r", "" }
local groupedTable = { "|cffaaaaaa*|r", "" } 
local friendTable, BNTable = {}, {}
local totalOnline, BNTotalOnline = 0, 0
local BNGetGameAccountInfo = BNGetGameAccountInfo
local GetFriendInfo = GetFriendInfo
local BNGetFriendInfo = BNGetFriendInfo

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
	{ text = OPTIONS_MENU, isTitle = true, notCheckable=true},
	{ text = INVITE, hasArrow = true, notCheckable=true, },
	{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable=true, },			
	{ text = PLAYER_STATUS, hasArrow = true, notCheckable=true,
		menuList = {
			{ text = "|cff2BC226"..AVAILABLE.."|r", notCheckable=true, func = function()
				if IsChatAFK() then
					SendChatMessage("", "AFK")
				elseif IsChatDND() then
					SendChatMessage("", "DND")
				end
			end },

			{ text = "|cffE7E716"..DND.."|r", notCheckable=true, func = function()
				if not IsChatDND() then
					SendChatMessage("", "DND")
				end
			end },

			{ text = "|cffFF0000"..AFK.."|r", notCheckable=true, func = function()
				if not IsChatAFK() then
					SendChatMessage("", "AFK")
				end
			end },
		},
	},
	{ text = BN_BROADCAST_TOOLTIP, notCheckable=true, func = function()
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

local function whisperClick(self,name,bnet)
	menuFrame:Hide()
	
	if bnet then
		ChatFrame_SendSmartTell(name)
	else
		SetItemRef( "player:"..name, ("|Hplayer:%1$s|h[%1$s]|h"):format(name), "LeftButton" )
	end
end

local function BuildFriendTable(total)
	totalOnline = 0
	wipe(friendTable)

	local name, level, class, area, connected, status, note

	for i = 1, total do
		name, level, class, area, connected, status, note = GetFriendInfo(i)

		for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
			if class == v then
				class = k
			end
		end

		if status == "<"..AFK..">" then
			status = "|cffff0000[AFK]|r"
		elseif status == "<"..DND..">" then
			status = "|cffff0000[DND]|r"
		end

		friendTable[i] = { name, level, class, area, connected, status, note }

		if connected then
			totalOnline = totalOnline + 1
		end
	end
end

local function UpdateFriendTable(total)
	totalOnline = 0

	local name, level, class, area, connected, status, note

	for i = 1, #friendTable do
		name, level, class, area, connected, status, note = GetFriendInfo(i)

		for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
			if class == v then
				class = k
			end
		end

		-- get the correct index in our table		
		local index = GetTableIndex(friendTable, 1, name)

		-- we cannot find a friend in our table, so rebuild it
		if index == -1 then
			BuildFriendTable(total)
			break
		end

		-- update on-line status for all members
		friendTable[index][5] = connected

		-- update information only for on-line members
		if connected then
			friendTable[index][2] = level
			friendTable[index][3] = class
			friendTable[index][4] = area
			friendTable[index][6] = status
			friendTable[index][7] = note
			totalOnline = totalOnline + 1
		end
	end
end

local function BuildBNTable(total)
	BNTotalOnline = 0
	wipe(BNTable)

	for i = 1, total do
		local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(i)
		local hasFocus, _, _, realmName, realmID, faction, race, class, guild, zoneName, level, gameText = BNGetGameAccountInfo(toonID or presenceID)

		for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
			if class == v then
				class = k
			end
		end

		BNTable[i] = { presenceID, presenceName, battleTag, toonName, toonID, client, isOnline, isAFK, isDND, noteText, realmName, faction, race, class, zoneName, level }

		if isOnline then
			BNTotalOnline = BNTotalOnline + 1
		end
	end
end

local function UpdateBNTable(total)
	BNTotalOnline = 0

	for i = 1, #BNTable do
		-- get guild roster information
		local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(i)
		local hasFocus, _, _, realmName, realmID, faction, race, class, guild, zoneName, level, gameText = BNGetGameAccountInfo(toonID or presenceID)

		for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
			if class == v then
				class = k
			end
		end

		-- get the correct index in our table		
		local index = GetTableIndex(BNTable, 1, presenceID)

		-- we cannot find a BN member in our table, so rebuild it
		if index == -1 then
			BuildBNTable(total)
			return
		end

		-- update on-line status for all members
		BNTable[index][7] = isOnline

		-- update information only for on-line members
		if isOnline then
			BNTable[index][2] = presenceName
			BNTable[index][3] = RemoveTagNumber(battleTag)
			BNTable[index][4] = toonName
			BNTable[index][5] = toonID
			BNTable[index][6] = client
			BNTable[index][8] = isAFK
			BNTable[index][9] = isDND
			BNTable[index][10] = noteText
			BNTable[index][11] = realmName
			BNTable[index][12] = faction
			BNTable[index][13] = race
			BNTable[index][14] = class
			BNTable[index][15] = zoneName
			BNTable[index][16] = level
			BNTable[index][17] = isBattleTagPresence

			BNTotalOnline = BNTotalOnline + 1
		end
	end
end

local OnMouseUp = function(self, btn)
	if btn ~= "RightButton" then
		return
	end

	GameTooltip:Hide()

	local menuCountWhispers = 0
	local menuCountInvites = 0
	local classc, levelc

	menuList[2].menuList = {}
	menuList[3].menuList = {}

	if totalOnline > 0 then
		for i = 1, #friendTable do
			if (friendTable[i][5]) then
				menuCountInvites = menuCountInvites + 1
				menuCountWhispers = menuCountWhispers + 1

				classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[friendTable[i][3]], GetQuestDifficultyColor(friendTable[i][2])

				if classc == nil then
					classc = GetQuestDifficultyColor(friendTable[i][2])
				end

				menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,friendTable[i][2],classc.r*255,classc.g*255,classc.b*255,friendTable[i][1]), arg1 = friendTable[i][1],notCheckable=true, func = inviteClick}
				menuList[3].menuList[menuCountWhispers] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,friendTable[i][2],classc.r*255,classc.g*255,classc.b*255,friendTable[i][1]), arg1 = friendTable[i][1],notCheckable=true, func = whisperClick}
			end
		end
	end

	if BNTotalOnline > 0 then
		local realID, grouped

		for i = 1, #BNTable do
			if (BNTable[i][7]) then
				realID = BNTable[i][2]
				menuCountWhispers = menuCountWhispers + 1
				menuList[3].menuList[menuCountWhispers] = {text = realID, arg1 = realID, arg2 = true, notCheckable=true, func = whisperClick}

				if BNTable[i][6] == wowString and UnitFactionGroup("player") == BNTable[i][12] then
					classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(BNTable[i][16])

					if classc == nil then
						classc = GetQuestDifficultyColor(BNTable[i][16])
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
	end

	T.Miscellaneous.DropDown.Open(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
end

local OnMouseDown = function(self, btn)
	if btn == "LeftButton" then
		ToggleFriendsFrame()
	end
end

local OnLeave = function()
	GameTooltip:Hide()
end

local OnEnter = function(self)
	if InCombatLockdown() then
		return
	end

	local totalonline = totalOnline + BNTotalOnline
	local totalfriends = #friendTable + #BNTable
	local zonec, classc, levelc, realmc, grouped
	local onWoW, onHS, onD3, onHotS, onOW, onClient, onS2 = 0, 0, 0, 0, 0, 0, 0

	if (totalonline > 0) then
		GameTooltip:SetOwner(self:GetTooltipAnchor())
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine(L.DataText.FriendsList, format(totalOnlineString, totalonline, totalfriends),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)

		if totalOnline > 0 then
			GameTooltip:AddLine(" ")

			for i = 1, #friendTable do
				if friendTable[i][5] then
					if GetRealZoneText() == friendTable[i][4] then
						zonec = activezone
					else
						zonec = inactivezone
					end

					classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[friendTable[i][3]], GetQuestDifficultyColor(friendTable[i][2])

					if classc == nil then
						classc = GetQuestDifficultyColor(friendTable[i][2])
					end

					if UnitInParty(friendTable[i][1]) or UnitInRaid(friendTable[i][1]) then
						grouped = 1
					else
						grouped = 2
					end

					GameTooltip:AddDoubleLine(format(levelNameClassString,levelc.r*255,levelc.g*255,levelc.b*255,friendTable[i][2],friendTable[i][1],groupedTable[grouped]," "..friendTable[i][6]),friendTable[i][4],classc.r,classc.g,classc.b,zonec.r,zonec.g,zonec.b)
				end
			end
		end

		if BNTotalOnline > 0 then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine("["..BATTLETAG.."]------------------------ "..battleNetString.." ------------------------["..NAME.."]")

			local status = 0

			for i = 1, #BNTable do
				if BNTable[i][7] then
					if BNTable[i][6] == wowString then
						onWoW = onWoW + 1

						local Client = "World of Warcraft"
						local isBattleTag = BNTable[i][17]

						if onWoW == 1 then
							GameTooltip:AddLine(" ")
							GameTooltip:AddLine(Client)
						end

						if (BNTable[i][8] == true) then
							status = 1
						elseif (BNTable[i][9] == true) then
							status = 2
						else
							status = 3
						end

						classc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]]
						levelc = GetQuestDifficultyColor(BNTable[i][16])

						if not classc then
							classc = {r=1, g=1, b=1}
						end

						if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then
							grouped = 1
						else
							grouped = 2
						end

						GameTooltip:AddDoubleLine(format(clientLevelNameString, BNTable[i][3],levelc.r*255,levelc.g*255,levelc.b*255,BNTable[i][16],classc.r*255,classc.g*255,classc.b*255,BNTable[i][4],groupedTable[grouped], 255, 0, 0, statusTable[status]),isBattleTag == false and BNTable[i][2],238,238,238,238,238,238)

						if IsShiftKeyDown() then
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
				end
			end

			for i = 1, #BNTable do
				if BNTable[i][7] then
					if BNTable[i][6] == "WTCG" then
						onHS = onHS + 1

						local Client = "Hearthstone"
						local isBattleTag = BNTable[i][17]

						if onHS == 1 then
							GameTooltip:AddDoubleLine(" ", " ")
							GameTooltip:AddDoubleLine("|cffD49E43"..Client.."|r", "")
						end

						GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][3].."|r", isBattleTag == false and BNTable[i][2],238,238,238,238,238,238)
					end
				end
			end

			for i = 1, #BNTable do
				if BNTable[i][7] then
					if BNTable[i][6] == "D3" then
						onD3 = onD3 + 1

						local Client = "Diablo III"
						local isBattleTag = BNTable[i][17]

						if onD3 == 1 then
							GameTooltip:AddDoubleLine(" ", " ")
							GameTooltip:AddDoubleLine("|cffCC2200"..Client.."|r", "")
						end

						GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][3].."|r", isBattleTag == false and BNTable[i][2],238,238,238,238,238,238)
					end
				end
			end

			for i = 1, #BNTable do
				if BNTable[i][7] then
					if BNTable[i][6] == "Hero" then
						onHotS = onHotS + 1

						local Client = "Heroes of the Storm"
						local isBattleTag = BNTable[i][17]

						if onHotS == 1 then
							GameTooltip:AddDoubleLine(" ", " ")
							GameTooltip:AddDoubleLine("|cffACE5EE"..Client.."|r", "")
						end

						GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][3].."|r", isBattleTag == false and BNTable[i][2],238,238,238,238,238,238)
					end
				end
			end

			for i = 1, #BNTable do
				if BNTable[i][7] then
					if BNTable[i][6] == "S2" then
						onS2 = onS2 + 1

						local Client = "Starcraft II"
						local isBattleTag = BNTable[i][17]

						if onS2 == 1 then
							GameTooltip:AddDoubleLine(" ", " ")
							GameTooltip:AddDoubleLine("|cffACE5EE"..Client.."|r", "")
						end

						GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][3].."|r", isBattleTag == false and BNTable[i][2],238,238,238,238,238,238)
					end
				end
			end

			for i = 1, #BNTable do
				if BNTable[i][7] then
					if BNTable[i][6] == "Pro" then
						onOW = onOW + 1

						local Client = "Overwatch"
						local isBattleTag = BNTable[i][17]

						if onOW == 1 then
							GameTooltip:AddDoubleLine(" ", " ")
							GameTooltip:AddDoubleLine("|cffACE5EE"..Client.."|r", "")
						end

						GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][3].."|r", isBattleTag == false and BNTable[i][2],238,238,238,238,238,238)
					end
				end
			end

			for i = 1, #BNTable do
				if BNTable[i][7] then
					if BNTable[i][6] == "App" then
						onClient = onClient + 1

						local Client = "Battle.NET Client"
						local isBattleTag = BNTable[i][17]

						if onClient == 1 then
							GameTooltip:AddDoubleLine(" ", " ")
							GameTooltip:AddDoubleLine("|cff00B4FF"..Client.."|r", "")
						end

						GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][3].."|r", isBattleTag == false and BNTable[i][2],238,238,238,238,238,238)
					end
				end
			end
		end

		GameTooltip:Show()
	else 
		GameTooltip:Hide() 
	end
end

local Update = function(self, event)
	local BNTotal = BNGetNumFriends()
	local Total = GetNumFriends()

	if BNTotal == #BNTable then
		UpdateBNTable(BNTotal)
	else
		BuildBNTable(BNTotal)
	end

	if Total == #friendTable then
		UpdateFriendTable(Total)
	else
		BuildFriendTable(Total)
	end

	self.Text:SetFormattedText("%s: %s%s", DataText.NameColor .. FRIENDS .. "|r", DataText.ValueColor, totalOnline + BNTotalOnline)
end

local Enable = function(self)
	self:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
	self:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
	self:RegisterEvent("BN_FRIEND_TOON_ONLINE")
	self:RegisterEvent("BN_FRIEND_TOON_OFFLINE")
	self:RegisterEvent("BN_TOON_NAME_UPDATED")
	self:RegisterEvent("FRIENDLIST_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("FRIENDLIST_SHOW")
	self:RegisterEvent("IGNORELIST_UPDATE")
	self:RegisterEvent("MUTELIST_UPDATE")
	self:RegisterEvent("PLAYER_FLAGS_CHANGED")
	self:RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED")
	self:RegisterEvent("BN_FRIEND_INFO_CHANGED")
	self:RegisterEvent("BN_FRIEND_INVITE_LIST_INITIALIZED")
	self:RegisterEvent("BN_FRIEND_INVITE_ADDED")
	self:RegisterEvent("BN_FRIEND_INVITE_REMOVED")
	self:RegisterEvent("BN_SELF_ONLINE")
	self:RegisterEvent("BN_BLOCK_LIST_UPDATED")
	self:RegisterEvent("BN_CONNECTED")
	self:RegisterEvent("BN_DISCONNECTED")
	self:RegisterEvent("BN_INFO_CHANGED")
	self:RegisterEvent("BATTLETAG_INVITE_SHOW")
	self:RegisterEvent("PARTY_REFER_A_FRIEND_UPDATED")

	self:SetScript("OnMouseDown", OnMouseDown)
	self:SetScript("OnMouseUp", OnMouseUp)
	self:SetScript("OnEnter", OnEnter)
	self:SetScript("OnLeave", OnLeave)
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

DataText:Register(L.DataText.Friends, Enable, Disable, Update)