local T, C, L = select(2, ...):unpack()

local Maps = T["Maps"]

function Maps:Enable()
	Maps["Minimap"]:Enable()
	Maps["Zonemap"]:Enable()
	Maps["Worldmap"]:Enable()
end
