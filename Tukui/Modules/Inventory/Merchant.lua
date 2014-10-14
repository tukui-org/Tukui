local T, C, L = select(2, ...):unpack()

local Inventory = T["Inventory"]
local Merchant = CreateFrame("Frame")
local BlizzardMerchantClick = MerchantItemButton_OnModifiedClick

Merchant.MerchantFilter = {
	[6289]  = true, -- Raw Longjaw Mud Snapper
	[6291]  = true, -- Raw Brilliant Smallfish
	[6308]  = true, -- Raw Bristle Whisker Catfish
	[6309]  = true, -- 17 Pound Catfish
	[6310]  = true, -- 19 Pound Catfish
	[41808] = true, -- Bonescale Snapper
	[42336] = true, -- Bloodstone Band
	[42337] = true, -- Sun Rock Ring
	[43244] = true, -- Crystal Citrine Necklace
	[43571] = true, -- Sewer Carp
	[43572] = true, -- Magic Eater		
}

function Merchant:OnEvent()
	if C["Merchant"].AutoSellGrays or C["Merchant"].SellMisc then
		local Cost = 0
		
		for Bag = 0, 4 do
			for Slot = 1, GetContainerNumSlots(Bag) do
				local Link, ID = GetContainerItemLink(Bag, Slot), GetContainerItemID(Bag, Slot)
				
				if (Link and ID) then
					local Price = 0
					local Mult1, Mult2 = select(11, GetItemInfo(Link)), select(2, GetContainerItemInfo(Bag, Slot))
					
					if (Mult1 and Mult2) then
						Price = Mult1 * Mult2
					end
					
					if (C["Merchant"].AutoSellGrays and select(3, GetItemInfo(Link)) == 0 and Price > 0) then
						UseContainerItem(Bag, Slot)
						PickupMerchantItem()
						Cost = Cost + Price
					end
					
					if C["Merchant"].SellMisc and self.MerchantFilter[ID] then
						UseContainerItem(Bag, Slot)
						PickupMerchantItem()
						Cost = Cost + Price
					end
				end
			end
		end
		
		if (Cost > 0) then
			local Gold, Silver, Copper = math.floor(Cost / 10000) or 0, math.floor((Cost % 10000) / 100) or 0, Cost % 100
			
			DEFAULT_CHAT_FRAME:AddMessage(L.Merchant.SoldTrash.." |cffffffff"..Gold..L.DataText.GoldShort.." |cffffffff"..Silver..L.DataText.SilverShort.." |cffffffff"..Copper..L.DataText.CopperShort..".", 0255, 255, 0)
		end
	end
	
	if (not IsShiftKeyDown()) then
		if (CanMerchantRepair() and C["Merchant"].AutoRepair) then
			local Cost, Possible = GetRepairAllCost()
			
			if (Cost > 0) then
				if (IsInGuild() and C["Merchant"].UseGuildRepair) then
					local CanGuildRepair = (CanGuildBankRepair() and (Cost <= GetGuildBankWithdrawMoney()))
					
					if CanGuildRepair then
						RepairAllItems(1)
						
						return
					end
				end
				
				if Possible then
					RepairAllItems()
					
					local Copper = Cost % 100
					local Silver = math.floor((Cost % 10000) / 100)
					local Gold = math.floor(Cost / 10000)
					DEFAULT_CHAT_FRAME:AddMessage(L.Merchant.RepairCost.." |cffffffff"..Gold..L.DataText.GoldShort.." |cffffffff"..Silver..L.DataText.SilverShort.." |cffffffff"..Copper..L.DataText.CopperShort..".", 255, 255, 0)
				else
					DEFAULT_CHAT_FRAME:AddMessage(L.Merchant.NotEnoughMoney, 255, 0, 0)
				end
			end
		end
	end
end

function Merchant:MerchantClick(...)
	if (IsAltKeyDown()) then
		local MaxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))
		
		if (MaxStack and MaxStack > 1) then
			BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
		end
	end
	
	BlizzardMerchantClick(self, ...)
end

function Merchant:Enable()
	self:RegisterEvent("MERCHANT_SHOW")
	self:SetScript("OnEvent", self.OnEvent)

	MerchantItemButton_OnModifiedClick = self.MerchantClick
end

function Merchant:Disable()
	self:UnregisterEvent("MERCHANT_SHOW")
	self:SetScript("OnEvent", nil)
	
	MerchantItemButton_OnModifiedClick = BlizzardMerchantClick
end

Inventory.Merchant = Merchant