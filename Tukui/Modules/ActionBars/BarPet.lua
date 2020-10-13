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
	local PetActionBarFrame = PetActionBarFrame
	local PetActionBar_UpdateCooldowns = PetActionBar_UpdateCooldowns
	
	local Bar = CreateFrame("Frame", "TukuiPetActionBar", T.PetHider, "SecureHandlerStateTemplate")
	Bar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 28, 213)
	Bar:SetFrameStrata("LOW")
	Bar:SetFrameLevel(10)
	Bar:SetWidth((PetSize * 5) + (Spacing * 6))
	Bar:SetHeight((PetSize * 2) + (Spacing * 3))
	
	if C.ActionBars.ShowBackdrop then
		Bar:CreateBackdrop()
		Bar:CreateShadow()
	end

	PetActionBarFrame:EnableMouse(0)
	PetActionBarFrame:ClearAllPoints()
	PetActionBarFrame:SetParent(T.Hider)

	for i = 1, NUM_PET_ACTION_SLOTS do
		local Button = _G["PetActionButton"..i]
		Button:SetParent(Bar)
		Button:ClearAllPoints()
		Button:SetSize(PetSize, PetSize)
		Button:SetNormalTexture("")
		Button:Show()

		if (i == 1) then
			Button:SetPoint("TOPLEFT", Bar, "TOPLEFT", Spacing, -Spacing)
		elseif (i == 6) then
			Button:SetPoint("TOP", _G["PetActionButton1"], "BOTTOM", 0, -Spacing)
		else
			Button:SetPoint("LEFT", _G["PetActionButton"..(i - 1)], "RIGHT", Spacing, 0)
		end
		
		if Button:IsEventRegistered("UPDATE_BINDINGS") then
			Button:UnregisterEvent("UPDATE_BINDINGS")
		end

		Bar:SetAttribute("addchild", Button)
		Bar["Button"..i] = Button
	end

	hooksecurefunc("PetActionBar_Update", ActionBars.UpdatePetBar)

	ActionBars:SkinPetButtons()

	RegisterStateDriver(Bar, "visibility", "[@pet,exists,nopossessbar] show; hide")

	Movers:RegisterFrame(Bar)
	
	self.Bars.Pet = Bar
end
