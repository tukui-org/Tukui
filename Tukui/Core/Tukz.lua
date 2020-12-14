local T, C, L = select(2, ...):unpack()

-- This is my personal skins and settings for others addons, sorry guys, just for me! :)

local Tukz = CreateFrame("Frame")

Tukz:RegisterEvent("PLAYER_PVP_TALENT_UPDATE")
Tukz:RegisterEvent("ADDON_LOADED")
Tukz:RegisterEvent("PLAYER_ENTERING_WORLD")

function Tukz:OnEvent(event, arg)
	if event == "ADDON_LOADED" and arg == "Tukui" then
		if IsAddOnLoaded("OmniBar") then
			hooksecurefunc("OmniBar_AddIcon", self.SkinOmniBarButton)
			hooksecurefunc("OmniBar_ShowAnchor", self.ToggleOmniBarAnchor)
			hooksecurefunc("OmniBar_LoadPosition", self.DefaultOmniBarSettings)
		end
	end
	
	for Macro = 1, MAX_ACCOUNT_MACROS + MAX_CHARACTER_MACROS do
		local Name, Icon, Body = GetMacroInfo(Macro)
		local Spec = GetSpecialization()
		local Class = select(2, UnitClass("player"))
		
		if Class == "PRIEST" and Spec == 1 then
			if Name and string.find(Body, "Archangel") then
				SetMacroSpell(Name, GetSpellInfo("Archangel(PvP Talent)") or GetSpellInfo("Thoughtsteal") or GetSpellInfo("Dark Archangel(PvP Talent)") or GetSpellInfo("Atonement"))
				
				break
			end
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

	self:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
end

if T.MyName == "Tukz" and T.MyRealm == "Illidan" and GetCurrentRegion() == 3 then
	Tukz:SetScript("OnEvent", Tukz.OnEvent)
end