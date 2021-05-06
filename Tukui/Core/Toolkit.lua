local T, C, L = select(2, ...):unpack()

-- Lib Globals
local select = select
local unpack = unpack
local type = type
local assert = assert
local getmetatable = getmetatable

-- WoW Globals
local CreateFrame = CreateFrame
local CreateTexture = CreateTexture
local UIFrameFadeOut = UIFrameFadeOut
local UIFrameFadeIn = UIFrameFadeIn
local Advanced_UseUIScale = Advanced_UseUIScale
local Advanced_UIScaleSlider = Advanced_UIScaleSlider
local Reload = C_UI.Reload

-- Locals
local Resolution = select(1, GetPhysicalScreenSize()).."x"..select(2, GetPhysicalScreenSize())
local PixelPerfectScale = 768 / string.match(Resolution, "%d+x(%d+)")
local Noop = function() return end
local Toolkit = CreateFrame("Frame", "T00LKIT", UIParent)
local Tabs = {"LeftDisabled", "MiddleDisabled", "RightDisabled", "Left", "Middle", "Right"}
local Hider = CreateFrame("Frame", nil, UIParent) Hider:Hide()

-- Tables
Toolkit.Settings = {}
Toolkit.API = {}
Toolkit.Functions = {}
Toolkit.DefaultSettings = {
	["UIScale"] = PixelPerfectScale,
	["NormalTexture"] = C.Medias.Blank,
	["GlowTexture"] = C.Medias.Glow,
	["ShadowTexture"] = C.Medias.Glow,
	["CloseTexture"] = "Interface\\AddOns\\Tukui\\Medias\\Textures\\Others\\Close",
	["ArrowUpTexture"] = "Interface\\AddOns\\Tukui\\Medias\\Textures\\Others\\ArrowUp",
	["ArrowDownTexture"] = "Interface\\AddOns\\Tukui\\Medias\\Textures\\Others\\ArrowDown",
	["DefaultFont"] = C.Medias.Font,
	["BackdropColor"] = C.General.BackdropColor,
	["BorderColor"] = C.General.BorderColor,
	["Transparency"] = 0.75,
}

----------------------------------------------------------------
-- API
----------------------------------------------------------------

-- Kills --

Toolkit.API.Kill = function(self)
	if (self.UnregisterAllEvents) then
		self:UnregisterAllEvents()
		self:SetParent(Hider)
	else
		self.Show = self.Hide
	end

	self:Hide()
end

Toolkit.API.StripTexts = function(self, Kill)
	for i = 1, self:GetNumRegions() do
		local Region = select(i, self:GetRegions())
		if (Region and Region:GetObjectType() == "FontString") then
			if (Kill and type(Kill) == "boolean") then
				Region:Kill()
			else
				Region:SetText("")
			end
		end
	end
end

Toolkit.API.StripTextures = function(self, Kill)
	for i = 1, self:GetNumRegions() do
		local Region = select(i, self:GetRegions())
		if (Region and Region:GetObjectType() == "Texture") then
			if (Kill and type(Kill) == "boolean") then
				Region:Kill()
			elseif (Region:GetDrawLayer() == Kill) then
				Region:SetTexture(nil)
			elseif (Kill and type(Kill) == "string" and Region:GetTexture() ~= Kill) then
				Region:SetTexture(nil)
			else
				Region:SetTexture(nil)
			end
		end
	end
end


Toolkit.API.StripTexts = function(self, Kill)
	for i = 1, self:GetNumRegions() do
		local Region = select(i, self:GetRegions())
		if (Region and Region:GetObjectType() == "FontString") then
			Region:SetText("")
		end
	end
end

-- Fading --

Toolkit.API.SetFadeInTemplate = function(self, FadeTime, Alpha)
	securecall(UIFrameFadeIn, self, FadeTime, self:GetAlpha(), Alpha)
end

Toolkit.API.SetFadeOutTemplate = function(self, FadeTime, Alpha)
	securecall(UIFrameFadeOut, self, FadeTime, self:GetAlpha(), Alpha)
end

-- Fonts --

Toolkit.API.SetFontTemplate = function(self, Font, FontSize, ShadowOffsetX, ShadowOffsetY)
	self:SetFont(Font, Toolkit.Functions.Scale(FontSize), "THINOUTLINE")
	self:SetShadowColor(0, 0, 0, 1)
	self:SetShadowOffset(Toolkit.Functions.Scale(ShadowOffsetX or 1), -Toolkit.Functions.Scale(ShadowOffsetY or 1))
end

-- Resize --

Toolkit.API.SetOutside = function(self, Anchor, OffsetX, OffsetY)
	OffsetX = OffsetX and Toolkit.Functions.Scale(OffsetX) or Toolkit.Functions.Scale(1)
	OffsetY = OffsetY and Toolkit.Functions.Scale(OffsetY) or Toolkit.Functions.Scale(1)
	
	Anchor = Anchor or self:GetParent()

	if self:GetPoint() then
		self:ClearAllPoints()
	end

	self:SetPoint("TOPLEFT", Anchor, "TOPLEFT", -OffsetX, OffsetY)
	self:SetPoint("BOTTOMRIGHT", Anchor, "BOTTOMRIGHT", OffsetX, -OffsetY)
end

Toolkit.API.SetInside = function(self, Anchor, OffsetX, OffsetY)
	OffsetX = OffsetX and Toolkit.Functions.Scale(OffsetX) or Toolkit.Functions.Scale(1)
	OffsetY = OffsetY and Toolkit.Functions.Scale(OffsetY) or Toolkit.Functions.Scale(1)

	Anchor = Anchor or self:GetParent()

	if self:GetPoint() then
		self:ClearAllPoints()
	end

	self:SetPoint("TOPLEFT", Anchor, "TOPLEFT", OffsetX, -OffsetY)
	self:SetPoint("BOTTOMRIGHT", Anchor, "BOTTOMRIGHT", -OffsetX, OffsetY)
end

-- Borders & Backdrop --

Toolkit.API.SetBorderColor = function(self, R, G, B, Alpha)
	if self.BorderTop then
		self.BorderTop:SetColorTexture(R, G, B, Alpha)
	end

	if self.BorderBottom then
		self.BorderBottom:SetColorTexture(R, G, B, Alpha)
	end

	if self.BorderRight then
		self.BorderRight:SetColorTexture(R, G, B, Alpha)
	end

	if self.BorderLeft then
		self.BorderLeft:SetColorTexture(R, G, B, Alpha)
	end
end

Toolkit.API.EnableBackdrop = function(self)
	if not self.SetBackdrop then
		Mixin(self, BackdropTemplateMixin)
	end
end

Toolkit.API.CreateBackdrop = function(self, BackgroundTemplate, BackgroundTexture, BorderTemplate)
	if (self.Backdrop) then
		return
	end
	
	self.Backdrop = CreateFrame("Frame", nil, self, "BackdropTemplate")
	self.Backdrop:SetAllPoints()
	self.Backdrop:SetFrameLevel(self:GetFrameLevel())

	local BackgroundAlpha = (BackgroundTemplate == "Transparent" and Toolkit.Settings.Transparency) or (1)
	local BorderR, BorderG, BorderB = unpack(Toolkit.Settings.BorderColor)
	local BackdropR, BackdropG, BackdropB = unpack(Toolkit.Settings.BackdropColor)
	local BorderSize = Toolkit.Functions.Scale(1)

	self.Backdrop:SetBackdrop({bgFile = BackgroundTexture or Toolkit.Settings.NormalTexture})
	self.Backdrop:SetBackdropColor(BackdropR, BackdropG, BackdropB, BackgroundAlpha)

	self.Backdrop.BorderTop = self.Backdrop:CreateTexture(nil, "BORDER", nil, 1)
	self.Backdrop.BorderTop:SetSize(BorderSize, BorderSize)
	self.Backdrop.BorderTop:SetPoint("TOPLEFT", self.Backdrop, "TOPLEFT", 0, 0)
	self.Backdrop.BorderTop:SetPoint("TOPRIGHT", self.Backdrop, "TOPRIGHT", 0, 0)
	self.Backdrop.BorderTop:SetSnapToPixelGrid(false)
	self.Backdrop.BorderTop:SetTexelSnappingBias(0)

	self.Backdrop.BorderBottom = self.Backdrop:CreateTexture(nil, "BORDER", nil, 1)
	self.Backdrop.BorderBottom:SetSize(BorderSize, BorderSize)
	self.Backdrop.BorderBottom:SetPoint("BOTTOMLEFT", self.Backdrop, "BOTTOMLEFT", 0, 0)
	self.Backdrop.BorderBottom:SetPoint("BOTTOMRIGHT", self.Backdrop, "BOTTOMRIGHT", 0, 0)
	self.Backdrop.BorderBottom:SetSnapToPixelGrid(false)
	self.Backdrop.BorderBottom:SetTexelSnappingBias(0)

	self.Backdrop.BorderLeft = self.Backdrop:CreateTexture(nil, "BORDER", nil, 1)
	self.Backdrop.BorderLeft:SetSize(BorderSize, BorderSize)
	self.Backdrop.BorderLeft:SetPoint("TOPLEFT", self.Backdrop, "TOPLEFT", 0, 0)
	self.Backdrop.BorderLeft:SetPoint("BOTTOMLEFT", self.Backdrop, "BOTTOMLEFT", 0, 0)
	self.Backdrop.BorderLeft:SetSnapToPixelGrid(false)
	self.Backdrop.BorderLeft:SetTexelSnappingBias(0)

	self.Backdrop.BorderRight = self.Backdrop:CreateTexture(nil, "BORDER", nil, 1)
	self.Backdrop.BorderRight:SetSize(BorderSize, BorderSize)
	self.Backdrop.BorderRight:SetPoint("TOPRIGHT", self.Backdrop, "TOPRIGHT", 0, 0)
	self.Backdrop.BorderRight:SetPoint("BOTTOMRIGHT", self.Backdrop, "BOTTOMRIGHT", 0, 0)
	self.Backdrop.BorderRight:SetSnapToPixelGrid(false)
	self.Backdrop.BorderRight:SetTexelSnappingBias(0)

	self.Backdrop:SetBorderColor(BorderR, BorderG, BorderB, BorderA)
end

Toolkit.API.CreateShadow = function(self, ShadowScale)
	if (self.Shadow) then
		return
	end

	local Level = (self:GetFrameLevel() - 1 >= 0 and self:GetFrameLevel() - 1) or (0)
	local Scale = ShadowScale or 1
	local Shadow = CreateFrame("Frame", nil, self, "BackdropTemplate")

	Shadow:SetBackdrop({edgeFile = Toolkit.Settings.ShadowTexture, edgeSize = Toolkit.Functions.Scale(4)})
	Shadow:SetFrameLevel(Level)
	Shadow:SetOutside(self, Toolkit.Functions.Scale(3), Toolkit.Functions.Scale(3))
	Shadow:SetBackdropBorderColor(0, 0, 0, .8)
	Shadow:SetScale(Toolkit.Functions.Scale(Scale))

	self.Shadow = Shadow
end

Toolkit.API.CreateGlow = function(self, Scale, EdgeSize, R, G, B, Alpha)
	if (self.Glow) then
		return
	end

	local Level = (self:GetFrameLevel() - 1 >= 0 and self:GetFrameLevel() - 1) or (0)
	local Glow = CreateFrame("Frame", nil, self, "BackdropTemplate")
	
	Glow:SetFrameStrata("BACKGROUND")
	Glow:SetFrameLevel(Level)
	Glow:SetOutside(self, 4, 4)
	Glow:SetBackdrop({edgeFile = Toolkit.Settings.GlowTexture, edgeSize = Toolkit.Functions.Scale(EdgeSize)})
	Glow:SetScale(Toolkit.Functions.Scale(Scale))
	Glow:SetBackdropBorderColor(R, G, B, Alpha)

	self.Glow = Glow
end

-- Action Bars --

Toolkit.API.StyleButton = function(self)
	local Cooldown = self:GetName() and _G[self:GetName().."Cooldown"]

	if (self.SetHighlightTexture and not self.Highlight) then
		local Highlight = self:CreateTexture()

		Highlight:SetColorTexture(1, 1, 1, 0.3)
		Highlight:SetInside()

		self.Highlight = Highlight
		self:SetHighlightTexture(Highlight)
	end

	if (self.SetPushedTexture and not self.Pushed) then
		local Pushed = self:CreateTexture()

		Pushed:SetColorTexture(0.9, 0.8, 0.1, 0.3)
		Pushed:SetInside()

		self.Pushed = Pushed
		self:SetPushedTexture(Pushed)
	end

	if (self.SetCheckedTexture and not self.Checked) then
		local Checked = self:CreateTexture()

		Checked:SetColorTexture(0, 1, 0, 0.3)
		Checked:SetInside()

		self.Checked = Checked
		self:SetCheckedTexture(Checked)
	end

	if (Cooldown) then
		Cooldown:ClearAllPoints()
		Cooldown:SetInside()
		Cooldown:SetDrawEdge(true)
	end
end

-- Skinning --

Toolkit.API.SkinButton = function(self, BackdropStyle, Shadows, Strip)
	-- Unskin everything
	if self.Left then self.Left:SetAlpha(0) end
	if self.Middle then self.Middle:SetAlpha(0) end
	if self.Right then self.Right:SetAlpha(0) end
	if self.TopLeft then self.TopLeft:SetAlpha(0) end
	if self.TopMiddle then self.TopMiddle:SetAlpha(0) end
	if self.TopRight then self.TopRight:SetAlpha(0) end
	if self.MiddleLeft then self.MiddleLeft:SetAlpha(0) end
	if self.MiddleMiddle then self.MiddleMiddle:SetAlpha(0) end
	if self.MiddleRight then self.MiddleRight:SetAlpha(0) end
	if self.BottomLeft then self.BottomLeft:SetAlpha(0) end
	if self.BottomMiddle then self.BottomMiddle:SetAlpha(0) end
	if self.BottomRight then self.BottomRight:SetAlpha(0) end
	if self.LeftSeparator then self.LeftSeparator:SetAlpha(0) end
	if self.RightSeparator then self.RightSeparator:SetAlpha(0) end
	if self.SetNormalTexture then self:SetNormalTexture("") end
	if self.SetHighlightTexture then self:SetHighlightTexture("") end
	if self.SetPushedTexture then self:SetPushedTexture("") end
	if self.SetDisabledTexture then self:SetDisabledTexture("") end
	if Strip then self:StripTexture() end

	-- Push our style
	self:CreateBackdrop(BackdropStyle)

	if (Shadows) then
		self:CreateShadow()
	end

	self:HookScript("OnEnter", function()
		if not self.Backdrop then
			return
		end
			
		local Class = select(2, UnitClass("player"))
		local Color = RAID_CLASS_COLORS[Class]

		if Toolkit.Settings.ClassColors then
			Color.r, Color.g, Color.b = unpack(Toolkit.Settings.ClassColors[Class])
		end

		self.Backdrop:SetBackdropColor(Color.r * .2, Color.g * .2, Color.b * .2)
		self.Backdrop:SetBorderColor(Color.r, Color.g, Color.b)
	end)

	self:HookScript("OnLeave", function()
		self.Backdrop:SetBackdropColor(Toolkit.Settings.BackdropColor[1], Toolkit.Settings.BackdropColor[2], Toolkit.Settings.BackdropColor[3], 1)
		self.Backdrop:SetBorderColor(Toolkit.Settings.BorderColor[1], Toolkit.Settings.BorderColor[2], Toolkit.Settings.BorderColor[3], 1)
	end)
end

Toolkit.API.SkinCloseButton = function(self, OffsetX, OffsetY, CloseSize)
	self:SetNormalTexture("")
	self:SetPushedTexture("")
	self:SetHighlightTexture("")
	self:SetDisabledTexture("")

	self.Texture = self:CreateTexture(nil, "OVERLAY")
	self.Texture:SetPoint("CENTER", OffsetX or 0, OffsetY or 0)
	self.Texture:SetSize(CloseSize or 12, CloseSize or 12)
	self.Texture:SetTexture(Toolkit.Settings.CloseTexture)

	self:SetScript("OnEnter", function(self) self.Texture:SetVertexColor(1, 0, 0) end)
	self:SetScript("OnLeave", function(self) self.Texture:SetVertexColor(1, 1, 1) end)
end

Toolkit.API.SkinEditBox = function(self)
	local Left = _G[self:GetName().."Left"]
	local Middle = _G[self:GetName().."Middle"]
	local Right = _G[self:GetName().."Right"]
	local Mid = _G[self:GetName().."Mid"]

	if Left then Left:Kill() end
	if Middle then Middle:Kill() end
	if Right then Right:Kill() end
	if Mid then Mid:Kill() end

	self:CreateBackdrop()

	if self:GetName() and self:GetName():find("Silver") or self:GetName():find("Copper") then
		self.Backdrop:SetPoint("BOTTOMRIGHT", -12, -2)
	end
end

Toolkit.API.SkinArrowButton = function(self, Vertical)
	self:CreateBackdrop()
	self:SetSize(self:GetWidth() - 7, self:GetHeight() - 7)

	if Vertical then
		self:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)

		if self:GetPushedTexture() then
			self:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		end

		if self:GetDisabledTexture() then
			self:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	else
		self:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)

		if self:GetPushedTexture() then
			self:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end

		if self:GetDisabledTexture() then
			self:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end

	self:GetNormalTexture():ClearAllPoints()
	self:GetNormalTexture():SetInside()

	if self:GetDisabledTexture() then
		self:GetDisabledTexture():SetAllPoints(self:GetNormalTexture())
	end

	if self:GetPushedTexture() then
		self:GetPushedTexture():SetAllPoints(self:GetNormalTexture())
	end

	self:GetHighlightTexture():SetColorTexture(1, 1, 1, 0.3)
	self:GetHighlightTexture():SetAllPoints(self:GetNormalTexture())
end

Toolkit.API.SkinDropDown = function(self, Width)
	local Button = _G[self:GetName().."Button"]
	local Text = _G[self:GetName().."Text"]

	self:StripTextures()
	self:SetWidth(Width or 155)

	Text:ClearAllPoints()
	Text:SetPoint("RIGHT", Button, "LEFT", -2, 0)

	Button:ClearAllPoints()
	Button:SetPoint("RIGHT", self, "RIGHT", -10, 3)
	Button.SetPoint = Noop

	Button:SkinArrowButton(true)

	self:CreateBackdrop()
	self.Backdrop:SetPoint("TOPLEFT", 20, -2)
	self.Backdrop:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 2, -2)
end

Toolkit.API.SkinCheckBox = function(self)
	self:StripTextures()
	self:CreateBackdrop()
	self.Backdrop:SetInside(self, 4, 4)

	if self.SetCheckedTexture then
		self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end

	if self.SetDisabledCheckedTexture then
		self:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end

	-- why does the disabled texture is always displayed as checked ?
	self:HookScript("OnDisable", function(self)
		if not self.SetDisabledTexture then return end

		if self:GetChecked() then
			self:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		else
			self:SetDisabledTexture("")
		end
	end)

	self.SetNormalTexture = Noop
	self.SetPushedTexture = Noop
	self.SetHighlightTexture = Noop
end

Toolkit.API.SkinTab = function(self)
	if (not self) then
		return
	end

	for _, object in pairs(Tabs) do
		local Texture = _G[self:GetName()..object]
		if (Texture) then
			Texture:SetTexture(nil)
		end
	end

	if self.GetHighlightTexture and self:GetHighlightTexture() then
		self:GetHighlightTexture():SetTexture(nil)
	else
		self:StripTextures()
	end

	self.Backdrop = CreateFrame("Frame", nil, self)
	self.Backdrop:CreateBackdrop()
	self.Backdrop:SetFrameLevel(self:GetFrameLevel() - 1)
	self.Backdrop:SetPoint("TOPLEFT", 10, -3)
	self.Backdrop:SetPoint("BOTTOMRIGHT", -10, 3)
end

Toolkit.API.SkinScrollBar = function(self)
	local ScrollUpButton = _G[self:GetName().."ScrollUpButton"]
	local ScrollDownButton = _G[self:GetName().."ScrollDownButton"]
	if _G[self:GetName().."BG"] then
		_G[self:GetName().."BG"]:SetTexture(nil)
	end

	if _G[self:GetName().."Track"] then
		_G[self:GetName().."Track"]:SetTexture(nil)
	end

	if _G[self:GetName().."Top"] then
		_G[self:GetName().."Top"]:SetTexture(nil)
	end

	if _G[self:GetName().."Bottom"] then
		_G[self:GetName().."Bottom"]:SetTexture(nil)
	end

	if _G[self:GetName().."Middle"] then
		_G[self:GetName().."Middle"]:SetTexture(nil)
	end

	if ScrollUpButton and ScrollDownButton then
		ScrollUpButton:StripTextures()
		ScrollUpButton:CreateBackdrop("Default", true)

		if not ScrollUpButton.texture then
			ScrollUpButton.texture = ScrollUpButton:CreateTexture(nil, "OVERLAY")
			ScrollUpButton.texture:SetPoint("TOPLEFT", 2, -2)
			ScrollUpButton.texture:SetPoint("BOTTOMRIGHT", -2, 2)
			ScrollUpButton.texture:SetTexture(Toolkit.Settings.ArrowUpTexture)
			ScrollUpButton.texture:SetVertexColor(unpack(Toolkit.Settings.BorderColor))
		end

		ScrollDownButton:StripTextures()
		ScrollDownButton:CreateBackdrop("Default", true)

		if not ScrollDownButton.texture then
			ScrollDownButton.texture = ScrollDownButton:CreateTexture(nil, "OVERLAY")
			ScrollDownButton.texture:SetTexture(Toolkit.Settings.ArrowDownTexture)
			ScrollDownButton.texture:SetVertexColor(unpack(Toolkit.Settings.BorderColor))
			ScrollDownButton.texture:SetPoint("TOPLEFT", 2, -2)
			ScrollDownButton.texture:SetPoint("BOTTOMRIGHT", -2, 2)
		end

		if not self.trackbg then
			self.trackbg = CreateFrame("Frame", nil, self)
			self.trackbg:SetPoint("TOPLEFT", ScrollUpButton, "BOTTOMLEFT", 0, -1)
			self.trackbg:SetPoint("BOTTOMRIGHT", ScrollDownButton, "TOPRIGHT", 0, 1)
			self.trackbg:CreateBackdrop("Transparent")
		end

		if self:GetThumbTexture() then
			local thumbTrim = 3

			self:GetThumbTexture():SetTexture(nil)

			if not self.thumbbg then
				self.thumbbg = CreateFrame("Frame", nil, self)
				self.thumbbg:SetPoint("TOPLEFT", self:GetThumbTexture(), "TOPLEFT", 2, -thumbTrim)
				self.thumbbg:SetPoint("BOTTOMRIGHT", self:GetThumbTexture(), "BOTTOMRIGHT", -2, thumbTrim)
				self.thumbbg:CreateBackdrop("Default", true)

				if self.trackbg then
					self.thumbbg:SetFrameLevel(self.trackbg:GetFrameLevel())
				end
			end
		end
	end
end

---------------------------------------------------
-- Functions
---------------------------------------------------

Toolkit.Functions.Scale = function(size)
	local Mult = PixelPerfectScale / GetCVar("uiScale")
	local Value = Mult * math.floor(size / Mult + .5)

	return Value
end

Toolkit.Functions.AddAPI = function(object)
	local mt = getmetatable(object).__index

	for API, FUNCTIONS in pairs(Toolkit.API) do
		if not object[API] then mt[API] = Toolkit.API[API] end
	end
end

Toolkit.Functions.OnEvent = function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		local CurrentScale = math.floor((self.Settings.UIScale * 100) + .5)
		local SavedScale = math.floor((GetCVar("uiScale") * 100) + .5)

		SetCVar("useUiScale", 1)
		
		-- Only change ui scale if cvar was changed
		if SavedScale ~= CurrentScale then
			SetCVar("uiScale", self.Settings.UIScale)
		end

		-- For big monitors, allow ui to be set under 0.64
		if (self.Settings.UIScale < 0.64) then
			UIParent:SetScale(self.Settings.UIScale)
		end
	elseif event == "ADDON_LOADED" then
		local Addon = ...
		
		if Addon == "Tukui" then
			self:Enable()
		end
	end
end

Toolkit.Functions.HideBlizzard = function(self)
	if T.Retail then
		Display_UseUIScale:Hide()
		Display_UIScaleSlider:Hide()
	else
		Advanced_UseUIScale:Hide()
		Advanced_UIScaleSlider:Hide()
	end
end

Toolkit.Functions.RegisterDefaultSettings = function(self)
	for Option, Parameter in pairs(self.DefaultSettings) do
		if not self.Settings[Option] then
			self.Settings[Option] = Parameter
		end
	end
end

---------------------------------------------------
-- Toolkit init
---------------------------------------------------

Toolkit.Enable = function(self)
	local Handled = {["Frame"] = true}
	local Object = CreateFrame("Frame")
	local AddAPI = self.Functions.AddAPI
	local AddFrames = self.Functions.AddFrames
	local AddHooks = self.Functions.AddHooks
	local HideBlizzard = self.Functions.HideBlizzard
	local RegisterDefaultSettings = self.Functions.RegisterDefaultSettings

	AddAPI(Object)
	AddAPI(Object:CreateTexture())
	AddAPI(Object:CreateFontString())

	Object = EnumerateFrames()

	while Object do
		if not Object:IsForbidden() and not Handled[Object:GetObjectType()] then
			AddAPI(Object)

			Handled[Object:GetObjectType()] = true
		end

		Object = EnumerateFrames(Object)
	end

	RegisterDefaultSettings(self)
	HideBlizzard(self)
end

Toolkit:RegisterEvent("PLAYER_LOGIN")
Toolkit:RegisterEvent("ADDON_LOADED")
Toolkit:SetScript("OnEvent", Toolkit.Functions.OnEvent)

T.Toolkit = Toolkit

---------------------------------------------------
-- Deprecated Functions
---------------------------------------------------

-- :SetTemplate moved to :CreateBackdrop, please update your addons as soon as possible
Toolkit.API.SetTemplate = Toolkit.API.CreateBackdrop
