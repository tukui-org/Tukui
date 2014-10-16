local TukuiConfig = CreateFrame("Frame", "TukuiConfig", UIParent)
TukuiConfig.Functions = {}
local GroupPages = {}
local Locale = GetLocale()
local Colors = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
local DropDownMenus = {}

if (Locale == "enGB") then
	Locale = "enUS"
end

function TukuiConfig:SetOption(group, option, value)
	local C = TukuiConfigNotShared
	
	if (not C[group]) then
		C[group] = {}
	end
	
	C[group][option] = value -- Save our setting
	
	if (not self.Functions[group]) then
		return
	end
	
	if self.Functions[group][option] then
		self.Functions[group][option](value) -- Run the associated function
	end
end

function TukuiConfig:SetCallback(group, option, func)
	if (not self.Functions[group]) then
		self.Functions[group] = {}
	end
	
	self.Functions[group][option] = func -- Set a function to call
end

TukuiConfig.ColorDefaults = {
	["Chat"] = {
		["LinkColor"] = {0.08, 1, 0.36},
	},

	["DataTexts"] = {
		["NameColor"] = {1, 1, 1},
		["ValueColor"] = {1, 1, 1},
	},
	
	["General"] = {
		["BackdropColor"] = {0.1, 0.1, 0.1},
		["BorderColor"] = {0.6, 0.6, 0.6},
	},
}

function TukuiConfig:UpdateColorDefaults()
	local C = Tukui[2]
	
	self.ColorDefaults["General"]["BorderColor"] = {0.6, 0.6, 0.6}
	self.ColorDefaults["General"]["BackdropColor"] = {0.1, 0.1, 0.1}
end

-- Filter unwanted groups
TukuiConfig.Filter = {
	["Medias"] = true,
	["OrderedIndex"] = true,
}

local Credits = {
	"Elv",
	"Hydra",
	"Haste",
	"Nightcracker",
	"Haleth",
	"Caellian",
	"Shestak",
	"Tekkub",
	"Roth",
	"Alza",
	"P3lim",
	"Tulla",
	"Hungtar",
	"Ishtara",
	"Caith",
	"Azilroka",
}

local GetOrderedIndex = function(t)
    local OrderedIndex = {}
	
    for key in pairs(t) do
        table.insert(OrderedIndex, key)
    end
	
    table.sort(OrderedIndex)
	
    return OrderedIndex
end

local OrderedNext = function(t, state)
	local Key
	
    if (state == nil) then
        t.OrderedIndex = GetOrderedIndex(t)
        Key = t.OrderedIndex[1]
		
        return Key, t[Key]
    end
	
    Key = nil
	
    for i = 1, #t.OrderedIndex do
        if (t.OrderedIndex[i] == state) then
            Key = t.OrderedIndex[i + 1]
        end
    end
	
    if Key then
        return Key, t[Key]
    end
	
    t.OrderedIndex = nil
	
    return
end

local PairsByKeys = function(t)
    return OrderedNext, t, nil
end

-- Create custom controls for options.
local ControlOnEnter = function(self)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, 2)
	GameTooltip:AddLine(self.Tooltip, 1, 1, 1, 1, 1)
	GameTooltip:Show()
end

local ControlOnLeave = function(self)
	GameTooltip:Hide()
end

local SetControlInformation = function(control, group, option)
	if (not TukuiConfig[Locale] or not TukuiConfig[Locale][group]) then
		control.Label:SetText(option) -- Set what info we can for it
		
		return
	end
	
	if (not TukuiConfig[Locale][group][option]) then
		control.Label:SetText(option) -- Set what info we can for it
	end
	
	local Info = TukuiConfig[Locale][group][option]
	
	if (not Info) then
		return
	end
	
	control.Label:SetText(Info.Name)
	
	if control.Box then
		control.Box.Tooltip = Info.Desc
		control.Box:HookScript("OnEnter", ControlOnEnter)
		control.Box:HookScript("OnLeave", ControlOnLeave)
	else
		control.Tooltip = Info.Desc
		control:HookScript("OnEnter", ControlOnEnter)
		control:HookScript("OnLeave", ControlOnLeave)
	end
end

local EditBoxOnMouseDown = function(self)
	self:SetAutoFocus(true)
end

local EditBoxOnEditFocusLost = function(self)
	self:SetAutoFocus(false)
end

local EditBoxOnEnterPressed = function(self)
	self:SetAutoFocus(false)
	self:ClearFocus()
	
	local Value = self:GetText()
	
	if (type(tonumber(Value)) == "number") then -- Assume we want a number, not a string
		Value = tonumber(Value)
	end
	
	TukuiConfig:SetOption(self.Group, self.Option, Value)
end

local EditBoxOnMouseWheel = function(self, delta)
	local Number = tonumber(self:GetText())
	
	if (delta > 0) then
		Number = Number + 1
	else
		Number = Number - 1
	end
	
	self:SetText(Number)
end

local ButtonOnClick = function(self)
	if self.Toggled then
		self.Tex:SetAnimation("Gradient", "texture", 0, 0.3, 1, 0, 0, nil, 0, 1, 0)
		self.Toggled = false
	else
		self.Tex:SetAnimation("Gradient", "texture", 0, 0.3, 0, 1, 0, nil, 1, 0, 0)
		self.Toggled = true
	end
	
	TukuiConfig:SetOption(self.Group, self.Option, self.Toggled)
end

local ButtonCheck = function(self)
	self.Toggled = true
	self.Tex:SetTexture(0, 1, 0)
end

local ButtonUncheck = function(self)
	self.Toggled = false
	self.Tex:SetTexture(1, 0, 0)
end

local ResetColor = function(self)
	local Defaults = TukuiConfig.ColorDefaults
	
	if (Defaults[self.Group] and Defaults[self.Group][self.Option]) then
		local Default = Defaults[self.Group][self.Option]
		
		self.Color:SetTexture(Default[1], Default[2], Default[3])
		TukuiConfig:SetOption(self.Group, self.Option, {Default[1], Default[2], Default[3]})
	end
end

local SetSelectedValue = function(dropdown, value)
	local Key
	
	if (dropdown.Type == "Custom") then
		for k, v in pairs(dropdown.Info.Options) do
			if (v == value) then
				Key = k
				
				break
			end
		end
	end
	
	if Key then
		value = Key
	end
	
	if dropdown[value] then
		if (dropdown.Type == "Texture") then
			dropdown.CurrentTex:SetTexture(dropdown[value])
		elseif (dropdown.Type == "Font") then
			dropdown.Current:SetFontObject(dropdown[value])
		end
		
		dropdown.Current:SetText((value))
	end
end

local SetIconUp = function(self)
	self:ClearAllPoints()
	self:Point("CENTER", self.Owner, 1, -4)
	self:SetTexture("Interface\\BUTTONS\\Arrow-Down-Up")
end

local SetIconDown = function(self)
	self:ClearAllPoints()
	self:Point("CENTER", self.Owner, 1, 1)
	self:SetTexture("Interface\\BUTTONS\\Arrow-Up-Up")
end

local ListItemOnClick = function(self)
	local List = self.Owner
	local DropDown = List.Owner
	
	if (DropDown.Type == "Texture") then
		DropDown.CurrentTex:SetTexture(self.Value)
	elseif (DropDown.Type == "Font") then
		DropDown.Current:SetFontObject(self.Value)
	else
		DropDown.Info.Value = self.Value
	end
	
	DropDown.Current:SetText(self.Name)
	
	SetIconUp(DropDown.Button.Tex)
	List:Hide()
	
	if (DropDown.Type == "Custom") then
		TukuiConfig:SetOption(DropDown._Group, DropDown._Option, DropDown.Info)
	else
		TukuiConfig:SetOption(DropDown._Group, DropDown._Option, self.Name)
	end
end

local ListItemOnEnter = function(self)
	self.Hover:SetTexture(0.2, 1, 0.2, 0.5)
end

local ListItemOnLeave = function(self)
	self.Hover:SetTexture(0.2, 1, 0.2, 0)
end

local AddListItems = function(self, info)
	local DropDown = self.Owner
	local Type = DropDown.Type
	local Height = 3
	local LastItem
	
	for Name, Value in pairs(info) do
		local Button = CreateFrame("Button", nil, self)
		Button:Size(self:GetWidth() - 4, 18)
		
		local Text = Button:CreateFontString(nil, "OVERLAY")
		Text:Point("LEFT", Button, 4, 0)
		
		if (Type ~= "Font") then
			local C = Tukui[2]
			
			Text:SetFont(C.Medias.Font, 12)
			Text:SetShadowColor(0, 0, 0)
			Text:SetShadowOffset(1.25, -1.25)
		else
			Text:SetFontObject(Value)
		end
		
		Text:SetText(Name)
		
		if (Type == "Texture") then
			local Bar = self:CreateTexture(nil, "ARTWORK")
			Bar:SetAllPoints(Button)
			Bar:SetTexture(Value)
			Bar:SetVertexColor(Colors.r, Colors.g, Colors.b)
			
			Button.Bar = Bar
		end
		
		local Hover = Button:CreateTexture(nil, "OVERLAY")
		Hover:SetAllPoints()
		
		Button.Owner = self
		Button.Name = Name
		Button.Text = Text
		Button.Value = Value
		Button.Hover = Hover
		
		Button:SetScript("OnClick", ListItemOnClick)
		Button:SetScript("OnEnter", ListItemOnEnter)
		Button:SetScript("OnLeave", ListItemOnLeave)
		
		if (not LastItem) then
			Button:Point("TOP", self, 0, -2)
		else
			Button:Point("TOP", LastItem, "BOTTOM", 0, -1)
		end
		
		DropDown[Name] = Value
		
		LastItem = Button
		Height = Height + 19
	end
	
	self:Height(Height)
end

local CloseOtherLists = function(self)
	for i = 1, #DropDownMenus do
		local Menu = DropDownMenus[i]
		local List = Menu.List
		
		if (self ~= Menu and List:IsVisible()) then
			List:Hide()
			SetIconUp(Menu.Button.Tex)
		end
	end
end

local DropDownButtonOnClick = function(self)
	local DropDown = self.Owner
	local Texture = self.Tex
	
	if DropDown.List then
		local List = DropDown.List
		CloseOtherLists(DropDown)
		
		if List:IsVisible() then
			DropDown.List:Hide()
			SetIconUp(Texture)
		else
			DropDown.List:Show()
			SetIconDown(Texture)
		end
	end
end

local SliderOnValueChanged = function(self, value)
	if (not self.ScrollFrame.Set) and (self.ScrollFrame:GetVerticalScrollRange() ~= 0) then
		self:SetMinMaxValues(0, floor(self.ScrollFrame:GetVerticalScrollRange()) - 1)
		self.ScrollFrame.Set = true
	end
	
	self.ScrollFrame:SetVerticalScroll(value)
end

local SliderOnMouseWheel = function(self, delta)
	local Value = self:GetValue()
	
	if (delta > 0) then
		Value = Value - 10
	else
		Value = Value + 10
	end
	
	self:SetValue(Value)
end

local CreateConfigButton = function(parent, group, option, value)
	local C = Tukui[2]
	
	local Button = CreateFrame("Button", nil, parent)
	Button:SetTemplate()
	Button:SetSize(20, 20)
	Button.Toggled = false
	Button:SetScript("OnClick", ButtonOnClick)
	Button.Type = "Button"
	
	Button.Tex = Button:CreateTexture(nil, "OVERLAY")
	Button.Tex:SetPoint("TOPLEFT", 2, -2)
	Button.Tex:SetPoint("BOTTOMRIGHT", -2, 2)
	Button.Tex:SetTexture(1, 0, 0)
	
	Button.Check = ButtonCheck
	Button.Uncheck = ButtonUncheck
	
	Button.Group = group
	Button.Option = option
	
	Button.Label = Button:CreateFontString(nil, "OVERLAY")
	Button.Label:SetFont(C.Medias.Font, 12)
	Button.Label:SetPoint("LEFT", Button, "RIGHT", 5, 0)
	Button.Label:SetShadowColor(0, 0, 0)
	Button.Label:SetShadowOffset(1.25, -1.25)
	
	if value then
		Button:Check()
	else
		Button:Uncheck()
	end
	
	return Button
end

local CreateConfigEditBox = function(parent, group, option, value, max)
	local C = Tukui[2]
	
	local EditBox = CreateFrame("Frame", nil, parent)
	EditBox:SetSize(50, 20)
	EditBox:SetTemplate()
	EditBox.Type = "EditBox"
	
	EditBox.Box = CreateFrame("EditBox", nil, EditBox)
	EditBox.Box:SetFont(C.Medias.Font, 12)
	EditBox.Box:SetPoint("TOPLEFT", EditBox, 4, -2)
	EditBox.Box:SetPoint("BOTTOMRIGHT", EditBox, -4, 2)
	EditBox.Box:SetMaxLetters(max or 4)
	EditBox.Box:SetAutoFocus(false)
	EditBox.Box:EnableKeyboard(true)
	EditBox.Box:EnableMouse(true)
	EditBox.Box:SetScript("OnMouseDown", EditBoxOnMouseDown)
	EditBox.Box:SetScript("OnEscapePressed", EditBoxOnEnterPressed)
	EditBox.Box:SetScript("OnEnterPressed", EditBoxOnEnterPressed)
	EditBox.Box:SetScript("OnEditFocusLost", EditBoxOnEditFocusLost)
	EditBox.Box:SetScript("OnTextChanged", EditBoxOnEnterPressed)
	EditBox.Box:SetText(value)
	
	if (not max) then
		EditBox.Box:EnableMouseWheel(true)
		EditBox.Box:SetScript("OnMouseWheel", EditBoxOnMouseWheel)
	end
	
	EditBox.Label = EditBox:CreateFontString(nil, "OVERLAY")
	EditBox.Label:SetFont(C.Medias.Font, 12)
	EditBox.Label:SetPoint("LEFT", EditBox, "RIGHT", 5, 0)
	EditBox.Label:SetShadowColor(0, 0, 0)
	EditBox.Label:SetShadowOffset(1.25, -1.25)
	
	EditBox.Box.Group = group
	EditBox.Box.Option = option
	EditBox.Box.Label = EditBox.Label
	
	return EditBox
end

local CreateConfigColorPicker = function(parent, group, option, value)
	local C = Tukui[2]
	
	local Button = CreateFrame("Button", nil, parent)
	Button:SetTemplate()
	Button:SetSize(50, 20)
	Button.Colors = value
	Button.Type = "Color"
	Button.Group = group
	Button.Option = option
	
	Button:RegisterForClicks("AnyUp")
	Button:SetScript("OnClick", function(self, button)
		if (button == "RightButton") then
			ResetColor(self)
		else
			if ColorPickerFrame:IsShown() then
				return
			end
			
			local OldR, OldG, OldB, OldA = unpack(value)
			
			local ShowColorPicker = function(r, g, b, a, changedCallback, sameCallback)
				HideUIPanel(ColorPickerFrame)
				ColorPickerFrame.button = self
				ColorPickerFrame:SetColorRGB(r, g, b)
				ColorPickerFrame.hasOpacity = (a ~= nil and a < 1)
				ColorPickerFrame.opacity = a
				ColorPickerFrame.previousValues = {OldR, OldG, OldB, OldA}
				ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, sameCallback
				ShowUIPanel(ColorPickerFrame)
			end
			
			local ColorCallback = function(restore)
				if (restore ~= nil or self ~= ColorPickerFrame.button) then
					return
				end
				
				local NewA, NewR, NewG, NewB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
				
				value = {NewR, NewG, NewB, NewA}
				TukuiConfig:SetOption(group, option, value)
				self.Color:SetTexture(NewR, NewG, NewB, NewA)	
			end
			
			local SameColorCallback = function()
				value = {OldR, OldG, OldB, OldA}
				TukuiConfig:SetOption(group, option, value)
				self.Color:SetTexture(OldR, OldG, OldB, OldA)
			end
			
			ShowColorPicker(OldR, OldG, OldB, OldA, ColorCallback, SameColorCallback)
		end
	end)
	
	Button.Name = Button:CreateFontString(nil, "OVERLAY")
	Button.Name:SetFont(C.Medias.Font, 12)
	Button.Name:SetPoint("CENTER", Button)
	Button.Name:SetShadowColor(0, 0, 0)
	Button.Name:SetShadowOffset(1.25, -1.25)
	Button.Name:SetText(COLOR)
	
	Button.Color = Button:CreateTexture(nil, "OVERLAY")
	Button.Color:Point("TOPLEFT", 2, -2)
	Button.Color:Point("BOTTOMRIGHT", -2, 2)
	Button.Color:SetTexture(value[1], value[2], value[3])
	
	Button.Label = Button:CreateFontString(nil, "OVERLAY")
	Button.Label:SetFont(C.Medias.Font, 12)
	Button.Label:SetPoint("LEFT", Button, "RIGHT", 5, 0)
	Button.Label:SetShadowColor(0, 0, 0)
	Button.Label:SetShadowOffset(1.25, -1.25)
	
	return Button
end

local CreateConfigDropDown = function(parent, group, option, value, type)
	local T, C = Tukui:unpack()
	
	local DropDown = CreateFrame("Button", nil, parent)
	DropDown:Size(100, 20)
	DropDown:SetTemplate()
	DropDown.Type = type
	DropDown._Group = group
	DropDown._Option = option
	local Info
	
	if (type == "Font") then
		Info = T.FontTable
	elseif (type == "Texture") then
		Info = T.TextureTable
	else
		Info = value
	end
	
	DropDown.Info = Info
	
	local Current = DropDown:CreateFontString(nil, "OVERLAY")
	Current:SetPoint("LEFT", DropDown, 6, -0.5)
	
	if (type == "Texture") then
		local CurrentTex = DropDown:CreateTexture(nil, "ARTWORK")
		CurrentTex:Size(DropDown:GetWidth() - 4, 16)
		CurrentTex:Point("LEFT", DropDown, 2, 0)
		CurrentTex:SetVertexColor(Colors.r, Colors.g, Colors.b)
		DropDown.CurrentTex = CurrentTex
		
		Current:SetFont(C.Medias.Font, 12)
		Current:SetShadowColor(0, 0, 0)
		Current:SetShadowOffset(1.25, -1.25)
	elseif (type == "Custom") then
		Current:SetFont(C.Medias.Font, 12)
		Current:SetShadowColor(0, 0, 0)
		Current:SetShadowOffset(1.25, -1.25)
	end
	
	local Button = CreateFrame("Button", nil, DropDown)
	Button:Size(16, 16)
	Button:SetTemplate()
	Button:Point("RIGHT", DropDown, -2, 0)
	Button.Owner = DropDown
	
	local ButtonTex = Button:CreateTexture(nil, "OVERLAY")
	ButtonTex:Size(14, 14)
	ButtonTex:Point("CENTER", Button, 1, -4)
	ButtonTex:SetTexture("Interface\\BUTTONS\\Arrow-Down-Up")
	ButtonTex.Owner = Button
	
	local Label = DropDown:CreateFontString(nil, "OVERLAY")
	Label:SetFont(C.Medias.Font, 12)
	Label:SetShadowColor(0, 0, 0)
	Label:SetShadowOffset(1.25, -1.25)
	Label:SetPoint("LEFT", DropDown, "RIGHT", 5, 0)
	
	local List = CreateFrame("Frame", nil, DropDown)
	List:Point("TOPLEFT", DropDown, "BOTTOMLEFT", 0, -3)
	List:SetTemplate()
	List:Hide()
	List:Width(100)
	List:SetFrameLevel(DropDown:GetFrameLevel() + 3)
	List:EnableMouse(true)
	List.Owner = DropDown
	
	if (type == "Custom") then
		AddListItems(List, Info.Options)
	else
		AddListItems(List, Info)
	end
	
	DropDown.Label = Label
	DropDown.Button = Button
	DropDown.Current = Current
	DropDown.List = List
	
	Button.Tex = ButtonTex
	Button:SetScript("OnClick", DropDownButtonOnClick)
	
	if (type == "Custom") then
		SetSelectedValue(DropDown, value.Value)
	else
		SetSelectedValue(DropDown, value)	
	end
	tinsert(DropDownMenus, DropDown)
	
	return DropDown
end

local CreateGroupOptions = function(group)
	local Control
	local LastControl
	local GroupPage = GroupPages[group]
	local Group = group

	for Option, Value in pairs(Tukui[2][group]) do
		if (type(Value) == "boolean") then -- Button
			Control = CreateConfigButton(GroupPage, Group, Option, Value)
		elseif (type(Value) == "number") then -- EditBox
			Control = CreateConfigEditBox(GroupPage, Group, Option, Value)
		elseif (type(Value) == "table") then -- Color Picker / Custom DropDown
			if Value.Options then
				Control = CreateConfigDropDown(GroupPage, Group, Option, Value, "Custom")
			else
				Control = CreateConfigColorPicker(GroupPage, Group, Option, Value)
			end
		elseif (type(Value) == "string") then -- DropDown / EditBox
			if strfind(strlower(Option), "font") then
				Control = CreateConfigDropDown(GroupPage, Group, Option, Value, "Font")
			elseif strfind(strlower(Option), "texture") then
				Control = CreateConfigDropDown(GroupPage, Group, Option, Value, "Texture")
			else
				Control = CreateConfigEditBox(GroupPage, Group, Option, Value, 155)
			end
		end
		
		SetControlInformation(Control, Group, Option) -- Set the label and tooltip
		
		if (not GroupPage.Controls[Control.Type]) then
			GroupPage.Controls[Control.Type] = {}
		end
		
		tinsert(GroupPage.Controls[Control.Type], Control)
	end
	
	local Buttons = GroupPage.Controls["Button"]
	local EditBoxes = GroupPage.Controls["EditBox"]
	local ColorPickers = GroupPage.Controls["Color"]
	local Fonts = GroupPage.Controls["Font"]
	local Textures = GroupPage.Controls["Texture"]
	local Custom = GroupPage.Controls["Custom"]
	
	if Buttons then
		for i = 1, #Buttons do
			if (i == 1) then
				if LastControl then
					Buttons[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				else
					Buttons[i]:Point("TOPLEFT", GroupPage, 6, -6)
				end
			else
				Buttons[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
			end
			
			LastControl = Buttons[i]
		end
	end
	
	if EditBoxes then
		for i = 1, #EditBoxes do
			if (i == 1) then
				if LastControl then
					EditBoxes[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				else
					EditBoxes[i]:Point("TOPLEFT", GroupPage, 6, -6)
				end
			else
				EditBoxes[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
			end
			
			LastControl = EditBoxes[i]
		end
	end
	
	if ColorPickers then
		for i = 1, #ColorPickers do
			if (i == 1) then
				if LastControl then
					ColorPickers[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				else
					ColorPickers[i]:Point("TOPLEFT", GroupPage, 6, -6)
				end
			else
				ColorPickers[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
			end
			
			LastControl = ColorPickers[i]
		end
	end
	
	if Fonts then
		for i = 1, #Fonts do
			if (i == 1) then
				if LastControl then
					Fonts[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				else
					Fonts[i]:Point("TOPLEFT", GroupPage, 6, -6)
				end
			else
				Fonts[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
			end
			
			LastControl = Fonts[i]
		end
	end
	
	if Textures then
		for i = 1, #Textures do
			if (i == 1) then
				if LastControl then
					Textures[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				else
					Textures[i]:Point("TOPLEFT", GroupPage, 6, -6)
				end
			else
				Textures[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
			end
			
			LastControl = Textures[i]
		end
	end
	
	if Custom then
		for i = 1, #Custom do
			if (i == 1) then
				if LastControl then
					Custom[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
				else
					Custom[i]:Point("TOPLEFT", GroupPage, 6, -6)
				end
			else
				Custom[i]:Point("TOPLEFT", LastControl, "BOTTOMLEFT", 0, -4)
			end
			
			LastControl = Custom[i]
		end
	end
	
	GroupPage.Handled = true
end

local ShowGroup = function(group)
	if (not GroupPages[group]) then
		return
	end
	
	if (not GroupPages[group].Handled) then
		CreateGroupOptions(group)
	end
	
	for group, page in pairs(GroupPages) do
		page:Hide()
		
		if page.Slider then
			page.Slider:Hide()
		end
	end
	
	GroupPages[group]:Show()
	TukuiConfigFrameTitle.Text:SetText(group)
	
	if GroupPages[group].Slider then
		GroupPages[group].Slider:Show()
	end
end

local GroupButtonOnClick = function(self)
	ShowGroup(self.Group)
end

-- Create the config window
function TukuiConfig:CreateConfigWindow()
	local C = Tukui[2]
	
	self:UpdateColorDefaults()
	
	-- Dynamic sizing
	local NumGroups = 0
	
	for Group in pairs(C) do
		if (not self.Filter[Group]) then
			NumGroups = NumGroups + 1
		end
	end
	
	NumGroups = NumGroups + 2 -- Reload & Close buttons
	
	local Height = (12 + (NumGroups * 20) + ((NumGroups - 1) * 4)) -- Padding + (NumButtons * ButtonSize) + ((NumButtons - 1) * ButtonSpacing)
	
	local ConfigFrame = CreateFrame("Frame", "TukuiConfigFrame", UIParent)
	ConfigFrame:Size(447, Height)
	ConfigFrame:Point("CENTER")
	ConfigFrame:SetFrameStrata("HIGH")
	
	local LeftWindow = CreateFrame("Frame", "TukuiConfigFrameLeft", ConfigFrame)
	LeftWindow:SetTemplate()
	LeftWindow:Size(144, Height)
	LeftWindow:Point("LEFT", ConfigFrame)
	LeftWindow:EnableMouse(true)
	
	local RightWindow = CreateFrame("Frame", "TukuiConfigFrameRight", ConfigFrame)
	RightWindow:SetTemplate()
	RightWindow:Size(300, Height)
	RightWindow:Point("RIGHT", ConfigFrame)
	RightWindow:EnableMouse(true)
	
	local TitleFrame = CreateFrame("Frame", "TukuiConfigFrameTitle", ConfigFrame)
	TitleFrame:SetTemplate()
	TitleFrame:Size(447, 22)
	TitleFrame:Point("BOTTOM", ConfigFrame, "TOP", 0, 3)
	
	TitleFrame.Text = TitleFrame:CreateFontString(nil, "OVERLAY")
	TitleFrame.Text:SetFont(C.Medias.Font, 16)
	TitleFrame.Text:Point("CENTER", TitleFrame, 0, -1)
	TitleFrame.Text:SetShadowColor(0, 0, 0)
	TitleFrame.Text:SetShadowOffset(1.25, -1.25)
	
	local CloseButton = CreateFrame("Button", nil, ConfigFrame)
	CloseButton:Size(132, 20)
	CloseButton:SetTemplate()
	CloseButton:SetScript("OnClick", function() ConfigFrame:Hide() end)
	CloseButton:StyleButton()
	CloseButton:SetFrameLevel(LeftWindow:GetFrameLevel() + 1)
	CloseButton:SetPoint("BOTTOM", LeftWindow, 0, 6)
	
	CloseButton.Text = CloseButton:CreateFontString(nil, "OVERLAY")
	CloseButton.Text:SetFont(C.Medias.Font, 12)
	CloseButton.Text:Point("CENTER", CloseButton)
	CloseButton.Text:SetTextColor(1, 0, 0)
	CloseButton.Text:SetText(CLOSE)
	
	local ReloadButton = CreateFrame("Button", nil, ConfigFrame)
	ReloadButton:Size(132, 20)
	ReloadButton:SetTemplate()
	ReloadButton:SetScript("OnClick", function() ReloadUI() end)
	ReloadButton:StyleButton()
	ReloadButton:SetFrameLevel(LeftWindow:GetFrameLevel() + 1)
	ReloadButton:SetPoint("BOTTOM", CloseButton, "TOP", 0, 4)
	
	ReloadButton.Text = ReloadButton:CreateFontString(nil, "OVERLAY")
	ReloadButton.Text:SetFont(C.Medias.Font, 12)
	ReloadButton.Text:Point("CENTER", ReloadButton)
	ReloadButton.Text:SetText("|cff00FF00"..APPLY.."|r")
	
	local LastButton
	local ButtonCount = 0
	
	for Group, Table in PairsByKeys(C) do
		if (not self.Filter[Group]) then
			local NumOptions = 0
			
			for Key in pairs(Table) do
				NumOptions = NumOptions + 1
			end
			
			local GroupHeight = 8 + (NumOptions * 24)
			
			local GroupPage = CreateFrame("Frame", nil, ConfigFrame)
			GroupPage:SetTemplate()
			GroupPage:Size(300, Height)
			GroupPage:Point("TOPRIGHT", ConfigFrame)
			GroupPage.Controls = {}
			
			if (GroupHeight > Height) then
				GroupPage:Size(300, GroupHeight)
				
				local ScrollFrame = CreateFrame("ScrollFrame", nil, ConfigFrame)
				ScrollFrame:Size(300, Height)
				ScrollFrame:Point("TOPRIGHT", ConfigFrame)
				ScrollFrame:SetScrollChild(GroupPage)
				
				local Slider = CreateFrame("Slider", nil, ScrollFrame)
				Slider:SetPoint("RIGHT", 0, 0)
				Slider:SetWidth(12)
				Slider:SetHeight(Height)
				Slider:SetThumbTexture(C.Medias.Blank)
				Slider:SetOrientation("VERTICAL")
				Slider:SetValueStep(1)
				Slider:SetTemplate()
				Slider:SetMinMaxValues(0, 1)
				Slider:SetValue(0)
				Slider.ScrollFrame = ScrollFrame
				Slider:EnableMouseWheel(true)
				Slider:SetScript("OnMouseWheel", SliderOnMouseWheel)
				Slider:SetScript("OnValueChanged", SliderOnValueChanged)
				
				Slider:SetValue(10)
				Slider:SetValue(0)
				
				local Thumb = Slider:GetThumbTexture() 
				Thumb:Width(12)
				Thumb:Height(18)
				Thumb:SetVertexColor(0.6, 0.6, 0.6, 1)
				
				Slider:Show()
				
				GroupPage.Slider = Slider
			end
			
			GroupPages[Group] = GroupPage
			
			local Button = CreateFrame("Button", nil, ConfigFrame)
			Button.Group = Group
			
			Button:Size(132, 20)
			Button:SetTemplate()
			Button:SetScript("OnClick", GroupButtonOnClick)
			Button:StyleButton()
			Button:SetFrameLevel(LeftWindow:GetFrameLevel() + 1)
			
			Button.Text = Button:CreateFontString(nil, "OVERLAY")
			Button.Text:SetFont(C.Medias.Font, 12)
			Button.Text:Point("CENTER", Button)
			Button.Text:SetText(Group)
			
			if (ButtonCount == 0) then
				Button:SetPoint("TOP", LeftWindow, 0, -6)
			else
				Button:SetPoint("TOP", LastButton, "BOTTOM", 0, -4)
			end
			
			ButtonCount = ButtonCount + 1
			LastButton = Button
		end
	end
	
	-- Credits are important, so let's make them sexy!
	local CreditFrame = CreateFrame("Frame", "TukuiConfigFrameCredit", ConfigFrame)
	CreditFrame:SetTemplate()
	CreditFrame:Size(447, 22)
	CreditFrame:Point("TOP", ConfigFrame, "BOTTOM", 0, -3)
	
	local ScrollFrame = CreateFrame("ScrollFrame", nil, ConfigFrame)
	ScrollFrame:Size(443, 22)
	ScrollFrame:Point("CENTER", CreditFrame, 0, 0)
	
	local Scrollable = CreateFrame("Frame", nil, ScrollFrame)
	Scrollable:Size(439, 22)
	Scrollable:SetPoint("CENTER", CreditFrame)
	
	ScrollFrame:SetScrollChild(Scrollable)
	
	local CreditString = "Special thanks to: "
	
	for i = 1, #Credits do
		if (i ~= 1) then
			CreditString = CreditString .. ", " .. Credits[i]
		else
			CreditString = CreditString .. Credits[i]
		end
	end
	
	local CreditText = Scrollable:CreateFontString(nil, "OVERLAY")
	CreditText:SetFont(C.Medias.Font, 14)
	CreditText:SetText(CreditString)
	CreditText:Point("LEFT", Scrollable, "RIGHT", 4, 0)
	
	Scrollable:SetAnimation("Move", "Horizontal", -1250, 0.5)
	
	Scrollable:AnimOnFinished("Move", function(self)
		if (not ConfigFrame:IsVisible()) then
			return
		end
		
		self:ClearAllPoints()
		self:SetPoint("CENTER", CreditFrame)
		self:SetAnimation("Move", "Horizontal", -1250, 0.5)
	end)
	
	ShowGroup("General") -- Show General options by default
	
	ConfigFrame:Hide()
	
	GameMenuFrame:HookScript("OnShow", function() ConfigFrame:Hide() end)
end