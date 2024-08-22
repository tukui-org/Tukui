local T, C, L = unpack((select(2, ...)))

--[[ THIS BAG MODULE IS CURRENTLY WORK IN PROGRESS]]

local Bags = CreateFrame("Frame")
local Inventory = T["Inventory"]
local Movers = T["Movers"]

function Bags:SkinButtons()
	local Bag = ContainerFrameCombinedBags
	
	for i, itemButton in Bag:EnumerateValidItems() do
		itemButton:StripTextures()
		itemButton:SkinButton()
		itemButton.IconBorder:SetAlpha(0)
		itemButton.icon:SetTexCoord(.08, .92, .08, .92)
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