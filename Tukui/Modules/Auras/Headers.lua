local T, C, L = select(2, ...):unpack()

local TukuiAuras = T["Auras"]

TukuiAuras.HeaderNames = {
	"TukuiBuffHeader",
	"TukuiDebuffHeader",
}

function TukuiAuras:CreateHeaders()
	if (not C.Auras.Enable) then
		return
	end

	local Panels = T["Panels"]
	local Movers = T["Movers"]
	local Headers = TukuiAuras.Headers
	local Parent = Panels.PetBattleHider

	for i = 1, 2 do
		local Header


		Header = CreateFrame("Frame", TukuiAuras.HeaderNames[i], Parent, "SecureAuraHeaderTemplate")
		Header:SetClampedToScreen(true)
		Header:SetMovable(true)
		Header:SetAttribute("minHeight", 30)
		Header:SetAttribute("wrapAfter", C["Auras"].BuffsPerRow)
		Header:SetAttribute("wrapYOffset", -73.5)
		Header:SetAttribute("xOffset", -35)
		Header:CreateBackdrop()
		Header.Backdrop:SetBackdropBorderColor(1, 0, 0)
		Header.Backdrop:Hide()

		Header.Backdrop:FontString("Text", C.Medias.Font, 12)
		Header.Backdrop.Text:SetPoint("CENTER")

		if (i == 1) then
			Header.Backdrop.Text:SetText(L.Auras.MoveBuffs)
		else
			Header.Backdrop.Text:SetText(L.Auras.MoveDebuffs)
		end


		Header:SetAttribute("minWidth", C["Auras"].BuffsPerRow * 35)
		Header:SetAttribute("template", "TukuiAurasTemplate")
		Header:SetAttribute("weaponTemplate", "TukuiAurasTemplate")
		Header:SetSize(30, 30)
		Header:SetFrameStrata("BACKGROUND")

		RegisterAttributeDriver(Header, "unit", "[vehicleui] vehicle; player")

		table.insert(Headers, Header)
	end

	local Buffs = Headers[1]
	local Debuffs = Headers[2]

	if (not C.Auras.HideBuffs) then
		Buffs:SetPoint("TOPRIGHT", UIParent, -184, -29)
		Buffs:SetAttribute("filter", "HELPFUL")
		Buffs:SetAttribute("includeWeapons", 1)
		Buffs:Show()

		Movers:RegisterFrame(Buffs)
	end

	if (not C.Auras.HideDebuffs) then
		if (C.Auras.HideBuffs) then
			Debuffs:SetPoint("TOPRIGHT", UIParent, -184, -29)
		else
			Debuffs:SetPoint("TOP", Buffs, "BOTTOM", 0, -97)
		end

		Debuffs:SetAttribute("filter", "HARMFUL")
		Debuffs:Show()

		Movers:RegisterFrame(Debuffs)
	end
end
