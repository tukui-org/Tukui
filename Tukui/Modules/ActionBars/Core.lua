local T, C, L = select(2, ...):unpack()

local ActionBars = T["ActionBars"]
local format = format
local Replace = string.gsub
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local NUM_STANCE_SLOTS = NUM_STANCE_SLOTS
local MainMenuBar, MainMenuBarArtFrame = MainMenuBar, MainMenuBarArtFrame
local ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight = ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight
local Noop = function() return end

local Frames = {
	MainMenuBar,
	MainMenuBarArtFrame,
	OverrideActionBar,
	PossessBarFrame,
	ShapeshiftBarLeft,
	ShapeshiftBarMiddle,
	ShapeshiftBarRight,
}

function ActionBars:DisableBlizzard()
	local Hider = T.Hider

	for _, frame in pairs(Frames) do
		frame:UnregisterAllEvents()
		frame:SetParent(Hider)
	end

	local Options = {
		InterfaceOptionsActionBarsPanelBottomLeft,
		InterfaceOptionsActionBarsPanelBottomRight,
		InterfaceOptionsActionBarsPanelRight,
		InterfaceOptionsActionBarsPanelRightTwo,
		InterfaceOptionsActionBarsPanelStackRightBars,
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars,
	}

	ActionBarButtonEventsFrame:UnregisterEvent("ACTIONBAR_SHOWGRID")
	ActionBarButtonEventsFrame:UnregisterEvent("ACTIONBAR_HIDEGRID")

	for i, j in pairs(Options) do
		j:Hide()
		j:Disable()
		j:SetScale(0.001)
	end

	MultiActionBar_Update = Noop
	BeginActionBarTransition = Noop

	if C.ActionBars.HotKey then
		ActionButton_UpdateRangeIndicator = Noop
	end

	if T.Retail then
		if not C.ActionBars.AutoAddNewSpell then
			IconIntroTracker:UnregisterAllEvents()

			RegisterStateDriver(IconIntroTracker, "visibility", "hide")
		end

		-- Micro Menu
		MicroButtonAndBagsBar:ClearAllPoints()
		MicroButtonAndBagsBar:SetPoint("TOP", UIParent, "TOP", 0, 200)
	end
end

function ActionBars:MovePetBar()
	local PetBar = TukuiPetActionBar
	local RightBar = TukuiActionBar5
	local Data1 = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.TukuiActionBar5
	local Data2 = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.TukuiPetActionBar

	-- Don't run if player moved bar 5 or pet bar
	if Data1 or Data2 then
		return
	end

	if RightBar:IsShown() then
		PetBar:SetPoint("RIGHT", RightBar, "LEFT", -6, 0)
	else
		PetBar:SetPoint("RIGHT", UIParent, "RIGHT", -28, 8)
	end
end

function ActionBars:UpdatePetBar()
	local Button, Icon, CastTexture, ShineTexture

	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local PetActionButton = "PetActionButton" .. i

		Button = _G[PetActionButton]
		Icon = _G[PetActionButton.."Icon"]
		CastTexture = _G[PetActionButton.."AutoCastable"]
		ShineTexture = _G[PetActionButton.."Shine"]

		local Name, Texture, IsToken, IsActive, AutoCastAllowed, AutoCastEnabled, SpellID = GetPetActionInfo(i)

		if not IsToken then
			Icon:SetTexture(Texture)
			Button.tooltipName = Name
		else
			Icon:SetTexture(_G[Texture])
			Button.tooltipName = _G[Name]
		end

		Button.isToken = IsToken

		if SpellID then
			local spell = Spell:CreateFromSpellID(SpellID)

			Button.spellDataLoadedCancelFunc = spell:ContinueWithCancelOnSpellLoad(function()
				Button.tooltipSubtext = spell:GetSpellSubtext();
			end)
		end

		if IsActive then
			if IsPetAttackAction(i) then
				PetActionButton_StartFlash(Button)

				Button:GetCheckedTexture():SetAlpha(0.5)
			else
				PetActionButton_StopFlash(Button)

				Button:GetCheckedTexture():SetAlpha(1.0)
			end

			Button:SetChecked(true)
		else
			PetActionButton_StopFlash(Button)

			Button:SetChecked(false)
		end

		if AutoCastAllowed then
			CastTexture:Show()
		else
			CastTexture:Hide()
		end

		if AutoCastEnabled then
			AutoCastShine_AutoCastStart(ShineTexture)
		else
			AutoCastShine_AutoCastStop(ShineTexture)
		end

		if Texture then
			if GetPetActionSlotUsable(i) then
				Icon:SetVertexColor(1, 1, 1)
			else
				Icon:SetVertexColor(0.4, 0.4, 0.4)
			end

			Icon:Show()

			Button:SetNormalTexture("")
		else
			Icon:Hide()

			Button:SetNormalTexture("")
		end

		SharedActionButton_RefreshSpellHighlight(Button, HasPetActionHighlightMark(i))
	end

	PetActionBar_UpdateCooldowns()

	if not PetHasActionBar() then
		HidePetActionBar()
	end

	PetActionBarFrame.rangeTimer = -1
end

function ActionBars:OnUpdatePetBarCooldownText(elapsed)
	local Now = GetTime()
	local Timer = Now - self.StartTimer
	local Cooldown = self.DurationTimer - Timer

	self.Elapsed = self.Elapsed - elapsed

	if self.Elapsed < 0 then
		if Cooldown <= 0 then
			self.Text:SetText("")

			self:SetScript("OnUpdate", nil)
		else
			self.Text:SetTextColor(1, 0, 0)
			self.Text:SetText(T.FormatTime(Cooldown))
		end

		self.Elapsed = .1
	end
end

function ActionBars.UpdatePetBarCooldownText()
	for i = 1, NUM_PET_ACTION_SLOTS, 1 do
		local Cooldown = _G["PetActionButton"..i.."Cooldown"]
		local Start, Duration, Enable = GetPetActionCooldown(i)

		if Enable and Enable ~= 0 and Start > 0 and Duration > 0 then
			if not Cooldown.Text then
				local Font = T.GetFont(C["Cooldowns"].Font)

				Font = _G[Font]:GetFont()

				Cooldown.Text = Cooldown:CreateFontString(nil, "OVERLAY")
				Cooldown.Text:SetPoint("CENTER", 1, 0)
				Cooldown.Text:SetFont(Font, 14, "THINOUTLINE")
			end

			Cooldown.StartTimer = Start
			Cooldown.DurationTimer = Duration
			Cooldown.Elapsed = .1
			Cooldown:SetScript("OnUpdate", ActionBars.OnUpdatePetBarCooldownText)
		end
	end
end

function ActionBars:UpdateStanceBar()
	if InCombatLockdown() then
		return
	end

	local NumForms = GetNumShapeshiftForms()
	local Texture, Name, IsActive, IsCastable, Button, Icon, Cooldown, Start, Duration, Enable
	local PetSize = C.ActionBars.PetButtonSize
	local Spacing = C.ActionBars.ButtonSpacing

	if NumForms == 0 then
		self.Bars.Stance:SetAlpha(0)
	else
		self.Bars.Stance:SetAlpha(1)
		self.Bars.Stance:SetSize((PetSize * NumForms) + (Spacing * (NumForms + 1)), PetSize + (Spacing * 2))

		if self.Bars.Stance.Backdrop then
			self.Bars.Stance.Backdrop:SetPoint("TOPLEFT", 0, 0)
		end

		for i = 1, NUM_STANCE_SLOTS do
			local ButtonName = "StanceButton"..i

			Button = _G[ButtonName]
			Icon = _G[ButtonName.."Icon"]

			Button:SetNormalTexture("")

			if i <= NumForms then
				Texture, IsActive, IsCastable = GetShapeshiftFormInfo(i)

				if not Icon then
					return
				end

				Icon:SetTexture(Texture)
				Cooldown = _G[ButtonName.."Cooldown"]

				if Texture then
					Cooldown:SetAlpha(1)
				else
					Cooldown:SetAlpha(0)
				end

				Start, Duration, Enable = GetShapeshiftFormCooldown(i)
				CooldownFrame_Set(Cooldown, Start, Duration, Enable)

				if IsActive then
					StanceBarFrame.lastSelected = Button:GetID()
					Button:SetChecked(true)

					if Button.Backdrop then
						Button.Backdrop:SetBorderColor(0, 1, 0)
					end
				else
					Button:SetChecked(false)

					if Button.Backdrop then
						Button.Backdrop:SetBorderColor(unpack(C.General.BorderColor))
					end
				end

				if IsCastable then
					Icon:SetVertexColor(1.0, 1.0, 1.0)
				else
					Icon:SetVertexColor(0.4, 0.4, 0.4)
				end
			end
		end
	end
end

function ActionBars:RangeUpdate(hasrange, inrange)
	local Icon = self.icon
	local NormalTexture = self.NormalTexture
	local ID = self.action

	if not ID then
		return
	end

	local IsUsable, NotEnoughPower = IsUsableAction(ID)
	local HasRange = hasrange
	local InRange = inrange

	if IsUsable then
		if (HasRange and InRange == false) then
			Icon:SetVertexColor(0.8, 0.1, 0.1)

			NormalTexture:SetVertexColor(0.8, 0.1, 0.1)
		else
			Icon:SetVertexColor(1.0, 1.0, 1.0)

			NormalTexture:SetVertexColor(1.0, 1.0, 1.0)
		end
	elseif NotEnoughPower then
		Icon:SetVertexColor(0.1, 0.3, 1.0)

		NormalTexture:SetVertexColor(0.1, 0.3, 1.0)
	else
		Icon:SetVertexColor(0.3, 0.3, 0.3)

		NormalTexture:SetVertexColor(0.3, 0.3, 0.3)
	end
end

function ActionBars:StartHighlight()
	if not self.Animation then
		self.Animation = self:CreateAnimationGroup()
		self.Animation:SetLooping("BOUNCE")

		self.Animation.FadeOut = self.Animation:CreateAnimation("Alpha")
		self.Animation.FadeOut:SetFromAlpha(1)
		self.Animation.FadeOut:SetToAlpha(.3)
		self.Animation.FadeOut:SetDuration(.3)
		self.Animation.FadeOut:SetSmoothing("IN_OUT")
	end

	-- Hide Blizard Proc
	if self.overlay and self.overlay:GetParent() ~= T.Hider then
		self.overlay:SetParent(T.Hider)
	end

	if not self.Animation:IsPlaying() then
		self.Animation:Play()

		if self.Backdrop then
			self.Backdrop:SetBorderColor(1, 1, 0)
		end
	end
end

function ActionBars:StopHightlight()
	if self.Animation and self.Animation:IsPlaying() then
		self.Animation:Stop()

		if self.Backdrop then
			self.Backdrop:SetBorderColor(unpack(C.General.BorderColor))
		end
	end
end

function ActionBars:SetHotKeyText()
	local HotKey = self.HotKey
	local Text = HotKey:GetText()
	local Indicator = _G["RANGE_INDICATOR"]

	if (not Text) then
		return
	end

	Text = Replace(Text, "(s%-)", "|cffff8000s|r")
	Text = Replace(Text, "(a%-)", "|cffff8000a|r")
	Text = Replace(Text, "(c%-)", "|cffff8000c|r")
	Text = Replace(Text, KEY_BUTTON3, "m3")
	Text = Replace(Text, KEY_BUTTON4, "m4")
	Text = Replace(Text, KEY_BUTTON5, "m5")
	Text = Replace(Text, KEY_MOUSEWHEELUP, "mU")
	Text = Replace(Text, KEY_MOUSEWHEELDOWN, "mD")
	Text = Replace(Text, KEY_NUMPAD0, "N0")
	Text = Replace(Text, KEY_NUMPAD1, "N1")
	Text = Replace(Text, KEY_NUMPAD2, "N2")
	Text = Replace(Text, KEY_NUMPAD3, "N3")
	Text = Replace(Text, KEY_NUMPAD4, "N4")
	Text = Replace(Text, KEY_NUMPAD5, "N5")
	Text = Replace(Text, KEY_NUMPAD6, "N6")
	Text = Replace(Text, KEY_NUMPAD7, "N7")
	Text = Replace(Text, KEY_NUMPAD8, "N8")
	Text = Replace(Text, KEY_NUMPAD9, "N9")
	Text = Replace(Text, KEY_NUMPADDECIMAL, "N.")
	Text = Replace(Text, KEY_NUMPADDIVIDE, "N/")
	Text = Replace(Text, KEY_NUMPADMINUS, "N-")
	Text = Replace(Text, KEY_NUMPADMULTIPLY, "N*")
	Text = Replace(Text, KEY_NUMPADPLUS, "N+")
	Text = Replace(Text, KEY_PAGEUP, "PU")
	Text = Replace(Text, KEY_PAGEDOWN, "PD")
	Text = Replace(Text, KEY_SPACE, "SPB")
	Text = Replace(Text, KEY_INSERT, "INS")
	Text = Replace(Text, KEY_HOME, "HM")
	Text = Replace(Text, KEY_DELETE, "DEL")
	Text = Replace(Text, KEY_BACKSPACE, "BKS")
	Text = Replace(Text, KEY_INSERT_MAC, "HLP") -- mac

	if HotKey:GetText() == Indicator then
		HotKey:SetText("")
	else
		HotKey:SetText(Text)
	end

	HotKey:SetVertexColor(1, 1, 1)
end

function ActionBars:UpdateButton()
	local HotKey = self.HotKey
	local Action = self.action

	if HotKey then
		HotKey:SetVertexColor(1, 1, 1)
	end

	if C.ActionBars.EquipBorder then
		if (IsEquippedAction(Action)) then
			if self.Backdrop then
				self.Backdrop:SetBorderColor(.08, .70, 0)
			end
		else
			if self.Backdrop then
				self.Backdrop:SetBorderColor(unpack(C.General.BorderColor))
			end
		end
	end
end

function ActionBars:AddHooks()
	if T.Retail then
		hooksecurefunc("ActionButton_UpdateFlyout", self.StyleFlyout)
		hooksecurefunc("SpellButton_OnClick", self.StyleFlyout)
	else
		hooksecurefunc("ActionButton_Update", self.UpdateButton)
	end

	hooksecurefunc("ActionButton_UpdateRangeIndicator", self.RangeUpdate)

	if C.ActionBars.HotKey then
		if not T.Retail then
			hooksecurefunc("ActionButton_UpdateHotkeys", self.SetHotKeyText)
		end

		hooksecurefunc("PetActionButton_SetHotkeys", self.SetHotKeyText)
	end

	if C.ActionBars.ProcAnim then
		hooksecurefunc("ActionButton_ShowOverlayGlow", self.StartHighlight)
		hooksecurefunc("ActionButton_HideOverlayGlow", self.StopHightlight)
	end
	
	if T.WotLK and C.ActionBars.MultiCastBar then
		hooksecurefunc("ShowMultiCastActionBar", self.UpdateMultiCastBar)
	end
end

function ActionBars:UpdateMultiCastBar()
	local Bar = MultiCastActionBarFrame
	local Movers = T["Movers"]
	local CustomPosition = TukuiDatabase.Variables[T.MyRealm][T.MyName].Move.MultiCastActionBarFrame

	Movers:RegisterFrame(Bar, "MultiCastBar")

	Bar:ClearAllPoints()
	Bar:SetParent(TukuiPetHider)
	Bar:SetPoint("BOTTOM", 0, 300)

	if CustomPosition then
		Bar:ClearAllPoints()
		Bar:SetPoint(unpack(CustomPosition))
	end
end

function ActionBars:Enable()
	if not C.ActionBars.Enable then
		return
	end

	SetCVar("alwaysShowActionBars", 1)
	SetActionBarToggles(1, 1, 1, 1, 1)

	self:DisableBlizzard()
	self:CreateBar1()
	self:CreateBar2()
	self:CreateBar3()
	self:CreateBar4()
	self:CreateBar5()
	self:CreatePetBar()
	self:CreateStanceBar()
	self:AddHooks()

	if T.Retail then
		self:SetupExtraButton()
	end
end
