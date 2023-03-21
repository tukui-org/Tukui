local T, C, L = unpack((select(2, ...)))

local Maps = T["Maps"]

function Maps:Enable()
	Maps["Minimap"]:Enable()
	Maps["Zonemap"]:Enable()
	Maps["Worldmap"]:Enable()
end
