local T, C, L = select(2, ...):unpack()

local TukuiUnitFrames = T["UnitFrames"]
local Class = select(2, UnitClass("player"))

if (Class ~= "ROGUE") then
	return
end

TukuiUnitFrames.AddClassFeatures["ROGUE"] = function(self)
	if (C.UnitFrames.AnticipationBar) then
		local PowerTexture = T.GetTexture(C["UnitFrames"].PowerTexture)

		local AnticipationBar = CreateFrame("Frame", self:GetName()..'AnticipationBar', self)
		AnticipationBar:SetFrameStrata(self:GetFrameStrata())
		AnticipationBar:SetFrameLevel(self:GetFrameLevel())
		AnticipationBar:Point("BOTTOMLEFT", self, "TOPLEFT", 0, 1)
		AnticipationBar:Width(250)
		AnticipationBar:Height(8)
		AnticipationBar:SetBackdrop(TukuiUnitFrames.Backdrop)
		AnticipationBar:SetBackdropColor(0, 0, 0)
		AnticipationBar:SetBackdropBorderColor(unpack(C["General"].BorderColor))

		for i = 1, 5 do
			AnticipationBar[i] = CreateFrame("StatusBar", self:GetName()..'Anticipation'..i, AnticipationBar)
			AnticipationBar[i]:Height(8)
			AnticipationBar[i]:SetStatusBarTexture(PowerTexture)
	
			if i == 1 then
				AnticipationBar[i]:Point("LEFT", AnticipationBar, "LEFT", 0, 0)
				AnticipationBar[i]:Width(250 / 5)
			else
				AnticipationBar[i]:Point("LEFT", AnticipationBar[i-1], "RIGHT", 1, 0)
				AnticipationBar[i]:Width(250 / 5 - 1)
			end					
		end
	
		AnticipationBar:SetScript("OnShow", function(self) 
			TukuiUnitFrames.UpdateShadow(self, 12)
		end)

		AnticipationBar:SetScript("OnHide", function(self)
			TukuiUnitFrames.UpdateShadow(self, 4)
		end)

		self.AnticipationBar = AnticipationBar
	end
end