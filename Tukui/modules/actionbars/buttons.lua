local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
-- This is the file for our action bars settings in game via mouseover buttons around action bars.
-- I really hope you'll understand the code, because I was totally drunk when I wrote this file.
-- At least, it work fine. :P (lol)

local function ShowOrHideBar(bar, button)
	local db = TukuiDataPerChar
	
	if bar:IsShown() then
		if bar == TukuiBar5 and T.lowversion then
			if button == TukuiBar5ButtonTop then
				if TukuiBar7:IsShown() then
					TukuiBar7:Hide()
					bar:SetWidth((T.buttonsize * 2) + (T.buttonspacing * 3))
					db.hidebar7 = true
				elseif TukuiBar6:IsShown() then
					TukuiBar6:Hide()
					bar:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
					db.hidebar6 = true
				else
					bar:Hide()
				end
			else
				if button == TukuiBar5ButtonBottom then
					if not bar:IsShown() then
						bar:Show()
						bar:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
					elseif not TukuiBar6:IsShown() then
						TukuiBar6:Show()
						bar:SetWidth((T.buttonsize * 2) + (T.buttonspacing * 3))
						db.hidebar6 = false
					else
						TukuiBar7:Show()
						bar:SetWidth((T.buttonsize * 3) + (T.buttonspacing * 4))
						db.hidebar7 = false
					end
				end
			end
		else
			bar:Hide()
		end
		
		-- for bar 2�+3�+4, high reso only
		if bar == TukuiBar4 then
			TukuiBar1:SetHeight((T.buttonsize * 1) + (T.buttonspacing * 2))
			TukuiBar2:SetHeight(TukuiBar1:GetHeight())
			TukuiBar3:SetHeight(TukuiBar1:GetHeight())
			TukuiBar2Button:SetHeight(TukuiBar1:GetHeight())
			TukuiBar3Button:SetHeight(TukuiBar1:GetHeight())
		end
	else
		if bar == TukuiBar5 and T.lowversion then
			if TukuiBar7:IsShown() then
				TukuiBar7:Show()
				TukuiBar5:SetWidth((T.buttonsize * 3) + (T.buttonspacing * 4))
			elseif TukuiBar6:IsShown() then
				TukuiBar6:Show()
				TukuiBar5:SetWidth((T.buttonsize * 2) + (T.buttonspacing * 3))
			else
				bar:Show()
			end
		else
			bar:Show()
		end
		
		-- for bar 2�+3�+4, high reso only
		if bar == TukuiBar4 then
			TukuiBar1:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
			TukuiBar2:SetHeight(TukuiBar4:GetHeight())
			TukuiBar3:SetHeight(TukuiBar4:GetHeight())
			TukuiBar2Button:SetHeight(TukuiBar2:GetHeight())
			TukuiBar3Button:SetHeight(TukuiBar3:GetHeight())
		end
	end
end

local function MoveButtonBar(button, bar)
	local db = TukuiDataPerChar
	
	if button == TukuiBar2Button then
		if bar:IsShown() then
			db.hidebar2 = false
			button:ClearAllPoints()
			button:Point("BOTTOMRIGHT", TukuiBar2, "BOTTOMLEFT", -2, 0)
			button.text:SetText("|cff4BAF4C>|r")
		else
			db.hidebar2 = true
			button:ClearAllPoints()
			button:Point("BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -2, 0)
			button.text:SetText("|cff4BAF4C<|r")
		end
	end
	
	if button == TukuiBar3Button then
		if bar:IsShown() then
			db.hidebar3 = false
			button:ClearAllPoints()
			button:Point("BOTTOMLEFT", TukuiBar3, "BOTTOMRIGHT", 2, 0)
			button.text:SetText("|cff4BAF4C<|r")
		else
			db.hidebar3 = true
			button:ClearAllPoints()
			button:Point("BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 2, 0)
			button.text:SetText("|cff4BAF4C>|r")
		end
	end

	if button == TukuiBar4Button then
		if bar:IsShown() then
			db.hidebar4 = false
			button.text:SetText("|cff4BAF4C- - - - - -|r")
		else
			db.hidebar4 = true
			button.text:SetText("|cff4BAF4C+ + + + + +|r")
		end
	end
	
	if button == TukuiBar5ButtonTop or button == TukuiBar5ButtonBottom then		
		local buttontop = TukuiBar5ButtonTop
		local buttonbot = TukuiBar5ButtonBottom
		if bar:IsShown() then
			db.hidebar5 = false
			buttontop:ClearAllPoints()
			buttontop:Size(bar:GetWidth(), 17)
			buttontop:Point("BOTTOM", bar, "TOP", 0, 2)
			if not T.lowversion then buttontop.text:SetText("|cff4BAF4C>|r") end
			buttonbot:ClearAllPoints()
			buttonbot:Size(bar:GetWidth(), 17)
			buttonbot:Point("TOP", bar, "BOTTOM", 0, -2)
			if not T.lowversion then buttonbot.text:SetText("|cff4BAF4C>|r") end
				
			-- move the pet
			TukuiPetBar:ClearAllPoints()
			TukuiPetBar:Point("RIGHT", bar, "LEFT", -6, 0)		
		else
			db.hidebar5 = true
			buttonbot:ClearAllPoints()
			buttonbot:SetSize(TukuiLineToPetActionBarBackground:GetWidth(), TukuiLineToPetActionBarBackground:GetHeight())
			buttonbot:Point("LEFT", TukuiPetBar, "RIGHT", 2, 0)
			if not T.lowversion then buttonbot.text:SetText("|cff4BAF4C<|r") end
			buttontop:ClearAllPoints()
			buttontop:SetSize(TukuiLineToPetActionBarBackground:GetWidth(), TukuiLineToPetActionBarBackground:GetHeight())
			buttontop:Point("LEFT", TukuiPetBar, "RIGHT", 2, 0)
			if not T.lowversion then buttontop.text:SetText("|cff4BAF4C<|r") end
			
			-- move the pet
			TukuiPetBar:ClearAllPoints()
			TukuiPetBar:Point("RIGHT", UIParent, "RIGHT", -23, -14)
		end	
	end
end

local function DrPepper(self, bar) -- guess what! :P
	-- yep, you cannot drink DrPepper while in combat. :(
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	
	local button = self
	
	ShowOrHideBar(bar, button)
	MoveButtonBar(button, bar)
end

local TukuiBar2Button = CreateFrame("Button", "TukuiBar2Button", UIParent)
TukuiBar2Button:Width(17)
TukuiBar2Button:SetHeight(TukuiBar2:GetHeight())
if T.lowversion then
	TukuiBar2Button:Point("BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", 2, 0)
else
	TukuiBar2Button:Point("BOTTOMRIGHT", TukuiBar2, "BOTTOMLEFT", -2, 0)
end
TukuiBar2Button:SetTemplate("Default")
TukuiBar2Button:RegisterForClicks("AnyUp")
TukuiBar2Button:SetAlpha(0)
TukuiBar2Button:SetScript("OnClick", function(self) DrPepper(self, TukuiBar2) end)
TukuiBar2Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar2Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar2Button.text = T.SetFontString(TukuiBar2Button, C.media.uffont, 20)
TukuiBar2Button.text:Point("CENTER", 1, 1)
TukuiBar2Button.text:SetText("|cff4BAF4C>|r")

local TukuiBar3Button = CreateFrame("Button", "TukuiBar3Button", UIParent)
TukuiBar3Button:Width(17)
TukuiBar3Button:SetHeight(TukuiBar3:GetHeight())
if T.lowversion then
	TukuiBar3Button:Point("BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 2, 0)
else
	TukuiBar3Button:Point("BOTTOMLEFT", TukuiBar3, "BOTTOMRIGHT", 2, 0)
end
TukuiBar3Button:SetTemplate("Default")
TukuiBar3Button:RegisterForClicks("AnyUp")
TukuiBar3Button:SetAlpha(0)
TukuiBar3Button:SetScript("OnClick", function(self) DrPepper(self, TukuiBar3) end)
TukuiBar3Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar3Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar3Button.text = T.SetFontString(TukuiBar3Button, C.media.uffont, 20)
TukuiBar3Button.text:Point("CENTER", 1, 1)
TukuiBar3Button.text:SetText("|cff4BAF4C<|r")

local TukuiBar4Button = CreateFrame("Button", "TukuiBar4Button", UIParent)
TukuiBar4Button:SetWidth(TukuiBar1:GetWidth())
TukuiBar4Button:Height(10)
TukuiBar4Button:Point("TOP", TukuiBar1, "BOTTOM", 0, -2)
TukuiBar4Button:SetTemplate("Default")
TukuiBar4Button:RegisterForClicks("AnyUp")
TukuiBar4Button:SetAlpha(0)
TukuiBar4Button:SetScript("OnClick", function(self) DrPepper(self, TukuiBar4) end)
TukuiBar4Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar4Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar4Button.text = T.SetFontString(TukuiBar4Button, C.media.uffont, 30)
TukuiBar4Button.text:SetPoint("CENTER", 0, 0)
TukuiBar4Button.text:SetText("|cff4BAF4C- - - - - -|r")

local TukuiBar5ButtonTop = CreateFrame("Button", "TukuiBar5ButtonTop", UIParent)
TukuiBar5ButtonTop:SetWidth(TukuiBar5:GetWidth())
TukuiBar5ButtonTop:Height(17)
TukuiBar5ButtonTop:Point("BOTTOM", TukuiBar5, "TOP", 0, 2)
TukuiBar5ButtonTop:SetTemplate("Default")
TukuiBar5ButtonTop:RegisterForClicks("AnyUp")
TukuiBar5ButtonTop:SetAlpha(0)
TukuiBar5ButtonTop:SetScript("OnClick", function(self) DrPepper(self, TukuiBar5) end)
TukuiBar5ButtonTop:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar5ButtonTop:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar5ButtonTop.text = T.SetFontString(TukuiBar5ButtonTop, C.media.uffont, 20)
TukuiBar5ButtonTop.text:Point("CENTER", 1, 1)
TukuiBar5ButtonTop.text:SetText("|cff4BAF4C>|r")

local TukuiBar5ButtonBottom = CreateFrame("Button", "TukuiBar5ButtonBottom", UIParent)
TukuiBar5ButtonBottom:SetFrameLevel(TukuiBar5ButtonTop:GetFrameLevel() + 1)
TukuiBar5ButtonBottom:SetWidth(TukuiBar5:GetWidth())
TukuiBar5ButtonBottom:Height(17)
TukuiBar5ButtonBottom:Point("TOP", TukuiBar5, "BOTTOM", 0, -2)
TukuiBar5ButtonBottom:SetTemplate("Default")
TukuiBar5ButtonBottom:RegisterForClicks("AnyUp")
TukuiBar5ButtonBottom:SetAlpha(0)
TukuiBar5ButtonBottom:SetScript("OnClick", function(self) DrPepper(self, TukuiBar5) end)
TukuiBar5ButtonBottom:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar5ButtonBottom:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar5ButtonBottom.text = T.SetFontString(TukuiBar5ButtonBottom, C.media.uffont, 20)
TukuiBar5ButtonBottom.text:Point("CENTER", 1, 1)
if T.lowversion then TukuiBar5ButtonBottom.text:SetText("|cff4BAF4C<|r") else TukuiBar5ButtonBottom.text:SetText("|cff4BAF4C>|r") end

-- exit vehicle button on left side of bottom action bar
local vehicleleft = CreateFrame("Button", "TukuiExitVehicleButtonLeft", UIParent, "SecureHandlerClickTemplate")
vehicleleft:SetAllPoints(TukuiBar2Button)
vehicleleft:SetFrameStrata(TukuiBar2Button:GetFrameStrata())
vehicleleft:SetFrameLevel(TukuiBar2Button:GetFrameLevel() + 1)
vehicleleft:SetTemplate("Default")
vehicleleft:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleleft:RegisterForClicks("AnyUp")
vehicleleft:SetScript("OnClick", function() VehicleExit() end)
vehicleleft.text = T.SetFontString(vehicleleft, C.media.uffont, 20)
vehicleleft.text:SetPoint("CENTER", T.Scale(1), T.Scale(1))
vehicleleft.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleleft, "visibility", "[target=vehicle,exists] show;hide")

-- exit vehicle button on right side of bottom action bar
local vehicleright = CreateFrame("Button", "TukuiExitVehicleButtonRight", UIParent, "SecureHandlerClickTemplate")
vehicleright:SetAllPoints(TukuiBar3Button)
vehicleright:SetTemplate("Default")
vehicleright:SetFrameStrata(TukuiBar3Button:GetFrameStrata())
vehicleright:SetFrameLevel(TukuiBar3Button:GetFrameLevel() + 1)
vehicleright:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleright:RegisterForClicks("AnyUp")
vehicleright:SetScript("OnClick", function() VehicleExit() end)
vehicleright.text = T.SetFontString(vehicleright, C.media.uffont, 20)
vehicleright.text:SetPoint("CENTER", T.Scale(1), T.Scale(1))
vehicleright.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleright, "visibility", "[target=vehicle,exists] show;hide")

--------------------------------------------------------------
-- DrPepper taste is really good with Vodka. 
--------------------------------------------------------------

local init = CreateFrame("Frame")
init:RegisterEvent("VARIABLES_LOADED")
init:SetScript("OnEvent", function(self, event)
	if not TukuiDataPerChar then TukuiDataPerChar = {} end
	local db = TukuiDataPerChar
	
	if not T.lowversion and db.hidebar2 then 
		DrPepper(TukuiBar2Button, TukuiBar2)
	end
	
	if not T.lowversion and db.hidebar3 then
		DrPepper(TukuiBar3Button, TukuiBar3)
	end
	
	if db.hidebar4 then
		DrPepper(TukuiBar4Button, TukuiBar4)
	end
		
	if T.lowversion then
		-- because we use bar6.lua and bar7.lua with TukuiBar5Button for lower reso.
		TukuiBar2Button:Hide()
		TukuiBar3Button:Hide()
		if db.hidebar7 then
			TukuiBar7:Hide()
			TukuiBar5:SetWidth((T.buttonsize * 2) + (T.buttonspacing * 3))
		end
		
		if db.hidebar6 then
			TukuiBar6:Hide()
			TukuiBar5:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
		end
		
		TukuiBar5ButtonTop:SetWidth(TukuiBar5:GetWidth())
		TukuiBar5ButtonBottom:SetWidth(TukuiBar5:GetWidth())
	end
	
	if db.hidebar5 then
		DrPepper(TukuiBar5ButtonTop, TukuiBar5)
	end
end)