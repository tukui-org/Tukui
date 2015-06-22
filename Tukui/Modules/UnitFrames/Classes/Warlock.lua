local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "WARLOCK") then
	return
end

TukuiUnitFrames.AddClassFeatures["WARLOCK"] = function(self)
	local Bar = CreateFrame("Frame", self:GetName()..'WarlockSpecBars', self)
	local Shadow = self.Shadow
	local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)

	-- Warlock Class Bar
	Bar:SetFrameStrata(self:GetFrameStrata())
	Bar:SetFrameLevel(self:GetFrameLevel())
	Bar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
	Bar:SetWidth(250)
	Bar:SetHeight(8)
	Bar:SetBackdrop(TukuiUnitFrames.Backdrop)
	Bar:SetBackdropColor(0, 0, 0)
	Bar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		Bar[i] = CreateFrame("StatusBar", nil, Bar)
		Bar[i]:Height(8)
		Bar[i]:SetStatusBarTexture(PowerTexture)

		if i == 1 then
			Bar[i]:Width((250 / 4) - 2)
			Bar[i]:SetPoint("LEFT", Bar, "LEFT", 0, 0)
		else
			Bar[i]:Width((250 / 4) - 1)
			Bar[i]:SetPoint("LEFT", Bar[i-1], "RIGHT", 1, 0)
		end

		Bar[i].bg = Bar[i]:CreateTexture(nil, "ARTWORK")
	end

	-- Shadow Effect Updates
	Shadow:Point("TOPLEFT", -4, 12)

	Bar:SetScript("OnShow", function(self)
		TukuiUnitFrames.UpdateShadow(self, 12)
	end)

	Bar:SetScript("OnHide", function(self)
		TukuiUnitFrames.UpdateShadow(self, 4)
	end)

	-- Register
	self.WarlockSpecBars = Bar
end