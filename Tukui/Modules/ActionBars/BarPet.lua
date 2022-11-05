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
	local PetActionBarFrame = PetActionBar or PetActionBarFrame
	local PetActionBar_UpdateCooldowns = PetActionBar_UpdateCooldowns
	local ButtonsPerRow = C.ActionBars.BarPetButtonsPerRow
	local NumRow = ceil(10 / ButtonsPerRow)

	local Bar = CreateFrame("Frame", "TukuiPetActionBar", T.PetHider, "SecureHandlerStateTemplate")
	Bar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 28, 233)
	Bar:SetFrameStrata("LOW")
	Bar:SetFrameLevel(10)
	Bar:SetWidth((PetSize * ButtonsPerRow) + (Spacing * (ButtonsPerRow + 1)))
	Bar:SetHeight((PetSize * NumRow) + (Spacing * (NumRow + 1)))
	
	self.Bars.Pet = Bar

	if not T.Retail and C.ActionBars.ShowBackdrop then
		Bar:CreateBackdrop()
		Bar:CreateShadow()
	end

	PetActionBarFrame:EnableMouse(false)
	PetActionBarFrame:ClearAllPoints()
	PetActionBarFrame:SetParent(Bar)
	
	if not T.Retail then
		ActionBars:UpdatePetBarButtons()
	end

	-- overwrite PetActionBar_Update, causing a lot of taint with original
	PetActionBar_Update = ActionBars.UpdatePetBar

	if not T.Retail then
		hooksecurefunc("PetActionBar_UpdateCooldowns", ActionBars.UpdatePetBarCooldownText)
	end

	ActionBars:SkinPetButtons()

	RegisterStateDriver(Bar, "visibility", "[@pet,exists,nopossessbar] show; hide")

	Movers:RegisterFrame(Bar, "Pet Action Bar")
end