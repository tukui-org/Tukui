local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS

function ActionBars:CreatePetBar()
	local Movers = T["Movers"]

	if (not C.ActionBars.Pet) then
		return
	end

	local PetSize = C.ActionBars.PetButtonSize
	local Spacing = C.ActionBars.ButtonSpacing
	local PetActionBarFrame = T.Retail and PetActionBar or PetActionBarFrame
	local PetActionBar_UpdateCooldowns = PetActionBar_UpdateCooldowns
	local ButtonsPerRow = C.ActionBars.BarPetButtonsPerRow
	local NumRow = ceil(10 / ButtonsPerRow)
	
	PetActionBarFrame:EnableMouse(false)
	PetActionBarFrame:ClearAllPoints()
	PetActionBarFrame:SetParent(T.Hider)
	PetActionBarFrame:UnregisterAllEvents()

	local Bar = CreateFrame("Frame", "TukuiPetActionBar", T.PetHider, "SecureHandlerStateTemplate")
	Bar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 28, 233)
	Bar:SetFrameStrata("LOW")
	Bar:SetFrameLevel(10)
	Bar:SetWidth((PetSize * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)))
	Bar:SetHeight((PetSize * NumRow) + (Spacing * (NumRow + 1)))
	
	self.Bars.Pet = Bar

	if C.ActionBars.ShowBackdrop then
		Bar:CreateBackdrop()
		Bar:CreateShadow()
	end
	
	local NumPerRows = ButtonsPerRow
	local NextRowButtonAnchor = _G["PetActionButton1"]

	for i = 1, NUM_PET_ACTION_SLOTS do
		local Button = _G["PetActionButton"..i]
		local PreviousButton = _G["PetActionButton"..i-1]

		Button:SetParent(Bar)
		Button:ClearAllPoints()
		Button:SetSize(PetSize, PetSize)
		Button:SetNormalTexture("")
		Button:Show()

		if (i == 1) then
			Button:SetPoint("TOPLEFT", Bar, "TOPLEFT", Spacing, -Spacing)
		elseif (i == NumPerRows + 1) then
			Button:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

			NumPerRows = NumPerRows + ButtonsPerRow
			NextRowButtonAnchor = _G["PetActionButton"..i]
		else
			Button:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end

		Bar:SetAttribute("addchild", Button)
		Bar["Button"..i] = Button
	end
	
	ActionBars:SkinPetButtons()
	
	ActionBars:RegisterEvent("PET_BAR_UPDATE", ActionBars.UpdatePetBar)
	ActionBars:RegisterEvent("PLAYER_CONTROL_GAINED", ActionBars.UpdatePetBar)
	ActionBars:RegisterEvent("PLAYER_CONTROL_LOST", ActionBars.UpdatePetBar)
	ActionBars:RegisterEvent("PLAYER_ENTERING_WORLD", ActionBars.UpdatePetBar)
	ActionBars:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED", ActionBars.UpdatePetBar)
	ActionBars:RegisterEvent("SPELLS_CHANGED", ActionBars.UpdatePetBar)
	ActionBars:RegisterEvent("UNIT_FLAGS", ActionBars.UpdatePetBar)
	ActionBars:RegisterEvent("UNIT_PET", ActionBars.UpdatePetBar)
	ActionBars:RegisterEvent("PET_BAR_UPDATE_COOLDOWN", ActionBars.UpdatePetBarCooldownText)
	
	RegisterStateDriver(Bar, "visibility", "[@pet,exists,nopossessbar] show; hide")

	Movers:RegisterFrame(Bar, "Pet Action Bar")
end