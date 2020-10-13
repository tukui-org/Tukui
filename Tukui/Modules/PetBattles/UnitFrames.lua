local T, C, L = select(2, ...):unpack()
local Battle = T["PetBattles"]
local PetBattles = PetBattleFrame

local Pets = {
	PetBattles.ActiveAlly,
	PetBattles.ActiveEnemy,
}

local PetsHelping = {
	PetBattles.Ally2,
	PetBattles.Ally3,
	PetBattles.Enemy2,
	PetBattles.Enemy3
}

function Battle:SkinUnitFrames()
	for i, Pet in pairs(Pets) do
		Pet.Border:SetAlpha(0)
		Pet.Border2:SetAlpha(0)
		Pet.healthBarWidth = 300

		Pet.Name:SetFont(C.Medias.Font, 12, "OUTLINE")

		Pet.IconBackdrop = CreateFrame("Frame", nil, Pet)
		Pet.IconBackdrop:SetFrameLevel(Pet:GetFrameLevel() - 1)
		Pet.IconBackdrop:SetOutside(Pet.Icon)
		Pet.IconBackdrop:CreateBackdrop()
		Pet.IconBackdrop:CreateShadow()

		Pet.HealthBarBG:Kill()
		Pet.HealthBarFrame:Kill()

		Pet.HealthBarBackdrop = CreateFrame("Frame", nil, Pet)
		Pet.HealthBarBackdrop:SetFrameLevel(Pet:GetFrameLevel() - 1)
		Pet.HealthBarBackdrop:CreateBackdrop("Transparent")
		Pet.HealthBarBackdrop:CreateShadow()
		Pet.HealthBarBackdrop:SetWidth(Pet.healthBarWidth + 4)

		Pet.ActualHealthBar:SetTexture(C.Medias.Normal)

		Pet.ActualHealthBar:ClearAllPoints()
		Pet.Name:ClearAllPoints()

		Pet.PetTypeFrame = CreateFrame("Frame", nil, Pet)
		Pet.PetTypeFrame:SetSize(100, 23)
		Pet.PetTypeFrame.Text = Pet.PetTypeFrame:CreateFontString(nil, "OVERLAY")
		Pet.PetTypeFrame.Text:SetFont(C.Medias.Font, 12, "THINOUTLINE") 
		Pet.PetTypeFrame.Text:SetText("")

		Pet.SpeedIcon:SetAlpha(0)
		Pet.SpeedUnderlay:SetAlpha(0)

		Pet.FirstAttack = Pet:CreateTexture(nil, "ARTWORK")
		Pet.FirstAttack:SetSize(30, 30)
		Pet.FirstAttack:SetTexture("Interface\\PetBattles\\PetBattle-StatIcons")
		Pet.FirstAttack:Hide()

		if (i == 1) then
			Pet.HealthBarBackdrop:SetPoint("TOPLEFT", Pet.ActualHealthBar, "TOPLEFT", -2, 2)
			Pet.HealthBarBackdrop:SetPoint("BOTTOMLEFT", Pet.ActualHealthBar, "BOTTOMLEFT", -2, -2)
			Pet.ActualHealthBar:SetVertexColor(171 / 255, 214 / 255, 116 / 255)
			PetBattles.Ally2.iconPoint = Pet.IconBackdrop
			PetBattles.Ally3.iconPoint = Pet.IconBackdrop

			Pet.ActualHealthBar:SetPoint("BOTTOMLEFT", Pet.Icon, "BOTTOMRIGHT", 10, 0)
			Pet.Name:SetPoint("BOTTOMLEFT", Pet.ActualHealthBar, "TOPLEFT", 0, 10)

			Pet.PetTypeFrame:SetPoint("BOTTOMRIGHT",Pet.HealthBarBackdrop, "TOPRIGHT", -2, 3)
			Pet.PetTypeFrame.Text:SetPoint("RIGHT")

			Pet.FirstAttack:SetPoint("LEFT", Pet.HealthBarBackdrop, "RIGHT", 5, 0)
			Pet.FirstAttack:SetTexCoord(Pet.SpeedIcon:GetTexCoord())
			Pet.FirstAttack:SetVertexColor(.1,.1,.1,1)
		else
			Pet.HealthBarBackdrop:SetPoint("TOPRIGHT", Pet.ActualHealthBar, "TOPRIGHT", 2, 2)
			Pet.HealthBarBackdrop:SetPoint("BOTTOMRIGHT", Pet.ActualHealthBar, "BOTTOMRIGHT", 2, -2)
			Pet.ActualHealthBar:SetVertexColor(196 / 255, 30 / 255, 60 / 255)
			PetBattles.Enemy2.iconPoint = Pet.IconBackdrop
			PetBattles.Enemy3.iconPoint = Pet.IconBackdrop

			Pet.ActualHealthBar:SetPoint("BOTTOMRIGHT", Pet.Icon, "BOTTOMLEFT", -10, 0)
			Pet.Name:SetPoint("BOTTOMRIGHT", Pet.ActualHealthBar, "TOPRIGHT", 0, 10)

			Pet.PetTypeFrame:SetPoint("BOTTOMLEFT",Pet.HealthBarBackdrop, "TOPLEFT", 2, 3)
			Pet.PetTypeFrame.Text:SetPoint("LEFT")

			Pet.FirstAttack:SetPoint("RIGHT", Pet.HealthBarBackdrop, "LEFT", -5, 0)
			Pet.FirstAttack:SetTexCoord(.5, 0, .5, 1)
			Pet.FirstAttack:SetVertexColor(.1,.1,.1,1)
		end

		Pet.PetType:ClearAllPoints()
		Pet.PetType:SetAllPoints(Pet.PetTypeFrame)
		Pet.PetType:SetFrameLevel(Pet.PetTypeFrame:GetFrameLevel() + 2)
		Pet.PetType:SetAlpha(0)

		Pet.HealthText:ClearAllPoints()
		Pet.HealthText:SetPoint("CENTER", Pet.HealthBarBackdrop, "CENTER")

		Pet.LevelUnderlay:SetAlpha(0)
		Pet.Level:SetFontObject(NumberFont_Outline_Large)
		Pet.Level:ClearAllPoints()
		Pet.Level:SetPoint("BOTTOMLEFT", Pet.Icon, "BOTTOMLEFT", 2, 2)

		Pet.BorderFlash:Kill()
	end

	PetBattles.TopVersusText:ClearAllPoints()
	--PetBattles.TopVersusText:SetPoint("TOP", f, "TOP", 0, -46) -- Global lookup: f

	for i, Pet in pairs(PetsHelping) do
		Pet.BorderAlive:SetAlpha(0)
		Pet.HealthBarBG:SetAlpha(0)
		Pet.HealthDivider:SetAlpha(0)
		Pet:SetSize(40, 40)
		Pet:CreateBackdrop()
		Pet:ClearAllPoints()

		Pet.healthBarWidth = 40
		Pet.ActualHealthBar:ClearAllPoints()
		Pet.ActualHealthBar:SetPoint("TOPLEFT", Pet.Backdrop, "BOTTOMLEFT", 2, -3)

		Pet.HealthBarBackdrop = CreateFrame("Frame", nil, Pet)
		Pet.HealthBarBackdrop:SetFrameLevel(Pet:GetFrameLevel() - 1)
		Pet.HealthBarBackdrop:CreateBackdrop()
		Pet.HealthBarBackdrop:SetWidth(Pet.healthBarWidth + 4)
		Pet.HealthBarBackdrop:SetPoint("TOPLEFT", Pet.ActualHealthBar, "TOPLEFT", -2, 2)
		Pet.HealthBarBackdrop:SetPoint("BOTTOMLEFT", Pet.ActualHealthBar, "BOTTOMLEFT", -2, -1)
	end

	PetBattles.Ally2:SetPoint("TOPRIGHT", PetBattles.Ally2.iconPoint, "TOPLEFT", -6, -2)
	PetBattles.Ally3:SetPoint("TOPRIGHT", PetBattles.Ally2, "TOPLEFT", -8, 0)
	PetBattles.Enemy2:SetPoint("TOPLEFT", PetBattles.Enemy2.iconPoint, "TOPRIGHT", 6, -2)
	PetBattles.Enemy3:SetPoint("TOPLEFT", PetBattles.Enemy2, "TOPRIGHT", 8, 0)
end

function Battle:AddUnitFramesHooks()
	hooksecurefunc("PetBattleFrame_UpdateSpeedIndicators", function(self)
		if not PetBattles.ActiveAlly.SpeedIcon:IsShown() and not PetBattles.ActiveEnemy.SpeedIcon:IsShown() then
			PetBattles.ActiveAlly.FirstAttack:Hide()
			PetBattles.ActiveEnemy.FirstAttack:Hide()
			return
		end

		for i, Pet in pairs(Pets) do
			Pet.FirstAttack:Show()
			if Pet.SpeedIcon:IsShown() then
				Pet.FirstAttack:SetVertexColor(0,1,0,1)
			else
				Pet.FirstAttack:SetVertexColor(.8,0,.3,1)
			end
		end
	end)

	-- PETS UNITFRAMES PET TYPE UPDATE
	hooksecurefunc("PetBattleUnitFrame_UpdatePetType", function(self)
		if self.PetType then
			local PetType = C_PetBattles.GetPetType(self.petOwner, self.petIndex)
			if self.PetTypeFrame then
				self.PetTypeFrame.Text:SetText(PET_TYPE_SUFFIX[PetType])
			end
		end
	end)

	-- PETS UNITFRAMES AURA SKINS
	hooksecurefunc("PetBattleAuraHolder_Update", function(self)
		if not self.petOwner or not self.petIndex then return end

		local Next = 1

		for i = 1, C_PetBattles.GetNumAuras(self.petOwner, self.petIndex) do
			local AuraID, InstanceID, TurnsRemaining, IsBuff = C_PetBattles.GetAuraInfo(self.petOwner, self.petIndex, i)

			if (IsBuff and self.displayBuffs) or (not IsBuff and self.displayDebuffs) then
				local Frame = self.frames[Next]

				-- always hide the border
				Frame.DebuffBorder:Hide()

				if not Frame.IsSkinned then
					Frame:CreateBackdrop()
					Frame.Backdrop:SetOutside(Frame.Icon)
					Frame.Icon:SetTexCoord(unpack(T.IconCoord))
					Frame.IsSkinned = true
				end

				if IsBuff then
					Frame.Backdrop:SetBackdropBorderColor(0, 1, 0)
				else
					Frame.Backdrop:SetBackdropBorderColor(1, 0, 0)
				end

				if TurnsRemaining > 0 then
					Frame.Duration:SetText(TurnsRemaining)
				end

				Frame.Duration:SetFont(C.Medias.Font, 14, "OUTLINE")
				Frame.Duration:ClearAllPoints()
				Frame.Duration:SetPoint("CENTER", Frame.Icon, "CENTER", 1, 0)

				Next = Next + 1
			end
		end
	end)

	-- PETS UNITFRAMES, ALWAYS HIDE BLIZZARD ICONS BORDER
	hooksecurefunc("PetBattleUnitFrame_UpdateDisplay", function(self)
		self.Icon:SetTexCoord(unpack(T.IconCoord))
	end)

	-- WEATHER
	hooksecurefunc("PetBattleWeatherFrame_Update", function(self)
		local Weather = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_WEATHER, PET_BATTLE_PAD_INDEX, 1)

		if Weather then
			self.Icon:Hide()
			self.Name:Hide()
			self.DurationShadow:Hide()
			self.Label:Hide()
			self.Duration:SetPoint("CENTER", self, 0, 8)
			self:ClearAllPoints()
			self:SetPoint("TOP", UIParent, 0, -15)
		end
	end)
end