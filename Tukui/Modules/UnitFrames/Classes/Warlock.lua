local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARLOCK") then
	return
end

UnitFrames.AddClassFeatures["WARLOCK"] = function(self)
	if T.Classic or not C.UnitFrames.ClassBar then
		return
	end

	local Bar = CreateFrame("Frame", self:GetName().."SoulShardsBar", self.Health)
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)
	local maxShards = UnitPowerMax("player", Enum.PowerType.SoulShards)

	-- Warlock Class Bar
	Bar:SetHeight(6)
	Bar:SetPoint("BOTTOMLEFT", self.Health)
	Bar:SetPoint("BOTTOMRIGHT", self.Health)
	Bar:SetFrameLevel(self.Health:GetFrameLevel() + 1)

	Bar:CreateBackdrop()
	Bar.Backdrop:SetOutside()

	for i = 1, maxShards do
		Bar[i] = CreateFrame("StatusBar", "TukuiSoulShardBar"..i , Bar)
		Bar[i]:SetHeight(6)
		Bar[i]:SetStatusBarTexture(PowerTexture)

		if i == 1 then
			Bar[i]:SetWidth((250 / maxShards))
			Bar[i]:SetPoint("LEFT", Bar, "LEFT", 0, 0)
		else
			Bar[i]:SetWidth((250 / maxShards) - 1)
			Bar[i]:SetPoint("LEFT", Bar[i-1], "RIGHT", 1, 0)
		end

		Bar[i].bg = Bar[i]:CreateTexture(nil, "ARTWORK")
	end

	-- Register
	self.SoulShards = Bar
end
