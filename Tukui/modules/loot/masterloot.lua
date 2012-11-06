------------------------------------------
-- Master Loot (special thanks to Ammo) --
------------------------------------------

local T, C, L, G = unpack(select(2, ...)) 

if not C["loot"].lootframe == true then return end

local mlItemName, mlAssignNickname, mlValue, mlPopupQuestion
local ML_UNKNOWN = UNKNOWN

T.CreatePopup["TUKUI_GIVEMASTERLOOT"] = {
	answer1 = ACCEPT,
	answer2 = CANCEL,
	function1 = function() GiveMasterLoot(LootFrame.selectedSlot, mlValue) end,
}

local hexColors = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	hexColors[k] = "|c" .. v.colorStr
end
hexColors["UNKNOWN"] = string.format("|cff%02x%02x%02x", 0.6*255, 0.6*255, 0.6*255)

local playerName = UnitName("player")
local classesInRaid = {}
local players, player_indices = {}, {}
local randoms = {}
local wipe = table.wipe

local function MasterLoot_RequestRoll(frame)
	DoMasterLootRoll(frame.value)
end

local function MasterLoot_GiveLoot(frame)
	if LootFrame.selectedQuality >= MASTER_LOOT_THREHOLD then
		mlValue = frame.value
		mlItemName = ITEM_QUALITY_COLORS[LootFrame.selectedQuality].hex..LootFrame.selectedItemName..FONT_COLOR_CODE_CLOSE
		mlAssignNickname = frame:GetText()
		T.CreatePopup.TUKUI_GIVEMASTERLOOT.question = string.format(CONFIRM_LOOT_DISTRIBUTION, mlItemName, mlAssignNickname)
		T.ShowPopup("TUKUI_GIVEMASTERLOOT")
	else
		GiveMasterLoot(LootFrame.selectedSlot, frame.value)
	end
	CloseDropDownMenus()
end

local function init()
	local candidate, color, lclass, className
	local slot = LootFrame.selectedSlot or 0
	local info = UIDropDownMenu_CreateInfo()
	
 	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		wipe(players)
		wipe(player_indices)
		local this_class = UIDROPDOWNMENU_MENU_VALUE
		for i = 1, MAX_RAID_MEMBERS do
			candidate,lclass,className = GetMasterLootCandidate(slot,i)
			if candidate and this_class == className then
				table.insert(players,candidate)
				player_indices[candidate] = i
			end
		end
		if #players > 0 then
			table.sort(players)
			local _, cand
			for _,cand in ipairs(players) do
				info.text = cand
				info.colorCode = hexColors[this_class] or hexColors["UNKNOWN"]
				info.textHeight = 12
				info.value = player_indices[cand]
				info.notCheckable = 1
				info.disabled = nil
				info.func = MasterLoot_GiveLoot
				UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL)
			end
		end
		return
 	end

	info.isTitle = 1
	info.text = GIVE_LOOT
	info.textHeight = 12
	info.notCheckable = 1
	info.disabled = nil
	info.notClickable = nil
	UIDropDownMenu_AddButton(info)

	if ( IsInRaid() ) then
		wipe(classesInRaid)
		for i = 1, MAX_RAID_MEMBERS do
			candidate,lclass,className = GetMasterLootCandidate(slot,i)
			if candidate then
				classesInRaid[className] = lclass
			end		
		end

		for i, class in ipairs(CLASS_SORT_ORDER) do
			local cname = classesInRaid[class]
			if cname then
				info.isTitle = nil
				info.text = cname
				info.colorCode = hexColors[class] or hexColors["UNKNOWN"]
				info.textHeight = 12
				info.hasArrow = 1
				info.notCheckable = 1
				info.value = class
				info.func = nil
				info.disabled = nil
				UIDropDownMenu_AddButton(info)
			end
		end
	else
		-- In a party
		for i=1, MAX_PARTY_MEMBERS+1, 1 do
			candidate,lclass,className = GetMasterLootCandidate(slot,i)
			if candidate then
				info.text = candidate
				info.colorCode = hexColors[className] or hexColors["UNKNOWN"]
				info.textHeight = 12
				info.value = i
				info.notCheckable = 1
				info.hasArrow = nil
				info.isTitle = nil
				info.disabled = nil
				info.func = MasterLoot_GiveLoot
				UIDropDownMenu_AddButton(info)
			end
		end
	end
	
	info.colorCode = "|cffffffff"
	info.isTitle = nil
	info.textHeight = 12
	info.value = slot
	info.notCheckable = 1
	info.hasArrow = nil
	info.text = REQUEST_ROLL
	info.func = MasterLoot_RequestRoll
	info.icon = "Interface\\Buttons\\UI-GroupLoot-Dice-Up"
	UIDropDownMenu_AddButton(info)
	
	wipe(randoms)
	for i = 1, MAX_RAID_MEMBERS do
		candidate,lclass,className = GetMasterLootCandidate(slot,i)
		if candidate then
			table.insert(randoms, i)
		end
	end
	if #randoms > 0 then
		info.colorCode = "|cffffffff"
		info.isTitle = nil
		info.textHeight = 12
		info.value = randoms[math.random(1, #randoms)]
		info.notCheckable = 1
		info.text = L.loot_randomplayer
		info.func = MasterLoot_GiveLoot
		info.icon = "Interface\\Buttons\\UI-GroupLoot-Coin-Up"
		UIDropDownMenu_AddButton(info)
	end
	for i = 1, MAX_RAID_MEMBERS do
		candidate,lclass,className = GetMasterLootCandidate(slot,i)
		if candidate and candidate == playerName then
			info.colorCode = hexColors[className] or hexColors["UNKNOWN"]
			info.isTitle = nil
			info.textHeight = 12
			info.value = i
			info.notCheckable = 1
			info.text = L.loot_self
			info.func = MasterLoot_GiveLoot
			info.icon = "Interface\\GossipFrame\\VendorGossipIcon"
			UIDropDownMenu_AddButton(info)
		end
	end
end

local dropdown = CreateFrame("Frame", "TukuiMasterLootDropDown", UIParent, "UIDropDownMenuTemplate")
UIDropDownMenu_Initialize(dropdown, init, "MENU")