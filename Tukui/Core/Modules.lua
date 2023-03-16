local T, C, L = unpack((select(2, ...)))

T["ActionBars"] = CreateFrame("Frame")
T["Auras"] = CreateFrame("Frame")
T["Chat"] = CreateFrame("Frame")
T["Cooldowns"] = CreateFrame("Frame")
T["DataTexts"] = CreateFrame("Frame")
T["Fonts"] = CreateFrame("Frame")
T["Inventory"] = CreateFrame("Frame")
T["Maps"] = CreateFrame("Frame")
T["Miscellaneous"] = CreateFrame("Frame")
T["Tooltips"] = CreateFrame("Frame")
T["UnitFrames"] = CreateFrame("Frame")

if T.Retail then
	T["PetBattles"] = CreateFrame("Frame")
end
