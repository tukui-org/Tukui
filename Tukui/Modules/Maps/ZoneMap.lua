local T, C, L = select(2, ...):unpack()

local ZoneMap = CreateFrame("Frame")
local Movers = T["Movers"]

function ZoneMap:SetMapAlpha()
	local Map = BattlefieldMapFrame
	local Alpha = 1 - BattlefieldMapOptions.opacity

	Map.ScrollContainer.Backdrop:SetAlpha(Alpha)
	Map.ScrollContainer.Shadow:SetAlpha(Alpha)
end

function ZoneMap:Skin()
	local Map = BattlefieldMapFrame
	local Tab = BattlefieldMapTab

	Map.BorderFrame:Kill()
	Map.ScrollContainer:CreateBackdrop()
	Map.ScrollContainer:CreateShadow()
	Tab:StripTextures()

	Map.IsSkinned = true
end

function ZoneMap:AddHooks()
	hooksecurefunc(BattlefieldMapFrame, "RefreshAlpha", self.SetMapAlpha)
end

function ZoneMap:OnEvent(event, addon)
	if addon ~= "Blizzard_BattlefieldMap" then
		return
	end

	if not BattlefieldMapFrame.IsSkinned then
		self:Skin()
		self:AddHooks()
	end
end

function ZoneMap:Enable()
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", self.OnEvent)

	if BattlefieldMapFrame and not BattlefieldMapFrame.IsSkinned then
		self:Skin()
		self:AddHooks()
	end
end

T["Maps"].Zonemap = ZoneMap
