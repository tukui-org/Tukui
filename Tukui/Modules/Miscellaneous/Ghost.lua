local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Ghost = CreateFrame("Frame")
local GhostFrame = GhostFrame

Ghost.Color = T.Colors.reaction[2]

function Ghost:OnShow()
	local Button = Ghost.Button

	Button:Show()
end

function Ghost:OnHide()
	local Button = Ghost.Button

	Button:Hide()
end

function Ghost:CreateButton()
	local Button = CreateFrame("Button", nil, UIParent)

	Button:CreateBackdrop()
	Button:SetAllPoints(T.DataTexts.Panels.Minimap or T.DataTexts.Panels.Right)
	Button:Hide()
	
	Button.Text = Button:CreateFontString(nil, "OVERLAY")
	Button.Text:SetFontTemplate(C.Medias.Font, 12)
	Button.Text:SetPoint("CENTER")
	Button.Text:SetText(T.RGBToHex(unpack(Ghost.Color)) .. RETURN_TO_GRAVEYARD .. "|r")

	self.Button = Button
end

function Ghost:AddHooks()
	GhostFrame:HookScript("OnShow", Ghost.OnShow)
	GhostFrame:HookScript("OnHide", Ghost.OnHide)
end

function Ghost:Enable()
	local DataRight = T.DataTexts.Panels.Right
	local Minimap = T.DataTexts.Panels.Minimap
	local Icon = GhostFrameContentsFrame
	local Text = GhostFrameContentsFrameText

	if Minimap or DataRight then
		self:CreateButton()
		self:AddHooks()

		GhostFrame:StripTextures()
		GhostFrame:ClearAllPoints()
		GhostFrame:SetAllPoints(Minimap or DataRight)
		GhostFrame:SetFrameStrata(self.Button:GetFrameStrata())
		GhostFrame:SetFrameLevel(self.Button:GetFrameLevel() + 1)
		GhostFrame:SetAlpha(0)

		Icon:StripTextures()

		Text:SetText("")
	end
end

Miscellaneous.Ghost = Ghost