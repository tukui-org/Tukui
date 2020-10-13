local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local DeathRecap = CreateFrame("Frame")

function DeathRecap:OnEvent(event, addon)
	if addon ~= "Blizzard_DeathRecap" then
		return
	end

	local DeathRecapFrame = _G["DeathRecapFrame"]
	DeathRecapFrame:StripTextures()
	DeathRecapFrame.CloseXButton:SkinCloseButton()
	DeathRecapFrame:CreateBackdrop("Transparent")
	DeathRecapFrame:CreateShadow()
	DeathRecapFrame.CloseButton:SkinButton()

	for i=1, 5 do
		local IconBorder = DeathRecapFrame["Recap"..i].SpellInfo.IconBorder
		local Icon = DeathRecapFrame["Recap"..i].SpellInfo.Icon

		IconBorder:SetAlpha(0)
		Icon:SetTexCoord(.08, .92, .08, .92)
		DeathRecapFrame["Recap"..i].SpellInfo:CreateBackdrop()
		DeathRecapFrame["Recap"..i].SpellInfo.Backdrop:SetOutside(Icon)
		Icon:SetParent(DeathRecapFrame["Recap"..i].SpellInfo.Backdrop)
	end
end

function DeathRecap:Enable()
	if not AddOnSkins then
		self:RegisterEvent("ADDON_LOADED")
		self:SetScript("OnEvent", self.OnEvent)
	end
end

Miscellaneous.DeathRecap = DeathRecap