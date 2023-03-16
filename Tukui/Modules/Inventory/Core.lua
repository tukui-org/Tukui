local T, C, L = unpack((select(2, ...)))

local Inventory = T["Inventory"]

function Inventory:Enable()
	Inventory["Bags"]:Enable()
	Inventory["Loot"]:Enable()
	Inventory["GroupLoot"]:Enable()
	Inventory["Merchant"]:Enable()
end
