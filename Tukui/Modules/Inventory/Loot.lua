--[[
	** Based on Butsu by Haste **
	** Build for Tukui by Aftermathh **
--]]

local T, C, L = select(2, ...):unpack()
local Inventory = T["Inventory"]
local Loot = CreateFrame("Frame")
local Movers = T["Movers"]
local LootFrame = LootFrame
local Font

-- Lib Globals
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
			Movers:RegisterFrame(LootFrame, "Loot Frame")
		end

		if not (TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.LootFrame) then
			TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.LootFrame = {"TOPLEFT", "UIParent", "TOPLEFT", 16, -116}
		end

		local A1, _, A2, X, Y = unpack(TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.LootFrame)

		LootFrame:ClearAllPoints()
		LootFrame:SetPoint(A1, UIParent, A2, X, Y)
	end
end

function Loot:SkinStandardLootFrame()
	local ItemText = select(19, LootFrame:GetRegions())
	
	LootFrame:StripTextures()
	LootFrameInset:StripTextures()
	LootFrameInset:CreateBackdrop("Transparent")
	LootFrameInset.Backdrop:CreateShadow()
	LootFramePortraitOverlay:SetAlpha(0)

	LootFrameDownButton:StripTextures()
	LootFrameDownButton:SetSize(LootFrame:GetWidth() - 6, 23)
	LootFrameDownButton:SkinButton()
	LootFrameDownButton.Text = LootFrameDownButton:CreateFontString(nil, "OVERLAY")
	LootFrameDownButton.Text:SetFontTemplate(C.Medias.Font, 12)
	LootFrameDownButton.Text:SetPoint("CENTER")
	LootFrameDownButton.Text:SetText(NEXT)
	LootFrameDownButton:ClearAllPoints()
	LootFrameDownButton:SetPoint("TOP", LootFrame, "BOTTOM", -1, -1)
	LootFrameDownButton:CreateShadow()
	LootFrameNext:SetAlpha(0)

	LootFrameUpButton:StripTextures()
	LootFrameUpButton:SetSize(LootFrame:GetWidth() - 6, 23)
	LootFrameUpButton:SkinButton()

	LootFrameUpButton.Text = LootFrameUpButton:CreateFontString(nil, "OVERLAY")
	LootFrameUpButton.Text:SetFontTemplate(C.Medias.Font, 12)
	LootFrameUpButton.Text:SetPoint("CENTER")
	LootFrameUpButton.Text:SetText(PREV)
	LootFrameUpButton:ClearAllPoints()
	LootFrameUpButton:SetPoint("TOP", LootFrameDownButton, "BOTTOM", 0, -2)
	LootFrameUpButton:CreateShadow()
	LootFramePrev:SetAlpha(0)

	LootFrameCloseButton:EnableMouse(false)
	LootFrameCloseButton:StripTextures()

	LootFrame:StripTexts()
	LootFrame.TitleBg:SetAlpha(0)
	
	if T.Retail then
		LootFrameInset.NineSlice:SetAlpha(0)
		LootFrame.NineSlice:SetAlpha(0)
	end
end

function Loot:SkinStandardLootFrameButtons(i)
	for i = 1, LootFrame.numLootItems do
		local Button = _G["LootButton" .. i]
		local Slot = (LOOTFRAME_NUMBUTTONS * (LootFrame.page - 1)) + i

		if Button then
			local Icon = _G["LootButton" .. i .. "IconTexture"]
			local Quest = _G["LootButton" .. i .. "IconQuestTexture"]
			local IconTexture = Icon:GetTexture()
			local Quality = select(5, GetLootSlotInfo(Slot))
			local Color = ITEM_QUALITY_COLORS[Quality] or {r = 0, g = 0, b = 0}

			if (not Button.IsSkinned) then
				Button:StripTextures()
				Button:CreateBackdrop()
				Button.Backdrop:SetOutside(Icon)
				Button.IconBorder:SetAlpha(0)

				Icon:SetTexture(IconTexture)
				Icon:SetTexCoord(unpack(T.IconCoord))
				Icon:SetInside()
				
				if T.Retail then
					Quest:SetAlpha(0)
				end

				Button.IsSkinned = true
			end
			
			if T.Retail then
				if Quest:IsShown() then
					Button.Backdrop:SetBorderColor(1, 1, 0)
				else
					Button.Backdrop:SetBorderColor(Color.r, Color.g, Color.b)
				end
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

	GameTooltip_Hide()
	ResetCursor()
end

function Loot:OnClick()
	LootFrame.selectedLootButton = self
	LootFrame.selectedSlot = self:GetID()
	LootFrame.selectedQuality = self.quality
	LootFrame.selectedItemName = self.name:GetText()

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

			frame:SetPoint("TOP", TukuiLootFrame, 4, (-8 + Loot.IconSize) - (shownSlots * (Loot.IconSize+1)))
		end
	end

	self:SetHeight(max(shownSlots * Loot.IconSize + 16, 20))
end

function Loot:CreateSlots(id)
	local IconSize = (Loot.IconSize - 2)

	local frame = CreateFrame("Button", "TukuiLootSlot"..id, TukuiLootFrame)
	frame:SetHeight(IconSize)
	frame:SetPoint("LEFT", 8, 0)
	frame:SetPoint("RIGHT", -8, 0)
	frame:CreateBackdrop()
	frame:CreateShadow()
	frame:SetID(id)

	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

	frame:SetScript("OnEnter", Loot.OnEnter)
	frame:SetScript("OnLeave", Loot.OnLeave)
	frame:SetScript("OnClick", Loot.OnClick)
	frame:SetScript("OnShow", Loot.OnShow)

	local iconFrame = CreateFrame("Frame", nil, frame)
	iconFrame:SetSize(IconSize, IconSize)
	iconFrame:SetPoint("RIGHT", frame, "LEFT", -2, 0)
	iconFrame:CreateBackdrop()
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
	count:SetPoint("BOTTOMRIGHT", iconFrame, -2, 4)
	count:SetFontTemplate(C.Medias.Font, 12)
	count:SetText(1)
	frame.count = count

	local name = invsframe:CreateFontString(nil, "OVERLAY")
	name:SetPoint("RIGHT", invsframe)
	name:SetPoint("LEFT", icon, "RIGHT", 4, 0)
	name:SetNonSpaceWrap(true)
	name:SetFontObject(Font)
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

    if TukuiLootFrame.LootSlots[slot] then
    	TukuiLootFrame.LootSlots[slot]:Hide()
    end

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
		TukuiLootFrame.Title:SetText(UnitName("target"):sub(1, 29))
	else
		TukuiLootFrame.Title:SetText(LOOT)
	end

	if GetCVarBool("lootUnderMouse") then
		local x, y = GetCursorPosition()
		x = x / TukuiLootFrame:GetEffectiveScale()
		y = y / TukuiLootFrame:GetEffectiveScale()

		TukuiLootFrame:ClearAllPoints()
		TukuiLootFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x - 40, y + 20)
		TukuiLootFrame:GetCenter()
		TukuiLootFrame:Raise()
	else
		local SavedVar = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move
		local CustomLootPosition = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.TukuiLootFrame
		local A1, P, A2, X, Y

		if CustomLootPosition then
			A1, P, A2, X, Y = unpack(CustomLootPosition)
		else
			A1, P, A2, X, Y = "TOPLEFT", UIParent, "TOPLEFT", 50, -50
		end

		TukuiLootFrame:ClearAllPoints()
		TukuiLootFrame:SetPoint(A1, P, A2, X, Y)
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
			local Multiplier = 0.3

			if (Quantity and Quantity > 1) then
				LootFrameSlots.count:SetText(Quantity)
				LootFrameSlots.count:Show()
			else
				LootFrameSlots.count:Hide()
			end

			if (QuestID and not isActive) then
				LootFrameSlots.name:SetTextColor(1, 0.82, 0)
				LootFrameSlots.Backdrop:SetBackdropColor(Color.r * Multiplier, Color.g * Multiplier, Color.b * Multiplier, 1)
			elseif (QuestID or IsQuestItem) then
				LootFrameSlots.name:SetTextColor(1, 0.82, 0)
				LootFrameSlots.Backdrop:SetBackdropColor(Color.r * Multiplier, Color.g * Multiplier, Color.b * Multiplier, 1)
			else
				LootFrameSlots.name:SetTextColor(Color.r, Color.g, Color.b)
				LootFrameSlots.Backdrop:SetBackdropColor(Color.r * Multiplier, Color.g * Multiplier, Color.b * Multiplier, 1)
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
		LootFrameSlots.icon:SetTexture([[Interface\Icons\Inv_misc_questionmark]])

		LootFrameSlots.count:Hide()
		LootFrameSlots.drop:Hide()
		LootFrameSlots:Disable()
		LootFrameSlots:Show()
	end

	Loot.AnchorSlots(TukuiLootFrame)
end

function Loot:OPEN_MASTER_LOOT_LIST()
	MasterLooterFrame_Show(_G.LootFrame.selectedLootButton)
end

function Loot:UPDATE_MASTER_LOOT_LIST()
	if _G.LootFrame.selectedLootButton then MasterLooterFrame_UpdatePlayers() end
end

function Loot:Enable()
	if not C.Loot.Enable then
		self:SkinStandardLootFrame()
		self:AddStandardLootHooks()

		return
	end

	Font = T.GetFont(C.Loot.Font)

	-- Locals
	self.IconSize = 32
	self.DefaultPosition = {"TOPLEFT", UIParent, "TOPLEFT", 50, -50}

	TukuiLootFrame = CreateFrame("Button", "TukuiLootFrame", UIParent)
	TukuiLootFrame:Hide()
	TukuiLootFrame:SetClampedToScreen(true)
	TukuiLootFrame:SetToplevel(true)
	TukuiLootFrame:SetSize(198, 58)
	TukuiLootFrame:SetPoint(unpack(self.DefaultPosition))
	TukuiLootFrame.LootSlots = {}
	TukuiLootFrame:SetScript("OnHide", function()
		StaticPopup_Hide("CONFIRM_LOOT_DISTRIBUTION")
		CloseLoot()
	end)

	TukuiLootFrame.Overlay = CreateFrame("Frame", nil, TukuiLootFrame)
	TukuiLootFrame.Overlay:SetSize(198+16, 19)
	TukuiLootFrame.Overlay:SetPoint("TOP", TukuiLootFrame, -16, 13)
	TukuiLootFrame.Overlay:CreateBackdrop()
	TukuiLootFrame.Overlay:CreateShadow()
	TukuiLootFrame.Overlay:EnableMouse()

	TukuiLootFrame.Title = TukuiLootFrame.Overlay:CreateFontString(nil, "OVERLAY", 7)
	TukuiLootFrame.Title:SetFontObject(Font)
	TukuiLootFrame.Title:SetPoint("CENTER", TukuiLootFrame.Overlay, 0, 1)
	TukuiLootFrame.Title:SetTextColor(1, 0.82, 0)

	self:RegisterEvent("LOOT_OPENED")
	self:RegisterEvent("LOOT_SLOT_CLEARED")
	self:RegisterEvent("LOOT_CLOSED")
	self:RegisterEvent("OPEN_MASTER_LOOT_LIST")
	self:RegisterEvent("UPDATE_MASTER_LOOT_LIST")
	self:SetScript("OnEvent", function(self, event, ...)
		self[event](self, event, ...)
	end)

	LootFrame:UnregisterAllEvents()

	Movers:RegisterFrame(TukuiLootFrame, "Loot Frame")

	tinsert(UISpecialFrames, "TukuiLootFrame")
end

Inventory.Loot = Loot
