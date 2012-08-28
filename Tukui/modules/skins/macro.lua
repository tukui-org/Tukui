local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	MacroFrameCloseButton:SkinCloseButton()
	
	MacroFrame:Width(360)
	
	local buttons = {
		"MacroDeleteButton",
		"MacroNewButton",
		"MacroExitButton",
		"MacroEditButton",
		"MacroFrameTab1",
		"MacroFrameTab2",
		"MacroPopupOkayButton",
		"MacroPopupCancelButton",
		"MacroSaveButton",
		"MacroCancelButton",
	}
	
	for i = 1, #buttons do
		if _G[buttons[i]] then
			_G[buttons[i]]:StripTextures()
			_G[buttons[i]]:SkinButton()
		end
	end
	
	for i = 1, 2 do
		tab = _G[format("MacroFrameTab%s", i)]
		tab:Height(22)
	end
	MacroFrameTab1:Point("TOPLEFT", MacroFrame, "TOPLEFT", 85, -39)
	MacroFrameTab2:Point("LEFT", MacroFrameTab1, "RIGHT", 4, 0)
	

	-- General
	MacroFrame:StripTextures()
	MacroFrame:SetTemplate("Default")
	MacroFrameTextBackground:StripTextures()
	MacroFrameTextBackground:CreateBackdrop()
	MacroButtonScrollFrame:CreateBackdrop()
	MacroPopupFrame:StripTextures()
	MacroPopupFrame:SetTemplate("Default")
	MacroPopupScrollFrame:StripTextures()
	MacroPopupScrollFrame:CreateBackdrop()
	MacroPopupScrollFrame.backdrop:Point("TOPLEFT", 51, 2)
	MacroPopupScrollFrame.backdrop:Point("BOTTOMRIGHT", -4, 4)
	MacroPopupEditBox:CreateBackdrop()
	MacroPopupEditBox:StripTextures()
	
	--Reposition edit button
	MacroEditButton:ClearAllPoints()
	MacroEditButton:Point("BOTTOMLEFT", MacroFrameSelectedMacroButton, "BOTTOMRIGHT", 10, 0)
	
	-- Regular scroll bar
	MacroButtonScrollFrame:SkinScrollBar()
	
	MacroPopupFrame:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:Point("TOPLEFT", MacroFrame, "TOPRIGHT", 5, -2)
	end)
	
	-- Big icon
	MacroFrameSelectedMacroButton:StripTextures()
	MacroFrameSelectedMacroButton:StyleButton()
	MacroFrameSelectedMacroButton:GetNormalTexture():SetTexture(nil)
	MacroFrameSelectedMacroButton:SetTemplate("Default")
	MacroFrameSelectedMacroButtonIcon:SetTexCoord(.08, .92, .08, .92)
	MacroFrameSelectedMacroButtonIcon:ClearAllPoints()
	MacroFrameSelectedMacroButtonIcon:Point("TOPLEFT", 2, -2)
	MacroFrameSelectedMacroButtonIcon:Point("BOTTOMRIGHT", -2, 2)
	
	-- temporarily moving this text
	MacroFrameCharLimitText:ClearAllPoints()
	MacroFrameCharLimitText:Point("BOTTOM", MacroFrameTextBackground, 0, -70)
	
	-- Skin all buttons
	for i = 1, MAX_ACCOUNT_MACROS do
		local b = _G["MacroButton"..i]
		local t = _G["MacroButton"..i.."Icon"]
		local pb = _G["MacroPopupButton"..i]
		local pt = _G["MacroPopupButton"..i.."Icon"]
		
		if b then
			b:StripTextures()
			b:StyleButton()
			
			b:SetTemplate("Default", true)
		end
		
		if t then
			t:SetTexCoord(.08, .92, .08, .92)
			t:ClearAllPoints()
			t:Point("TOPLEFT", 2, -2)
			t:Point("BOTTOMRIGHT", -2, 2)
		end

		if pb then
			pb:StripTextures()
			pb:StyleButton()
			
			pb:SetTemplate("Default")					
		end
		
		if pt then
			pt:SetTexCoord(.08, .92, .08, .92)
			pt:ClearAllPoints()
			pt:Point("TOPLEFT", 2, -2)
			pt:Point("BOTTOMRIGHT", -2, 2)
		end
	end
	
	-- scroll bars
	MacroButtonScrollFrameScrollBar:SkinScrollBar()
	MacroFrameScrollFrameScrollBar:SkinScrollBar()
	MacroPopupScrollFrameScrollBar:SkinScrollBar()
	MacroFrameInset:StripTextures()
	MacroFrameEnterMacroText:SetAlpha(0)
	MacroFrameCharLimitText:SetAlpha(0)
end

T.SkinFuncs["Blizzard_MacroUI"] = LoadSkin