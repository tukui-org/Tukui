-- This will filter everythin NON user config data out of TukuiDB

local T, C, L
local myPlayerRealm = GetCVar("realmName")
local myPlayerName  = UnitName("player")

local ALLOWED_GROUPS = {
	["general"]=1,
	["unitframes"]=1,
	["arena"]=1,
	["actionbar"]=1,
	["nameplate"]=1,
	["bags"]=1,
	["loot"]=1,
	["cooldown"]=1,
	["datatext"]=1,
	["chat"]=1,
	["tooltip"]=1,
	["merchant"]=1,
	["error"]=1,
	["invite"]=1,
	["auras"]=1,
}

if TukuiEditedDefaultConfig then
	for group, value in pairs(TukuiEditedDefaultConfig) do
		if group ~= "media" and not ALLOWED_GROUPS[group] then
			-- add a new group from edited default
			ALLOWED_GROUPS[group]=1
		end
	end
end

--List of "Table Names" that we do not want to show in the config
local TableFilter = {
	["filter"]=1,
}

local function Local(o)
	local string = o
	for option, value in pairs(TukuiConfigUILocalization) do
		if option == o then
			string = value
		end
	end
	
	return string
end

local NewButton = function(text,parent)
	local T, C, L = unpack(Tukui)
	
	local result = CreateFrame("Button", nil, parent)
	local label = result:CreateFontString(nil,"OVERLAY",nil)
	label:SetFont(C.media.font,12)
	label:SetText(text)
	result:SetWidth(label:GetWidth())
	result:SetHeight(label:GetHeight())
	result:SetFontString(label)

	return result
end

StaticPopupDialogs["PERCHAR"] = {
	text = TukuiConfigUILocalization.option_perchar,
	OnAccept = function() 
		if TukuiConfigAllCharacters:GetChecked() then 
			TukuiConfigAll[myPlayerRealm][myPlayerName] = true
		else 
			TukuiConfigAll[myPlayerRealm][myPlayerName] = false
		end 	
		ReloadUI() 
	end,
	OnCancel = function() 
		TukuiConfigCover:Hide()
		if TukuiConfigAllCharacters:GetChecked() then 
			TukuiConfigAllCharacters:SetChecked(false)
		else 
			TukuiConfigAllCharacters:SetChecked(true)
		end 		
	end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs["RESET_PERCHAR"] = {
	text = TukuiConfigUILocalization.option_resetchar,
	OnAccept = function() 
		TukuiConfig = TukuiConfigPublic
		ReloadUI() 
	end,
	OnCancel = function() if TukuiConfigUI and TukuiConfigUI:IsShown() then TukuiConfigCover:Hide() end end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

StaticPopupDialogs["RESET_ALL"] = {
	text = TukuiConfigUILocalization.option_resetall,
	OnAccept = function() 
		TukuiConfigPublic = nil
		TukuiConfigPrivate = nil
		ReloadUI() 
	end,
	OnCancel = function() TukuiConfigCover:Hide() end,
	button1 = ACCEPT,
	button2 = CANCEL,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

-- We wanna make sure we have all needed tables when we try add values
local function SetValue(group,option,value)		
	--Determine if we should be copying our default settings to our player settings, this only happens if we're not using player settings by default
	local mergesettings
	if TukuiConfigPrivate == TukuiConfigPublic then
		mergesettings = true
	else
		mergesettings = false
	end

	if TukuiConfigAll[myPlayerRealm][myPlayerName] == true then
		if not TukuiConfigPrivate then TukuiConfigPrivate = {} end	
		if not TukuiConfigPrivate[group] then TukuiConfigPrivate[group] = {} end
		TukuiConfigPrivate[group][option] = value
	else
		--Set PerChar settings to the same as our settings if theres no per char settings
		if mergesettings == true then
			if not TukuiConfigPrivate then TukuiConfigPrivate = {} end	
			if not TukuiConfigPrivate[group] then TukuiConfigPrivate[group] = {} end
			TukuiConfigPrivate[group][option] = value
		end
		
		if not TukuiConfigPublic then TukuiConfigPublic = {} end
		if not TukuiConfigPublic[group] then TukuiConfigPublic[group] = {} end
		TukuiConfigPublic[group][option] = value
	end
end

local VISIBLE_GROUP = nil
local function ShowGroup(group)
	local T, C, L = unpack(Tukui)
	if(VISIBLE_GROUP) then
		_G["TukuiConfigUI"..VISIBLE_GROUP]:Hide()
	end
	if _G["TukuiConfigUI"..group] then
		local o = "TukuiConfigUI"..group
		local translate = Local(group)
		_G["TukuiConfigUITitle"]:SetText(translate)
		local height = _G["TukuiConfigUI"..group]:GetHeight()
		_G["TukuiConfigUI"..group]:Show()
		local scrollamntmax = 305
		local scrollamntmin = scrollamntmax - 10
		local max = height > scrollamntmax and height-scrollamntmin or 1
		
		if max == 1 then
			_G["TukuiConfigUIGroupSlider"]:SetValue(1)
			_G["TukuiConfigUIGroupSlider"]:Hide()
		else
			_G["TukuiConfigUIGroupSlider"]:SetMinMaxValues(0, max)
			_G["TukuiConfigUIGroupSlider"]:Show()
			_G["TukuiConfigUIGroupSlider"]:SetValue(1)
		end
		_G["TukuiConfigUIGroup"]:SetScrollChild(_G["TukuiConfigUI"..group])
		
		local x
		if TukuiConfigUIGroupSlider:IsShown() then 
			_G["TukuiConfigUIGroup"]:EnableMouseWheel(true)
			_G["TukuiConfigUIGroup"]:SetScript("OnMouseWheel", function(self, delta)
				if TukuiConfigUIGroupSlider:IsShown() then
					if delta == -1 then
						x = _G["TukuiConfigUIGroupSlider"]:GetValue()
						_G["TukuiConfigUIGroupSlider"]:SetValue(x + 10)
					elseif delta == 1 then
						x = _G["TukuiConfigUIGroupSlider"]:GetValue()			
						_G["TukuiConfigUIGroupSlider"]:SetValue(x - 30)	
					end
				end
			end)
		else
			_G["TukuiConfigUIGroup"]:EnableMouseWheel(false)
		end		
		VISIBLE_GROUP = group
	end
end

function CreateTukuiConfigUI()
	if TukuiConfigUI then
		ShowGroup("general")
		TukuiConfigUI:Show()
		return
	end
	
	-- MAIN FRAME
	local TukuiConfigUI = CreateFrame("Frame","TukuiConfigUI",UIParent)
	TukuiConfigUI:SetPoint("CENTER", UIParent, "CENTER", 90, 0)
	TukuiConfigUI:SetWidth(550)
	TukuiConfigUI:SetHeight(300)
	TukuiConfigUI:SetFrameStrata("DIALOG")
	TukuiConfigUI:SetFrameLevel(20)
	
	-- TITLE 2
	local TukuiConfigUITitleBox = CreateFrame("Frame","TukuiConfigUI",TukuiConfigUI)
	TukuiConfigUITitleBox:SetWidth(570)
	TukuiConfigUITitleBox:SetHeight(24)
	TukuiConfigUITitleBox:SetPoint("TOPLEFT", -10, 42)
	TukuiConfigUITitleBox:SetTemplate("Default")
	TukuiConfigUITitleBox:CreateShadow("Default")
	
	local title = TukuiConfigUITitleBox:CreateFontString("TukuiConfigUITitle", "OVERLAY")
	title:SetFont(C.media.font, 12)
	title:SetPoint("LEFT", TukuiConfigUITitleBox, "LEFT", 4, 0)
		
	local TukuiConfigUIBG = CreateFrame("Frame","TukuiConfigUI",TukuiConfigUI)
	TukuiConfigUIBG:SetPoint("TOPLEFT", -10, 10)
	TukuiConfigUIBG:SetPoint("BOTTOMRIGHT", 10, -10)
	TukuiConfigUIBG:SetTemplate("Default")
	TukuiConfigUIBG:CreateShadow("Default")
	
	-- GROUP SELECTION ( LEFT SIDE )
	local groups = CreateFrame("ScrollFrame", "TukuiCatagoryGroup", TukuiConfigUI)
	groups:SetPoint("TOPLEFT",-180,0)
	groups:SetWidth(150)
	groups:SetHeight(300)

	local groupsBG = CreateFrame("Frame","TukuiConfigUI",TukuiConfigUI)
	groupsBG:SetPoint("TOPLEFT", groups, -10, 10)
	groupsBG:SetPoint("BOTTOMRIGHT", groups, 10, -10)
	groupsBG:SetTemplate("Default")
	groupsBG:CreateShadow("Default")
	
	--This is our frame we will use to prevent clicking on the config, before you choose a popup window
	local TukuiConfigCover = CreateFrame("Frame", "TukuiConfigCover", TukuiConfigUI)
	TukuiConfigCover:SetPoint("TOPLEFT", TukuiCatagoryGroup, "TOPLEFT")
	TukuiConfigCover:SetPoint("BOTTOMRIGHT", TukuiConfigUI, "BOTTOMRIGHT")
	TukuiConfigCover:SetFrameLevel(TukuiConfigUI:GetFrameLevel() + 20)
	TukuiConfigCover:EnableMouse(true)
	TukuiConfigCover:SetScript("OnMouseDown", function(self) print(TukuiConfigUILocalization.option_makeselection) end)
	TukuiConfigCover:Hide()	
		
	local slider = CreateFrame("Slider", "TukuiConfigUICatagorySlider", groups)
	slider:SetPoint("TOPRIGHT", 0, 0)
	slider:SetWidth(20)
	slider:SetHeight(300)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetScript("OnValueChanged", function(self,value) groups:SetVerticalScroll(value) end)
	slider:SetTemplate("Default")
	local r,g,b,a = unpack(C["media"].bordercolor)
	slider:SetBackdropColor(r,g,b,0.2)
	local child = CreateFrame("Frame",nil,groups)
	child:SetPoint("TOPLEFT")
	local offset=5
	for group in pairs(ALLOWED_GROUPS) do
		local o = "TukuiConfigUI"..group
		local translate = Local(group)
		local button = NewButton(translate, child)
		button:SetHeight(16)
		button:SetWidth(125)
		button:SetPoint("TOPLEFT", 5,-(offset))
		button:SetScript("OnClick", function(self) ShowGroup(group) end)		
		offset=offset+20
	end
	child:SetWidth(125)
	child:SetHeight(offset)
	slider:SetMinMaxValues(0, (offset == 0 and 1 or offset-12*25))
	slider:SetValue(1)
	groups:SetScrollChild(child)
	
	local x
	_G["TukuiCatagoryGroup"]:EnableMouseWheel(true)
	_G["TukuiCatagoryGroup"]:SetScript("OnMouseWheel", function(self, delta)
		if _G["TukuiConfigUICatagorySlider"]:IsShown() then
			if delta == -1 then
				x = _G["TukuiConfigUICatagorySlider"]:GetValue()
				_G["TukuiConfigUICatagorySlider"]:SetValue(x + 10)
			elseif delta == 1 then
				x = _G["TukuiConfigUICatagorySlider"]:GetValue()			
				_G["TukuiConfigUICatagorySlider"]:SetValue(x - 20)	
			end
		end
	end)
	-- GROUP SCROLLFRAME ( RIGHT SIDE)
	local group = CreateFrame("ScrollFrame", "TukuiConfigUIGroup", TukuiConfigUI)
	group:SetPoint("TOPLEFT",0,5)
	group:SetWidth(550)
	group:SetHeight(300)
	local slider = CreateFrame("Slider", "TukuiConfigUIGroupSlider", group)
	slider:SetPoint("TOPRIGHT",0,0)
	slider:SetWidth(20)
	slider:SetHeight(300)
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:SetOrientation("VERTICAL")
	slider:SetValueStep(20)
	slider:SetTemplate("Default")
	local r,g,b,a = unpack(C["media"].bordercolor)
	slider:SetBackdropColor(r,g,b,0.2)
	slider:SetScript("OnValueChanged", function(self,value) group:SetVerticalScroll(value) end)
	
	for group in pairs(ALLOWED_GROUPS) do
		local frame = CreateFrame("Frame","TukuiConfigUI"..group,TukuiConfigUIGroup)
		frame:SetPoint("TOPLEFT")
		frame:SetWidth(325)
	
		local offset=5

		if type(C[group]) ~= "table" then error(group.." GroupName not found in config table.") return end
		for option,value in pairs(C[group]) do

			if type(value) == "boolean" then
				local button = CreateFrame("CheckButton", "TukuiConfigUI"..group..option, frame, "InterfaceOptionsCheckButtonTemplate")
				local o = "TukuiConfigUI"..group..option
				local translate = Local(group..option)
				_G["TukuiConfigUI"..group..option.."Text"]:SetText(translate)
				_G["TukuiConfigUI"..group..option.."Text"]:SetFont(C.media.font, 12)
				button:SetChecked(value)
				button:SetScript("OnClick", function(self) SetValue(group,option,(self:GetChecked() and true or false)) end)
				button:SetPoint("TOPLEFT", 5, -(offset))
				offset = offset+25
			elseif type(value) == "number" or type(value) == "string" then
				local label = frame:CreateFontString(nil,"OVERLAY",nil)
				label:SetFont(C.media.font,12)
				local o = "TukuiConfigUI"..group..option
				local translate = Local(group..option)
				label:SetText(translate)
				label:SetWidth(420)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -(offset))
				
				local editbox = CreateFrame("EditBox", nil, frame)
				editbox:SetAutoFocus(false)
				editbox:SetMultiLine(false)
				editbox:SetWidth(280)
				editbox:SetHeight(20)
				editbox:SetMaxLetters(255)
				editbox:SetTextInsets(3,0,0,0)
				editbox:SetBackdrop({
					bgFile = [=[Interface\Addons\Tukui\media\textures\blank]=], 
					tiled = false,
				})
				editbox:SetBackdropColor(0,0,0,0.5)
				editbox:SetBackdropBorderColor(0,0,0,1)
				editbox:SetFontObject(GameFontHighlight)
				editbox:SetPoint("TOPLEFT", 5, -(offset+20))
				editbox:SetText(value)
				
				editbox:SetTemplate("Default")
				
				local okbutton = CreateFrame("Button", nil, frame)
				okbutton:SetHeight(editbox:GetHeight())
				okbutton:SetWidth(editbox:GetHeight())
				okbutton:SetTemplate("Default")
				okbutton:SetPoint("LEFT", editbox, "RIGHT", 2, 0)
				
				local oktext = okbutton:CreateFontString(nil,"OVERLAY",nil)
				oktext:SetFont(C.media.font,12)
				oktext:SetText("OK")
				oktext:SetPoint("CENTER", T.Scale(1), 0)
				oktext:SetJustifyH("CENTER")
				okbutton:Hide()
 
				if type(value) == "number" then
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(group,option,tonumber(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(group,option,tonumber(editbox:GetText())) end)
				else
					editbox:SetScript("OnEscapePressed", function(self) okbutton:Hide() self:ClearFocus() self:SetText(value) end)
					editbox:SetScript("OnChar", function(self) okbutton:Show() end)
					editbox:SetScript("OnEnterPressed", function(self) okbutton:Hide() self:ClearFocus() SetValue(group,option,tostring(self:GetText())) end)
					okbutton:SetScript("OnMouseDown", function(self) editbox:ClearFocus() self:Hide() SetValue(group,option,tostring(editbox:GetText())) end)
				end
				offset = offset+45
			elseif type(value) == "table" and not TableFilter[option] then
				local label = frame:CreateFontString(nil,"OVERLAY",nil)
				label:SetFont(C.media.font,12)
				local o = "TukuiConfigUI"..group..option
				local translate = Local(group..option)
				label:SetText(translate)
				label:SetWidth(420)
				label:SetHeight(20)
				label:SetJustifyH("LEFT")
				label:SetPoint("TOPLEFT", 5, -(offset))
				
				colorbuttonname = (label:GetText().."ColorPicker")
				local colorbutton = CreateFrame("Button", colorbuttonname, frame)
				colorbutton:SetHeight(20)
				colorbutton:SetWidth(50)
				colorbutton:SetTemplate("Default")
				colorbutton:SetBackdropBorderColor(unpack(value))
				colorbutton:SetPoint("LEFT", label, "RIGHT", 2, 0)
				local colortext = colorbutton:CreateFontString(nil,"OVERLAY",nil)
				colortext:SetFont(C.media.font,12)
				colortext:SetText("Set Color")
				colortext:SetPoint("CENTER")
				colortext:SetJustifyH("CENTER")
				
				
				local function round(number, decimal)
					return (("%%.%df"):format(decimal)):format(number)
				end	
				
				colorbutton:SetScript("OnMouseDown", function(button) 
					if ColorPickerFrame:IsShown() then return end
					local oldr, oldg, oldb, olda = unpack(value)

					local function ShowColorPicker(r, g, b, a, changedCallback, sameCallback)
						HideUIPanel(ColorPickerFrame)
						ColorPickerFrame.button = button
						ColorPickerFrame:SetColorRGB(r,g,b)
						ColorPickerFrame.hasOpacity = (a ~= nil and a < 1)
						ColorPickerFrame.opacity = a
						ColorPickerFrame.previousValues = {oldr, oldg, oldb, olda}
						ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, sameCallback;
						ShowUIPanel(ColorPickerFrame)
					end
										
					local function ColorCallback(restore)
						-- Something change
						if restore ~= nil or button ~= ColorPickerFrame.button then return end

						local newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
						
						value = { newR, newG, newB, newA }
						SetValue(group,option,(value)) 
						button:SetBackdropBorderColor(newR, newG, newB, newA)	
					end
					
					local function SameColorCallback()
						value = { oldr, oldg, oldb, olda }
						SetValue(group,option,(value))
						button:SetBackdropBorderColor(oldr, oldg, oldb, olda)
					end
										
					ShowColorPicker(oldr, oldg, oldb, olda, ColorCallback, SameColorCallback)
				end)
				
				offset = offset+25
			end
		end
				
		frame:SetHeight(offset)
		frame:Hide()
	end

	local reset = NewButton(TukuiConfigUILocalization.option_button_reset, TukuiConfigUI)
	reset:SetWidth(100)
	reset:SetHeight(20)
	reset:SetPoint("BOTTOMLEFT",-10, -38)
	reset:SetScript("OnClick", function(self) 
		TukuiConfigCover:Show()
		if TukuiConfigAll[myPlayerRealm][myPlayerName] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end
	end)
	reset:SetTemplate("Default")
	reset:CreateShadow("Default")
	
	local close = NewButton(TukuiConfigUILocalization.option_button_close, TukuiConfigUI)
	close:SetWidth(100)
	close:SetHeight(20)
	close:SetPoint("BOTTOMRIGHT", 10, -38)
	close:SetScript("OnClick", function(self) TukuiConfigUI:Hide() end)
	close:SetTemplate("Default")
	close:CreateShadow("Default")
	
	local load = NewButton(TukuiConfigUILocalization.option_button_load, TukuiConfigUI)
	load:SetHeight(20)
	load:SetPoint("LEFT", reset, "RIGHT", 15, 0)
	load:SetPoint("RIGHT", close, "LEFT", -15, 0)
	load:SetScript("OnClick", function(self) ReloadUI() end)
	load:SetTemplate("Default")
	load:CreateShadow("Default")
	
	if TukuiConfigAll then
		local button = CreateFrame("CheckButton", "TukuiConfigAllCharacters", TukuiConfigUITitleBox, "InterfaceOptionsCheckButtonTemplate")
		
		button:SetScript("OnClick", function(self) StaticPopup_Show("PERCHAR") TukuiConfigCover:Show() end)
		
		button:SetPoint("RIGHT", TukuiConfigUITitleBox, "RIGHT",-3, 0)	
		
		local label = TukuiConfigAllCharacters:CreateFontString(nil,"OVERLAY",nil)
		label:SetFont(C.media.font,12)
		
		label:SetText(TukuiConfigUILocalization.option_setsavedsetttings)
		label:SetPoint("RIGHT", button, "LEFT")
		
		if TukuiConfigAll[myPlayerRealm][myPlayerName] == true then
			button:SetChecked(true)
		else
			button:SetChecked(false)
		end
	end	
	
	ShowGroup("general")
end

do
	SLASH_CONFIG1 = '/tc'
	SLASH_CONFIG2 = '/tukui'
	function SlashCmdList.CONFIG(msg, editbox)
		if not TukuiConfigUI or not TukuiConfigUI:IsShown() then
			CreateTukuiConfigUI()
		else
			TukuiConfigUI:Hide()
		end
	end
	
	SLASH_RESETCONFIG1 = '/resetconfig'
	function SlashCmdList.RESETCONFIG()
		if TukuiConfigUI and TukuiConfigUI:IsShown() then TukuiConfigCover:Show() end
		
		if TukuiConfigAll[myPlayerRealm][myPlayerName] == true then
			StaticPopup_Show("RESET_PERCHAR")
		else
			StaticPopup_Show("RESET_ALL")
		end	
	end
	
	-- create esc button
	local loaded = CreateFrame("Frame")
	loaded:RegisterEvent("PLAYER_LOGIN")
	loaded:SetScript("OnEvent", function(self, event, addon)
		T, C, L = unpack(Tukui)
		
		local menu = GameMenuFrame
		local menuy = menu:GetHeight()
		local quit = GameMenuButtonQuit
		local continue = GameMenuButtonContinue
		local continuex = continue:GetWidth()
		local continuey = continue:GetHeight()
		local config = TukuiConfigUI
		local interface = GameMenuButtonUIOptions
		local keybinds = GameMenuButtonKeybindings

		menu:SetHeight(menuy + continuey)
		
		local button = CreateFrame("BUTTON", "GameMenuTukuiButtonOptions", menu, "GameMenuButtonTemplate")
		button:SetSize(continuex, continuey)
		button:Point("TOP", interface, "BOTTOM", 0, -1)
		button:SetText("Tukui")
		
		if C.general.blizzardreskin then
			T.SkinButton(button)
		end
		
		button:SetScript("OnClick", function(self)
			local config = TukuiConfigUI
			if config and config:IsShown() then
				TukuiConfigUI:Hide()
			else
				CreateTukuiConfigUI()
				HideUIPanel(menu)
			end
		end)
		
		keybinds:ClearAllPoints()
		keybinds:Point("TOP", button, "BOTTOM", 0, -1)
	end)

end
