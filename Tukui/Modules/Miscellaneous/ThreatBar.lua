local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local DataTextRight
local format = string.format
local floor = math.floor
local UnitName = UnitName
local ThreatBar = CreateFrame("StatusBar", nil, UIParent)

function ThreatBar:OnEvent(event)
	local Party = GetNumGroupMembers()
	local Raid = GetNumGroupMembers()
	local Pet = HasPetUI()
	
	if (event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_DEAD") then
		self:Hide()
	elseif (event == "PLAYER_REGEN_ENABLED") then
		self:Hide()
	elseif (event == "PLAYER_REGEN_DISABLED") then
		if (Party > 0 or Raid > 0 or Pet) then
			self:Show()
		else
			self:Hide()
		end
	else
		if (InCombatLockdown()) and (Party > 0 or Raid > 0 or Pet) then
			self:Show()
		else
			self:Hide()
		end
	end
end

function ThreatBar:OnUpdate()
	local GetColor = T.ColorGradient

	if UnitAffectingCombat("player") then
		local _, _, ThreatPercent = UnitDetailedThreatSituation("player", "target")
		local ThreatValue = ThreatPercent or 0
		local Text = self.Text
		local Title = self.Title
		local Dead = UnitIsDead("player")
		
		self:SetValue(ThreatValue)
		Text:SetText(floor(ThreatValue) .. "%")
		Title:SetText((UnitName("target") and UnitName("target") .. ":") or "")
		
		local R, G, B = GetColor(ThreatValue, 100, 0,.8,0,.8,.8,0,.8,0,0)
		self:SetStatusBarColor(R, G, B)
		
		if Dead then
			self:SetAlpha(0)
		elseif (ThreatValue > 0) then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end
	end
end

function ThreatBar:Parent()
	self:SetParent(DataTextRight)
end

function ThreatBar:Create()
	DataTextRight = T["Panels"].DataTextRight
	
	self:Parent()
	
	self:Point("TOPLEFT", 2, -2)
	self:Point("BOTTOMRIGHT", -2, 2)
	self:SetFrameLevel(DataTextRight:GetFrameLevel() + 2)
	self:SetFrameStrata("HIGH")
	self:SetStatusBarTexture(C.Medias.Normal)
	self:SetMinMaxValues(0, 100)
	self:SetAlpha(0)
	
	self.Text = self:CreateFontString(nil, "OVERLAY")
	self.Text:SetFont(C.Medias.Font, 12)
	self.Text:Point("RIGHT", self, -30, 0)
	self.Text:SetShadowColor(0, 0, 0)
	self.Text:SetShadowOffset(1.25, -1.25)
	
	self.Title = self:CreateFontString(nil, "OVERLAY")
	self.Title:SetFont(C.Medias.Font, 12)
	self.Title:Point("LEFT", self, 30, 0)
	self.Title:SetShadowColor(0, 0, 0)
	self.Title:SetShadowOffset(1.25, -1.25)
	
	self.Background = self:CreateTexture(nil, "BORDER")
	self.Background:Point("TOPLEFT", self, 0, 0)
	self.Background:Point("BOTTOMRIGHT", self, 0, 0)
	self.Background:SetTexture(0.15, 0.15, 0.15)
	
	self:SetScript("OnShow", function(self)
		self:SetScript("OnUpdate", self.OnUpdate)
	end)
	
	self:SetScript("OnHide", function(self)
		self:SetScript("OnUpdate", nil)
	end)
	
	self:RegisterEvent("PLAYER_DEAD")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:SetScript("OnEvent", self.OnEvent)
end

function ThreatBar:Enable()
	self:Create()
end

Miscellaneous.ThreatBar = ThreatBar