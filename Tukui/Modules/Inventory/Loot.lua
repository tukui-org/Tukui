--[[
	** Based on Butsu by Haste **
	** Build for Tukui by Aftermathh **
--]]

local T, C, L = select(2, ...):unpack()
local Inventory = T["Inventory"]
local Loot = CreateFrame("Frame")
local Movers = T["Movers"]
local LootFrame = LootFrame

-- Lib Globals
local _G = _G
local select = select
local unpack = unpack
local pairs = pairs
local max = math.max
local tinsert = table.insert

-- WoW Globals
local LootSlotHasItem = LootSlotHasItem
local CursorUpdate = CursorUpdate
local CursorOnUpdate = CursorOnUpdate
local ResetCursor = ResetCursor
local IsModifiedClick = IsModifiedClick
local GetLootSlotLink = GetLootSlotLink
local StaticPopup_Hide = StaticPopup_Hide
local CloseLoot = CloseLoot
local IsFishingLoot = IsFishingLoot
local UnitIsDead = UnitIsDead
local UnitIsFriend = UnitIsFriend
local UnitName = UnitName
local GetCVarBool = GetCVarBool
local GetCursorPosition = GetCursorPosition
local GetNumLootItems = GetNumLootItems
local GetLootSlotInfo = GetLootSlotInfo

---------------------------------------
-- Classic Blizzard Loot
---------------------------------------

function Loot:MoveStandardLoot()
	local IsUnderMouse = GetCVar("lootUnderMouse")

	if (IsUnderMouse ~= "1") then
		if not LootFrame.DragInfo then
			Movers:RegisterFrame(LootFrame)
		end

		if (not TukuiData[GetRealmName()][UnitName("Player")].Move) then
			TukuiData[GetRealmName()][UnitName("Player")].Move = {}
		end

		if not (TukuiData[GetRealmName()][UnitName("Player")].Move.LootFrame) then
			TukuiData[GetRealmName()][UnitName("Player")].Move.LootFrame = {"TOPLEFT", "UIParent", "TOPLEFT", 16, -116}
		end

		local A1, _, A2, X, Y = unpack(TukuiData[GetRealmName()][UnitName("Player")].Move.LootFrame)

		LootFrame:ClearAllPoints()
		LootFrame:SetPoint(A1, UIParent, A2, X, Y)
	end
end

function Loot:SkinStandardLootFrame()
	LootFrame:StripTextures()
	LootFrameInset:StripTextures()
	LootFrameInset:CreateBackdrop("Transparent")
	LootFrameInset.Backdrop:CreateShadow()
	LootFramePortraitOverlay:SetAlpha(0)

	LootFrameDownButton:StripTextures()
	LootFrameDownButton:Size(LootFrame:GetWidth() - 6, 23)
	LootFrameDownButton:SkinButton()
	LootFrameDownButton:FontString("Text", C.Medias.Font, 12)
	LootFrameDownButton.Text:SetPoint("CENTER")
	LootFrameDownButton.Text:SetText(NEXT)
	LootFrameDownButton:ClearAllPoints()
	LootFrameDownButton:Point("TOP", LootFrame, "BOTTOM", -1, -1)
	LootFrameDownButton:CreateShadow()
	LootFrameNext:SetAlpha(0)

	LootFrameUpButton:StripTextures()
	LootFrameUpButton:Size(LootFrame:GetWidth() - 6, 23)
	LootFrameUpButton:SkinButton()
	LootFrameUpButton:FontString("Text", C.Medias.Font, 12)
	LootFrameUpButton.Text:SetPoint("CENTER")
	LootFrameUpButton.Text:SetText(PREV)
	LootFrameUpButton:ClearAllPoints()
	LootFrameUpButton:Point("TOP", LootFrameDownButton, "BOTTOM", 0, -2)
	LootFrameUpButton:CreateShadow()
	LootFramePrev:SetAlpha(0)

	LootFrameCloseButton:EnableMouse(false)
	LootFrameCloseButton:StripTextures()

	local ItemText = select(19, LootFrame:GetRegions())

	ItemText:SetAlpha(0)
end

function Loot:SkinStandardLootFrameButtons(i)
	for i = 1, LootFrame.numLootItems do
		local Button = _G["LootButton" .. i]
		local Slot = (LOOTFRAME_NUMBUTTONS * (LootFrame.page - 1)) + i

		if Button then
			local Icon = _G["LootButton" .. i .. "IconTexture"]
			local Quest = _G["LootButton" .. i .. "IconQuestTexture"]
			local IconTexture = Icon:GetTexture()
			local IsQuestItem, QuestID, IsActive = select(6, GetLootSlotInfo(Slot))

			if (not Button.IsSkinned) then
				Button:StripTextures()
				Button:CreateBackdrop()
				Button.Backdrop:SetOutside(Icon)
				Button.IconBorder:SetAlpha(0)

				Icon:SetTexture(IconTexture)
				Icon:SetTexCoord(unpack(T.IconCoord))
				Icon:SetInside()

				Quest:SetAlpha(0)

				Button.IsSkinned = true
			end

			if (QuestID and not IsActive) then
				Button.Backdrop:SetBackdropBorderColor(0.97, 0.85, 0.31) -- Quest item
			elseif (QuestID or IsQuestItem) then
				Button.Backdrop:SetBackdropBorderColor(0.97, 0.85, 0.31) -- Quest item
			else
				Button.Backdrop:SetBackdropBorderColor(unpack(C.General.BorderColor)) -- Recolor if the previous item in the slot was a quest item
			end
		end
	end
end

function Loot:AddStandardLootHooks()
	hooksecurefunc("LootFrame_UpdateButton", self.SkinStandardLootFrameButtons)
	hooksecurefunc("LootFrame_Show", self.MoveStandardLoot)
end

---------------------------------------
-- Tukui Loot
---------------------------------------

function Loot:OnEnter()
	self.drop:SetStatusBarColor(1, 1, 1, 0.10)
	self.drop:Show()

	local slot = self:GetID()
	if LootSlotHasItem(slot) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetLootItem(slot)
		CursorUpdate(self)
	end
end

function Loot:OnLeave()
	self.drop:SetStatusBarColor(0, 0, 0, 0)
	self.drop:Hide()

	GameTooltip:Hide()
	ResetCursor()
end

function Loot:OnClick()
	LootFrame.selectedQuality = self.quality
	LootFrame.selectedItemName = self.name:GetText()
	LootFrame.selectedSlot = self:GetID()
	LootFrame.selectedLootButton = self:GetName()
	LootFrame.selectedTexture = self.icon:GetTexture()

	if IsModifiedClick() then
		HandleModifiedItemClick(GetLootSlotLink(self:GetID()))
	else
		StaticPopup_Hide("CONFIRM_LOOT_DISTRIBUTION")
		LootSlot(self:GetID())
	end
end

function Loot:OnShow()
	if GameTooltip:IsOwned(self) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetLootItem(self:GetID())
		CursorOnUpdate(self)
	end
end

function Loot:AnchorSlots()
	local shownSlots = 0
	for i = 1, #self.LootSlots do
		local frame = self.LootSlots[i]
		if frame:IsShown() then
			shownSlots = shownSlots + 1

			frame:Point("TOP", TukuiLootFrame, 4, (-8 + Loot.IconSize) - (shownSlots * (Loot.IconSize+1)))
		end
	end

	self:Height(max(shownSlots * Loot.IconSize + 16, 20))
end

function Loot:CreateSlots(id)
	local IconSize = (Loot.IconSize - 2)

	local frame = CreateFrame("Button", "TukuiLootSlot"..id, TukuiLootFrame)
	frame:Height(IconSize)
	frame:Point("LEFT", 8, 0)
	frame:Point("RIGHT", -8, 0)
	frame:CreateBackdrop()
	frame:CreateShadow()
	frame:SetID(id)
	
	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	frame:SetScript("OnEnter", Loot.OnEnter)
	frame:SetScript("OnLeave", Loot.OnLeave)
	frame:SetScript("OnClick", Loot.OnClick)
	frame:SetScript("OnShow", Loot.OnShow)

	local iconFrame = CreateFrame("Frame", nil, frame)
	iconFrame:Size(IconSize, IconSize)
	iconFrame:Point("RIGHT", frame, "LEFT", -2, 0)
	iconFrame:SetTemplate()
	iconFrame:CreateShadow()
	frame.iconFrame = iconFrame

	local icon = iconFrame:CreateTexture(nil, "ARTWORK")
	icon:SetTexCoord(.1, .9, .1, .9)
	icon:SetInside()
	frame.icon = icon
	
	local invsframe = CreateFrame("Frame", nil, frame)
	invsframe:SetFrameLevel(frame:GetFrameLevel() + 5)
	invsframe:SetAllPoints()
	frame.invsframe = invsframe

	local count = iconFrame:CreateFontString(nil, "OVERLAY")
	count:SetJustifyH("RIGHT")
	count:Point("BOTTOMRIGHT", iconFrame, -2, 4)
	count:SetFontTemplate(C.Medias.Font, 12)
	count:SetText(1)
	frame.count = count

	local name = invsframe:CreateFontString(nil, "OVERLAY")
	name:Point("RIGHT", invsframe)
	name:Point("LEFT", icon, "RIGHT", 4, 0)
	name:SetNonSpaceWrap(true)
	name:SetFontTemplate(C.Medias.Font, 12)
	frame.name = name
	
	local drop = CreateFrame("StatusBar", nil, frame)
	drop:SetFrameLevel(frame:GetFrameLevel() + 5)
	drop:SetInside(frame, 1, 1)
	drop:SetStatusBarTexture(C.Medias.Blank)
	drop:SetStatusBarColor(0, 0, 0, 0)
	frame.drop = drop
	
	TukuiLootFrame.LootSlots[id] = frame
	
	return frame
end

function Loot:LOOT_SLOT_CLEARED(_, slot)
	if not TukuiLootFrame:IsShown() then 
		return 
	end

	TukuiLootFrame.LootSlots[slot]:Hide()
	Loot.AnchorSlots(TukuiLootFrame)
end

function Loot:LOOT_CLOSED()
	StaticPopup_Hide("LOOT_BIND")
	TukuiLootFrame:Hide()

	for _, v in pairs(TukuiLootFrame.LootSlots) do
		v:Hide()
	end
end

function Loot:LOOT_OPENED(_, autoloot)
	TukuiLootFrame:Show()

	if not TukuiLootFrame:IsShown() then
		CloseLoot(not autoLoot)
	end
	
	if IsFishingLoot() then
		TukuiLootFrame.Title:SetText("Fishy Loot")
	elseif not UnitIsFriend("player", "target") and UnitIsDead("target") then
		TukuiLootFrame.Title:SetText(UnitName("target"))
	else
		TukuiLootFrame.Title:SetText(LOOT)
	end

	if GetCVarBool("lootUnderMouse") then
		local x, y = GetCursorPosition()
		x = x / TukuiLootFrame:GetEffectiveScale()
		y = y / TukuiLootFrame:GetEffectiveScale()

		TukuiLootFrame:ClearAllPoints()
		TukuiLootFrame:Point("TOPLEFT", UIParent, "BOTTOMLEFT", x - 40, y + 20)
		TukuiLootFrame:GetCenter()
		TukuiLootFrame:Raise()
	else
		local SavedVar = TukuiData[GetRealmName()][UnitName("Player")].Move
		local CustomLootPosition = TukuiData[GetRealmName()][UnitName("Player")].Move.TukuiLootFrame
		local A1, P, A2, X, Y
		
		if CustomLootPosition then
			A1, P, A2, X, Y = unpack(CustomLootPosition)
		else
			A1, P, A2, X, Y = "TOPLEFT", UIParent, "TOPLEFT", 50, -50
		end
		
		TukuiLootFrame:ClearAllPoints()
		TukuiLootFrame:Point(A1, P, A2, X, Y)
	end

	local Items = GetNumLootItems()

	if (Items > 0) then
		for i = 1, Items do
			local Texture, Item, Quantity, _, Quality, _, IsQuestItem, QuestID, isActive = GetLootSlotInfo(i)

			if (GetLootSlotType(i) == LOOT_SLOT_MONEY) then
				Item = Item:gsub("\n", ", ")
			end
			
			local LootFrameSlots = TukuiLootFrame.LootSlots[i] or Loot:CreateSlots(i)
			local Color = ITEM_QUALITY_COLORS[Quality] or {r = 1, g = 1, b = 1}
			
			if (Quantity and Quantity > 1) then
				LootFrameSlots.count:SetText(Quantity)
				LootFrameSlots.count:Show()
			else
				LootFrameSlots.count:Hide()
			end

			if (QuestID and not isActive) then
				LootFrameSlots.name:SetTextColor(1, 0.82, 0)
				LootFrameSlots:SetBackdropColor(Color.r * 0.55, Color.g * 0.55, Color.b * 0.55, 0.25)
			elseif (QuestID or IsQuestItem) then
				LootFrameSlots.name:SetTextColor(1, 0.82, 0)
				LootFrameSlots:SetBackdropColor(Color.r * 0.55, Color.g * 0.55, Color.b * 0.55, 0.25)
			else
				LootFrameSlots.name:SetTextColor(Color.r, Color.g, Color.b)
				LootFrameSlots:SetBackdropColor(Color.r * 0.55, Color.g * 0.55, Color.b * 0.55, 0.25)
			end

			LootFrameSlots.quality = Quality
			LootFrameSlots.name:SetText(Item)
			LootFrameSlots.icon:SetTexture(Texture)

			LootFrameSlots:Enable()
			LootFrameSlots:Show()
		end
	else
		local LootFrameSlots = TukuiLootFrame.LootSlots[1] or Loot:CreateSlots(1)
		local Color = ITEM_QUALITY_COLORS[0]

		LootFrameSlots.name:SetText("Empty Slot")
		LootFrameSlots.name:SetTextColor(Color.r, Color.g, Color.b)
		LootFrameSlots.icon:SetTexture([[Interface\Icons\INV_Misc_Herb_AncientLichen]])

		LootFrameSlots.count:Hide()
		LootFrameSlots.drop:Hide()
		LootFrameSlots:Disable()
		LootFrameSlots:Show()
	end

	Loot.AnchorSlots(TukuiLootFrame)
end

function Loot:Enable()
	if not C.Loot.Enable then
		return
	end
	
	if C.Loot.StandardLoot then
		self:SkinStandardLootFrame()
		self:AddStandardLootHooks()
		
		return
	end
	
	-- Locals
	self.IconSize = 32
	self.DefaultPosition = {"TOPLEFT", UIParent, "TOPLEFT", 50, -50}
	
	TukuiLootFrame = CreateFrame("Button", "TukuiLootFrame", UIParent)
	TukuiLootFrame:SetClampedToScreen(true)
	TukuiLootFrame:SetToplevel(true)
	TukuiLootFrame:Size(198, 58)
	TukuiLootFrame:SetPoint(unpack(self.DefaultPosition))
	TukuiLootFrame.LootSlots = {}
	TukuiLootFrame:SetScript("OnHide", function()
		StaticPopup_Hide("CONFIRM_LOOT_DISTRIBUTION")
		CloseLoot()
	end)
	
	TukuiLootFrame.Overlay = CreateFrame("Frame", nil, TukuiLootFrame)
	TukuiLootFrame.Overlay:Size(198+16, 28)
	TukuiLootFrame.Overlay:Point("TOP", TukuiLootFrame, -16, 22)
	TukuiLootFrame.Overlay:CreateBackdrop()
	TukuiLootFrame.Overlay:CreateShadow()
	
	TukuiLootFrame.InvisFrame = CreateFrame("Frame", nil, TukuiLootFrame)
	TukuiLootFrame.InvisFrame:SetFrameLevel(TukuiLootFrame:GetFrameLevel() + 5)
	TukuiLootFrame.InvisFrame:SetAllPoints()
	
	TukuiLootFrame.Title = TukuiLootFrame.InvisFrame:CreateFontString(nil, "OVERLAY", 7)
	TukuiLootFrame.Title:SetFontTemplate(C.Medias.UnitFrameFont, 12)
	TukuiLootFrame.Title:Point("CENTER", TukuiLootFrame.Overlay, 0, 1)
	TukuiLootFrame.Title:SetTextColor(1, 0.82, 0)
	
	self:RegisterEvent("LOOT_OPENED")
	self:RegisterEvent("LOOT_SLOT_CLEARED")
	self:RegisterEvent("LOOT_CLOSED")
	
	self:SetScript("OnEvent", function(self, event, ...)
		self[event](self, event, ...)
	end)
	
	LootFrame:UnregisterAllEvents()
	
	Movers:RegisterFrame(TukuiLootFrame)
	
	tinsert(UISpecialFrames, "TukuiLootFrame")
end

Inventory.Loot = Loot