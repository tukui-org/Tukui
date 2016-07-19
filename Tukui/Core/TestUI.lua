local T, C, L = select(2, ...):unpack()

local TestUI = CreateFrame("Frame")

local Enabled = false

function TestUI:SetUnit()
	if Enabled then
		self.oldunit = self.unit
		self.unit = "player"
	else
		self.unit = self.oldunit
	end

	self:SetAttribute("unit", self.unit)
end

function TestUI:EnableOrDisable()
	local Frames = T["UnitFrames"].Units

	if (not Enabled and InCombatLockdown()) then
		return T.Print(ERR_NOT_IN_COMBAT)
	end

	if Enabled then
		Enabled = false
	else
		Enabled = true
	end

	for _, Frame in pairs(Frames) do
		local Unit = Frame

		if Frame.unit then
			self.SetUnit(Unit)
		else
			for i = 1, 5 do
				Unit = Frame[i]

				self.SetUnit(Unit)
			end
		end
	end
end

function TestUI:OnEvent(self, event)
	if Enabled then
		TestUI:EnableOrDisable()
	end
end

TestUI:RegisterEvent("PLAYER_REGEN_DISABLED")
TestUI:SetScript("OnEvent", TestUI.OnEvent)

T["TestUI"] = TestUI
