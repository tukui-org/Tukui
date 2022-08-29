local T, C, L = select(2, ...):unpack()

local Noop = function() end
local ReplaceBags = 0
local NeedBagRefresh, NeedBankRefresh
local LastButtonBag, LastButtonBank
local Token1, Token2, Token3 = BackpackTokenFrameToken1, BackpackTokenFrameToken2, BackpackTokenFrameToken3
local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local ContainerFrame_GetOpenFrame = ContainerFrame_GetOpenFrame
local ReagentBankFrame = ReagentBankFrame
local OriginalToggleBag = ToggleBag
local BankFrame = BankFrame
local BagHelpBox = BagHelpBox
local ButtonSize, ButtonSpacing, ItemsPerRow
local Bags = CreateFrame("Frame")
local Inventory = T["Inventory"]
local QuestColor = {1, 1, 0}
local Bag_Normal = 1
local Bag_SoulShard = 2
local Bag_Profession = 3
local Bag_Quiver = 4
local KEYRING_CONTAINER = KEYRING_CONTAINER
local BAGTYPE_QUIVER = 0x0001 + 0x0002
local BAGTYPE_SOUL = 0x004
local BAGTYPE_PROFESSION = 0x0008 + 0x0010 + 0x0020 + 0x0040 + 0x0080 + 0x0200 + 0x0400

local BlizzardBags = {
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
}

local BagProfessions = {
	[8] = "Leatherworking",
	[16] = "Inscription",
	[32] = "Herb",
	[64] = "Enchanting",
	[128] = "Engineering",
	[512] = "Gem",
	[1024] = "Mining",
	[32768] = "Fishing",
}

local BagSize = {}

function Bags:SetTokensPosition()
	local Money = ContainerFrame1MoneyFrame
	
	MAX_WATCHED_TOKENS = 2

	-- Set Position
	Token1:ClearAllPoints()
	Token1:SetPoint("LEFT", Money, "RIGHT", 0, -2)
	Token2:ClearAllPoints()
	Token2:SetPoint("LEFT", Token1, "RIGHT", 0, 0)
	Token3:SetParent(T.Hider)
	
	-- Skin Icons
	Token1.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Token2.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
end

function Bags:GetBagProfessionType(bag)
	local BagType = select(2, GetContainerNumFreeSlots(bag))

	if BagProfessions[BagType] then
		return BagProfessions[BagType]
	end
end

function Bags:GetBagType(bag)
	local bagType = select(2, GetContainerNumFreeSlots(bag))

	if bit.band(bagType, BAGTYPE_QUIVER) > 0 then
		return Bag_Quiver
	elseif bit.band(bagType, BAGTYPE_SOUL) > 0 then
		return Bag_SoulShard
	elseif bit.band(bagType, BAGTYPE_PROFESSION) > 0 then
		return Bag_Profession
	end

	return Bag_Normal
end

function Bags:SkinBagButton()
	if self.IsSkinned then
		return
	end

	local Icon = _G[self:GetName().."IconTexture"]
	local Quest = _G[self:GetName().."IconQuestTexture"]
	local Count = _G[self:GetName().."Count"]
	local JunkIcon = self.JunkIcon
	local Border = self.IconBorder
	local BattlePay = self.BattlepayItemTexture
	
	self:SetFrameLevel(0)

	Border:SetAlpha(0)

	Icon:SetTexCoord(unpack(T.IconCoord))
	Icon:SetInside(self)
	
	Count:ClearAllPoints()
	Count:SetPoint("BOTTOMRIGHT", 1, 1)
	Count:SetFont(C.Medias.Font, 12, "OUTLINE")

	if Quest then
		Quest:SetAlpha(0)
	end

	if JunkIcon then
		JunkIcon:SetAlpha(0)
	end

	if BattlePay then
		BattlePay:SetAlpha(0)
	end

	self:SetNormalTexture("")
	self:SetPushedTexture("")
	self:CreateBackdrop()
	self:StyleButton()
	self.IconOverlay:SetAlpha(0)

	self.IsSkinned = true
end

function Bags:HideBlizzard()
	local BankPortraitTexture = _G["BankPortraitTexture"]
	local BankSlotsFrame = _G["BankSlotsFrame"]

	BankPortraitTexture:Hide()

	BankFrame:EnableMouse(false)

	for i = 1, 12 do
		local CloseButton = _G["ContainerFrame"..i.."CloseButton"]
		CloseButton:Hide()

		for k = 1, 7 do
			local Container = _G["ContainerFrame"..i]
			select(k, Container:GetRegions()):SetAlpha(0)
		end
	end

	-- Hide Bank Frame Textures
	for i = 1, BankFrame:GetNumRegions() do
		local Region = select(i, BankFrame:GetRegions())

		Region:SetAlpha(0)
	end

	-- Hide BankSlotsFrame Textures and Fonts
	for i = 1, BankSlotsFrame:GetNumRegions() do
		local Region = select(i, BankSlotsFrame:GetRegions())

		Region:SetAlpha(0)
	end
	
	if T.Retail then
		local TokenFrame = _G["BackpackTokenFrame"]
		local Inset = _G["BankFrameMoneyFrameInset"]
		local Border = _G["BankFrameMoneyFrameBorder"]
		local BankClose = _G["BankFrameCloseButton"]
		local BankItemSearchBox = _G["BankItemSearchBox"]
		local BankItemAutoSortButton = _G["BankItemAutoSortButton"]
		
		TokenFrame:GetRegions():SetAlpha(0)	
		Inset:Hide()	
		Border:Hide()	
		BankClose:Hide()
		
		BankItemAutoSortButton:Hide()
		BankItemSearchBox:Hide()
		
		BankFrame.NineSlice:SetAlpha(0)
		
		-- Hide Tabs, we will create our tabs
		for i = 1, 2 do
			local Tab = _G["BankFrameTab"..i]
			Tab:Hide()
		end
	end
end

function Bags:CreateReagentContainer()
	ReagentBankFrame:StripTextures()

	local DataTextLeft = T.DataTexts.Panels.Left
	local Reagent = CreateFrame("Frame", "TukuiReagent", UIParent)
	local SwitchBankButton = CreateFrame("Button", nil, Reagent)
	local SortButton = CreateFrame("Button", nil, Reagent)
	local NumButtons = ReagentBankFrame.size
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton
	local Movers = T["Movers"]

	Reagent:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	Reagent:SetPoint("BOTTOMLEFT", TukuiBank, "BOTTOMLEFT", 0, 0)
	Reagent:CreateBackdrop()
	Reagent:CreateShadow()
	Reagent:SetFrameStrata(self.Bank:GetFrameStrata())
	Reagent:SetFrameLevel(self.Bank:GetFrameLevel())

	SwitchBankButton:SetSize((Reagent:GetWidth() / 2) - 1, 23)
	SwitchBankButton:SkinButton()
	SwitchBankButton:CreateShadow()
	SwitchBankButton:SetPoint("BOTTOMLEFT", Reagent, "TOPLEFT", 0, 2)

	SwitchBankButton.Text = SwitchBankButton:CreateFontString(nil, "OVERLAY")
	SwitchBankButton.Text:SetFont(C.Medias.Font, 12)
	SwitchBankButton.Text:SetJustifyH("LEFT")
	SwitchBankButton.Text:SetPoint("CENTER")
	SwitchBankButton.Text:SetText("Switch to: "..BANK)
	SwitchBankButton:SetScript("OnClick", function()
		Reagent:Hide()
		self.Bank:Show()
		BankFrame_ShowPanel(BANK_PANELS[1].name)

		for i = 5, T.Classic and 10 or 11 do
			if (not IsBagOpen(i)) then

				self:OpenBag(i, 1)
			end
		end
	end)

	Deposit:SetParent(Reagent)
	Deposit:ClearAllPoints()
	Deposit:SetSize(Reagent:GetWidth(), 23)
	Deposit:SetPoint("BOTTOMLEFT", SwitchBankButton, "TOPLEFT", 0, 2)
	Deposit:SkinButton()
	Deposit:CreateShadow()

	SortButton:SetSize((Reagent:GetWidth() / 2) - 1, 23)
	SortButton:SetPoint("LEFT", SwitchBankButton, "RIGHT", 2, 0)
	SortButton:SkinButton()
	SortButton:CreateShadow()
	SortButton.Text = SortButton:CreateFontString(nil, "OVERLAY")
	SortButton.Text:SetFont(C.Medias.Font, 12)
	SortButton.Text:SetJustifyH("LEFT")
	SortButton.Text:SetPoint("CENTER")
	SortButton.Text:SetText(BAG_FILTER_CLEANUP)
	SortButton:SetScript("OnClick", BankFrame_AutoSortButtonOnClick)

	for i = 1, 98 do
		local Button = _G["ReagentBankFrameItem"..i]
		local Count = _G[Button:GetName().."Count"]
		local Icon = _G[Button:GetName().."IconTexture"]

		ReagentBankFrame:SetParent(Reagent)
		ReagentBankFrame:ClearAllPoints()
		ReagentBankFrame:SetAllPoints()

		Button:ClearAllPoints()
		Button:SetWidth(ButtonSize)
		Button:SetHeight(ButtonSize)
		Button:SetNormalTexture("")
		Button:SetPushedTexture("")
		Button:SetHighlightTexture("")
		Button:CreateBackdrop()
		Button.IconBorder:SetAlpha(0)

		if (i == 1) then
			Button:SetPoint("TOPLEFT", Reagent, "TOPLEFT", 10, -10)
			LastRowButton = Button
			LastButton = Button
		elseif (NumButtons == ItemsPerRow) then
			Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSize))
			Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSize))
			LastRowButton = Button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSize), 0)
			Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSize), 0)
			NumButtons = NumButtons + 1
		end

		Icon:SetTexCoord(unpack(T.IconCoord))
		Icon:SetInside()

		LastButton = Button

		self:SlotUpdate(-3, Button)
	end

	Reagent:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 20) - ButtonSpacing)
	Reagent:SetScript("OnHide", function()
		ReagentBankFrame:Hide()
	end)

	-- Unlock window
	local Unlock = ReagentBankFrameUnlockInfo
	local UnlockButton = ReagentBankFrameUnlockInfoPurchaseButton

	Unlock:StripTextures()
	Unlock:SetAllPoints(Reagent)
	Unlock:CreateBackdrop()

	UnlockButton:SkinButton()

	self.Reagent = Reagent
	self.Reagent.SwitchBankButton = SwitchBankButton
	self.Reagent.SortButton = SortButton
end

function Bags:CreateContainer(storagetype, ...)
	local Container = CreateFrame("Frame", "Tukui".. storagetype, UIParent)
	Container:SetScale(1)
	Container:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	Container:SetPoint(...)
	Container:SetFrameStrata("MEDIUM")
	Container:SetFrameLevel(1)
	Container:Hide()
	Container:CreateBackdrop()
	Container:CreateShadow()
	Container:EnableMouse(true)

	if (storagetype == "Bag") then
		local BagsContainer = CreateFrame("Frame", nil, UIParent)
		local ToggleBagsContainer = CreateFrame("Button")
		local Sort = CreateFrame("Button", nil, Container)
		local SearchBox = CreateFrame("EditBox", nil, Container)
		local ToggleBags = CreateFrame("Button", nil, Container)
		local Keys = CreateFrame("Button", nil, Container)

		BagsContainer:SetParent(Container)
		BagsContainer:SetWidth(10)
		BagsContainer:SetHeight(10)
		BagsContainer:SetPoint("BOTTOMRIGHT", Container, "TOPRIGHT", 0, 1)
		BagsContainer:Hide()
		BagsContainer:CreateBackdrop()
		BagsContainer:CreateShadow()

		ToggleBagsContainer:SetHeight(20)
		ToggleBagsContainer:SetWidth(20)
		ToggleBagsContainer:SetPoint("TOPRIGHT", Container, "TOPRIGHT", -6, -6)
		ToggleBagsContainer:SetParent(Container)
		ToggleBagsContainer:EnableMouse(true)
		ToggleBagsContainer:SkinCloseButton()
		ToggleBagsContainer:SetScript("OnEnter", GameTooltip_Hide)
		ToggleBagsContainer:SetScript("OnMouseUp", function(self, button)
			CloseAllBags()
			CloseBankBagFrames()
			CloseBankFrame()

			PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
		end)

		for _, Button in pairs(BlizzardBags) do
			local Count = _G[Button:GetName().."Count"]
			local Icon = _G[Button:GetName().."IconTexture"]

			Button:SetParent(BagsContainer)
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetNormalTexture("")
			Button:SetPushedTexture("")
			Button:CreateBackdrop()
			Button.IconBorder:SetAlpha(0)
			Button:SkinButton()
			
			if T.Retail then
				Button.SlotHighlightTexture:SetAlpha(0)
			else
				Button:SetCheckedTexture("")
			end

			if LastButtonBag then
				Button:SetPoint("LEFT", LastButtonBag, "RIGHT", ButtonSpacing, 0)
			else
				Button:SetPoint("TOPLEFT", BagsContainer, "TOPLEFT", ButtonSpacing, -ButtonSpacing)
			end

			Count.Show = Noop
			Count:Hide()

			Icon:SetTexCoord(unpack(T.IconCoord))
			Icon:SetInside()

			LastButtonBag = Button
			BagsContainer:SetWidth((ButtonSize * getn(BlizzardBags)) + (ButtonSpacing * (getn(BlizzardBags) + 1)))
			BagsContainer:SetHeight(ButtonSize + (ButtonSpacing * 2))
		end

		SearchBox:SetFrameLevel(Container:GetFrameLevel() + 10)
		SearchBox:SetMultiLine(false)
		SearchBox:EnableMouse(true)
		SearchBox:SetAutoFocus(false)
		SearchBox:SetFont(C.Medias.Font, 12)
		SearchBox:SetWidth(Container:GetWidth() - 28)
		SearchBox:SetHeight(16)
		SearchBox:SetPoint("BOTTOM", Container, -1, 10)
		SearchBox:CreateBackdrop()
		SearchBox.Backdrop:SetBorderColor(.3, .3, .3, 1)
		SearchBox.Backdrop:SetBackdropColor(0, 0, 0, 1)
		SearchBox.Backdrop:SetPoint("TOPLEFT", -3, 4)
		SearchBox.Backdrop:SetPoint("BOTTOMRIGHT", 3, -4)
		SearchBox.Title = SearchBox:CreateFontString(nil, "OVERLAY")
		SearchBox.Title:SetAllPoints()
		SearchBox.Title:SetFontTemplate(C.Medias.Font, 12)
		SearchBox.Title:SetJustifyH("CENTER")
		SearchBox.Title:SetText("Type here to search an item")
		SearchBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() self:SetText("") end)
		SearchBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() self:SetText("") end)
		SearchBox:SetScript("OnTextChanged", function(self) SetItemSearch(self:GetText()) end)
		SearchBox:SetScript("OnEditFocusLost", function(self) self.Backdrop:SetBorderColor(.3, .3, .3, 1) end)
		SearchBox:SetScript("OnEditFocusGained", function(self) self.Title:Hide() self.Backdrop:SetBorderColor(1, 1, 1, 1) end)

		ToggleBags:SetSize(16, 16)
		ToggleBags:SetPoint("RIGHT", ToggleBagsContainer, "LEFT", -1, 1)
		ToggleBags.Texture = ToggleBags:CreateTexture(nil, "OVERLAY")
		ToggleBags.Texture:SetSize(14, 14)
		ToggleBags.Texture:SetPoint("CENTER")
		ToggleBags.Texture:SetTexture(C.Medias.ArrowUp)
		ToggleBags:SetScript("OnEnter", GameTooltip_Hide)
		ToggleBags:SetScript("OnClick", function(self)
			local BanksContainer = Bags.Bank.BagsContainer

			if (ReplaceBags == 0) then
				ReplaceBags = 1
				BagsContainer:Show()
				BanksContainer:Show()

				self.Texture:SetTexture(C.Medias.ArrowDown)
			else
				ReplaceBags = 0
				BagsContainer:Hide()
				BanksContainer:Hide()

				self.Texture:SetTexture(C.Medias.ArrowUp)
			end
		end)

		Sort:SetSize(16, 16)
		Sort:SetPoint("RIGHT", ToggleBags, "LEFT", -2, 0)
		Sort.Texture = Sort:CreateTexture(nil, "OVERLAY")
		Sort.Texture:SetSize(14, 14)
		Sort.Texture:SetPoint("CENTER")
		Sort.Texture:SetTexture(C.Medias.Sort)
		Sort:SetScript("OnEnter", GameTooltip_Hide)
		Sort:SetScript("OnClick", function()
			if InCombatLockdown() then
				T.Print("You cannot sort your bag in combat")

				return
			end

			SortBags()
		end)
		
		if T.BCC or T.WotLK then
			Keys:SetSize(16, 16)
			Keys:SetPoint("RIGHT", Sort, "LEFT", -5, 0)
			Keys:CreateShadow()
			Keys.Texture = Keys:CreateTexture(nil, "OVERLAY")
			Keys.Texture:SetSize(16, 16)
			Keys.Texture:SetPoint("CENTER")
			Keys.Texture:SetTexture("Interface\\ContainerFrame\\KeyRing-Bag-Icon")
			Keys:SetScript("OnEnter", GameTooltip_Hide)
			Keys:SetScript("OnClick", function()
				if not IsBagOpen(KEYRING_CONTAINER) then
					ToggleBag(KEYRING_CONTAINER)
				else
					ToggleAllBags()
					ToggleAllBags()
				end
			end)
		end

		Container.BagsContainer = BagsContainer
		Container.CloseButton = ToggleBagsContainer
		Container.SortButton = Sort
		Container.SearchBox = SearchBox
		Container.ToggleBags = ToggleBags
		Container.Keys = Keys
	else
		local PurchaseButton = BankFramePurchaseButton
		local CostText = BankFrameSlotCost
		local TotalCost = BankFrameDetailMoneyFrame
		local Purchase = BankFramePurchaseInfo
		local CloseButton = BankCloseButton
		local BankBagsContainer = CreateFrame("Frame", nil, Container)

		CostText:ClearAllPoints()
		CostText:SetPoint("BOTTOMLEFT", 60, 10)
		TotalCost:ClearAllPoints()
		TotalCost:SetPoint("LEFT", CostText, "RIGHT", 0, 0)
		PurchaseButton:ClearAllPoints()
		PurchaseButton:SetPoint("BOTTOMRIGHT", -10, 10)
		PurchaseButton:SkinButton()
		
		local SortButton = CreateFrame("Button", nil, Container)
		SortButton:SetSize((Container:GetWidth() / 2) - 1, 23)
		SortButton:SetPoint("BOTTOMLEFT", Container, "TOPLEFT", 0, 2)
		SortButton:SkinButton()
		SortButton:CreateShadow()
		SortButton.Text = SortButton:CreateFontString(nil, "OVERLAY")
		SortButton.Text:SetFont(C.Medias.Font, 12)
		SortButton.Text:SetJustifyH("LEFT")
		SortButton.Text:SetPoint("CENTER")
		SortButton.Text:SetText(BAG_FILTER_CLEANUP)
		SortButton:SetScript("OnClick", BankFrame_AutoSortButtonOnClick)
		
		local SwitchReagentButton = CreateFrame("Button", nil, Container)
		SwitchReagentButton:SetSize((Container:GetWidth() / 2) - 1, 23)
		SwitchReagentButton:SkinButton()
		SwitchReagentButton:CreateShadow()
		SwitchReagentButton:SetPoint("LEFT", SortButton, "RIGHT", 2, 0)
		SwitchReagentButton:SetScript("OnClick", function()
			BankFrame_ShowPanel(BANK_PANELS[2].name)

			if (not ReagentBankFrame.isMade) then
				self:CreateReagentContainer()
				ReagentBankFrame.isMade = true
			else
				self.Reagent:Show()
			end

			for i = 5, T.Classic and 10 or 11 do
				self:CloseBag(i)
			end
		end)
		
		SwitchReagentButton.Text = SwitchReagentButton:CreateFontString(nil, "OVERLAY")
		SwitchReagentButton.Text:SetFont(C.Medias.Font, 12)
		SwitchReagentButton.Text:SetJustifyH("LEFT")
		SwitchReagentButton.Text:SetPoint("CENTER")
		SwitchReagentButton.Text:SetText("Switch to: "..REAGENT_BANK)

		Purchase:ClearAllPoints()
		Purchase:SetWidth(Container:GetWidth() + 50)
		Purchase:SetHeight(70)
		Purchase:SetPoint("TOP", UIParent, "TOP", 0, -8)
		Purchase:CreateBackdrop()
		Purchase.Backdrop:SetPoint("TOPLEFT", 50, 0)
		Purchase.Backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
		Purchase.Backdrop:CreateShadow()

		BankBagsContainer:SetSize(Container:GetWidth(), BankSlotsFrame.Bag1:GetHeight() + ButtonSpacing + ButtonSpacing)
		BankBagsContainer:CreateBackdrop()
		BankBagsContainer:CreateShadow()
		BankBagsContainer:SetPoint("BOTTOMLEFT", SortButton, "TOPLEFT", 0, 3)
		BankBagsContainer:SetFrameLevel(Container:GetFrameLevel())
		BankBagsContainer:SetFrameStrata(Container:GetFrameStrata())

		for i = 1, 7 do
			local Bag = BankSlotsFrame["Bag"..i]
			if Bag then
				Bag:SetParent(BankBagsContainer)
				Bag:SetWidth(ButtonSize)
				Bag:SetHeight(ButtonSize)

				Bag.IconBorder:SetAlpha(0)
				Bag.icon:SetTexCoord(unpack(T.IconCoord))
				Bag.icon:SetInside()

				Bag:SkinButton()
				Bag:ClearAllPoints()

				if T.Retail then
					Bag.SlotHighlightTexture:SetAlpha(0)
				end

				if i == 1 then
					Bag:SetPoint("TOPLEFT", BankBagsContainer, "TOPLEFT", ButtonSpacing, -ButtonSpacing)
				else
					Bag:SetPoint("LEFT", BankSlotsFrame["Bag"..i-1], "RIGHT", ButtonSpacing, 0)
				end
			end
		end

		BankBagsContainer:SetWidth((ButtonSize * 7) + (ButtonSpacing * (7 + 1)))
		BankBagsContainer:SetHeight(ButtonSize + (ButtonSpacing * 2))
		BankBagsContainer:Hide()

		BankFrame:EnableMouse(false)

		Container.BagsContainer = BankBagsContainer
		Container.SortButton = SortButton
		Container.ReagentButton = SwitchReagentButton

		if not T.Retail then
			SwitchReagentButton:Hide()

			SortButton:SetWidth(Container:GetWidth())

			CloseButton:Hide()
		end
	end

	self[storagetype] = Container
end

function Bags:SlotUpdate(id, button)
	if not button then
		return
	end

	local _, _, _, Rarity, _, _, ItemLink, _, _, ItemID, IsBound = GetContainerItemInfo(id, button:GetID())
	local QuestItem = false
	local IsNewItem = C_NewItems.IsNewItem(id, button:GetID())

	if (button.ItemID == ItemID) then
		return
	end

	if button.Quest then
		button.Quest:Hide()
	end

	button.ItemID = ItemID

	if ItemLink then
		local itemName, itemString, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(ItemLink)

		if itemString then
			if (itemType == TRANSMOG_SOURCE_2) then
				QuestItem = true
			end
		end
		
		if T.Retail then
			if IsCosmeticItem(ItemLink) and not IsBound then
				button.IconOverlay:SetAlpha(1)
			else
				button.IconOverlay:SetAlpha(0)
			end
		end
	end

	if C.Bags.IdentifyQuestItems and QuestItem then
		if not button.QuestTex then
			button.Quest = CreateFrame("Frame", nil, button)
			button.Quest:SetFrameLevel(button:GetFrameLevel())
			button.Quest:SetSize(8, button:GetHeight() - 2)
			button.Quest:SetPoint("TOPLEFT", 1, -1)
			
			button.Quest.Backdrop = button.Quest:CreateTexture(nil, "ARTWORK", 0)
			button.Quest.Backdrop:SetAllPoints()
			button.Quest.Backdrop:SetColorTexture(unpack(C.General.BackdropColor))
			
			button.Quest.BorderRight = button.Quest:CreateTexture(nil, "ARTWORK", nil, 1)
			button.Quest.BorderRight:SetSize(1, 1)
			button.Quest.BorderRight:SetPoint("TOPRIGHT", button.Quest, "TOPRIGHT", 1, 0)
			button.Quest.BorderRight:SetPoint("BOTTOMRIGHT", button.Quest, "BOTTOMRIGHT", 1, 0)
			button.Quest.BorderRight:SetColorTexture(1, 1, 0)
			
			button.Quest.Texture = button.Quest:CreateTexture(nil, "OVERLAY", -1)
			button.Quest.Texture:SetTexture("Interface\\QuestFrame\\AutoQuest-Parts")
			button.Quest.Texture:SetTexCoord(0.13476563, 0.17187500, 0.01562500, 0.53125000)
			button.Quest.Texture:SetSize(8, 16)
			button.Quest.Texture:SetPoint("CENTER")
		end

		button.Quest:Show()
		button.Backdrop:SetBorderColor(1, 1, 0)
	else
		if Rarity then
			button.Backdrop:SetBorderColor(GetItemQualityColor(Rarity))
		else
			button.Backdrop:SetBorderColor(unpack(C["General"].BorderColor))
		end
	end

	if C.Bags.FlashNewItems and IsNewItem then
		if not button.Animation then
			button.Animation = button:CreateAnimationGroup()
			button.Animation:SetLooping("BOUNCE")

			button.Animation.FadeOut = button.Animation:CreateAnimation("Alpha")
			button.Animation.FadeOut:SetFromAlpha(1)
			button.Animation.FadeOut:SetToAlpha(.3)
			button.Animation.FadeOut:SetDuration(.3)
			button.Animation.FadeOut:SetSmoothing("IN_OUT")
			button:HookScript("OnEnter", function(self)
				local ItemID = self.ItemID
				local BagID = self:GetID()
					
				if ItemID and BagID then
					local IsNewItem = C_NewItems.IsNewItem(self.ItemID, self:GetID())

					if not IsNewItem and button.Animation:IsPlaying() then
						button.Animation:Stop()
					end
				end
			end)
		end
		
		if not button.Animation:IsPlaying() then
			button.Animation:Play()
		end
	end
	
	if C.Bags.ItemLevel then
		if ItemLink then
			local Level = GetDetailedItemLevelInfo(ItemLink)
			local _, _, Rarity, _, _, _, _, _, _, _, _, ClassID = GetItemInfo(ItemLink)

			if (ClassID == LE_ITEM_CLASS_ARMOR or ClassID == LE_ITEM_CLASS_WEAPON) and Level > 1 then
				if not button.ItemLevel then
					button.ItemLevel = button:CreateFontString(nil, "ARTWORK")
					button.ItemLevel:SetPoint("TOPRIGHT", 1, -1)
					button.ItemLevel:SetFont(C.Medias.Font, 12, "OUTLINE")
					button.ItemLevel:SetJustifyH("RIGHT")
				end

				button.ItemLevel:SetText(Level)
				
				if Rarity then
					button.ItemLevel:SetTextColor(GetItemQualityColor(Rarity))
				else
					button.ItemLevel:SetTextColor(1, 1, 1)
				end
			else
				if button.ItemLevel then
					button.ItemLevel:SetText("")
				end
			end
		else
			if button.ItemLevel then
				button.ItemLevel:SetText("")
			end
		end
	end
end

function Bags:CooldownOnUpdate(elapsed)
	local Now = GetTime()
	local Timer = Now - self.StartTimer
	local Cooldown = self.DurationTimer - Timer
	
	self.Elapsed = self.Elapsed - elapsed

	if self.Elapsed < 0 then
		if Cooldown <= 0 then
			self.Text:SetText("")

			self:SetScript("OnUpdate", nil)
		else
			self.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE")
			self.Text:SetTextColor(1, 0, 0)
			self.Text:SetText(T.FormatTime(Cooldown))
		end
		
		self.Elapsed = .1
	end
end

function Bags:UpdateCooldown(button)
	local Cooldown = button.Cooldown or _G[button:GetName().."Cooldown"]
	local Start, Duration, Enable = GetContainerItemCooldown(self, button:GetID())
	
	if not Cooldown.Text then
		Cooldown.Text = Cooldown:CreateFontString(nil, "OVERLAY")
		Cooldown.Text:SetPoint("CENTER", 1, 0)
	end
	
	Cooldown.StartTimer = Start
	Cooldown.DurationTimer = Duration
	Cooldown.Elapsed = .1
	Cooldown:SetScript("OnUpdate", Bags.CooldownOnUpdate)
end

function Bags:BagUpdate(id)
	local Size = GetContainerNumSlots(id)
	local ContainerNumber = IsBagOpen(KEYRING_CONTAINER) and 1 or id + 1

	for Slot = 1, Size do
		local Button = _G["ContainerFrame"..ContainerNumber.."Item"..Slot]

		if Button then
			if not Button:IsShown() then
				Button:Show()
			end

			local BagType = Bags:GetBagType(id)

			if (BagType ~= 1) and (not Button.IsTypeStatusCreated) then
				Button.TypeStatus = CreateFrame("StatusBar", nil, Button)
				Button.TypeStatus:SetPoint("BOTTOMLEFT", 1, 1)
				Button.TypeStatus:SetPoint("BOTTOMRIGHT", -1, 1)
				Button.TypeStatus:SetHeight(3)
				Button.TypeStatus:SetFrameStrata(Button:GetFrameStrata())
				Button.TypeStatus:SetFrameLevel(Button:GetFrameLevel())
				Button.TypeStatus:SetStatusBarTexture(C.Medias.Blank)

				Button.IsTypeStatusCreated = true
			end

			if BagType == 2 then
				-- Warlock Soul Shards Slots
				Button.TypeStatus:SetStatusBarColor(unpack(T.Colors.class["WARLOCK"]))
			elseif BagType == 3 then
				local ProfessionType = Bags:GetBagProfessionType(id)

				if ProfessionType == "Leatherworking" then
					Button.TypeStatus:SetStatusBarColor(102/255, 51/255, 0/255)
				elseif ProfessionType == "Inscription" then
					Button.TypeStatus:SetStatusBarColor(204/255, 204/255, 0/255)
				elseif ProfessionType == "Herb" then
					Button.TypeStatus:SetStatusBarColor(0/255, 153/255, 0/255)
				elseif ProfessionType == "Enchanting" then
					Button.TypeStatus:SetStatusBarColor(230/255, 25/255, 128/255)
				elseif ProfessionType == "Engineering" then
					Button.TypeStatus:SetStatusBarColor(25/255, 230/255, 230/255)
				elseif ProfessionType == "Gem" then
					Button.TypeStatus:SetStatusBarColor(232/255, 252/255, 252/255)
				elseif ProfessionType == "Mining" then
					Button.TypeStatus:SetStatusBarColor(138/255, 40/255, 40/255)
				elseif ProfessionType == "Fishing" then
					Button.TypeStatus:SetStatusBarColor(54/255, 54/255, 226/255)
				end
			elseif BagType == 4 then
				-- Hunter Quiver Slots
				Button.TypeStatus:SetStatusBarColor(unpack(T.Colors.class["HUNTER"]))
			end
			
			self:SlotUpdate(id, Button)
		end
	end
end

function Bags:UpdateAllBags()
	-- check if containers changed
	if not NeedBagRefresh then
		for i = 1, 5 do
			local ContainerSize = _G["ContainerFrame"..i].size

			if ContainerSize ~= BagSize[i] then
				NeedBagRefresh = true

				BagSize[i] = ContainerSize
			end
		end
		
		if (not NeedBagRefresh) then
			return
		end
	end

	-- Refresh layout if a refresh if found
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
	local FirstButton

	for Bag = 1, 5 do
		local ID = Bag - 1
		
		if IsBagOpen(KEYRING_CONTAINER) then
			ID = -2
		end
		
		local Slots = GetContainerNumSlots(ID)

		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"..Bag.."Item"..Item]
			local Money = ContainerFrame1MoneyFrame

			if not FirstButton then
				FirstButton = Button
			end

			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetScale(1)
			
			Button.newitemglowAnim:Stop()
			Button.newitemglowAnim.Play = Noop

			Button.flashAnim:Stop()
			Button.flashAnim.Play = Noop

			if (Button == FirstButton) then
				Button:SetPoint("TOPLEFT", Bags.Bag, "TOPLEFT", 10, -40)
				LastRowButton = Button
				LastButton = Button
			elseif (NumButtons == ItemsPerRow) then
				Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSize))
				Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSize), 0)
				Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSize), 0)
				NumButtons = NumButtons + 1
			end

			LastButton = Button

			if not Button.IsSkinned then
				Bags.SkinBagButton(Button)
			end

			if not Money.IsMoved then
				Money:ClearAllPoints()
				Money:Show()
				Money:SetPoint("TOPLEFT", Bags.Bag, "TOPLEFT", 8, -10)
				Money:SetScale(1)
				Money.IsMoved = true
			end
		end

		Bags:BagUpdate(ID)
		
		if IsBagOpen(KEYRING_CONTAINER) then
			break
		end
	end

	NeedBagRefresh = false

	self.Bag:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 64 + (ButtonSpacing * 4)) - ButtonSpacing)
end

function Bags:UpdateAllBankBags()
	-- check if containers changed
	for i = 6, 13 do
		local ContainerSize = _G["ContainerFrame"..i].size

		if ContainerSize ~= BagSize[i] then
			NeedBankRefresh = true

			BagSize[i] = ContainerSize
		end
	end

	if not NeedBankRefresh then
		return
	end

	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
	local BankFrameMoneyFrame = BankFrameMoneyFrame

	for Bank = 1, T.Classic and 24 or 28 do
		local Button = _G["BankFrameItem"..Bank]
		local Money = ContainerFrame2MoneyFrame

		Button:ClearAllPoints()
		Button:SetWidth(ButtonSize)
		Button:SetHeight(ButtonSize)
		Button:SetScale(1)
		Button.IconBorder:SetAlpha(0)

		if (Bank == 1) then
			Button:SetPoint("TOPLEFT", Bags.Bank, "TOPLEFT", 10, -10)
			LastRowButton = Button
			LastButton = Button
		elseif (NumButtons == ItemsPerRow) then
			Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSize))
			Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSize))
			LastRowButton = Button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing + ButtonSize), 0)
			Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing + ButtonSize), 0)
			NumButtons = NumButtons + 1
		end

		if not Button.IsSkinned then
			Bags.SkinBagButton(Button)
		end

		Bags.SlotUpdate(self, -1, Button)

		LastButton = Button
	end

	BankFrameMoneyFrame:Hide()

	for Bag = 6, 12 do
		local Slots = GetContainerNumSlots(Bag - 1)

		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"..Bag.."Item"..Item]

			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetScale(1)
			Button.IconBorder:SetAlpha(0)

			if (NumButtons == ItemsPerRow) then
				Button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(ButtonSpacing + ButtonSize))
				Button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(ButtonSpacing + ButtonSize))
				LastRowButton = Button
				NumRows = NumRows + 1
				NumButtons = 1
			else
				Button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (ButtonSpacing+ButtonSize), 0)
				Button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (ButtonSpacing+ButtonSize), 0)
				NumButtons = NumButtons + 1
			end

			Bags.SkinBagButton(Button)
			Bags.SlotUpdate(self, Bag - 1, Button)

			LastButton = Button
		end
	end

	NeedBankRefresh = false

	Bags.Bank:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 20) - ButtonSpacing)
end

function Bags:OpenBag(id)
	if (not CanOpenPanels()) then
		if (UnitIsDead("player")) then
			NotWhileDeadError()
		end

		return
	end

	local Size = GetContainerNumSlots(id)
	local OpenFrame = ContainerFrame_GetOpenFrame()

	for i = 1, 40 do
		local Index = Size - i + 1
		local Button = _G[OpenFrame:GetName().."Item"..i]
		
		if Button then
			if (i > Size) then
				Button:Hide()
			else
				Button:SetID(Index)
				Button:Show()
			end
		end
	end

	OpenFrame.size = Size
	OpenFrame:SetID(id)
	OpenFrame:Show()

	if (id == 4) then
		Bags:UpdateAllBags()
	end
end

function Bags:CloseBag(id)
	CloseBag(id)
end

function Bags:OpenAllBags()
	self:OpenBag(0)

	for i = 1, 4 do
		self:OpenBag(i)
	end

	if IsBagOpen(0) then
		self.Bag:Show()

		if not self.Bag.MoverAdded then
			local Movers = T["Movers"]

			Movers:RegisterFrame(self.Bag, "Bags")

			self.Bag.MoverAdded = true
		end
	end
end

function Bags:OpenAllBankBags()
	local Bank = BankFrame
	local CustomPosition = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.TukuiBank

	if Bank:IsShown() then
		self.Bank:Show()

		if not self.Bank.MoverAdded then
			local Movers = T["Movers"]

			Movers:RegisterFrame(self.Bank, "Bank")

			self.Bank.MoverAdded = true
		end

		if CustomPosition and not self.Bank.MoverApplied then
			self.Bank:ClearAllPoints()
			self.Bank:SetPoint(unpack(CustomPosition))

			self.Bank.MoverApplied = true
		end

		for i = 5, T.Classic and 10 or 11 do
			if (not IsBagOpen(i)) then

				self:OpenBag(i, 1)
			end
		end
	end
end

function Bags:CloseAllBags()
	if MerchantFrame:IsVisible() or InboxFrame:IsVisible() then
		return
	end

	CloseAllBags()
	
	if IsBagOpen(KEYRING_CONTAINER) then
		CloseBag(KEYRING_CONTAINER)
	end

	PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
end

function Bags:CloseAllBankBags()
	local Bank = BankFrame

	if (Bank:IsVisible()) then
		CloseBankBagFrames()
		CloseBankFrame()
	end
end

function Bags:ToggleBags(id, openonly)
	if id == KEYRING_CONTAINER then
		if not IsBagOpen(KEYRING_CONTAINER) then
			CloseAllBags()
			CloseBankBagFrames()
			CloseBankFrame()
			
			NeedBagRefresh = true
			
			Bags:OpenBag(id)
			Bags:UpdateAllBags()
			
			NeedBagRefresh = true
		else
			CloseBag(id)
		end
	else
		if (self.Bag:IsShown() and BankFrame:IsShown()) and (not self.Bank:IsShown()) then
			if T.Retail and ReagentBankFrame:IsShown() then
				return
			end

			self:OpenAllBankBags()

			return
		end

		if (not openonly) and (self.Bag:IsShown() or self.Bank:IsShown()) then
			if MerchantFrame:IsVisible() or InboxFrame:IsVisible() then
				return
			end

			self:CloseAllBags()
			self:CloseAllBankBags()

			return
		end

		if not self.Bag:IsShown() then
			self:OpenAllBags()
		end

		if not self.Bank:IsShown() and BankFrame:IsShown() then
			self:OpenAllBankBags()
		end
	end
end

function Bags:OnEvent(event, ...)
	if (event == "BAG_UPDATE") then
		if not IsBagOpen(KEYRING_CONTAINER) then
			self:BagUpdate(...)
		else
			self:BagUpdate(-2)
		end
	elseif (event == "MERCHANT_CLOSED" or event ==  "MAIL_CLOSED") then
		CloseAllBags()
	elseif (event == "CURRENCY_DISPLAY_UPDATE") then
		BackpackTokenFrame_Update()
	elseif (event == "BAG_CLOSED") then
		-- This is usually where the client find a bag swap in character or bank slots.

		local Bag = ... + 1

		-- We need to hide buttons from a bag when closing it because they are not parented to the original frame
		local Container = _G["ContainerFrame"..Bag]
		local Size = Container.size

		if Size then
			for i = 1, Size do
				local Button = _G["ContainerFrame"..Bag.."Item"..i]

				if Button then
					Button:Hide()
				end
			end
		end

		-- We close to refresh the all in one layout.
		self:CloseAllBags()
		self:CloseAllBankBags()
	elseif (event == "PLAYERBANKSLOTS_CHANGED") then
		local ID = ...

		if ID <= 28 then
			local Button = _G["BankFrameItem"..ID]

			if (Button) then
				self:SlotUpdate(-1, Button)
			end
		end
	elseif (event == "PLAYERREAGENTBANKSLOTS_CHANGED") then
		local ID = ...

		local Button = _G["ReagentBankFrameItem"..ID]

		if (Button) then
			self:SlotUpdate(-3, Button)
		end
	elseif (event == "BANKFRAME_CLOSED") then
		local Bank = self.Bank

		self:CloseAllBags()
		self:CloseAllBankBags()

		-- Clear search on close
		self.Bag.SearchBox:SetText("")
	elseif (event == "BANKFRAME_OPENED") then
		local Bank = self.Bank

		Bank:Show()
		self:UpdateAllBankBags()
	elseif (event == "SOULBIND_FORGE_INTERACTION_STARTED") then
		self:OpenAllBags()
		
		ItemButtonUtil.OpenAndFilterBags(SoulbindViewer)
	elseif (event == "SOULBIND_FORGE_INTERACTION_ENDED") then
		self:CloseAllBags()
	end
end

function Bags:Enable()
	if (not C.Bags.Enable) then
		return
	end
	
	if C.Bags.SortToBottom then
		SetSortBagsRightToLeft(false)
	else
		SetSortBagsRightToLeft(true)
	end
	SetInsertItemsLeftToRight(false)

	-- Bug with mouse click
	GroupLootContainer:EnableMouse(false)

	ButtonSize = C.Bags.ButtonSize
	ButtonSpacing = C.Bags.Spacing
	ItemsPerRow = C.Bags.ItemsPerRow

	local Bag = ContainerFrame1
	local GameMenu = GameMenuFrame
	local BankItem1 = BankFrameItem1
	local BankFrame = BankFrame
	local DataTextLeft = T.DataTexts.Panels.Left
	local DataTextRight = T.DataTexts.Panels.Right

	self:CreateContainer("Bag", "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -34, 48)
	self:CreateContainer("Bank", "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 34, 48)
	self:HideBlizzard()

	Bag:SetScript("OnHide", function()
		self.Bag:Hide()
	end)

	Bag:HookScript("OnShow", function() -- Cinematic Bug with Bags open.
		self.Bag:Show()
	end)

	BankItem1:SetScript("OnHide", function()
		self.Bank:Hide()
	end)

	-- Rewrite Blizzard Bags Functions
	function UpdateContainerFrameAnchors() end
	function ToggleBag(id) ToggleAllBags(id) end
	function ToggleBackpack() ToggleAllBags() end
	function OpenAllBags() ToggleAllBags(1, true) end
	function OpenBackpack() ToggleAllBags(1, true) end
	function ToggleAllBags(id, openonly) self:ToggleBags(id, openonly) end

	-- Destroy bubbles help boxes
	for i = 1, 13 do
		local HelpBox = _G["ContainerFrame"..i.."ExtraBagSlotsHelpBox"]

		if HelpBox then
			HelpBox:Kill()
		end
	end
	
	OpenAllBagsMatchingContext = function() return 4 end

	-- Register Events for Updates
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	self:RegisterEvent("BAG_CLOSED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("MERCHANT_CLOSED")
	self:RegisterEvent("MAIL_CLOSED")
	self:SetScript("OnEvent", self.OnEvent)

	for i = 1, 13 do
		_G["ContainerFrame"..i]:EnableMouse(false)
	end
	
	-- Add Text Cooldowns Timer
	hooksecurefunc("ContainerFrame_UpdateCooldown", Bags.UpdateCooldown)
	hooksecurefunc("BankFrame_UpdateCooldown", Bags.UpdateCooldown)
	
	if T.Retail then
		self:SetTokensPosition()
		
		BankFrame:HookScript("OnHide", function()
			if self.Reagent and self.Reagent:IsShown() then
				self.Reagent:Hide()
			end
		end)
		
		self:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
		self:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
		self:RegisterEvent("SOULBIND_FORGE_INTERACTION_STARTED")
		self:RegisterEvent("SOULBIND_FORGE_INTERACTION_ENDED")
	end
	
	--TEMP FIX for WotLK
	if T.WotLK then
		ContainerFrame1.SetHeight = function() return end
	end

	ToggleAllBags()
	ToggleAllBags()
end

Inventory.Bags = Bags
