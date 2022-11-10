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
		local Icon = _G["PetActionButton"..i.."Icon"]
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

		-- stop randomly moving these buttons, WTF
		if T.Retail then
			Button.SetPoint = function() return end
		end
	end
	
	ActionBars:SkinPetButtons()
	
	if T.Retail then
		self:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR")
	end

	self:RegisterEvent("PLAYER_CONTROL_LOST")
	self:RegisterEvent("PLAYER_CONTROL_GAINED")
	self:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
	self:RegisterEvent("UNIT_PET")
	self:RegisterEvent("UNIT_FLAGS")
	self:RegisterEvent("PET_BAR_UPDATE")
	self:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
	self:RegisterEvent("PET_BAR_UPDATE_USABLE")
	self:RegisterEvent("PET_UI_UPDATE")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
	self:SetScript("OnEvent", function(self, event, ...)
		if event == "PET_BAR_UPDATE_COOLDOWN" then
			self:UpdatePetBarCooldownText()
		end
			
		self:UpdatePetBar()
	end)
	
	RegisterStateDriver(Bar, "visibility", "[@pet,exists,nopossessbar] show; hide")

	Movers:RegisterFrame(Bar, "Pet Action Bar")
end