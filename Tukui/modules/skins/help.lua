local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	local frames = {
		"HelpFrameLeftInset",
		"HelpFrameMainInset",
		"HelpFrameKnowledgebase",
		"HelpFrameHeader",
		"HelpFrameKnowledgebaseErrorFrame",
	}

	local buttons = {
		"HelpFrameAccountSecurityOpenTicket",
		"HelpFrameOpenTicketHelpTopIssues",
		"HelpFrameOpenTicketHelpOpenTicket",
		"HelpFrameKnowledgebaseSearchButton",
		"HelpFrameKnowledgebaseNavBarHomeButton",
		"HelpFrameCharacterStuckStuck",
		"GMChatOpenLog",
		"HelpFrameTicketSubmit",
		"HelpFrameTicketCancel",
	}

	-- skin main frames
	for i = 1, #frames do
		_G[frames[i]]:StripTextures(true)
		_G[frames[i]]:CreateBackdrop("Default")
	end

	HelpFrameHeader:SetFrameLevel(HelpFrameHeader:GetFrameLevel() + 2)
	HelpFrameKnowledgebaseErrorFrame:SetFrameLevel(HelpFrameKnowledgebaseErrorFrame:GetFrameLevel() + 2)

	HelpFrameTicketScrollFrame:StripTextures()
	HelpFrameTicketScrollFrame:CreateBackdrop("Default")
	HelpFrameTicketScrollFrame.backdrop:Point("TOPLEFT", -4, 4)
	HelpFrameTicketScrollFrame.backdrop:Point("BOTTOMRIGHT", 6, -4)
	for i=1, HelpFrameTicket:GetNumChildren() do
		local child = select(i, HelpFrameTicket:GetChildren())
		if not child:GetName() then
			child:StripTextures()
		end
	end

	HelpFrameKnowledgebaseScrollFrame2ScrollBar:SkinScrollBar()

	-- skin sub buttons
	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures(true)
		_G[buttons[i]]:SkinButton(true)
		
		if _G[buttons[i]].text then
			_G[buttons[i]].text:ClearAllPoints()
			_G[buttons[i]].text:SetPoint("CENTER")
			_G[buttons[i]].text:SetJustifyH("CENTER")				
		end
	end

	-- skin main buttons
	for i = 1, 6 do
		local b = _G["HelpFrameButton"..i]
		b:SkinButton(true)
		b.text:ClearAllPoints()
		b.text:SetPoint("CENTER")
		b.text:SetJustifyH("CENTER")
	end
	
	local b = _G["HelpFrameButton16"]
	b:StripTextures(true)
	b:SkinButton(true)
	b.text:ClearAllPoints()
	b.text:SetPoint("CENTER")
	b.text:SetJustifyH("CENTER")

	local b2 = _G["HelpFrameSubmitSuggestionSubmit"]
	b2:StripTextures(true)
	b2:SkinButton(true)
	
	local b3 = _G["HelpFrameButton6"]
	b3:ClearAllPoints()
	b3:Point("TOP", b, "BOTTOM", 0, -4)

	-- skin table options
	for i = 1, HelpFrameKnowledgebaseScrollFrameScrollChild:GetNumChildren() do
		local b = _G["HelpFrameKnowledgebaseScrollFrameButton"..i]
		b:StripTextures(true)
		b:SkinButton(true)
	end

	-- skin misc items
	HelpFrameKnowledgebaseSearchBox:ClearAllPoints()
	HelpFrameKnowledgebaseSearchBox:Point("TOPLEFT", HelpFrameMainInset, "TOPLEFT", 13, -10)
	HelpFrameKnowledgebaseNavBarOverlay:Kill()

	HelpFrameKnowledgebaseNavBar:StripTextures()

	HelpFrame:StripTextures(true)
	HelpFrame:CreateBackdrop("Default")
	HelpFrameKnowledgebaseSearchBox:SkinEditBox()
	HelpFrameKnowledgebaseScrollFrameScrollBar:SkinScrollBar()
	HelpFrameTicketScrollFrameScrollBar:SkinScrollBar()
	HelpFrameCloseButton:SkinCloseButton(HelpFrame.backdrop)	
	HelpFrameKnowledgebaseErrorFrameCloseButton:SkinCloseButton(HelpFrameKnowledgebaseErrorFrame.backdrop)

	--Hearth Stone Button
	HelpFrameCharacterStuckHearthstone:StyleButton()
	HelpFrameCharacterStuckHearthstone:SetTemplate("Default", true)
	HelpFrameCharacterStuckHearthstone.IconTexture:ClearAllPoints()
	HelpFrameCharacterStuckHearthstone.IconTexture:Point("TOPLEFT", 2, -2)
	HelpFrameCharacterStuckHearthstone.IconTexture:Point("BOTTOMRIGHT", -2, 2)
	HelpFrameCharacterStuckHearthstone.IconTexture:SetTexCoord(.08, .92, .08, .92)

	local function navButtonFrameLevel(self)
		for i=1, #self.navList do
			local navButton = self.navList[i]
			local lastNav = self.navList[i-1]
			if navButton and lastNav then
				navButton:SetFrameLevel(lastNav:GetFrameLevel() - 2)
			end
		end			
	end

	hooksecurefunc("NavBar_AddButton", function(self, buttonData)
		local navButton = self.navList[#self.navList]
		
		
		if not navButton.skinned then
			navButton:SkinButton(true)
			navButton.skinned = true
			
			navButton:HookScript("OnClick", function()
				navButtonFrameLevel(self)
			end)
		end
		
		navButtonFrameLevel(self)
	end)
	
	HelpFrameGM_ResponseScrollFrame2ScrollBar:SkinScrollBar()
	HelpFrameGM_ResponseScrollFrame1ScrollBar:SkinScrollBar()
	HelpFrameGM_ResponseNeedMoreHelp:SkinButton()
	HelpFrameGM_ResponseCancel:SkinButton()
	for i=1, HelpFrameGM_Response:GetNumChildren() do
		local child = select(i, HelpFrameGM_Response:GetChildren())
		if child and child:GetObjectType() == "Frame" and not child:GetName() then
			child:SetTemplate("Default")
		end
	end
	
	for i=1, HelpFrameReportBug:GetNumChildren() do
		local child = select(i, HelpFrameReportBug:GetChildren())
		if child and not child:GetName() then
			child:StripTextures()
			child:SetTemplate()
		end
	end
	
	for i=1, HelpFrameSubmitSuggestion:GetNumChildren() do
		local child = select(i, HelpFrameSubmitSuggestion:GetChildren())
		if child and not child:GetName() then
			child:StripTextures()
			child:SetTemplate()
		end
	end
	
	HelpFrameOpenTicketHelpItemRestoration:SkinButton()
	HelpFrameReportBugSubmit:SkinButton()
	HelpFrameSubmitSuggestionScrollFrameScrollBar:SkinScrollBar()
	HelpFrameReportBugScrollFrameScrollBar:SkinScrollBar()
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)