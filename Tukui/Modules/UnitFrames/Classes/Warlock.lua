local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARLOCK") then
	return
end

TukuiUnitFrames.AddClassFeatures["WARLOCK"] = function(self)
	local Bar = CreateFrame("Frame", self:GetName().."SoulShardsBar", self)
	local Shadow = self.Shadow
	local Totems = self.Totems
	local PowerTexture = T.GetTexture(C["Textures"].UFPowerTexture)

	-- Warlock Class Bar
	Bar:SetFrameStrata(self:GetFrameStrata())
	Bar:SetFrameLevel(self:GetFrameLevel())
	Bar:SetHeight(8)
	Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Bar:Point("BOTTOMRIGHT", self, "TOPRIGHT", 0, 1)
	Bar:SetBackdrop(TukuiUnitFrames.Backdrop)
	Bar:SetBackdropColor(0, 0, 0)
	Bar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 5 do
		Bar[i] = CreateFrame("StatusBar", "TukuiSoulShardBar"..i , Bar)
		Bar[i]:Height(8)
		Bar[i]:SetStatusBarTexture(PowerTexture)

		if i == 1 then
			Bar[i]:Width((250 / 5))
			Bar[i]:SetPoint("LEFT", Bar, "LEFT", 0, 0)
		elseif i == 5 then
			Bar[i]:Point("LEFT", Bar[i-1], "RIGHT", 1, 0)
			Bar[i]:Point("RIGHT", 0, 0)
		else
			Bar[i]:Width((250 / 5) - 1)
			Bar[i]:SetPoint("LEFT", Bar[i-1], "RIGHT", 1, 0)
		end

		Bar[i].bg = Bar[i]:CreateTexture(nil, "ARTWORK")
	end

	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)

	-- Register
	self.SoulShards = Bar
end
