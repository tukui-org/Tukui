--[[
	NOTE FOR ME:
 
	Pet Battles UI is loaded directly on initial login and 
	is temporary for Beta. Pet Battles UI will go "Load on Demand" 
	on a future MoP beta build, so don't forget to modify loading parameters.
--]]

----------------------------------------------
-- Pet Battles UI ----------------------------
----------------------------------------------

local T, C, L, G = unpack(select(2, ...)) 
local f = PetBattleFrame
local bf = f.BottomFrame
local pets = {
	f.ActiveAlly,
	f.ActiveEnemy
}

-- GENERAL
f:StripTextures()

-- PETS UNITFRAMES
for i, pet in pairs(pets) do
	pet.Border:SetAlpha(0)
	pet.Border2:SetAlpha(0)
	pet.healthBarWidth = 300

	pet.Name:SetFont(C.media.font, 12, "OUTLINE")

	pet.IconBackdrop = CreateFrame("Frame", nil, pet)
	pet.IconBackdrop:SetFrameLevel(pet:GetFrameLevel() - 1)
	pet.IconBackdrop:SetOutside(pet.Icon)
	pet.IconBackdrop:SetTemplate()

	pet.HealthBarBG:Kill()
	pet.HealthBarFrame:Kill()
	pet.HealthBarBackdrop = CreateFrame("Frame", nil, pet)
	pet.HealthBarBackdrop:SetFrameLevel(pet:GetFrameLevel() - 1)
	pet.HealthBarBackdrop:SetTemplate("Transparent")
	pet.HealthBarBackdrop:Width(pet.healthBarWidth + 4)
	pet.ActualHealthBar:SetTexture(C.media.normTex)

	pet.ActualHealthBar:ClearAllPoints()
	pet.Name:ClearAllPoints()

	pet.PetTypeFrame = CreateFrame("Frame", nil, pet)
	pet.PetTypeFrame:Size(100, 23)
	pet.PetTypeFrame:FontString("text", C.media.font, 12, "OUTLINE")
	pet.PetTypeFrame.text:SetText("")

	-- hide original speed icon, create our after
	-- we dont kill it because we still need it, even if never show
	pet.SpeedIcon:SetAlpha(0)
	pet.SpeedUnderlay:SetAlpha(0)

	pet.FirstAttack = pet:CreateTexture(nil, "ARTWORK")
	pet.FirstAttack:Size(30)
	pet.FirstAttack:SetTexture("Interface\\PetBattles\\PetBattle-StatIcons")
	pet.FirstAttack:Hide()

	if i == 1 then
		pet.HealthBarBackdrop:Point("TOPLEFT", pet.ActualHealthBar, "TOPLEFT", -2, 2)
		pet.HealthBarBackdrop:Point("BOTTOMLEFT", pet.ActualHealthBar, "BOTTOMLEFT", -2, -2)
		pet.ActualHealthBar:SetVertexColor(171/255, 214/255, 116/255)
		f.Ally2.iconPoint = pet.IconBackdrop
		f.Ally3.iconPoint = pet.IconBackdrop

		pet.ActualHealthBar:Point("BOTTOMLEFT", pet.Icon, "BOTTOMRIGHT", 10, 0)
		pet.Name:Point("BOTTOMLEFT", pet.ActualHealthBar, "TOPLEFT", 0, 10)

		pet.PetTypeFrame:SetPoint("BOTTOMRIGHT",pet.HealthBarBackdrop, "TOPRIGHT", -2, 3)
		pet.PetTypeFrame.text:SetPoint("RIGHT")

		pet.FirstAttack:SetPoint("LEFT", pet.HealthBarBackdrop, "RIGHT", 5, 0)
		pet.FirstAttack:SetTexCoord(pet.SpeedIcon:GetTexCoord())
		pet.FirstAttack:SetVertexColor(.1,.1,.1,1)
	else
		pet.HealthBarBackdrop:Point("TOPRIGHT", pet.ActualHealthBar, "TOPRIGHT", 2, 2)
		pet.HealthBarBackdrop:Point("BOTTOMRIGHT", pet.ActualHealthBar, "BOTTOMRIGHT", 2, -2)
		pet.ActualHealthBar:SetVertexColor(196/255,  30/255,  60/255)
		f.Enemy2.iconPoint = pet.IconBackdrop
		f.Enemy3.iconPoint = pet.IconBackdrop

		pet.ActualHealthBar:Point("BOTTOMRIGHT", pet.Icon, "BOTTOMLEFT", -10, 0)
		pet.Name:Point("BOTTOMRIGHT", pet.ActualHealthBar, "TOPRIGHT", 0, 10)

		pet.PetTypeFrame:SetPoint("BOTTOMLEFT",pet.HealthBarBackdrop, "TOPLEFT", 2, 3)
		pet.PetTypeFrame.text:SetPoint("LEFT")

		pet.FirstAttack:SetPoint("RIGHT", pet.HealthBarBackdrop, "LEFT", -5, 0)
		pet.FirstAttack:SetTexCoord(.5, 0, .5, 1)
		pet.FirstAttack:SetVertexColor(.1,.1,.1,1)
	end

	pet.PetType:ClearAllPoints()
	pet.PetType:SetAllPoints(pet.PetTypeFrame)
	pet.PetType:SetFrameLevel(pet.PetTypeFrame:GetFrameLevel() + 2)
	pet.PetType:SetAlpha(0)

	pet.HealthText:ClearAllPoints()
	pet.HealthText:SetPoint("CENTER", pet.HealthBarBackdrop, "CENTER")

	pet.LevelUnderlay:SetAlpha(0)
	pet.Level:SetFontObject(NumberFont_Outline_Large)
	pet.Level:ClearAllPoints()
	pet.Level:Point("BOTTOMLEFT", pet.Icon, "BOTTOMLEFT", 2, 2)
	
	pet.BorderFlash:Kill()
end

-- PETS SPEED INDICATOR UPDATE
hooksecurefunc("PetBattleFrame_UpdateSpeedIndicators", function(self)
	if not f.ActiveAlly.SpeedIcon:IsShown() and not f.ActiveEnemy.SpeedIcon:IsShown() then
		f.ActiveAlly.FirstAttack:Hide()
		f.ActiveEnemy.FirstAttack:Hide()
		return
	end

	for i, pet in pairs(pets) do
		pet.FirstAttack:Show()
		if pet.SpeedIcon:IsShown() then
			pet.FirstAttack:SetVertexColor(0,1,0,1)
		else
			pet.FirstAttack:SetVertexColor(.8,0,.3,1)
		end
	end
end)

-- PETS UNITFRAMES PET TYPE UPDATE
hooksecurefunc("PetBattleUnitFrame_UpdatePetType", function(self)
	if self.PetType then
		local petType = C_PetBattles.GetPetType(self.petOwner, self.petIndex)
		if self.PetTypeFrame then
			self.PetTypeFrame.text:SetText(PET_TYPE_SUFFIX[petType])
		end
	end
end)

-- PETS UNITFRAMES AURA SKINS
hooksecurefunc("PetBattleAuraHolder_Update", function(self)
	if not self.petOwner or not self.petIndex then return end

	local nextFrame = 1
	for i=1, C_PetBattles.GetNumAuras(self.petOwner, self.petIndex) do
		local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(self.petOwner, self.petIndex, i)
		if (isBuff and self.displayBuffs) or (not isBuff and self.displayDebuffs) then
			local frame = self.frames[nextFrame]

			-- always hide the border
			frame.DebuffBorder:Hide()

			if not frame.isSkinned then
				frame:CreateBackdrop()
				frame.backdrop:SetOutside(frame.Icon)
				frame.Icon:SetTexCoord(.1,.9,.1,.9)
			end

			if isBuff then
				frame.backdrop:SetBackdropBorderColor(0, 1, 0)
			else
				frame.backdrop:SetBackdropBorderColor(1, 0, 0)
			end
			
			if turnsRemaining > 0 then
				frame.Duration:SetText(turnsRemaining)
			end
			
			frame.Duration:SetFont(C.media.font, 14, "OUTLINE")
			frame.Duration:ClearAllPoints()
			frame.Duration:SetPoint("CENTER", frame.Icon, "CENTER", 1, 0)
		
			nextFrame = nextFrame + 1
		end
	end
end)

-- PETS UNITFRAMES, ALWAYS HIDE BLIZZARD ICONS BORDER
hooksecurefunc("PetBattleUnitFrame_UpdateDisplay", function(self)
	self.Icon:SetTexCoord(.1,.9,.1,.9)
end)

-- REPOSITION "VS" TEXT
f.TopVersusText:ClearAllPoints()
f.TopVersusText:SetPoint("TOP", f, "TOP", 0, -46)

-- TOOLTIPS SKINNING
local tooltips = {PetBattlePrimaryAbilityTooltip, PetBattlePrimaryUnitTooltip, FloatingBattlePetTooltip, BattlePetTooltip , FloatingPetBattleAbilityTooltip}

for i, tt in pairs(tooltips) do
	tt.Background:SetTexture(nil)
	
	if tt.Delimiter1 then
		tt.Delimiter1:SetTexture(nil)
		tt.Delimiter2:SetTexture(nil)
	elseif tt.Delimiter then
		tt.Delimiter:SetTexture(nil)
	end
	
	tt.BorderTop:SetTexture(nil)
	tt.BorderTopLeft:SetTexture(nil)
	tt.BorderTopRight:SetTexture(nil)
	tt.BorderLeft:SetTexture(nil)
	tt.BorderRight:SetTexture(nil)
	tt.BorderBottom:SetTexture(nil)
	tt.BorderBottomRight:SetTexture(nil)
	tt.BorderBottomLeft:SetTexture(nil)
	tt:SetTemplate()
	
	if tt.CloseButton then
		tt.CloseButton:SkinCloseButton()
	end
end

-- TOOLTIP DEFAULT POSITION
hooksecurefunc("PetBattleAbilityTooltip_Show", function()
	local t = PetBattlePrimaryAbilityTooltip
	local a = TukuiInfoLeft
	if a then
		t:ClearAllPoints()
		t:SetPoint("BOTTOMLEFT", a, "TOPLEFT", 0, 6)
	end
end)

-- Pets #2 and #3
local morepets = {
	f.Ally2,
	f.Ally3,
	f.Enemy2,
	f.Enemy3
}

for i, pet in pairs(morepets) do
	pet.BorderAlive:SetAlpha(0)
	pet.HealthBarBG:SetAlpha(0)
	pet.HealthDivider:SetAlpha(0)
	pet:Size(40)
	pet:CreateBackdrop()
	pet:ClearAllPoints()

	pet.healthBarWidth = 40
	pet.ActualHealthBar:ClearAllPoints()
	pet.ActualHealthBar:SetPoint("TOPLEFT", pet.backdrop, "BOTTOMLEFT", 2, -3)

	pet.HealthBarBackdrop = CreateFrame("Frame", nil, pet)
	pet.HealthBarBackdrop:SetFrameLevel(pet:GetFrameLevel() - 1)
	pet.HealthBarBackdrop:SetTemplate("Default")
	pet.HealthBarBackdrop:Width(pet.healthBarWidth + 4)
	pet.HealthBarBackdrop:Point("TOPLEFT", pet.ActualHealthBar, "TOPLEFT", -2, 2)
	pet.HealthBarBackdrop:Point("BOTTOMLEFT", pet.ActualHealthBar, "BOTTOMLEFT", -2, -1)
end

f.Ally2:SetPoint("TOPRIGHT", f.Ally2.iconPoint, "TOPLEFT", -6, -2)
f.Ally3:SetPoint("TOPRIGHT", f.Ally2, "TOPLEFT", -8, 0)
f.Enemy2:SetPoint("TOPLEFT", f.Enemy2.iconPoint, "TOPRIGHT", 6, -2)
f.Enemy3:SetPoint("TOPLEFT", f.Enemy2, "TOPRIGHT", 8, 0)

-- WEATHER
hooksecurefunc("PetBattleWeatherFrame_Update", function(self)
	local weather = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_WEATHER, PET_BATTLE_PAD_INDEX, 1)
	if weather then
		self.Icon:Hide()
		self.Name:Hide()
		self.DurationShadow:Hide()
		self.Label:Hide()
		self.Duration:SetPoint("CENTER", self, 0, 8)
		self:ClearAllPoints()
		self:SetPoint("TOP", UIParent, 0, -15)
	end
end)

---------------------------------
-- PET BATTLE ACTION BAR SETUP --
---------------------------------

local bar = CreateFrame("Frame", "TukuiPetBattleActionBar", UIParent, "SecureHandlerStateTemplate")
bar:SetSize (52*6 + 7*10, 52 * 1 + 10*2)
bar:EnableMouse(true)
bar:SetTemplate()
bar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 14)
bar:Hide()

RegisterStateDriver(bar, "visibility", "[petbattle] show; hide")

bf:StripTextures()
bf.TurnTimer:StripTextures()
bf.TurnTimer.SkipButton:SetParent(bar)
bf.TurnTimer.SkipButton:SkinButton()
bf.TurnTimer.SkipButton:Width(bar:GetWidth())
bf.TurnTimer.SkipButton:Height(21)
bf.TurnTimer.SkipButton:ClearAllPoints()
bf.TurnTimer.SkipButton:SetPoint("BOTTOM", bar, "TOP", 0, 2)
bf.TurnTimer.SkipButton.ClearAllPoints = T.dummy
bf.TurnTimer.SkipButton.SetPoint = T.dummy

bf.TurnTimer:SetParent(bar)
bf.TurnTimer:SetTemplate()
bf.TurnTimer:Size(bf.TurnTimer.SkipButton:GetWidth(), bf.TurnTimer.SkipButton:GetHeight())
bf.TurnTimer:ClearAllPoints()
bf.TurnTimer:SetPoint("BOTTOM", bf.TurnTimer.SkipButton, "TOP", 0, 2)
bf.TurnTimer.TimerText:SetPoint("CENTER")

bf.MicroButtonFrame:StripTextures()
bf.MicroButtonFrame:Hide()
bf.Delimiter:StripTextures()
bf.FlowFrame:Kill()
bf.xpBar:SetParent(bar)
bf.xpBar:Width(bar:GetWidth() - 4)
bf.xpBar:CreateBackdrop()
bf.xpBar:ClearAllPoints()
bf.xpBar:SetPoint("BOTTOM", bf.TurnTimer, "TOP", 0, 4)
bf.xpBar:SetScript("OnShow", function(self) self:StripTextures() self:SetStatusBarTexture(C.media.normTex) end)

-- PETS SELECTION SKIN
for i = 1, 3 do
	local pet = bf.PetSelectionFrame["Pet"..i]

	pet.HealthBarBG:SetAlpha(0)
	pet.HealthDivider:SetAlpha(0)
	pet.ActualHealthBar:SetAlpha(0)
	pet.SelectedTexture:SetAlpha(0)
	pet.MouseoverHighlight:SetAlpha(0)
	pet.Framing:SetAlpha(0)
	pet.Icon:SetAlpha(0)
	pet.Name:SetAlpha(0)
	pet.DeadOverlay:SetAlpha(0)
	pet.Level:SetAlpha(0)
	pet.HealthText:SetAlpha(0)
end

-- MOVE DEFAULT POSITION OF PETS SELECTION
hooksecurefunc("PetBattlePetSelectionFrame_Show", function()
	bf.PetSelectionFrame:ClearAllPoints()
	bf.PetSelectionFrame:SetPoint("BOTTOM", bf.xpBar, "TOP", 0, 8)
end)

-- FUNCTION TO SKIN PET ACTION BUTTONS
local function SkinPetButton(self)
	self:CreateBackdrop()
	self:SetNormalTexture("")
	self.Icon:SetTexCoord(.1,.9,.1,.9)
	self:StyleButton()
	self.SelectedHighlight:SetTexture(0.9, 0.8, 0.1, 0.3)
	self.SelectedHighlight:SetInside(self.backdrop)
	self.pushed:SetInside(self.backdrop)
	self.hover:SetInside(self.backdrop)
	
	if self.BetterIcon then
		self.BetterIcon:ClearAllPoints()
		self.BetterIcon:SetPoint("CENTER", self)
	end
end

-- SETUP OUR PET ACTION BAR
hooksecurefunc("PetBattleFrame_UpdateActionBarLayout", function(self)
	for i=1, NUM_BATTLE_PET_ABILITIES do
		local b = bf.abilityButtons[i]
		b.checked = true
		SkinPetButton(b)
		b:SetParent(bar)
		b:ClearAllPoints()
		if i == 1 then
			b:SetPoint("BOTTOMLEFT", 10, 10)
		else
			local previous = bf.abilityButtons[i-1]
			b:SetPoint("LEFT", previous, "RIGHT", 10, 0)
		end
	end
	
	SkinPetButton(bf.SwitchPetButton)
	bf.SwitchPetButton:SetParent(bar)
	bf.SwitchPetButton:ClearAllPoints()
	bf.SwitchPetButton.checked:SetInside(bf.SwitchPetButton.backdrop)
	bf.SwitchPetButton:SetPoint("LEFT", bf.abilityButtons[3], "RIGHT", 10, 0)
	bf.SwitchPetButton:SetScript("OnClick", function(self)
		if bf.PetSelectionFrame:IsShown() then
			PetBattlePetSelectionFrame_Hide(bf.PetSelectionFrame)
		else
			PetBattlePetSelectionFrame_Show(bf.PetSelectionFrame)
		end
	end)

	SkinPetButton(bf.SwitchPetButton)
	bf.CatchButton:SetParent(bar)
	bf.CatchButton:ClearAllPoints()
	bf.CatchButton:SetPoint("LEFT", bf.SwitchPetButton, "RIGHT", 10, 0)
	SkinPetButton(bf.CatchButton)
	bf.ForfeitButton:SetParent(bar)
	bf.ForfeitButton:ClearAllPoints()
	bf.ForfeitButton:SetPoint("LEFT", bf.CatchButton, "RIGHT", 10, 0)
	SkinPetButton(bf.ForfeitButton)
end)

G.PetBattle = {}
G.PetBattle.TopFrame = f
G.PetBattle.BottomFrame = bf
G.PetBattle.Ally = f.ActiveAlly
G.PetBattle.Enemy = f.ActiveEnemy
G.PetBattle.AbilityTooltip = PetBattlePrimaryAbilityTooltip
G.PetBattle.UnitTooltip = PetBattlePrimaryUnitTooltip
G.PetBattle.FloatingTooltip = FloatingBattlePetTooltip
G.PetBattle.PetTooltip = BattlePetTooltip
G.PetBattle.BottomFrame = bf
G.PetBattle.ActionBar = bar
G.PetBattle.ActionBar.Buttons = {bf.abilityButtons[1], bf.abilityButtons[2], bf.abilityButtons[3], bf.SwitchPetButton, bf.CatchButton, bf.ForfeitButton}