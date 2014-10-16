local T, C, L = select(2, ...):unpack()

local Inventory = T["Inventory"]
local BagFilter = CreateFrame("Frame")
local Link
local TrashList = "\n\nTrash List:\n" -- 6.0 localize me

BagFilter.Trash = {
	32902, -- Bottled Nethergon Energy
	32905, -- Bottled Nethergon Vapor
	32897, -- Mark of the Illidari
}

function BagFilter:OnEvent(event)
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			Link = select(7, GetContainerItemInfo(bag, slot))
			
			for i = 1, #self.Trash do
				if (Link and (GetItemInfo(Link) == GetItemInfo(self.Trash[i]))) then
					PickupContainerItem(bag, slot)
					DeleteCursorItem()
				end
			end
		end
	end
end

function BagFilter:UpdateConfigDescription()
	if (not IsAddOnLoaded("Tukui_Config")) then
		return
	end
	
	local Locale = GetLocale()
	local Group = TukuiConfig[Locale]["Bags"]["BagFilter"]
	
	if Group then
		local Desc = Group.Default
		local Items = Desc .. TrashList -- 6.0 localize me
		
		for i = 1, #self.Trash do
			local Name, Link = GetItemInfo(self.Trash[i])
			
			if (Name and Link) then
				if i == 1 then
					Items = Items .. "" .. Link
				else
					Items = Items .. ", " .. Link
				end
			end
		end
		
		TukuiConfig[Locale]["Bags"]["BagFilter"]["Desc"] = Items
	end
end

function BagFilter:AddItem(id)
	tinsert(self.Trash, id)
	
	self:UpdateConfigDescription()
end

function BagFilter:RemoveItem(id)
	for i = 1, #self.Trash do
		if (self.Trash[i] == id) then
			tremove(self.Trash, i)
			self:UpdateConfigDescription()
			
			break
		end
	end
end

function BagFilter:Enable()
	self:RegisterEvent("CHAT_MSG_LOOT")
	self:SetScript("OnEvent", self.OnEvent)
end

function BagFilter:Disable()
	self:UnregisterEvent("CHAT_MSG_LOOT")
	self:SetScript("OnEvent", nil)
end

BagFilter:UpdateConfigDescription()

Inventory.BagFilter = BagFilter