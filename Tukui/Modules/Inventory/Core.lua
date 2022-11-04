local T, C, L = select(2, ...):unpack()

local Inventory = T["Inventory"]

function Inventory:Enable()
	-- FIX ME ON BETA
	if T.TocVersion < 100002 then
		Inventory["Bags"]:Enable()
	end
	
	Inventory["Loot"]:Enable()
	Inventory["GroupLoot"]:Enable()
	Inventory["Merchant"]:Enable()
end
