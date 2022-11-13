local T, C, L = select(2, ...):unpack()

local Inventory = T["Inventory"]

function Inventory:Enable()
	Inventory["Bags"]:Enable()
	Inventory["Loot"]:Enable()
	Inventory["GroupLoot"]:Enable()
	Inventory["Merchant"]:Enable()
end
