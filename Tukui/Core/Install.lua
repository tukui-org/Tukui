local T, C, L = select(2, ...):unpack()

local Install = CreateFrame("Frame", nil, UIParent)
Install.MaxStepNumber = 3
Install.CurrentStep = 0
Install.Width = 500
Install.Height = 200

function Install:ResetData()
	if (T.DataTexts) then
		T.DataTexts:Reset()
	end
	
	if (TukuiConfigNotShared) then
		TukuiConfigNotShared = {}
	end
	
	if (TukuiDataPerChar) then
		TukuiDataPerChar = {}
	end
	
	ReloadUI()
end

function Install:Step1()
	local ActionBars = C.ActionBars.Enable
	
	-- CVars
	SetCVar("countdownForCooldowns", 1)
	SetCVar("buffDurations", 1)
	SetCVar("consolidateBuffs", 0)
	SetCVar("scriptErrors", 1)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 8)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("WhisperMode", "inline")
	SetCVar("BnWhisperMode", "inline")
	SetCVar("showTutorials", 0)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("UberTooltips", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("bloatthreat", 0)
	SetCVar("bloattest", 0)
	SetCVar("showArenaEnemyFrames", 0)
	SetCVar("alwaysShowActionBars", 1)
	SetCVar("autoOpenLootHistory", 0)
	SetCVar("spamFilter", 0)
	SetCVar("violenceLevel", 5)
	
	if (ActionBars) then
		SetActionBarToggles(1, 1, 1, 1)
	end
end

function Install:Step2()
	local Chat = T["Chat"]
	
	if (not Chat) then
		return
	end
	
	Chat:Install()
	Chat:SetDefaultChatFramesPositions()
end

function Install:PrintStep(number)
	local ExecuteScript = self["Step" .. number]
	local Text = L.Install["InstallStep" .. number]
	local R, G, B = T.ColorGradient(number, self.MaxStepNumber, 1, 0.2, 0.2, 1, 1, 0, 0.2, 1, 0.2)
	
	if (not Text) then
		self:Hide()
		
		if (number > self.MaxStepNumber) then
			TukuiDataPerChar.InstallDone = true
			ReloadUI()
		end
		
		return
	end
	
	self.CurrentStep = number

	if (number == 0) then
		self.LeftButton.Text:SetText(CLOSE)
		self.LeftButton:SetScript("OnClick", function() self:Hide() end)
		self.RightButton.Text:SetText(NEXT)
		self.RightButton:SetScript("OnClick", function() self.PrintStep(self, self.CurrentStep + 1) end)
		self.MiddleButton.Text:SetText("|cffFF0000"..RESET_TO_DEFAULT.."|r")
		self.MiddleButton:SetScript("OnClick", self.ResetData)
		self.CloseButton:Show()
		if (TukuiDataPerChar.InstallDone) then
			self.MiddleButton:Show()
		else
			self.MiddleButton:Hide()
		end
	else
		self.LeftButton:SetScript("OnClick", function() self.PrintStep(self, self.CurrentStep - 1) end)
		self.LeftButton.Text:SetText(PREVIOUS)
		self.MiddleButton.Text:SetText(APPLY)
		self.RightButton:SetScript("OnClick", function() self.PrintStep(self, self.CurrentStep + 1) end)
		
		if (number == Install.MaxStepNumber) then
			self.RightButton.Text:SetText(COMPLETE)
			self.CloseButton:Hide()
			self.MiddleButton:Hide()
		else
			self.RightButton.Text:SetText(NEXT)
			self.CloseButton:Show()
			self.MiddleButton:Show()
		end
		
		if (ExecuteScript) then
			self.MiddleButton:SetScript("OnClick", ExecuteScript)
		end
	end
	
	self.Text:SetText(Text)
	
	self.StatusBar:SetValue(number)
	self.StatusBar:SetStatusBarColor(R, G, B)
	self.StatusBar.Background:SetTexture(R, G, B)
end

local StyleClick = function(self)
	self.Text:SetTextColor(0, 1, 0)
	
	self.Text:SetAnimation("Gradient", "Text", 0, 0.5, 1, 1, 1)
end

function Install:Launch()
	if (self.Description) then
		self:Show()
		return
	end
	
	local R, G, B = T.ColorGradient(0, self.MaxStepNumber, 1, 0.2, 0.2, 1, 1, 0, 0.2, 1, 0.2)
	
	self.Description = CreateFrame("Frame", nil, self)
	self.Description:Size(self.Width, self.Height)
	self.Description:Point("CENTER", self, "CENTER")
	self.Description:SetTemplate()
	self.Description:CreateShadow()
	self.Description:RegisterEvent("PLAYER_REGEN_DISABLED")
	self.Description:RegisterEvent("PLAYER_REGEN_ENABLED")
	self.Description:SetScript("OnEvent", function(self, event)
		if (event == "PLAYER_REGEN_DISABLED") then
			Install:Hide()
		else
			if (not TukuiDataPerChar.InstallDone) then
				Install:Show()
			end
		end
	end)

	self.StatusBar = CreateFrame("StatusBar", nil, self)
	self.StatusBar:SetStatusBarTexture(C.Medias.Normal)
	self.StatusBar:Point("BOTTOM", self.Description, "TOP", 0, 8)
	self.StatusBar:Height(20)
	self.StatusBar:Width(self.Description:GetWidth() - 4)
	self.StatusBar:CreateBackdrop()
	self.StatusBar.Backdrop:CreateShadow()
	self.StatusBar:SetStatusBarColor(R, G, B)
	self.StatusBar:SetMinMaxValues(0, self.MaxStepNumber)
	self.StatusBar:SetValue(0)
	self.StatusBar.Background = self.StatusBar:CreateTexture(nil, "ARTWORK")
	self.StatusBar.Background:SetAllPoints()
	self.StatusBar.Background:SetAlpha(0.15)
	self.StatusBar.Background:SetTexture(R, G, B)
	
	self.Logo = self.StatusBar:CreateTexture(nil, "OVERLAY")
	self.Logo:Size(256, 128)
	self.Logo:SetTexture(C.Medias.Logo)
	self.Logo:Point("TOP", self.Description, "TOP", -8, 88)

	self.LeftButton = CreateFrame("Button", nil, self)
	self.LeftButton:Point("TOPLEFT", self.Description, "BOTTOMLEFT", 0, -6)
	self.LeftButton:Size(128, 25)
	self.LeftButton:SkinButton()
	self.LeftButton:CreateShadow()
	self.LeftButton:FontString("Text", C.Medias.Font, 12)
	self.LeftButton.Text:SetPoint("CENTER")
	self.LeftButton.Text:SetText(CLOSE)
	self.LeftButton:SetScript("OnClick", function() self:Hide() end)
	
	self.RightButton = CreateFrame("Button", nil, self)
	self.RightButton:Point("TOPRIGHT", self.Description, "BOTTOMRIGHT", 0, -6)
	self.RightButton:Size(128, 25)
	self.RightButton:SkinButton()
	self.RightButton:CreateShadow()
	self.RightButton:FontString("Text", C.Medias.Font, 12)
	self.RightButton.Text:SetPoint("CENTER")
	self.RightButton.Text:SetText(NEXT)
	self.RightButton:SetScript("OnClick", function() self.PrintStep(self, self.CurrentStep + 1) end)
	
	self.MiddleButton = CreateFrame("Button", nil, self)
	self.MiddleButton:Point("TOPLEFT", self.LeftButton, "TOPRIGHT", 4, 0)
	self.MiddleButton:Point("BOTTOMRIGHT", self.RightButton, "BOTTOMLEFT", -4, 0)
	self.MiddleButton:SkinButton()
	self.MiddleButton:CreateShadow()
	self.MiddleButton:FontString("Text", C.Medias.Font, 12)
	self.MiddleButton.Text:SetPoint("CENTER")
	self.MiddleButton.Text:SetText("|cffFF0000"..RESET_TO_DEFAULT.."|r")
	self.MiddleButton:SetScript("OnClick", self.ResetData)
	self.MiddleButton:SetScript("OnMouseUp", StyleClick)
	if (TukuiDataPerChar.InstallDone) then
		self.MiddleButton:Show()
	else
		self.MiddleButton:Hide()
	end
	
	self.CloseButton = CreateFrame("Button", nil, self)
	self.CloseButton:Point("TOPRIGHT", self.Description, "TOPRIGHT", -6, -12)
	self.CloseButton:Size(12)
	self.CloseButton:FontString("Text", C.Medias.Font, 12)
	self.CloseButton.Text:SetPoint("CENTER")
	self.CloseButton.Text:SetText("X")
	self.CloseButton:SetScript("OnClick", function() self:Hide() end)

	self.Text = self.Description:CreateFontString(nil, "OVERLAY")
	self.Text:Size(self.Description:GetWidth() - 40, self.Description:GetHeight() - 60)
	self.Text:SetJustifyH("LEFT")
	self.Text:SetJustifyV("TOP")
	self.Text:SetFont(C.Medias.Font, 12)
	self.Text:SetPoint("TOPLEFT", 20, -40)
	self.Text:SetText(L.Install.InstallStep0)
	
	self:SetAllPoints(UIParent)
end

Install:RegisterEvent("PLAYER_LOGOUT")
Install:RegisterEvent("ADDON_LOADED")
Install:SetScript("OnEvent", function(self, event, addon)
	local IsMac = IsMacClient()
	local Name = UnitName("Player")
	
	if (event == "PLAYER_LOGOUT" and IsMac) then
		local Data = TukuiData.Settings
		local ConfigData = TukuiConfigShared.Settings
		
		if (Data) then
			Data[Name] = TukuiDataPerChar
		end	
		
		if (ConfigData) then
			 ConfigData[Name] = TukuiConfigNotShared
		end		
	else
		if (addon ~= "Tukui") then
			return
		end

		if (IsMac) and (not TukuiDataPerChar) then
			-- Work Around for OSX and saved variables per char. (6.0.2 Blizzard Bug)
			if (not TukuiData) then
				TukuiData = {}
			end
			
			local Data = TukuiData
			
			if (not Data.Settings) then
				Data.Settings = {}
			end
			
			if Data and Data.Settings[Name] then
				TukuiDataPerChar = Data.Settings[Name]
			end
			
			-- This is needed on live, I don't know why, not needed on Beta.
			hooksecurefunc("ReloadUI", function()
				TukuiData.Settings[Name] = TukuiDataPerChar
			end)
		end

		if (not TukuiDataPerChar) then
			TukuiDataPerChar = {}
		end
		
		if (IsMac) and (not TukuiConfigNotShared) then
			-- Work Around for OSX and saved variables per char. (6.0.2 Blizzard Bug)
			if (not TukuiConfigShared) then
				TukuiConfigShared = {}
			end
			
			local ConfigData = TukuiConfigShared

			if (not ConfigData.Settings) then
				ConfigData.Settings = {}
			end
			
			if ConfigData.Settings[Name] then
				TukuiConfigNotShared = ConfigData.Settings[Name]
			end
			
			-- This is needed on live, I don't know why, not needed on Beta.
			hooksecurefunc("ReloadUI", function()
				TukuiConfigShared.Settings[Name] = TukuiConfigNotShared
			end)
		end
	
		local IsInstalled = TukuiDataPerChar.InstallDone
	
		if (not IsInstalled) then
			self:Launch()
		end
	
		self:UnregisterEvent("ADDON_LOADED")
	end
end)

T["Install"] = Install