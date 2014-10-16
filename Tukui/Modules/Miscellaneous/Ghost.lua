local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Ghost = CreateFrame("Frame")
local Panels = T["Panels"]
local GhostFrame = GhostFrame
local Noop = function() end

Ghost.Color = {0.31, 0.45, 0.63}

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
	
	Button:SetFrameStrata("MEDIUM")
	Button:SetFrameLevel(10)
	Button:SetTemplate()
	Button:SetBackdropBorderColor(unpack(Ghost.Color))
	Button:SetAllPoints(Panels.DataTextRight)
	Button:Hide()

	Button.Text = Button:CreateFontString(nil, "OVERLAY")
	Button.Text:SetFont(C.Medias.Font, 12)
	Button.Text:Point("CENTER", 0, 0)
	Button.Text:SetText(T.RGBToHex(unpack(Ghost.Color)) .. RETURN_TO_GRAVEYARD .. "|r")
	Button.Text:SetShadowOffset(1.25, -1.25)

	self.Button = Button
end

function Ghost:AddHooks()
	GhostFrame:HookScript("OnShow", Ghost.OnShow)
	GhostFrame:HookScript("OnHide", Ghost.OnHide)
end

function Ghost:Enable()
	local DataRight = Panels.DataTextRight
	local Icon = GhostFrameContentsFrame
	local Text = GhostFrameContentsFrameText
	
	if DataRight then
		self:CreateButton()
		self:AddHooks()
		
		GhostFrame:StripTextures()
		GhostFrame:ClearAllPoints()
		GhostFrame:SetAllPoints(DataRight)
		GhostFrame:SetFrameStrata(self.Button:GetFrameStrata())
		GhostFrame:SetFrameLevel(self.Button:GetFrameLevel() + 1)
		GhostFrame:SetAlpha(0)
		
		Icon:StripTextures()
		
		Text:SetText("")
	end
end

Miscellaneous.Ghost = Ghost