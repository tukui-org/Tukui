local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS

function ActionBars:MovePetButtons(button, i)
	local FakeButton = _G["TukuiPetActionBarButton"..i]
	local Button = button
	
	Button:ClearAllPoints()
	Button:SetAllPoints(FakeButton)
end

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
	
	PetActionBarFrame.ignoreFramePositionManager = true
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
	local NextRowButtonAnchor
	
	for i = 1, NUM_PET_ACTION_SLOTS do
		local FakeButton = CreateFrame("Frame", "TukuiPetActionBarButton"..i, TukuiPetActionBar)
		local Button = _G["PetActionButton"..i]
		local Icon = _G["PetActionButton"..i.."Icon"]
		local PreviousButton = _G["TukuiPetActionBarButton"..i-1]
		
		Button:SetParent(Bar)
		Button:ClearAllPoints()
		Button:SetSize(PetSize, PetSize)
		Button:SetNormalTexture("")
		Button:Show()
		
		FakeButton:SetSize(PetSize, PetSize)
		
		if (i == 1) then
			FakeButton:SetPoint("TOPLEFT", Bar, "TOPLEFT", Spacing, -Spacing)
			
			NextRowButtonAnchor = _G["TukuiPetActionBarButton1"]
		elseif (i == NumPerRows + 1) then
			FakeButton:SetPoint("TOPLEFT", NextRowButtonAnchor, "BOTTOMLEFT", 0, -Spacing)

			NumPerRows = NumPerRows + ButtonsPerRow
			
			NextRowButtonAnchor = _G["TukuiPetActionBarButton"..i]
		else
			FakeButton:SetPoint("LEFT", PreviousButton, "RIGHT", Spacing, 0)
		end
		
		ActionBars:MovePetButtons(Button, i)

		if T.Retail then
			hooksecurefunc(Button, "SetPoint", function(self)
				local ID = Button:GetID()

				if ID then
					ActionBars:MovePetButtons(Button, ID)
				end
			end)
		end

		Bar:SetAttribute("addchild", Button)
		Bar["Button"..i] = Button
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