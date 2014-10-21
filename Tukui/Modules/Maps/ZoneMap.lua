local T, C, L = select(2, ...):unpack()

local ZoneMap = CreateFrame("Frame")
local Movers = T["Movers"]

function ZoneMap:SetMapAlpha()
    local NumDetailTiles = GetNumberOfDetailTiles()
    
    for i = 1, NumDetailTiles do
    	local Tile = _G["BattlefieldMinimap"..i]
    	
        Tile:SetAlpha(1)
    end
end

function ZoneMap:OnShow()
	local Auras = T.Auras
	local Check = select(2, BattlefieldMinimap:GetPoint())
	
	ZoneMap:SetMapAlpha()

	if (Check ~= Minimap) then
		return
	end
	
	if (Auras) then
		local Buffs = T.Auras.Headers[1]
		
		if (Buffs) then
			local A1, P, A2, X, Y = Buffs:GetPoint()
		
			X = tonumber(T.Round(X))
			Y = tonumber(T.Round(Y))
		
			if (A1 == "TOPRIGHT" and A2 == "TOPRIGHT" and X == -184 and Y == -28) then
				Buffs:ClearAllPoints()
				Buffs:SetPoint("TOPRIGHT", BattlefieldMinimap, "TOPLEFT", -14, 2)
			end
		
			Buffs.MovedByZoneMap = true
			Buffs.OriginalPosition = {A1, P, A2, X, Y}
		end
	end
end

function ZoneMap:OnHide()
	local Auras = T.Auras
	
	if (Auras) then
		local Buffs = T.Auras.Headers[1]

		if (Buffs and Buffs.MovedByZoneMap) then
			Buffs:ClearAllPoints()
			Buffs:SetPoint(unpack(Buffs.OriginalPosition))
		end
	end
end

function ZoneMap:AddHooks()
	BattlefieldMinimap:HookScript("OnShow", ZoneMap.OnShow)
	BattlefieldMinimap:HookScript("OnHide", ZoneMap.OnHide)
	
	-- Restore position of buffs if moved from minimap
	hooksecurefunc(BattlefieldMinimap, "ClearAllPoints", ZoneMap.OnHide)
end

function ZoneMap:Enable()
	LoadAddOn("Blizzard_BattlefieldMinimap")
	
	ZoneMap:SetMapAlpha()
	ZoneMap:AddHooks()
	
	BattlefieldMinimapCorner:SetTexture(nil)
	
	BattlefieldMinimapBackground:SetTexture(nil)
	
	BattlefieldMinimapTab:Kill()
	
	BattlefieldMinimap:SetHeight(165)
	BattlefieldMinimap:ClearAllPoints()
	BattlefieldMinimap:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", 0, 0)
	BattlefieldMinimap:StripTextures()

	BattlefieldMinimap:CreateBackdrop()
	BattlefieldMinimap.Backdrop:ClearAllPoints()
	BattlefieldMinimap.Backdrop:SetPoint("TOPLEFT", -2, 2)
	BattlefieldMinimap.Backdrop:SetPoint("BOTTOMRIGHT", -4, 23)
	BattlefieldMinimap.Backdrop:SetBackdropColor(0, 0, 0, 0)
	BattlefieldMinimap.Backdrop:SetFrameLevel(BattlefieldMinimap:GetFrameLevel() + 2)
	
	BattlefieldMinimapCloseButton:SkinCloseButton()
	BattlefieldMinimapCloseButton:ClearAllPoints()
	BattlefieldMinimapCloseButton:SetPoint("TOPRIGHT", BattlefieldMinimap, "TOPRIGHT", 0, 0)
	BattlefieldMinimapCloseButton:SetAlpha(1)
		
	BattlefieldMinimap.Title = CreateFrame("Frame", nil, BattlefieldMinimap)
	BattlefieldMinimap.Title:SetWidth(BattlefieldMinimap:GetWidth() - 2)
	BattlefieldMinimap.Title:SetHeight(19)
	BattlefieldMinimap.Title:SetTemplate()
	BattlefieldMinimap.Title:SetPoint("BOTTOM", -3, 3)
	BattlefieldMinimap.Title:FontString("Text", C.Medias.Font, 12)
	BattlefieldMinimap.Title.Text:SetPoint("CENTER", BattlefieldMinimap.Title)
	BattlefieldMinimap.Title.Text:SetText(BATTLEFIELD_MINIMAP)
	
	Movers:RegisterFrame(BattlefieldMinimap)
	
	if BattlefieldMinimap:IsShown() then
		ZoneMap:OnShow()
	end
end

T["Maps"].Zonemap = ZoneMap