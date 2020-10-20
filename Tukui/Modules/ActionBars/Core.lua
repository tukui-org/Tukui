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
	
	if not C.ActionBars.AutoAddNewSpell then
		IconIntroTracker:UnregisterAllEvents()
		
		RegisterStateDriver(IconIntroTracker, "visibility", "hide")
	end
	
	-- Micro Menu
	MicroButtonAndBagsBar:ClearAllPoints()
	MicroButtonAndBagsBar:SetPoint("TOP", UIParent, "TOP", 0, 200)
end

function ActionBars:MovePetBar()
	local PetBar = TukuiPetActionBar
	local RightBar = TukuiActionBar5
	local Data1 = TukuiData[T.MyRealm][T.MyName].Move.TukuiActionBar5
	local Data2 = TukuiData[T.MyRealm][T.MyName].Move.TukuiPetActionBar

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
	for i = 1, NUM_PET_ACTION_SLOTS, 1 do
		local ButtonName = "PetActionButton" .. i
		local PetActionButton = _G[ButtonName]

		PetActionButton:SetNormalTexture("")
	end
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

function ActionBars:BetterHotKeyText()
	local HotKey = self.HotKey
	local Text = HotKey:GetText()
	local Indicator = _G["RANGE_INDICATOR"]

	if (not Text) then
		return
	end

	Text = Replace(Text, "(s%-)", "S")
	Text = Replace(Text, "(a%-)", "A")
	Text = Replace(Text, "(c%-)", "C")
	Text = Replace(Text, KEY_MOUSEWHEELDOWN , "MDn")
	Text = Replace(Text, KEY_MOUSEWHEELUP , "MUp")
	Text = Replace(Text, KEY_BUTTON3, "M3")
	Text = Replace(Text, KEY_BUTTON4, "M4")
	Text = Replace(Text, KEY_BUTTON5, "M5")
	Text = Replace(Text, KEY_MOUSEWHEELUP, "MU")
	Text = Replace(Text, KEY_MOUSEWHEELDOWN, "MD")
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
	Text = Replace(Text, KEY_SPACE, "SpB")
	Text = Replace(Text, KEY_INSERT, "Ins")
	Text = Replace(Text, KEY_HOME, "Hm")
	Text = Replace(Text, KEY_DELETE, "Del")
	Text = Replace(Text, KEY_BACKSPACE, "Bks")
	Text = Replace(Text, KEY_INSERT_MAC, "Hlp") -- mac

	if HotKey:GetText() == Indicator then
		HotKey:SetText("")
	else
		HotKey:SetText(Text)
	end
end

function ActionBars:AddHooks()
	hooksecurefunc("ActionButton_UpdateFlyout", self.StyleFlyout)
	hooksecurefunc("SpellButton_OnClick", self.StyleFlyout)
	hooksecurefunc("ActionButton_UpdateRangeIndicator", ActionBars.RangeUpdate)
	
	if C.ActionBars.HotKey then
		hooksecurefunc("PetActionButton_SetHotkeys", self.BetterHotKeyText)
	end
	
	if C.ActionBars.ProcAnim then
		hooksecurefunc("ActionButton_ShowOverlayGlow", ActionBars.StartHighlight)
		hooksecurefunc("ActionButton_HideOverlayGlow", ActionBars.StopHightlight)
	end
end

function ActionBars:Enable()
	if not C.ActionBars.Enable then
		return
	end
	
	SetCVar("alwaysShowActionBars", 1)

	self:DisableBlizzard()
	self:CreateBar1()
	self:CreateBar2()
	self:CreateBar3()
	self:CreateBar4()
	self:CreateBar5()
	self:CreatePetBar()
	self:CreateStanceBar()
	self:SetupExtraButton()
	self:AddHooks()
end
