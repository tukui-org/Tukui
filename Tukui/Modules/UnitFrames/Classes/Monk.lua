local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "MONK") then
	return
end

UnitFrames.AddClassFeatures["MONK"] = function(self)
	if not C.UnitFrames.ClassBar then
		return
	end
	
	local Harmony = CreateFrame("Frame", self:GetName().."Harmony", self.Health)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)

	-- Harmony Bar
	Harmony:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	Harmony:SetHeight(6)
	Harmony:SetPoint("BOTTOMLEFT", self.Health)
	Harmony:SetPoint("BOTTOMRIGHT", self.Health)
	
	Harmony:CreateBackdrop()
	Harmony.Backdrop:SetOutside()

	for i = 1, 6 do
		Harmony[i] = CreateFrame("StatusBar", self:GetName().."Harmony"..i, Harmony)
		Harmony[i]:SetHeight(8)
		Harmony[i]:SetStatusBarTexture(PowerTexture)

		if i == 1 then
			Harmony[i]:SetWidth(40)
			Harmony[i]:SetPoint("LEFT", Harmony, "LEFT", 0, 0)
			Harmony[i].Ascension = Harmony[i]:GetWidth()
			Harmony[i].NoTalent = 250 / 5
		else
			Harmony[i]:SetWidth(41)
			Harmony[i]:SetPoint("LEFT", Harmony[i-1], "RIGHT", 1, 0)
			Harmony[i].Ascension = Harmony[i]:GetWidth()
			Harmony[i].NoTalent = 250 / 5 - 1
		end
	end

	-- Register
	self.HarmonyBar = Harmony
end
