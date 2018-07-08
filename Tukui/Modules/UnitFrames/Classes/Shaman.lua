local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "SHAMAN") then
	return
end

TukuiUnitFrames.AddClassFeatures["SHAMAN"] = function(self)
	if (C.UnitFrames.TotemBar) then
		local Bar = CreateFrame("Frame", "TukuiTotemBar", self)
		Bar:SetFrameStrata(self:GetFrameStrata())
		Bar:Point("TOPLEFT", Minimap, "BOTTOMLEFT", -1, -42)
		Bar:Size(Minimap:GetWidth(), 16)

		Bar.activeTotems = 0
		Bar.Override = TukuiUnitFrames.UpdateTotemOverride

		-- Totem Bar
		for i = 1, MAX_TOTEMS do
			Bar[i] = CreateFrame("StatusBar", "TukuiTotemBarSlot"..i, Bar)
			Bar[i]:SetTemplate()
			Bar[i]:Height(32)
			Bar[i]:Width(32)
			Bar[i]:SetStatusBarTexture(PowerTexture)
			Bar[i]:EnableMouse(true)
			Bar[i]:SetFrameLevel(Health:GetFrameLevel())
			Bar[i]:CreateShadow()
			Bar[i]:IsMouseEnabled(true)

			if i == 1 then
				Bar[i]:Point("BOTTOMRIGHT", Bar, "BOTTOMRIGHT", 0, 0)
			else
				Bar[i]:Point("BOTTOMRIGHT", Bar[i-1], "BOTTOMRIGHT", -36, 0)
			end

			Bar[i]:SetMinMaxValues(0, 1)

			Bar[i].Icon = Bar[i]:CreateTexture(nil, "BORDER")
			Bar[i].Icon:SetInside()
			Bar[i].Icon:SetAlpha(1)
			Bar[i].Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
		
		Movers:RegisterFrame(Bar)

		self.Totems = Bar
	end
end
