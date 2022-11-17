local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "EVOKER") then
	return
end

UnitFrames.AddClassFeatures["EVOKER"] = function(self)
	local ClassPower = {}
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)
	local Essence = CreateFrame("Frame", self:GetName().."Essence", self.Health)

	-- Essence Bar
	Essence:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	Essence:SetHeight(6)
	Essence:SetPoint("BOTTOMLEFT", self.Health)
	Essence:SetPoint("BOTTOMRIGHT", self.Health)

	Essence:CreateBackdrop()
	Essence.Backdrop:SetOutside()

	for i = 1, 6 do
		local Bar = CreateFrame("StatusBar", nil, Essence)

		Bar:SetFrameStrata(Essence:GetFrameStrata())
		Bar:SetFrameLevel(Essence:GetFrameLevel() + 1)
		Bar:SetHeight(8)

		if i == 1 then
			Bar:SetWidth(40)
			Bar:SetPoint("LEFT", Essence, "LEFT", 0, 0)
		else
			Bar:SetWidth(41)
			Bar:SetPoint("LEFT", ClassPower[i - 1], "RIGHT", 1, 0)
		end

		ClassPower[i] = Bar
	end
	
	-- Register with oUF
	self.ClassPower = ClassPower
	self.ClassPower.PostUpdate = UnitFrames.UpdateMaxEssence
end
