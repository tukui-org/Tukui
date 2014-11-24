local T, C, L = select(2, ...):unpack()

local _G = _G
local Noop = function() end
local Font
local ReplaceBags = 0
local LastButtonBag, LastButtonBank, LastButtonReagent
local Token1, Token2, Token3 = BackpackTokenFrameToken1, BackpackTokenFrameToken2, BackpackTokenFrameToken3
local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local ContainerFrame_GetOpenFrame = ContainerFrame_GetOpenFrame
local BankFrame = BankFrame
local ReagentBankFrame = ReagentBankFrame
local BagHelpBox = BagHelpBox
local ButtonSize, ButtonSpacing, ItemsPerRow
local Bags = CreateFrame("Frame")
local Inventory = T["Inventory"]
local QuestColor = {1, 1, 0}

local BlizzardBags = {
	CharacterBag0Slot,
	CharacterBag1Slot,
	CharacterBag2Slot,
	CharacterBag3Slot,
}

local BlizzardBank = {
	BankSlotsFrame["Bag1"],
	BankSlotsFrame["Bag2"],
	BankSlotsFrame["Bag3"],
	BankSlotsFrame["Bag4"],
	BankSlotsFrame["Bag5"],
	BankSlotsFrame["Bag6"],
	BankSlotsFrame["Bag7"],
}

local BagType = {
	[8] = true,     -- Leatherworking Bag
	[16] = true,    -- Inscription Bag
	[32] = true,    -- Herb Bag
	[64] = true,    -- Enchanting Bag
	[128] = true,   -- Engineering Bag
	[512] = true,   -- Gem Bag
	[1024] = true,  -- Mining Bag
	[32768] = true, -- Fishing Bag
}

function Bags:IsProfessionBag(bag)
	local Type = select(2, GetContainerNumFreeSlots(bag))
	
	if BagType[Type] then
		return true
	end
end

function Bags:SkinBagButton()
	if self.IsSkinned then
		return
	end
	
	local Icon = _G[self:GetName().."IconTexture"]
	local Quest = _G[self:GetName().."IconQuestTexture"]
	local JunkIcon = self.JunkIcon
	local Border = self.IconBorder
	local BattlePay = self.BattlepayItemTexture
	
	Border:SetAlpha(0)
	
	Icon:SetTexCoord(unpack(T.IconCoord))
	Icon:SetInside(self)
	
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
	self:SetTemplate()
	self:StyleButton()
	
	self.IsSkinned = true
end

function Bags:HideBlizzard()
	local TokenFrame = _G["BackpackTokenFrame"]
	local Inset = _G["BankFrameMoneyFrameInset"]
	local Border = _G["BankFrameMoneyFrameBorder"]
	local BankClose = _G["BankFrameCloseButton"]
	local BankPortraitTexture = _G["BankPortraitTexture"]
	local BankSlotsFrame = _G["BankSlotsFrame"]
	
	TokenFrame:GetRegions():SetAlpha(0)
	Inset:Hide()
	Border:Hide()
	BankClose:Hide()
	BankPortraitTexture:Hide()
	BagHelpBox:Kill()
	BankFrame:EnableMouse(0)
	
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
	
	-- Hide Tabs, we will create our tabs
	for i = 1, 2 do
		local Tab = _G["BankFrameTab"..i]
		Tab:Hide()
	end
end

function Bags:CreateReagentContainer()
	ReagentBankFrame:StripTextures()
	
	local DataTextLeft = T["Panels"].DataTextLeft
	local Reagent = CreateFrame("Frame", "TukuiReagent", UIParent)
	local SwitchBankButton = CreateFrame("Button", nil, Reagent)
	local SortButton = CreateFrame("Button", nil, Reagent)
	local NumButtons = ReagentBankFrame.size
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton
	local Movers = T["Movers"]
	
	Reagent:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	Reagent:SetPoint("BOTTOMLEFT", DataTextLeft, "TOPLEFT", 0, 6)
	Reagent:SetTemplate()
	Reagent:SetFrameStrata(self.Bank:GetFrameStrata())
	Reagent:SetFrameLevel(self.Bank:GetFrameLevel())
	
	SwitchBankButton:Size((Reagent:GetWidth() / 2) - 1, 23)
	SwitchBankButton:SkinButton()
	SwitchBankButton:Point("BOTTOMLEFT", Reagent, "TOPLEFT", 0, 2)
	SwitchBankButton:FontString(Text, C.Medias.Font, 12)
	SwitchBankButton.Text:SetPoint("CENTER")
	SwitchBankButton.Text:SetText("Switch to: "..BANK)
	SwitchBankButton:SetScript("OnClick", function()
		Reagent:Hide()
		self.Bank:Show()
		BankFrame_ShowPanel(BANK_PANELS[1].name)
		
		for i = 5, 11 do
			if (not IsBagOpen(i)) then

				self:OpenBag(i, 1)
			end
		end
	end)
	
	Deposit:SetParent(Reagent)
	Deposit:ClearAllPoints()
	Deposit:Size(Reagent:GetWidth(), 23)
	Deposit:Point("BOTTOMLEFT", SwitchBankButton, "TOPLEFT", 0, 2)
	Deposit:SkinButton()
	
	SortButton:Size((Reagent:GetWidth() / 2) - 1, 23)
	SortButton:SetPoint("LEFT", SwitchBankButton, "RIGHT", 2, 0)
	SortButton:SkinButton()
	SortButton:FontString(Text, C.Medias.Font, 12)
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
		Button:SetTemplate()
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
	Unlock:SetTemplate()
	
	UnlockButton:SkinButton()
	
	Movers:RegisterFrame(Reagent)
	
	self.Reagent = Reagent
	-- Couldn't access these.
	self.Reagent.SwitchBankButton = SwitchBankButton
	self.Reagent.SortButton = SortButton
end

function Bags:CreateContainer(storagetype, ...)
	local Container = CreateFrame("Frame", "Tukui".. storagetype, UIParent)
	Container:SetScale(1)
	Container:SetWidth(((ButtonSize + ButtonSpacing) * ItemsPerRow) + 22 - ButtonSpacing)
	Container:SetPoint(...)
	Container:SetFrameStrata("HIGH")
	Container:SetFrameLevel(1)
	--Container:RegisterForDrag("LeftButton","RightButton")
	--Container:SetScript("OnDragStart", function(self) self:StartMoving() end)
	--Container:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	Container:Hide()
	Container:SetTemplate()
    --Container:SetClampedToScreen(true)
    --Container:SetMovable(true)
    --Container:SetUserPlaced(true)
	Container:EnableMouse(true)
	--Container:RegisterForDrag("LeftButton","RightButton")
	
	if (storagetype == "Bag") then
		local Sort = BagItemAutoSortButton
		local BagsContainer = CreateFrame("Frame", nil, UIParent)
		local ToggleBagsContainer = CreateFrame("Frame")

		BagsContainer:SetParent(Container)
		BagsContainer:SetWidth(10)
		BagsContainer:SetHeight(10)
		BagsContainer:SetPoint("BOTTOMRIGHT", Container, "TOPRIGHT", 0, 27)
		BagsContainer:Hide()
		BagsContainer:SetTemplate()
			
		Sort:Size(Container:GetWidth(), 23)
		Sort:ClearAllPoints()
		Sort:SetPoint("BOTTOMLEFT", Container, "TOPLEFT", 0, 2)
		Sort:SetFrameLevel(Container:GetFrameLevel())
		Sort:SetFrameStrata(Container:GetFrameStrata())
		Sort:StripTextures()
		Sort:SkinButton()
		Sort:FontString(Text, C.Medias.Font, 12)
		Sort.Text:SetPoint("CENTER")
		Sort.Text:SetText(BAG_FILTER_CLEANUP)
		Sort.ClearAllPoints = Noop
		Sort.SetPoint = Noop
		
		ToggleBagsContainer:SetHeight(20)
		ToggleBagsContainer:SetWidth(20)
		ToggleBagsContainer:SetPoint("TOPRIGHT", Container, "TOPRIGHT", -6, -6)
		ToggleBagsContainer:SetParent(Container)
		ToggleBagsContainer:EnableMouse(true)
		ToggleBagsContainer.Text = ToggleBagsContainer:CreateFontString("button")
		ToggleBagsContainer.Text:SetPoint("CENTER", ToggleBagsContainer, "CENTER")
		ToggleBagsContainer.Text:SetFontObject(Font)
		ToggleBagsContainer.Text:SetText("X")
		ToggleBagsContainer.Text:SetTextColor(.5, .5, .5)
		ToggleBagsContainer:SetScript("OnMouseUp", function(self, button)
			local Purchase = BankFramePurchaseInfo
			
			if (button == "RightButton") then
				local BanksContainer = Bags.Bank.BagsContainer
				local Purchase = BankFramePurchaseInfo
				local ReagentButton = Bags.Bank.ReagentButton
				
				if (ReplaceBags == 0) then
					ReplaceBags = 1
					BagsContainer:Show()
					BanksContainer:Show()
					BanksContainer:ClearAllPoints()
					ToggleBagsContainer.Text:SetTextColor(1, 1, 1)
					
					if Purchase:IsShown() then
						BanksContainer:SetPoint("BOTTOMLEFT", Purchase, "TOPLEFT", 50, 2)
					else
						BanksContainer:SetPoint("BOTTOMLEFT", ReagentButton, "TOPLEFT", 0, 2)
					end
				else
					ReplaceBags = 0
					BagsContainer:Hide()
					BanksContainer:Hide()
					ToggleBagsContainer.Text:SetTextColor(.4, .4, .4)
				end
			else
				CloseAllBags()
				CloseBankBagFrames()
				CloseBankFrame()
			end	
		end)
	
		for _, Button in pairs(BlizzardBags) do
			local Count = _G[Button:GetName().."Count"]
			local Icon = _G[Button:GetName().."IconTexture"]

			Button:SetParent(BagsContainer)
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			Button:SetNormalTexture("")
			Button:SetPushedTexture("")
			Button:SetCheckedTexture("")
			Button:SetTemplate()
			Button.IconBorder:SetAlpha(0)
			Button:SkinButton()
			
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
		
		Container.BagsContainer = BagsContainer
		Container.CloseButton = ToggleBagsContainer
		Container.SortButton = Sort
	else
		local PurchaseButton = BankFramePurchaseButton
		local CostText = BankFrameSlotCost
		local TotalCost = BankFrameDetailMoneyFrame
		local Purchase = BankFramePurchaseInfo
		local SortButton = CreateFrame("Button", nil, Container)
		local BankBagsContainer = CreateFrame("Frame", nil, Container)
		
		CostText:ClearAllPoints()
		CostText:SetPoint("BOTTOMLEFT", 60, 10)
		TotalCost:ClearAllPoints()
		TotalCost:SetPoint("LEFT", CostText, "RIGHT", 0, 0)
		PurchaseButton:ClearAllPoints()
		PurchaseButton:SetPoint("BOTTOMRIGHT", -10, 10)
		PurchaseButton:SkinButton()
		BankItemAutoSortButton:Hide()
		
		local SwitchReagentButton = CreateFrame("Button", nil, Container)
		SwitchReagentButton:Size((Container:GetWidth() / 2) - 1, 23)
		SwitchReagentButton:SkinButton()
		SwitchReagentButton:Point("BOTTOMLEFT", Container, "TOPLEFT", 0, 2)
		SwitchReagentButton:FontString(Text, C.Medias.Font, 12)
		SwitchReagentButton.Text:SetPoint("CENTER")
		SwitchReagentButton.Text:SetText("Switch to: "..REAGENT_BANK)
		SwitchReagentButton:SetScript("OnClick", function()
			BankFrame_ShowPanel(BANK_PANELS[2].name)
			
			if (not ReagentBankFrame.isMade) then
				self:CreateReagentContainer()
				ReagentBankFrame.isMade = true
			else
				self.Reagent:Show()
				
			end
			
			for i = 5, 11 do
				self:CloseBag(i)
			end
		end)
		
		SortButton:Size((Container:GetWidth() / 2) - 1, 23)
		SortButton:SetPoint("LEFT", SwitchReagentButton, "RIGHT", 2, 0)
		SortButton:SkinButton()
		SortButton:FontString(Text, C.Medias.Font, 12)
		SortButton.Text:SetPoint("CENTER")
		SortButton.Text:SetText(BAG_FILTER_CLEANUP)
		SortButton:SetScript("OnClick", BankFrame_AutoSortButtonOnClick)
		
		Purchase:ClearAllPoints()
		Purchase:SetWidth(Container:GetWidth() + 50)
		Purchase:SetHeight(70)
		Purchase:SetPoint("BOTTOMLEFT", SwitchReagentButton, "TOPLEFT", -50, 2)
		Purchase:CreateBackdrop()
		Purchase.Backdrop:SetPoint("TOPLEFT", 50, 0)
		Purchase.Backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
		
		BankBagsContainer:Size(Container:GetWidth(), BankSlotsFrame.Bag1:GetHeight() + ButtonSpacing + ButtonSpacing)
		BankBagsContainer:SetTemplate()
		BankBagsContainer:SetPoint("BOTTOMLEFT", SwitchReagentButton, "TOPLEFT", 0, 2)
		BankBagsContainer:SetFrameLevel(Container:GetFrameLevel())
		BankBagsContainer:SetFrameStrata(Container:GetFrameStrata())

		for i = 1, 7 do
			local Bag = BankSlotsFrame["Bag"..i]
			Bag.HighlightFrame:Kill() -- Bugged Texture on Bank Bag Slot

			Bag:SetParent(BankBagsContainer)
			Bag:SetWidth(ButtonSize)
			Bag:SetHeight(ButtonSize)

			Bag.IconBorder:SetAlpha(0)
			Bag.icon:SetTexCoord(unpack(T.IconCoord))
			Bag.icon:SetInside()
			Bag:SkinButton()
			Bag:ClearAllPoints()
			
			if i == 1 then
				Bag:SetPoint("TOPLEFT", BankBagsContainer, "TOPLEFT", ButtonSpacing, -ButtonSpacing)
			else
				Bag:SetPoint("LEFT", BankSlotsFrame["Bag"..i-1], "RIGHT", ButtonSpacing, 0)			
			end
		end

		BankBagsContainer:SetWidth((ButtonSize * 7) + (ButtonSpacing * (7 + 1)))
		BankBagsContainer:SetHeight(ButtonSize + (ButtonSpacing * 2))
		BankBagsContainer:Hide()
		
		BankFrame:EnableMouse(false)
		
		Container.BagsContainer = BankBagsContainer
		Container.ReagentButton = SwitchReagentButton
		Container.SortButton = SortButton
	end
	
	self[storagetype] = Container
end

function Bags:SetBagsSearchPosition()
	local BagItemSearchBox = BagItemSearchBox
	local BankItemSearchBox = BankItemSearchBox
	
	BagItemSearchBox:SetParent(self.Bag)
	BagItemSearchBox:SetWidth(self.Bag:GetWidth() - (ButtonSpacing + ButtonSpacing + ButtonSpacing + ButtonSpacing))
	BagItemSearchBox:ClearAllPoints()
	BagItemSearchBox:SetPoint("BOTTOMLEFT", self.Bag, "BOTTOMLEFT", ButtonSpacing - 1, ButtonSpacing * 3)
	BagItemSearchBox:StripTextures()
	BagItemSearchBox.SetParent = Noop
	BagItemSearchBox.ClearAllPoints = Noop
	BagItemSearchBox.SetPoint = Noop
	BagItemSearchBox.Backdrop = CreateFrame("Frame", nil, BagItemSearchBox)
	BagItemSearchBox.Backdrop:SetPoint("TOPLEFT", 7, 4)
	BagItemSearchBox.Backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	BagItemSearchBox.Backdrop:SetTemplate()
	BagItemSearchBox.Backdrop:SetFrameLevel(BagItemSearchBox:GetFrameLevel() - 1)

	BankItemSearchBox:Hide()
end

function Bags:SetTokensPosition()
	local Money = ContainerFrame1MoneyFrame
	
	Token3:ClearAllPoints()
	Token3:SetPoint("LEFT", Money, "RIGHT", 2, -2)
	Token2:ClearAllPoints()
	Token2:SetPoint("LEFT", Token3, "RIGHT", 10, 0)
	Token1:ClearAllPoints()
	Token1:SetPoint("LEFT", Token2, "RIGHT", 10, 0)
end

function Bags:SkinTokens()
	for i = 1, 3 do
		local Token = _G["BackpackTokenFrameToken"..i]
		local Icon = _G["BackpackTokenFrameToken"..i.."Icon"]
		local Count = _G["BackpackTokenFrameToken"..i.."Count"]
		local PreviousToken = _G["BackpackTokenFrameToken"..(i - 1)]
		
		Token:SetFrameStrata("HIGH")
		Token:SetFrameLevel(5)
		Token:SetScale(1)
		Token:CreateBackdrop()
		Token.Backdrop:SetOutside(Icon)
		
		Icon:SetSize(12,12) 
		Icon:SetTexCoord(unpack(T.IconCoord)) 
		Icon:SetPoint("LEFT", Token, "RIGHT", -8, 2) 
		
		Count:SetFontObject(Font)
	end
end

function Bags:SlotUpdate(id, button)
	if not button then
		return
	end
	
	local ItemLink = GetContainerItemLink(id, button:GetID())
	local Texture, Count, Lock = GetContainerItemInfo(id, button:GetID())
	local IsQuestItem, QuestId, IsActive = GetContainerItemQuestInfo(id, button:GetID())
	local IsNewItem = C_NewItems.IsNewItem(id, button:GetID())
	local IsBattlePayItem = IsBattlePayItem(id, button:GetID())
	local NewItem = button.NewItemTexture
	local IsProfBag = self:IsProfessionBag(id)
	
	-- Letting you style this
	if IsProfBag then
		
	else
		--button:SetBackdropColor(unpack(C["General"].BackdropColor))
	end
	
	if IsNewItem then
		NewItem:SetAlpha(0)
		
		if C.Bags.PulseNewItem then
			if not button.Animation then
				button.Animation = button:CreateAnimationGroup()
				button.Animation:SetLooping("BOUNCE")

				button.FadeOut = button.Animation:CreateAnimation("Alpha")
				button.FadeOut:SetChange(-0.5)
				button.FadeOut:SetDuration(0.40)
				button.FadeOut:SetSmoothing("IN_OUT")
			end
			
			button.Animation:Play()
		end
	else
		if button.Animation and button.Animation:IsPlaying() then
			button.Animation:Stop()
		end
	end
	
	if IsQuestItem then
		if (button.BorderColor ~= QuestColor) then
			button:SetBackdropBorderColor(1, 1, 0)
			
			button.BorderColor = QuestColor
		end
		
		return
	end
	
	if ItemLink then
		local Name, _, Rarity, _, _, Type = GetItemInfo(ItemLink)
		
		if (not Lock and Rarity and Rarity > 1) then
			if (button.BorderColor ~= GetItemQualityColor(Rarity)) then
				button:SetBackdropBorderColor(GetItemQualityColor(Rarity))

				button.BorderColor = GetItemQualityColor(Rarity)
			end
		else
			if (button.BorderColor ~= C["General"].BorderColor) then
				button:SetBackdropBorderColor(unpack(C["General"].BorderColor))
				
				button.BorderColor = C["General"].BorderColor
			end
		end
	else
		if (button.BorderColor ~= C["General"].BorderColor) then
			button:SetBackdropBorderColor(unpack(C["General"].BorderColor))

			button.BorderColor = C["General"].BorderColor
		end
	end
end

function Bags:BagUpdate(id)
	local Size = GetContainerNumSlots(id)

	for Slot = 1, Size do
		local Button = _G["ContainerFrame"..(id + 1).."Item"..Slot]
		
		if Button then
			self:SlotUpdate(id, Button)
		end
	end
end

function Bags:UpdateAllBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1
	local FirstButton
	
	for Bag = 5, 1, -1 do
		local ID = Bag - 1
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
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
			
			Button.newitemglowAnim:Stop()
			Button.newitemglowAnim.Play = Noop
			
			Button.flashAnim:Stop()
			Button.flashAnim.Play = Noop

			Money:ClearAllPoints()
			Money:Show()
			Money:SetPoint("TOPLEFT", Bags.Bag, "TOPLEFT", 8, -10)
			Money:SetFrameStrata("HIGH")
			Money:SetFrameLevel(2)
			Money:SetScale(1)
			
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
			
			Bags.SkinBagButton(Button)
			
			LastButton = Button
		end
		
		Bags:BagUpdate(ID)
	end
	
	Bags.Bag:SetHeight(((ButtonSize + ButtonSpacing) * (NumRows + 1) + 54 + BagItemSearchBox:GetHeight() + (ButtonSpacing * 4)) - ButtonSpacing)
end

function Bags:UpdateAllBankBags()
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ContainerFrame1Item1, 1, ContainerFrame1Item1

	for Bank = 1, 28 do
		local Button = _G["BankFrameItem"..Bank]
		local Money = ContainerFrame2MoneyFrame
		local BankFrameMoneyFrame = BankFrameMoneyFrame
		
		Button:ClearAllPoints()
		Button:SetWidth(ButtonSize)
		Button:SetHeight(ButtonSize)
		Button:SetFrameStrata("HIGH")
		Button:SetFrameLevel(2)
		Button:SetScale(1)
		Button.IconBorder:SetAlpha(0)
		
		BankFrameMoneyFrame:Hide()
		
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
		
		Bags.SkinBagButton(Button)
		Bags.SlotUpdate(self, -1, Button)
		
		LastButton = Button
	end
	
	for Bag = 6, 12 do
		local Slots = GetContainerNumSlots(Bag - 1)

		for Item = Slots, 1, -1 do
			local Button = _G["ContainerFrame"..Bag.."Item"..Item]
			
			Button:ClearAllPoints()
			Button:SetWidth(ButtonSize)
			Button:SetHeight(ButtonSize)
			Button:SetFrameStrata("HIGH")
			Button:SetFrameLevel(2)
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

	for i = 1, Size, 1 do
		local Index = Size - i + 1
		local Button = _G[OpenFrame:GetName().."Item"..i]
		
		Button:SetID(Index)
		Button:Show()
	end
	
	OpenFrame.size = Size
	OpenFrame:SetID(id)
	OpenFrame:Show()

	if (id == 4) then
		Bags:UpdateAllBags()
	elseif (id == 11) then
		Bags:UpdateAllBankBags()
	end
end

function Bags:CloseBag(id)
	CloseBag(id)
end

function Bags:OpenAllBags()
	self:OpenBag(0, 1)

	for i = 1, 4 do
		self:OpenBag(i, 1)
	end	

	if IsBagOpen(0) then
		self.Bag:Show()
	
		if not self.Bag.MoverAdded then
			local Movers = T["Movers"]
		
			Movers:RegisterFrame(self.Bag)
		
			self.Bag.MoverAdded = true
		end
	end
end

function Bags:OpenAllBankBags()
	local Bank = BankFrame
	
	if Bank:IsShown() then		
		self.Bank:Show()
	
		for i = 5, 11 do
			if (not IsBagOpen(i)) then

				self:OpenBag(i, 1)
			end
		end
	
		if not self.Bank.MoverAdded then
			local Movers = T["Movers"]
		
			Movers:RegisterFrame(self.Bank)
		
			self.Bank.MoverAdded = true
		end	
	end
end

function Bags:CloseAllBags()
	if MerchantFrame:IsVisible() or InboxFrame:IsVisible() then
		return
	end
	
	CloseAllBags()
end

function Bags:CloseAllBankBags()
	local Bank = BankFrame
	
	if (Bank:IsVisible()) then
		CloseBankBagFrames()
		CloseBankFrame()
	end
end

function Bags:ToggleBags()	
	if (self.Bag:IsShown() and BankFrame:IsShown()) and (not self.Bank:IsShown())  and (not ReagentBankFrame:IsShown()) then
		self:OpenAllBankBags()
		
		return
	end
	
	if (self.Bag:IsShown() or self.Bank:IsShown()) then
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

function Bags:OnBagSwitch()
	-- Used to update bag layout when we find a bag switch.
	-- We use a little delay here just to make sure the button receive the drag command successfully.
	T.Delay(1, function()
		CloseAllBags()
		
		if Bags.Bank:IsShown() then
			CloseBankBagFrames()
			Bags.Bank:Hide()
		end
		
		Bags:ToggleBags()
	end)
end

function Bags:OnEvent(event, ...)
	if (event == "BAG_UPDATE") then
		self:BagUpdate(...)
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
	end
end

function Bags:AddHooks()
	for _, Bag in pairs(BlizzardBags) do
		Bag:HookScript("OnDragStop", Bags.OnBagSwitch)
		Bag:HookScript("OnReceiveDrag", Bags.OnBagSwitch)
	end
	
	for _, Bag in pairs(BlizzardBank) do
		Bag:HookScript("OnDragStop", Bags.OnBagSwitch)
		Bag:HookScript("OnReceiveDrag", Bags.OnBagSwitch)
	end
end

function Bags:Enable()
	if (not C.Bags.Enable) then
		return
	end
	
	SetSortBagsRightToLeft(false)
	SetInsertItemsLeftToRight(true)
	InterfaceOptionsControlsPanelReverseCleanUpBags:Hide()
	InterfaceOptionsControlsPanelReverseNewLoot:Hide()

	Font = T.GetFont(C["Bags"].Font)
	ButtonSize = C.Bags.ButtonSize
	ButtonSpacing = C.Bags.Spacing
	ItemsPerRow = C.Bags.ItemsPerRow

	local Bag = ContainerFrame1
	local GameMenu = GameMenuFrame
	local Bank = BankFrameItem1
	local BankFrame = BankFrame
	local DataTextLeft = T["Panels"].DataTextLeft
	local DataTextRight = T["Panels"].DataTextRight
	
	self:CreateContainer("Bag", "BOTTOMRIGHT", DataTextRight, "TOPRIGHT", 0, 6)
	self:CreateContainer("Bank", "BOTTOMLEFT", DataTextLeft, "TOPLEFT", 0, 6)
	self:HideBlizzard()
	self:SetBagsSearchPosition()
	self:SetTokensPosition()
	self:SkinTokens()
	
	Bag:SetScript("OnHide", function()
		self.Bag:Hide()
		
		if self.Reagent and self.Reagent:IsShown() then
			self.Reagent:Hide()
		end
	end)
	
	Bank:SetScript("OnHide", function()
		self.Bank:Hide()
	end)
	
	BankFrame:HookScript("OnHide", function()
		if self.Reagent and self.Reagent:IsShown() then
			self.Reagent:Hide()
		end
	end)
	
	-- Rewrite Blizzard Bags Functions
	function UpdateContainerFrameAnchors() end
	function ToggleBag() ToggleAllBags() end
	function ToggleBackpack() ToggleAllBags() end
	function OpenAllBags() ToggleAllBags() end
	function OpenBackpack() ToggleAllBags() end
	function ToggleAllBags() self:ToggleBags() end
	
	-- Add Hooks
	self:AddHooks()
	
	-- Register Events for Updates
	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	self:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
	self:SetScript("OnEvent", self.OnEvent)
	
	-- Force an update, setting colors
	ToggleAllBags()
	ToggleAllBags()
end

Inventory.Bags = Bags