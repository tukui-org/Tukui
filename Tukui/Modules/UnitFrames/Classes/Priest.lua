-- NOTE: Please Fix me - TotemBar Position, when Shadow Orbs Bar is Shown!

local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PRIEST") then
	return
end

TukuiUnitFrames.AddClassFeatures["PRIEST"] = function(self)
	local Atonement = CreateFrame("StatusBar", nil, self.Health)
	Atonement:SetSize(250, 8)
	Atonement:SetPoint("BOTTOM", 0, 0)
	Atonement:SetStatusBarTexture(C.Medias.Normal)
	Atonement:SetFrameStrata(self.Health:GetFrameStrata())
	Atonement:SetFrameLevel(self.Health:GetFrameLevel() + 4)
	
	Atonement.Backdrop = Atonement:CreateTexture(nil, "BACKGROUND")
	Atonement.Backdrop:SetSize(250, 10)
	Atonement.Backdrop:SetPoint("CENTER", 0, 0)
	Atonement.Backdrop:SetColorTexture(unpack(C.Medias.BackdropColor))
	
	self.Atonement = Atonement
end
