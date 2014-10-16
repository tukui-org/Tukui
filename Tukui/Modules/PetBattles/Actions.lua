local T, C, L = select(2, ...):unpack()

local Battle = T["PetBattles"]
local Bottom = PetBattleFrame.BottomFrame
local Noop = function() end
local NUM_BATTLE_PET_ABILITIES = NUM_BATTLE_PET_ABILITIES

function Battle:AddActionBar()
	local Bar = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")

	Bar:SetSize ((52 * 6) + (7 * 10), (52 * 1) + (10 * 2))
	Bar:EnableMouse(true)
	Bar:SetTemplate()
	Bar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 14)
	Bar:Hide()
	
	self.ActionBar = Bar

	RegisterStateDriver(Bar, "visibility", "[petbattle] show; hide")
end

function Battle:SkinActionBar()
	Bottom:StripTextures()
	Bottom.TurnTimer:StripTextures()
	Bottom.TurnTimer.SkipButton:SetParent(self.ActionBar)
	Bottom.TurnTimer.SkipButton:SkinButton()
	Bottom.TurnTimer.SkipButton:Width(self.ActionBar:GetWidth())
	Bottom.TurnTimer.SkipButton:Height(21)
	Bottom.TurnTimer.SkipButton:ClearAllPoints()
	Bottom.TurnTimer.SkipButton:SetPoint("BOTTOM", self.ActionBar, "TOP", 0, 2)
	Bottom.TurnTimer.SkipButton.ClearAllPoints = Noop
	Bottom.TurnTimer.SkipButton.SetPoint = Noop

	Bottom.TurnTimer:SetParent(self.ActionBar)
	Bottom.TurnTimer:SetTemplate()
	Bottom.TurnTimer:Size(Bottom.TurnTimer.SkipButton:GetWidth(), Bottom.TurnTimer.SkipButton:GetHeight())
	Bottom.TurnTimer:ClearAllPoints()
	Bottom.TurnTimer:SetPoint("BOTTOM", Bottom.TurnTimer.SkipButton, "TOP", 0, 2)
	Bottom.TurnTimer.TimerText:SetPoint("CENTER")

	Bottom.MicroButtonFrame:StripTextures()
	Bottom.MicroButtonFrame:Hide()
	Bottom.Delimiter:StripTextures()
	Bottom.FlowFrame:Kill()
	Bottom.xpBar:SetParent(self.ActionBar)
	Bottom.xpBar:Width(self.ActionBar:GetWidth() - 4)
	Bottom.xpBar:CreateBackdrop()
	Bottom.xpBar:ClearAllPoints()
	Bottom.xpBar:SetPoint("BOTTOM", Bottom.TurnTimer, "TOP", 0, 4)
	Bottom.xpBar:SetScript("OnShow", function(self)
		self:StripTextures()
		self:SetStatusBarTexture(C.Medias.Normal)
	end)
end

function Battle:SkinPetButton()
	self:CreateBackdrop()
	self:SetNormalTexture("")
	self.Icon:SetTexCoord(unpack(T.IconCoord))
	self:StyleButton()
	self.SelectedHighlight:SetTexture(0.9, 0.8, 0.1, 0.3)
	self.SelectedHighlight:SetInside(self.Backdrop)
	self.pushed:SetInside(self.Backdrop)
	self.hover:SetInside(self.Backdrop)
	
	if self.BetterIcon then
		self.BetterIcon:ClearAllPoints()
		self.BetterIcon:SetPoint("CENTER", self)
	end
end

function Battle:AddActionBarHooks()
	hooksecurefunc("PetBattlePetSelectionFrame_Show", function()
		Bottom.PetSelectionFrame:ClearAllPoints()
		Bottom.PetSelectionFrame:SetPoint("BOTTOM", Bottom.xpBar, "TOP", 0, 8)
	end)
	
	hooksecurefunc("PetBattleFrame_UpdateActionBarLayout", function(self)
		local Switch = Bottom.SwitchPetButton
		local Catch = Bottom.CatchButton
		local Forfeit = Bottom.ForfeitButton
		
		for i=1, NUM_BATTLE_PET_ABILITIES do
			local Button = Bottom.abilityButtons[i]
			Button.checked = true
			Battle.SkinPetButton(Button)
			Button:SetParent(Battle.ActionBar)
			Button:ClearAllPoints()
			if i == 1 then
				Button:SetPoint("BOTTOMLEFT", 10, 10)
			else
				local PreviousButton = Bottom.abilityButtons[i-1]
				Button:SetPoint("LEFT", PreviousButton, "RIGHT", 10, 0)
			end
		end
		
		Battle.SkinPetButton(Switch)
		Switch:SetParent(Battle.ActionBar)
		Switch:ClearAllPoints()
		Switch.checked:SetInside(Switch.Backdrop)
		Switch:SetPoint("LEFT", Bottom.abilityButtons[3], "RIGHT", 10, 0)
		Switch:SetScript("OnClick", function(self)
			if Bottom.PetSelectionFrame:IsShown() then
				PetBattlePetSelectionFrame_Hide(Bottom.PetSelectionFrame)
			else
				PetBattlePetSelectionFrame_Show(Bottom.PetSelectionFrame)
			end
		end)

		Battle.SkinPetButton(Switch)
		Catch:SetParent(Battle.ActionBar)
		Catch:ClearAllPoints()
		Catch:SetPoint("LEFT", Switch, "RIGHT", 10, 0)
		Battle.SkinPetButton(Catch)
		Forfeit:SetParent(Battle.ActionBar)
		Forfeit:ClearAllPoints()
		Forfeit:SetPoint("LEFT", Catch, "RIGHT", 10, 0)
		Battle.SkinPetButton(Forfeit)
	end)
end