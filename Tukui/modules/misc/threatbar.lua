local T, C, L = unpack(select(2, ...))
if not TukuiInfoRight then return end

--[[local aggroColors = {
	[1] = {12/255, 151/255,  15/255},
	[2] = {166/255, 171/255,  26/255},
	[3] = {163/255,  24/255,  24/255},
}]]

local TukuiThreatBar = CreateFrame("StatusBar", "TukuiThreatBar", TukuiInfoRight)
TukuiThreatBar:Point("TOPLEFT", 2, -2)
TukuiThreatBar:Point("BOTTOMRIGHT", -2, 2)

TukuiThreatBar:SetStatusBarTexture(C.media.normTex)
TukuiThreatBar:GetStatusBarTexture():SetHorizTile(false)
TukuiThreatBar:SetBackdrop({bgFile = C.media.blank})
TukuiThreatBar:SetBackdropColor(0, 0, 0, 0)
TukuiThreatBar:SetMinMaxValues(0, 100)

TukuiThreatBar.text = T.SetFontString(TukuiThreatBar, C.media.font, 12)
TukuiThreatBar.text:Point("RIGHT", TukuiThreatBar, "RIGHT", -30, 0)

TukuiThreatBar.Title = T.SetFontString(TukuiThreatBar, C.media.font, 12)
TukuiThreatBar.Title:SetText(L.unitframes_ouf_threattext)
TukuiThreatBar.Title:SetPoint("LEFT", TukuiThreatBar, "LEFT", T.Scale(30), 0)
	  
TukuiThreatBar.bg = TukuiThreatBar:CreateTexture(nil, 'BORDER')
TukuiThreatBar.bg:SetAllPoints(TukuiThreatBar)
TukuiThreatBar.bg:SetTexture(0.1,0.1,0.1)

local function OnEvent(self, event, ...)
	local party = GetNumPartyMembers()
	local raid = GetNumRaidMembers()
	local pet = select(1, HasPetUI())
	if event == "PLAYER_ENTERING_WORLD" then
		self:Hide()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "PLAYER_REGEN_ENABLED" then
		self:Hide()
	elseif event == "PLAYER_REGEN_DISABLED" then
		if party > 0 or raid > 0 or pet == 1 then
			self:Show()
		else
			self:Hide()
		end
	else
		if (InCombatLockdown()) and (party > 0 or raid > 0 or pet == 1) then
			self:Show()
		else
			self:Hide()
		end
	end
end

local function OnUpdate(self, event, unit)
	if UnitAffectingCombat(self.unit) then
		local _, _, threatpct, rawthreatpct, _ = UnitDetailedThreatSituation(self.unit, self.tar)
		local threatval = threatpct or 0
		
		self:SetValue(threatval)
		self.text:SetFormattedText("%3.1f", threatval)
		
		local r, g, b = oUFTukui.ColorGradient(threatval/100, 0,.8,0,.8,.8,0,.8,0,0)
		self:SetStatusBarColor(r, g, b)

		if threatval > 0 then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end		
	end
end

TukuiThreatBar:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiThreatBar:RegisterEvent("PLAYER_REGEN_ENABLED")
TukuiThreatBar:RegisterEvent("PLAYER_REGEN_DISABLED")
TukuiThreatBar:SetScript("OnEvent", OnEvent)
TukuiThreatBar:SetScript("OnUpdate", OnUpdate)
TukuiThreatBar.unit = "player"
TukuiThreatBar.tar = TukuiThreatBar.unit.."target"
TukuiThreatBar.Colors = aggroColors
TukuiThreatBar:SetAlpha(0)