local T, C, L = select(2, ...):unpack()

-- This is my personal skins and settings for others addons, sorry guys, just for me! :)

local Tukz = CreateFrame("Frame")

function Tukz:OnEvent(event, arg)
	if event == "ADDON_LOADED" and arg == "Tukui" then
		if IsAddOnLoaded("OmniBar") then
			hooksecurefunc("OmniBar_AddIcon", self.SkinOmniBarButton)
			hooksecurefunc("OmniBar_ShowAnchor", self.ToggleOmniBarAnchor)
			hooksecurefunc("OmniBar_LoadPosition", self.DefaultOmniBarSettings)
		end
	end
end

function Tukz:SkinOmniBarButton()
	for i = 1, #self.active do
		if self.active[i] then
			if not self.active[i].IsSkinned then
				self.active[i]:CreateBackdrop()

				self.active[i].Backdrop:CreateShadow()
				self.active[i].Backdrop:SetFrameLevel(self.active[i]:GetFrameLevel() - 1)

				self.active[i].icon:SetInside()

				self.active[i].IsSkinned = true
			end
			
			self.active[i].icon:SetTexCoord(.1, .9, .1, .9)
		end
	end
end

function Tukz:ToggleOmniBarAnchor()
	self.anchor:Hide()
end

function Tukz:DefaultOmniBarSettings()
	self.settings.align = "CENTER"
	self.settings.highlightTarget = false
	self.settings.highlightFocus = false
	self.settings.glow = false
	self.settings.size = 32
	self.settings.padding = 6
	self.settings.locked = true
	self.settings.center = true
	self.settings.growUpward = false
	self.settings.columns = 7
	self.settings.border = false

	self:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
end

if T.MyName == "Tukz" and T.MyRealm == "Illidan" and GetCurrentRegion() == 3 then
	Tukz:RegisterEvent("ADDON_LOADED")
	Tukz:SetScript("OnEvent", Tukz.OnEvent)
end