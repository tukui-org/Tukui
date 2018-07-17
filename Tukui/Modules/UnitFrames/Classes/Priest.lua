-- NOTE: Please Fix me - TotemBar Position, when Shadow Orbs Bar is Shown!

local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "PRIEST") then
	return
end

TukuiUnitFrames.AddClassFeatures["PRIEST"] = function(self)
	local Shadow = self.Shadow
	local Atonement = CreateFrame("StatusBar", self:GetName().."Atonement", self)
	
	Atonement:SetHeight(8)
	Atonement:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Atonement:Point("BOTTOMRIGHT", self, "TOPRIGHT", 0, 1)
	Atonement:SetStatusBarTexture(C.Medias.Normal)

	Atonement.Backdrop = Atonement:CreateTexture(nil, "BACKGROUND")
	Atonement.Backdrop:SetAllPoints()
	Atonement.Backdrop:SetColorTexture(207/255 * 0.2, 181/255 * 0.2, 59/255 * 0.2)
	
	Atonement:SetScript("OnShow", function(self)
		TukuiUnitFrames.UpdateShadow(self, 12)
	end)

	Atonement:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, 4)
	end)
	
	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)
	
	self.Atonement = Atonement
end
