local T, C, L = select(2, ...):unpack()

local TukuiAuras = T["Auras"]

TukuiAuras.HeaderNames = {
	"TukuiBuffHeader",
	"TukuiDebuffHeader",
	"TukuiConsolidatedHeader",
}

function TukuiAuras:CreateHeaders()
	if (not C.Auras.Enable) then
		return
	end

	local Panels = T["Panels"]
	local Movers = T["Movers"]
	local Headers = TukuiAuras.Headers
	local Parent = Panels.PetBattleHider

	for i = 1, 3 do
		local Header
		
		if (i == 3) then
			Header = CreateFrame("Frame", TukuiAuras.HeaderNames[i], Parent, "SecureFrameTemplate")
			Header:SetAttribute("wrapAfter", 1)
			Header:SetAttribute("wrapYOffset", -35)
		else
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
			
			Movers:RegisterFrame(Header)
		end
		
		Header:SetAttribute("minWidth", C["Auras"].BuffsPerRow * 35)
		Header:SetAttribute("template", "TukuiAurasTemplate")
		Header:SetAttribute("weaponTemplate", "TukuiAurasTemplate")
		Header:SetSize(30, 30)
		
		RegisterAttributeDriver(Header, "unit", "[vehicleui] vehicle; player")
		
		table.insert(Headers, Header)
	end
	
	local Buffs = Headers[1]
	local Debuffs = Headers[2]
	local Consolidate = Headers[3]
	local Filter = (C.Auras.Consolidate and 1) or 0
	local Proxy = CreateFrame("Frame", nil, Buffs, "TukuiAurasProxyTemplate")
	local DropDown = CreateFrame("BUTTON", nil, Proxy, "SecureHandlerClickTemplate")
	
	if (not C.Auras.HideBuffs) then
		Buffs:SetPoint("TOPRIGHT", UIParent, -184, -28)
		Buffs:SetAttribute("filter", "HELPFUL")
		Buffs:SetAttribute("consolidateProxy", Proxy)
		Buffs:SetAttribute("consolidateHeader", Consolidate)
		Buffs:SetAttribute("consolidateTo", Filter)
		Buffs:SetAttribute("includeWeapons", 1)
		Buffs:SetAttribute("consolidateDuration", -1)
		Buffs:Show()
	
		Proxy = Buffs:GetAttribute("consolidateProxy")
		Proxy:HookScript("OnShow", function(self)
			if Consolidate:IsShown() then
				Consolidate:Hide()
			end
		end)
	
		DropDown:SetAllPoints()
		DropDown:RegisterForClicks("AnyUp")
		DropDown:SetAttribute("_onclick", [=[
			local Header = self:GetParent():GetFrameRef("header")
			local NumChild = 0
		
			repeat
				NumChild = NumChild + 1
				local child = Header:GetFrameRef("child" .. NumChild)
				until not child or not child:IsShown()

			NumChild = NumChild - 1

			local x, y = self:GetWidth(), self:GetHeight()
			Header:SetWidth(x)
			Header:SetHeight(y)
		
			if Header:IsShown() then
				Header:Hide()
			else
				Header:Show()
			end
		]=])
	
		Consolidate:SetAttribute("point", "RIGHT")
		Consolidate:SetAttribute("minHeight", nil)
		Consolidate:SetAttribute("minWidth", nil)
		Consolidate:SetParent(Proxy)
		Consolidate:ClearAllPoints()
		Consolidate:SetPoint("CENTER", Proxy, "CENTER", 0, -35)
		Consolidate:Hide()
		SecureHandlerSetFrameRef(Proxy, "header", Consolidate)
		
		Buffs.Proxy = Proxy
		Buffs.DropDown = DropDown
	end
	
	if (not C.Auras.HideDebuffs) then
		if (C.Auras.HideBuffs) then
			Debuffs:SetPoint("TOPRIGHT", UIParent, -184, -28)
		else
			Debuffs:SetPoint("TOP", Buffs, "BOTTOM", 0, -97)
		end
		
		Debuffs:SetAttribute("filter", "HARMFUL")
		Debuffs:Show()		
	end
end