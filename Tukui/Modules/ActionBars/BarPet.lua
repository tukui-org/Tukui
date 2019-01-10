local T, C, L = select(2, ...):unpack()

local TukuiActionBars = T["ActionBars"]
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS

function TukuiActionBars:CreatePetBar()
	local Bar = T.Panels.PetActionBar
	local Movers = T["Movers"]

	if (not C.ActionBars.Pet) then
		Bar.Backdrop:StripTextures()

		return
	end

	local PetSize = C.ActionBars.PetButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local PetActionBarFrame = PetActionBarFrame
	local PetActionBar_UpdateCooldowns = PetActionBar_UpdateCooldowns

	for i = 1, NUM_PET_ACTION_SLOTS do
		local Button = _G["PetActionButton"..i]
		Button:ClearAllPoints()
		Button:SetParent(Bar)
		Button:Size(PetSize)
		Button:SetNormalTexture("")
		Button:Show()

		if (i == 1) then
			Button:SetPoint("TOPLEFT", Spacing, -Spacing)

			Bar:SetWidth(Button:GetWidth() + (Spacing * 2))
			Bar:SetHeight((Button:GetWidth() * 10) + (Spacing * 11))
		else
			Button:SetPoint("TOP", _G["PetActionButton"..(i - 1)], "BOTTOM", 0, -Spacing)
		end

		Bar:SetAttribute("addchild", Button)
		Bar["Button"..i] = Button
	end

	PetActionBarFrame:EnableMouse(0)
	PetActionBarFrame:ClearAllPoints()
	PetActionBarFrame:SetParent(T.Panels.Hider)

	hooksecurefunc("PetActionBar_Update", TukuiActionBars.UpdatePetBar)

	TukuiActionBars:SkinPetButtons()

	RegisterStateDriver(Bar, "visibility", "[pet,nopetbattle,novehicleui,nooverridebar,nopossessbar,nobonusbar:5] show; hide")

	Movers:RegisterFrame(Bar)
end
