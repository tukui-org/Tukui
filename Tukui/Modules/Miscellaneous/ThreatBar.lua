local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local Movers = T["Movers"]
local format = string.format
local floor = math.floor
local UnitName = UnitName
local ThreatBar = CreateFrame("StatusBar", "TukuiThreatBar", UIParent)
local Timer = 1

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
	end
end

function ThreatBar:OnUpdate(elapsed)
	Timer = Timer - elapsed
	
	if Timer > 0 then
		return
	end

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
	
	Timer = 1
end

function ThreatBar:Create()
	self:SetSize(T.DataTexts.Panels.Right:GetSize())
	self:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -34, 19)
	self:SetFrameLevel(T.DataTexts.Panels.Right:GetFrameLevel() + 2)
	self:SetFrameStrata("HIGH")
	self:SetStatusBarTexture(C.Medias.Normal)
	self:SetMinMaxValues(0, 100)
	self:SetAlpha(0)
	
	self.Backdrop = CreateFrame("Frame", nil, self)
	self.Backdrop:SetFrameLevel(self:GetFrameLevel() - 1)
	self.Backdrop:SetOutside()
	self.Backdrop:CreateBackdrop()
	self.Backdrop:CreateShadow()

	self.Text = self:CreateFontString(nil, "OVERLAY")
	self.Text:SetFont(C.Medias.Font, 12)
	self.Text:SetPoint("RIGHT", self, -30, 0)
	self.Text:SetShadowColor(0, 0, 0)
	self.Text:SetShadowOffset(1.25, -1.25)

	self.Title = self:CreateFontString(nil, "OVERLAY")
	self.Title:SetFont(C.Medias.Font, 12)
	self.Title:SetPoint("LEFT", self, 30, 0)
	self.Title:SetShadowColor(0, 0, 0)
	self.Title:SetShadowOffset(1.25, -1.25)

	self.Background = self:CreateTexture(nil, "BORDER")
	self.Background:SetPoint("TOPLEFT", self, 0, 0)
	self.Background:SetPoint("BOTTOMRIGHT", self, 0, 0)
	self.Background:SetColorTexture(0.15, 0.15, 0.15)

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
	
	-- Register for moving
	Movers:RegisterFrame(self, "Talking Head")
end

function ThreatBar:Enable()
	if not C.Misc.ThreatBar then
		return
	end
	
	self:Create()
end

Miscellaneous.ThreatBar = ThreatBar
