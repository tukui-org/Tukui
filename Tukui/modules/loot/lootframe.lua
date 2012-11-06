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
	if not self:GetID() then return end
	
	if(IsModifiedClick()) then
		HandleModifiedItemClick(GetLootSlotLink(self:GetID()))
	else
		ss = self:GetID()
		sq = self.quality
		sn = self.name:GetText()
		st = self.icon:GetTexture()
		
		-- master looter
		LootFrame.selectedLootButton = self:GetName()
		LootFrame.selectedSlot = ss
		LootFrame.selectedQuality = sq
		LootFrame.selectedItemName = sn
		LootFrame.selectedTexture = st

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
	ToggleDropDownMenu(nil, nil, TukuiMasterLootDropDown, addon.slots[ss], 0, 0)
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