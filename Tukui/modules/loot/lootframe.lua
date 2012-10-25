local T, C, L, G = unpack(select(2, ...)) 
-- credits : Haste

if not C["loot"].lootframe == true then return end

local addon = CreateFrame("Button", "TukuiLootFrame")
G.Loot.Frame = addon
local title = addon:CreateFontString(nil, "OVERLAY")
G.Loot.Frame.title = title

local iconSize = 30
local frameScale = 1

local sq, ss, sn, st

local OnEnter = function(self)
	local slot = self:GetID()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetLootItem(slot)
	CursorUpdate(self)
	
	self.drop:Show()
	self.drop:SetVertexColor(1, 1, 0)
end

local OnLeave = function(self)
	if self.quality then
		if(self.quality > 1) then
			local color = ITEM_QUALITY_COLORS[self.quality]
			self.drop:SetVertexColor(color.r, color.g, color.b)
		else
			self.drop:Hide()
		end
	end

	GameTooltip:Hide()
	ResetCursor()
end

local OnClick = function(self)
	if(IsModifiedClick()) then
		HandleModifiedItemClick(GetLootSlotLink(self:GetID()))
	else
		ss = self:GetID()
		sq = self.quality
		sn = self.name:GetText()
		st = self.icon:GetTexture()

		LootSlot(ss)
	end
end

local OnUpdate = function(self)
	if(GameTooltip:IsOwned(self)) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetLootItem(self:GetID())
		CursorOnUpdate(self)
	end
end

local createSlot = function(id)
	local iconsize = iconSize-2
	local frame = CreateFrame("Button", 'TukuiLootFrameSlot'..id, addon)
	frame:Point("LEFT", 8, 0)
	frame:Point("RIGHT", -8, 0)
	frame:Height(iconsize)
	frame:SetID(id)

	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	frame:SetScript("OnEnter", OnEnter)
	frame:SetScript("OnLeave", OnLeave)
	frame:SetScript("OnClick", OnClick)
	frame:SetScript("OnUpdate", OnUpdate)

	local iconFrame = CreateFrame("Frame", nil, frame)
	iconFrame:Height(iconsize)
	iconFrame:Width(iconsize)
	iconFrame:ClearAllPoints()
	iconFrame:SetPoint("RIGHT", frame)
	
	iconFrame:SetTemplate("Default")

	local icon = iconFrame:CreateTexture(nil, "ARTWORK")
	icon:SetAlpha(.8)
	icon:SetTexCoord(.07, .93, .07, .93)
	icon:Point("TOPLEFT", 2, -2)
	icon:Point("BOTTOMRIGHT", -2, 2)
	frame.icon = icon

	local count = iconFrame:CreateFontString(nil, "OVERLAY")
	count:ClearAllPoints()
	count:SetJustifyH"RIGHT"
	count:Point("BOTTOMRIGHT", iconFrame, -1, 2)
	count:SetFont(C["media"].font, 12, "OUTLINE")
	count:SetShadowOffset(.8, -.8)
	count:SetShadowColor(0, 0, 0, 1)
	count:SetText(1)
	frame.count = count

	local name = frame:CreateFontString(nil, "OVERLAY")
	name:SetJustifyH"LEFT"
	name:ClearAllPoints()
	name:SetPoint("LEFT", frame)
	name:SetPoint("RIGHT", icon, "LEFT")
	name:SetNonSpaceWrap(true)
	name:SetFont(C["media"].font, 13, "OUTLINE")
	name:SetShadowOffset(.8, -.8)
	name:SetShadowColor(0, 0, 0, 1)
	frame.name = name

	local drop = frame:CreateTexture(nil, "ARTWORK")
	drop:SetTexture"Interface\\QuestFrame\\UI-QuestLogTitleHighlight"

	drop:SetPoint("LEFT", icon, "RIGHT", 0, 0)
	drop:SetPoint("RIGHT", frame)
	drop:SetAllPoints(frame)
	drop:SetAlpha(.3)
	frame.drop = drop

	addon.slots[id] = frame
	return frame
end

local anchorSlots = function(self)
	local iconsize = iconSize
	local shownSlots = 0
	for i=1, #self.slots do
		local frame = self.slots[i]
		if(frame:IsShown()) then
			shownSlots = shownSlots + 1

			-- We don't have to worry about the previous slots as they're already hidden.
			frame:Point("TOP", addon, 4, (-8 + iconsize) - (shownSlots * iconsize))
		end
	end

	self:Height(math.max(shownSlots * iconsize + 16, 20))
end

title:SetFont(C["media"].font, 13, "OUTLINE")
title:Point("BOTTOMLEFT", addon, "TOPLEFT", 4, 4)

addon:SetScript("OnMouseDown", function(self) if(IsAltKeyDown()) then self:StartMoving() end end)
addon:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
addon:SetScript("OnHide", function(self)
	StaticPopup_Hide"CONFIRM_LOOT_DISTRIBUTION"
	CloseLoot()
end)
addon:SetMovable(true)
addon:RegisterForClicks"anyup"

addon:SetParent(UIParent)
addon:Point("TOPLEFT", 0, -104)
addon:SetTemplate("Default")
addon:Width(256)
addon:Height(64)
addon:SetBackdropColor(0.1, 0.1, 0.1, 1)

addon:SetClampedToScreen(true)
addon:SetClampRectInsets(0, 0, T.Scale(14), 0)
addon:SetHitRectInsets(0, 0, T.Scale(-14), 0)
addon:SetFrameStrata"HIGH"
addon:SetToplevel(true)

addon.slots = {}
addon.LOOT_OPENED = function(self, event, autoloot)
	self:Show()

	if(not self:IsShown()) then
		CloseLoot(not autoLoot)
	end

	local items = GetNumLootItems()

	if(IsFishingLoot()) then
		title:SetText(L.loot_fish)
	elseif(not UnitIsFriend("player", "target") and UnitIsDead"target") then
		title:SetText(UnitName"target")
	else
		title:SetText(LOOT)
	end

	-- Blizzard uses strings here
	if(GetCVar("lootUnderMouse") == "1") then
		local x, y = GetCursorPosition()
		x = x / self:GetEffectiveScale()
		y = y / self:GetEffectiveScale()

		self:ClearAllPoints()
		self:Point("TOPLEFT", nil, "BOTTOMLEFT", x - 40, y + 20)
		self:GetCenter()
		self:Raise()
	else
		self:ClearAllPoints()
		self:SetUserPlaced(false)
		self:Point("TOPLEFT", 0, -104)		
	end

	local m, w, t = 0, 0, title:GetStringWidth()
	if(items > 0) then
		for i=1, items do
			local slot = addon.slots[i] or createSlot(i)
			local texture, item, quantity, quality, locked = GetLootSlotInfo(i)
			
			if texture then
				local color = ITEM_QUALITY_COLORS[quality]

				if texture and texture:find('INV_Misc_Coin') then
					item = item:gsub("\n", ", ")
				end

				if(quantity > 1) then
					slot.count:SetText(quantity)
					slot.count:Show()
				else
					slot.count:Hide()
				end

				if(quality > 1) then
					slot.drop:SetVertexColor(color.r, color.g, color.b)
					slot.drop:Show()
				else
					slot.drop:Hide()
				end

				slot.quality = quality
				slot.name:SetText(item)
				slot.name:SetTextColor(color.r, color.g, color.b)
				slot.icon:SetTexture(texture)

				m = math.max(m, quality)
				w = math.max(w, slot.name:GetStringWidth())

				slot:Enable()
				slot:Show()
			end
		end
	else
		local slot = addon.slots[1] or createSlot(1)
		local color = ITEM_QUALITY_COLORS[0]

		slot.name:SetText(L.loot_empty)
		slot.name:SetTextColor(color.r, color.g, color.b)
		slot.icon:SetTexture[[Interface\Icons\INV_Misc_Herb_AncientLichen]]

		items = 1
		w = math.max(w, slot.name:GetStringWidth())

		slot.count:Hide()
		slot.drop:Hide()
		slot:Disable()
		slot:Show()
	end
	anchorSlots(self)

	w = w + 60
	t = t + 5

	local color = ITEM_QUALITY_COLORS[m]
	self:SetBackdropBorderColor(color.r, color.g, color.b, .8)
	self:Width(math.max(w, t))
end

addon.LOOT_SLOT_CLEARED = function(self, event, slot)
	if(not self:IsShown()) then return end

	addon.slots[slot]:Hide()
	anchorSlots(self)
end

addon.LOOT_CLOSED = function(self)
	StaticPopup_Hide"LOOT_BIND"
	self:Hide()

	for _, v in pairs(self.slots) do
		v:Hide()
	end
end

addon.OPEN_MASTER_LOOT_LIST = function(self)
	ToggleDropDownMenu(nil, nil, GroupLootDropDown, addon.slots[ss], 0, 0)
end

addon.UPDATE_MASTER_LOOT_LIST = function(self)
	UIDropDownMenu_Refresh(GroupLootDropDown)
end

addon.ADDON_LOADED = function(self, event, addon)
	if(addon == "Tukui") then
		self:SetScale(frameScale)

		-- clean up.
		self[event] = nil
		self:UnregisterEvent(event)
	end
end

addon:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

addon:RegisterEvent"LOOT_OPENED"
addon:RegisterEvent"LOOT_SLOT_CLEARED"
addon:RegisterEvent"LOOT_CLOSED"
addon:RegisterEvent"OPEN_MASTER_LOOT_LIST"
addon:RegisterEvent"UPDATE_MASTER_LOOT_LIST"
addon:RegisterEvent"ADDON_LOADED"
addon:Hide()

-- Fuzz
LootFrame:UnregisterAllEvents()
table.insert(UISpecialFrames, "TukuiLootFrame")

-- Master Loot (special thanks to Ammo)
local mlItemName, mlAssignNickname, mlValue, mlPopupQuestion

T.CreatePopup["TUKUI_GIVEMASTERLOOT"] = {
	answer1 = ACCEPT,
	answer2 = CANCEL,
	function1 = function() GiveMasterLoot(ss, mlValue) end,
}

local hexColors = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	hexColors[k] = string.format("|cff%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
end
hexColors["UNKNOWN"] = string.format("|cff%02x%02x%02x", 0.6 * 255, 0.6 * 255, 0.6 * 255)

if CUSTOM_CLASS_COLORS then
	local function update()
		for k, v in pairs(CUSTOM_CLASS_COLORS) do
			hexColors[k] = string.format("|cff%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
		end
	end
	CUSTOM_CLASS_COLORS:RegisterCallback(update)
	update()
end

local playerName = UnitName("player")
local classesInRaid = {}
local players, player_indices = {}, {}
local randoms = {}
local wipe = table.wipe

local function MasterLoot_RequestRoll(frame)
	DoMasterLootRoll(frame.value)
end

local function MasterLoot_GiveLoot(frame)
	if sq >= MASTER_LOOT_THREHOLD then
		mlValue = frame.value
		mlItemName = ITEM_QUALITY_COLORS[sq].hex..sn..FONT_COLOR_CODE_CLOSE
		mlAssignNickname = frame:GetText()
		T.CreatePopup.TUKUI_GIVEMASTERLOOT.question = string.format(CONFIRM_LOOT_DISTRIBUTION, mlItemName, mlAssignNickname)
		T.ShowPopup("TUKUI_GIVEMASTERLOOT")
	else
		GiveMasterLoot(ss, frame.value)
	end
	CloseDropDownMenus()
end

local function init()
	local candidate, color, lclass, className
	local slot = sq or 0
	local info = UIDropDownMenu_CreateInfo()

	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		-- Raid class menu
		wipe(players)
		wipe(player_indices)
		local this_class = UIDROPDOWNMENU_MENU_VALUE
		for i = 1, MAX_RAID_MEMBERS do
			candidate, lclass, className = GetMasterLootCandidate(slot, i)
			if candidate and this_class == className then
				table.insert(players,candidate)
				player_indices[candidate] = i
			end
		end
		if #players > 0 then
			table.sort(players)
			for _, cand in ipairs(players) do
				-- Add candidate button
				info.text = cand
				info.colorCode = hexColors[this_class] or hexColors["UNKOWN"]
				info.textHeight = 12
				info.value = player_indices[cand]
				info.notCheckable = 1
				info.disabled = nil
				info.func = MasterLoot_GiveLoot
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
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

	if IsInRaid() then
		-- In a raid
		wipe(classesInRaid)
		for i = 1, MAX_RAID_MEMBERS do
			candidate, lclass, className = GetMasterLootCandidate(slot, i)
			if candidate then
				classesInRaid[className] = lclass
			end
		end

		for i, class in ipairs(CLASS_SORT_ORDER) do
			local cname = classesInRaid[class]
			if cname then
				info.isTitle = nil
				info.text = cname
				info.colorCode = hexColors[class] or hexColors["UNKOWN"]
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
		for i = 1, MAX_PARTY_MEMBERS + 1, 1 do
			candidate, lclass, className = GetMasterLootCandidate(slot, i)
			if candidate then
				-- Add candidate button
				info.text = candidate -- coloredNames[candidate]
				info.colorCode = hexColors[className] or hexColors["UNKOWN"]
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
		info.text = L_LOOT_RANDOM
		info.func = MasterLoot_GiveLoot
		info.icon = "Interface\\Buttons\\UI-GroupLoot-Coin-Up"
		UIDropDownMenu_AddButton(info)
	end
	for i = 1, MAX_RAID_MEMBERS do
		candidate, lclass, className = GetMasterLootCandidate(slot, i)
		if candidate and candidate == playerName then
			info.colorCode = hexColors[className] or hexColors["UNKOWN"]
			info.isTitle = nil
			info.textHeight = 12
			info.value = i
			info.notCheckable = 1
			info.text = L_LOOT_SELF
			info.func = MasterLoot_GiveLoot
			info.icon = "Interface\\GossipFrame\\VendorGossipIcon"
			UIDropDownMenu_AddButton(info)
		end
	end
end

UIDropDownMenu_Initialize(GroupLootDropDown, init, "MENU")