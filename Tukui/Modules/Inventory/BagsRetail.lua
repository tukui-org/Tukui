local T, C, L = unpack((select(2, ...)))

--[[ THIS BAG MODULE IS CURRENTLY WORK IN PROGRESS]]

local Bags = CreateFrame("Frame")
local Inventory = T["Inventory"]
local Movers = T["Movers"]

function Bags:SkinButtons()
	local Bag = ContainerFrameCombinedBags
	
	for i, itemButton in Bag:EnumerateValidItems() do
		itemButton:StripTextures()
		itemButton:CreateBackdrop()
		itemButton.IconBorder:SetAlpha(0)
		itemButton.icon:SetTexCoord(.08, .92, .08, .92)
	end
end

function Bags:UpdateItems()
	for i, Button in self:EnumerateValidItems() do
		local ID = Button:GetBagID()
		local Info = C_Container.GetContainerItemInfo(ID, Button:GetID())
		local Texture = Info and Info.iconFileID
		local Count = Info and Info.stackCount
		local Lock = Info and Info.isLocked
		local Quality = Info and Info.quality
		local Readable = Info and Info.IsReadable
		local ItemLink = Info and Info.hyperlink
		local IsFiltered = Info and Info.isFiltered
		local NoValue = Info and Info.hasNoValue
		local ItemID = Info and Info.itemID
		local IsBounch = Info and Info.isBound
		local QuestInfo = C_Container.GetContainerItemQuestInfo(ID, Button:GetID())
		local IsQuestItem = QuestInfo.isQuestItem
		local QuestID = QuestInfo.questID
		local IsActive = QuestInfo.isActive
		local R, G, B
		
		if Quality then
			R, G, B = C_Item.GetItemQualityColor(Quality)

			Button.Backdrop:SetBorderColor(R, G, B)
		else
			Button.Backdrop:SetBorderColor(unpack(C.General.BorderColor))
		end
		
		if IsQuestItem then
			Button.Backdrop:SetBorderColor(1, 1, 0)
		end
		
		if C.Bags.ItemLevel then
			if ItemLink then
				local Level = C_Item.GetDetailedItemLevelInfo(ItemLink)
				local _, _, Rarity, _, _, ItemType, _, _, _, _, _, ClassID = C_Item.GetItemInfo(ItemLink)

				if (ItemType and (ItemType == "Armor" or ItemType == "Weapon")) and Level and Level > 1 then
					if not Button.ItemLevel then
						Button.ItemLevel = Button:CreateFontString(nil, "ARTWORK")
						Button.ItemLevel:SetPoint("TOPRIGHT", 1, -1)
						Button.ItemLevel:SetFont(C.Medias.Font, 12, "OUTLINE")
						Button.ItemLevel:SetJustifyH("RIGHT")
					end

					Button.ItemLevel:SetText(Level)

					if Rarity then
						local R, G, B = C_Item.GetItemQualityColor(Rarity)

						if Button.ItemLevel then
							Button.ItemLevel:SetTextColor(R, G, B)
						end
					else
						if Button.ItemLevel then
							Button.ItemLevel:SetTextColor(1, 1, 1)
						end
					end
				else
					if Button.ItemLevel then
						Button.ItemLevel:SetText("")
					end
				end
			else
				if Button.ItemLevel then
					Button.ItemLevel:SetText("")
				end
			end
		end
	end
end

function Bags:SkinContainer()
	local Container = ContainerFrameCombinedBags
	local NineSlice = Container.NineSlice
	local CloseButton = Container.CloseButton
	local Portrait = ContainerFrameCombinedBagsPortrait
	local TokensBorder = BackpackTokenFrame.Border
	local MoneyBorder = ContainerFrameCombinedBags.MoneyFrame.Border
	local SearchBox = BagItemSearchBox
	local SortButton = BagItemAutoSortButton

	NineSlice:StripTextures()
	NineSlice:SetTemplate()
	NineSlice:SetFrameLevel(0)
	NineSlice:CreateShadow()
	
	CloseButton:SkinCloseButton()
	
	Portrait:Kill()
	
	TokensBorder:Kill()
	
	MoneyBorder:Kill()
	
	SearchBox:StripTextures()
	SearchBox:SkinEditBox()
end

function Bags:UpdatePosition()
	local Container = ContainerFrameCombinedBags
	local Position = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.ContainerFrameCombinedBags

	if Position then
		Container:ClearAllPoints()
		Container:SetPoint(unpack(Position))
	end
end

function Bags:AddHooks()
	hooksecurefunc("UpdateContainerFrameAnchors", Bags.UpdatePosition)
	hooksecurefunc(ContainerFrameCombinedBags, "UpdateItems", Bags.UpdateItems)
end

function Bags:Enable()
	if (not C.Bags.Enable) then
		return
	end

	SetCVar("combinedBags", 1)
	
	-- Create the AIO container on load
	ToggleAllBags()
	ToggleAllBags()
	
	-- Start doing shit
	self:AddHooks()
	self:SkinContainer()
	self:SkinButtons()
	
	Movers:RegisterFrame(ContainerFrameCombinedBags, "Bags")
end

Inventory.Bags = Bags