local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MONK") then
	return
end

TukuiUnitFrames.AddClassFeatures["MONK"] = function(self)
	local Harmony = CreateFrame("Frame", self:GetName().."Harmony", self)
	local Shadow = self.Shadow
	local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)

	-- Harmony Bar
	Harmony:SetFrameStrata(self:GetFrameStrata())
	Harmony:SetFrameLevel(self:GetFrameLevel())
	Harmony:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Harmony:Size(250, 8)
	Harmony:SetBackdrop(TukuiUnitFrames.Backdrop)
	Harmony:SetBackdropColor(0, 0, 0)
	Harmony:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 6 do
		Harmony[i] = CreateFrame("StatusBar", self:GetName().."Harmony"..i, Harmony)
		Harmony[i]:Height(8)
		Harmony[i]:SetStatusBarTexture(PowerTexture)
		
		if i == 1 then
			Harmony[i]:Width((250 / 6) - 2)
			Harmony[i]:SetPoint("LEFT", Harmony, "LEFT", 0, 0)
			Harmony[i].Ascension = Harmony[i]:GetWidth()
			Harmony[i].NoTalent = 250 / 5
		else
			Harmony[i]:Width((250 / 6) - 1)
			Harmony[i]:SetPoint("LEFT", Harmony[i-1], "RIGHT", 1, 0)
			Harmony[i].Ascension = Harmony[i]:GetWidth()
			Harmony[i].NoTalent = 250 / 5 - 1
		end
	end
	
	Harmony:SetScript("OnShow", function(self)
		TukuiUnitFrames.UpdateShadow(self, 12)
	end)

	Harmony:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, 4)
	end)

	-- Register
	self.HarmonyBar = Harmony
end
