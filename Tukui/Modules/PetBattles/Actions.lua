local T, C, L = select(2, ...):unpack()

local Battle = T["PetBattles"]
local Bottom = PetBattleFrame.BottomFrame
local Noop = function() end
local NUM_BATTLE_PET_ABILITIES = NUM_BATTLE_PET_ABILITIES

function Battle:AddActionBar()
	local Bar = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")

	Bar:SetSize((52 * 6) + (7 * 10), (52 * 1) + (10 * 2))
	Bar:EnableMouse(true)
	Bar:CreateBackdrop()
	Bar:CreateShadow()
	Bar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 14)
	Bar:Hide()

	self.ActionBar = Bar

	RegisterStateDriver(Bar, "visibility", "[petbattle] show; hide")
end

function Battle:SkinActionBar()
	Bottom:StripTextures()
	
	Bottom.TurnTimer.SkipButton:SetParent(self.ActionBar)
	Bottom.TurnTimer.SkipButton:SkinButton()
	Bottom.TurnTimer.SkipButton:CreateShadow()
	Bottom.TurnTimer.SkipButton:SetWidth(self.ActionBar:GetWidth())
	Bottom.TurnTimer.SkipButton:SetHeight(21)
	Bottom.TurnTimer.SkipButton:ClearAllPoints()
	Bottom.TurnTimer.SkipButton:SetPoint("BOTTOM", self.ActionBar, "TOP", 0, 2)
	Bottom.TurnTimer.SkipButton.ClearAllPoints = Noop
	Bottom.TurnTimer.SkipButton.SetPoint = Noop
	
	Bottom.TurnTimer:StripTextures()
	Bottom.TurnTimer:SetParent(self.ActionBar)
	Bottom.TurnTimer:CreateBackdrop()
	Bottom.TurnTimer:CreateShadow()
	Bottom.TurnTimer:SetSize(Bottom.TurnTimer.SkipButton:GetWidth(), Bottom.TurnTimer.SkipButton:GetHeight())
	Bottom.TurnTimer:ClearAllPoints()
	Bottom.TurnTimer:SetPoint("BOTTOM", Bottom.TurnTimer.SkipButton, "TOP", 0, 2)
	Bottom.TurnTimer.TimerText:SetPoint("CENTER")

	Bottom.MicroButtonFrame:StripTextures()
	Bottom.MicroButtonFrame:Hide()
	
	Bottom.Delimiter:StripTextures()
	
	Bottom.FlowFrame:Kill()
	
	Bottom.xpBar:SetParent(self.ActionBar)
	Bottom.xpBar:SetWidth(self.ActionBar:GetWidth())
	Bottom.xpBar:StripTextures()
	Bottom.xpBar:SetStatusBarTexture(C.Medias.Normal)
	Bottom.xpBar:CreateBackdrop()
	Bottom.xpBar.Backdrop:CreateShadow()
	Bottom.xpBar:ClearAllPoints()
	Bottom.xpBar:SetPoint("BOTTOM", Bottom.TurnTimer, "TOP", 0, 4)
	Bottom.xpBar:SetScript("OnShow", function(self)
		self:StripTextures()
		self:SetStatusBarTexture(C.Medias.Normal)
	end)
end

function Battle:SkinPetButton()
	if self.IsSkinned then
		return
	end
	
	local Switch = Bottom.SwitchPetButton
	
	self:CreateBackdrop()
	self.Backdrop:SetFrameLevel(self:GetFrameLevel() - 1)
	self:SetNormalTexture("")
	self.Icon:SetTexCoord(unpack(T.IconCoord))
	self:StyleButton()
	self.Pushed:SetAlpha(0)

	if self.BetterIcon then
		self.BetterIcon:ClearAllPoints()
		self.BetterIcon:SetPoint("BOTTOM", self)
	end
	
	Switch:SetScript("OnClick", function(self)
		if Bottom.PetSelectionFrame:IsShown() then
			PetBattlePetSelectionFrame_Hide(Bottom.PetSelectionFrame)
		else
			PetBattlePetSelectionFrame_Show(Bottom.PetSelectionFrame)
		end
	end)
end

function Battle:UpdateActionBar()
	local Switch = Bottom.SwitchPetButton
	local Catch = Bottom.CatchButton
	local Forfeit = Bottom.ForfeitButton

	for i=1, NUM_BATTLE_PET_ABILITIES do
		local Button = Bottom.abilityButtons[i]

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
	Battle.SkinPetButton(Catch)
	Battle.SkinPetButton(Forfeit)

	Switch:SetParent(Battle.ActionBar)
	Switch:ClearAllPoints()
	Switch:SetPoint("LEFT", Bottom.abilityButtons[3], "RIGHT", 10, 0)

	Catch:SetParent(Battle.ActionBar)
	Catch:ClearAllPoints()
	Catch:SetPoint("LEFT", Switch, "RIGHT", 10, 0)

	Forfeit:SetParent(Battle.ActionBar)
	Forfeit:ClearAllPoints()
	Forfeit:SetPoint("LEFT", Catch, "RIGHT", 10, 0)
end

function Battle:MoveSelection()
	Bottom.PetSelectionFrame:ClearAllPoints()
	Bottom.PetSelectionFrame:SetPoint("BOTTOM", Bottom.xpBar, "TOP", 0, 8)
end

function Battle:AddActionBarHooks()
	hooksecurefunc("PetBattlePetSelectionFrame_Show", self.MoveSelection)
	hooksecurefunc("PetBattleFrame_UpdateActionBarLayout", self.UpdateActionBar)
end
--/run PetBattleFrame.BottomFrame.CatchButton.overlay.animIn:Stop()