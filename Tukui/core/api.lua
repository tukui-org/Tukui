-- Tukui API, see DOCS/API.txt for more informations
-- Feel free to send us API suggestion at www.tukui.org/tickets

local T, C, L, G = unpack(select(2, ...))

local noop = T.dummy
local floor = math.floor
local class = T.myclass
local texture = C.media.blank
local backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
local borderr, borderg, borderb = unpack(C["media"].bordercolor)
local backdropa = 1
local bordera = 1
local template
local inset = 0
local noinset = C.media.noinset

-- pixel perfect script of custom ui Scale.
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/C["general"].uiscale
local Scale = function(x)
    return mult*math.floor(x/mult+.5)
end

T.Scale = function(x) return Scale(x) end
T.mult = mult

if noinset then inset = mult end

local function UpdateColor(t)
	if t == template then return end

	if t == "ClassColor" or t == "Class Color" or t == "Class" then
		local c = T.UnitColor.class[class]
		borderr, borderg, borderb = c[1], c[2], c[3]
		backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
		backdropa = 1
	else
		local balpha = 1
		if t == "Transparent" then balpha = 0.8 end
		borderr, borderg, borderb = unpack(C["media"].bordercolor)
		backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
		backdropa = balpha
	end
	
	template = t
end

---------------------------------------------------
-- TUKUI API START HERE
---------------------------------------------------

local function Size(frame, width, height)
	frame:SetSize(Scale(width), Scale(height or width))
end

local function Width(frame, width)
	frame:SetWidth(Scale(width))
end

local function Height(frame, height)
	frame:SetHeight(Scale(height))
end

local function Point(obj, arg1, arg2, arg3, arg4, arg5)
	-- anyone has a more elegant way for this?
	if type(arg1)=="number" then arg1 = Scale(arg1) end
	if type(arg2)=="number" then arg2 = Scale(arg2) end
	if type(arg3)=="number" then arg3 = Scale(arg3) end
	if type(arg4)=="number" then arg4 = Scale(arg4) end
	if type(arg5)=="number" then arg5 = Scale(arg5) end

	obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
end

local function SetOutside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 2
	yOffset = yOffset or 2
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end
	
	obj:Point("TOPLEFT", anchor, "TOPLEFT", -xOffset, yOffset)
	obj:Point("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", xOffset, -yOffset)
end

local function SetInside(obj, anchor, xOffset, yOffset)
	xOffset = xOffset or 2
	yOffset = yOffset or 2
	anchor = anchor or obj:GetParent()

	if obj:GetPoint() then obj:ClearAllPoints() end
	
	obj:Point("TOPLEFT", anchor, "TOPLEFT", xOffset, -yOffset)
	obj:Point("BOTTOMRIGHT", anchor, "BOTTOMRIGHT", -xOffset, yOffset)
end

local function SetTemplate(f, t, tex)
	if tex then 
		texture = C.media.normTex 
	else 
		texture = C.media.blank 
	end
	
	UpdateColor(t)
		
	f:SetBackdrop({
	  bgFile = texture, 
	  edgeFile = C.media.blank, 
	  tile = false, tileSize = 0, edgeSize = mult,
	})
	
	if not noinset and not f.isInsetDone then
		f.insettop = f:CreateTexture(nil, "BORDER")
		f.insettop:Point("TOPLEFT", f, "TOPLEFT", -1, 1)
		f.insettop:Point("TOPRIGHT", f, "TOPRIGHT", 1, -1)
		f.insettop:Height(1)
		f.insettop:SetTexture(0,0,0)	
		f.insettop:SetDrawLayer("BORDER", -7)
		
		f.insetbottom = f:CreateTexture(nil, "BORDER")
		f.insetbottom:Point("BOTTOMLEFT", f, "BOTTOMLEFT", -1, -1)
		f.insetbottom:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, -1)
		f.insetbottom:Height(1)
		f.insetbottom:SetTexture(0,0,0)	
		f.insetbottom:SetDrawLayer("BORDER", -7)
		
		f.insetleft = f:CreateTexture(nil, "BORDER")
		f.insetleft:Point("TOPLEFT", f, "TOPLEFT", -1, 1)
		f.insetleft:Point("BOTTOMLEFT", f, "BOTTOMLEFT", 1, -1)
		f.insetleft:Width(1)
		f.insetleft:SetTexture(0,0,0)
		f.insetleft:SetDrawLayer("BORDER", -7)
		
		f.insetright = f:CreateTexture(nil, "BORDER")
		f.insetright:Point("TOPRIGHT", f, "TOPRIGHT", 1, 1)
		f.insetright:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, -1)
		f.insetright:Width(1)
		f.insetright:SetTexture(0,0,0)	
		f.insetright:SetDrawLayer("BORDER", -7)

		f.insetinsidetop = f:CreateTexture(nil, "BORDER")
		f.insetinsidetop:Point("TOPLEFT", f, "TOPLEFT", 1, -1)
		f.insetinsidetop:Point("TOPRIGHT", f, "TOPRIGHT", -1, 1)
		f.insetinsidetop:Height(1)
		f.insetinsidetop:SetTexture(0,0,0)	
		f.insetinsidetop:SetDrawLayer("BORDER", -7)
		
		f.insetinsidebottom = f:CreateTexture(nil, "BORDER")
		f.insetinsidebottom:Point("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
		f.insetinsidebottom:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)
		f.insetinsidebottom:Height(1)
		f.insetinsidebottom:SetTexture(0,0,0)	
		f.insetinsidebottom:SetDrawLayer("BORDER", -7)
		
		f.insetinsideleft = f:CreateTexture(nil, "BORDER")
		f.insetinsideleft:Point("TOPLEFT", f, "TOPLEFT", 1, -1)
		f.insetinsideleft:Point("BOTTOMLEFT", f, "BOTTOMLEFT", -1, 1)
		f.insetinsideleft:Width(1)
		f.insetinsideleft:SetTexture(0,0,0)
		f.insetinsideleft:SetDrawLayer("BORDER", -7)
		
		f.insetinsideright = f:CreateTexture(nil, "BORDER")
		f.insetinsideright:Point("TOPRIGHT", f, "TOPRIGHT", -1, -1)
		f.insetinsideright:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 1, 1)
		f.insetinsideright:Width(1)
		f.insetinsideright:SetTexture(0,0,0)	
		f.insetinsideright:SetDrawLayer("BORDER", -7)

		f.isInsetDone = true
	end
		
	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end

local borders = {
	"insettop",
	"insetbottom",
	"insetleft",
	"insetright",
	"insetinsidetop",
	"insetinsidebottom",
	"insetinsideleft",
	"insetinsideright",
}

local function HideInsets(f)
	for i, border in pairs(borders) do
		if f[border] then
			f[border]:SetTexture(0,0,0,0)
		end
	end
end

local function CreateBackdrop(f, t, tex)
	if f.backdrop then return end
	if not t then t = "Default" end

	local b = CreateFrame("Frame", nil, f)
	b:Point("TOPLEFT", -2 + inset, 2 - inset)
	b:Point("BOTTOMRIGHT", 2 - inset, -2 + inset)
	b:SetTemplate(t, tex)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end
	
	f.backdrop = b
end

local function CreateShadow(f, t)
	if f.shadow then return end
			
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:Point("TOPLEFT", -3, 3)
	shadow:Point("BOTTOMLEFT", -3, -3)
	shadow:Point("TOPRIGHT", 3, 3)
	shadow:Point("BOTTOMRIGHT", 3, -3)
	shadow:SetBackdrop( { 
		edgeFile = C["media"].glowTex, edgeSize = T.Scale(3),
		insets = {left = T.Scale(5), right = T.Scale(5), top = T.Scale(5), bottom = T.Scale(5)},
	})
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.8)
	f.shadow = shadow
end

local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = noop
	object:Hide()
end

local function StyleButton(button) 
	if button.SetHighlightTexture and not button.hover then
		local hover = button:CreateTexture("frame", nil, self)
		hover:SetTexture(1, 1, 1, 0.3)
		hover:Point("TOPLEFT", 2, -2)
		hover:Point("BOTTOMRIGHT", -2, 2)
		button.hover = hover
		button:SetHighlightTexture(hover)
	end

	if button.SetPushedTexture and not button.pushed then
		local pushed = button:CreateTexture("frame", nil, self)
		pushed:SetTexture(0.9, 0.8, 0.1, 0.3)
		pushed:Point("TOPLEFT", 2, -2)
		pushed:Point("BOTTOMRIGHT", -2, 2)
		button.pushed = pushed
		button:SetPushedTexture(pushed)
	end

	if button.SetCheckedTexture and not button.checked then
		local checked = button:CreateTexture("frame", nil, self)
		checked:SetTexture(0,1,0,.3)
		checked:Point("TOPLEFT", 2, -2)
		checked:Point("BOTTOMRIGHT", -2, 2)
		button.checked = checked
		button:SetCheckedTexture(checked)
	end

	local cooldown = button:GetName() and _G[button:GetName().."Cooldown"]
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:Point("TOPLEFT", 2, -2)
		cooldown:Point("BOTTOMRIGHT", -2, 2)
	end
end

local function FontString(parent, name, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(mult, -mult)
	
	if not name then
		parent.text = fs
	else
		parent[name] = fs
	end
	
	return fs
end

local function HighlightTarget(self, event, unit)
	if self.unit == "target" then return end
	if UnitIsUnit("target", self.unit) then
		self.HighlightTarget:Show()
	else
		self.HighlightTarget:Hide()
	end
end

local function HighlightUnit(f, r, g, b)
	if f.HighlightTarget then return end
	local glowBorder = {edgeFile = C["media"].blank, edgeSize = 1}
	f.HighlightTarget = CreateFrame("Frame", nil, f)
	f.HighlightTarget:Point("TOPLEFT", f, "TOPLEFT", -2, 2)
	f.HighlightTarget:Point("BOTTOMRIGHT", f, "BOTTOMRIGHT", 2, -2)
	f.HighlightTarget:SetBackdrop(glowBorder)
	f.HighlightTarget:SetFrameLevel(f:GetFrameLevel() + 1)
	f.HighlightTarget:SetBackdropBorderColor(r,g,b,1)
	f.HighlightTarget:Hide()
	f:RegisterEvent("PLAYER_TARGET_CHANGED", HighlightTarget)
end

local function StripTextures(object, kill)
	for i=1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				region:Kill()
			else
				region:SetTexture(nil)
			end
		end
	end		
end

-----------------------------------------------------------
-- Skinning
-----------------------------------------------------------

local function SetModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	self:SetBackdropColor(color.r*.15, color.g*.15, color.b*.15)
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function SetOriginalBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	if C["general"].classcolortheme == true then
		self:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		self:SetTemplate()
	end
end

local function SkinButton(f, strip)
	if f:GetName() then
		local l = _G[f:GetName().."Left"]
		local m = _G[f:GetName().."Middle"]
		local r = _G[f:GetName().."Right"]


		if l then l:SetAlpha(0) end
		if m then m:SetAlpha(0) end
		if r then r:SetAlpha(0) end
	end

	if f.Left then f.Left:SetAlpha(0) end
	if f.Right then f.Right:SetAlpha(0) end	
	if f.Middle then f.Middle:SetAlpha(0) end
	if f.SetNormalTexture then f:SetNormalTexture("") end	
	if f.SetHighlightTexture then f:SetHighlightTexture("") end
	if f.SetPushedTexture then f:SetPushedTexture("") end	
	if f.SetDisabledTexture then f:SetDisabledTexture("") end	
	if strip then StripTextures(f) end
	
	SetTemplate(f, "Default")
	f:HookScript("OnEnter", SetModifiedBackdrop)
	f:HookScript("OnLeave", SetOriginalBackdrop)
end
T.SkinButton = SkinButton -- for t14 and less addons/plugins

local function SkinIconButton(b, shrinkIcon)
	if b.isSkinned then return end

	b:StripTextures()
	b:CreateBackdrop("Default", true)
	b:StyleButton()

	local icon = b.icon
	if b:GetName() and _G[b:GetName().."IconTexture"] then
		icon = _G[b:GetName().."IconTexture"]
	elseif b:GetName() and _G[b:GetName().."Icon"] then
		icon = _G[b:GetName().."Icon"]
	end

	if icon then
		icon:SetTexCoord(.08,.88,.08,.88)

		-- create a backdrop around the icon

		if shrinkIcon then
			b.backdrop:SetAllPoints()
			icon:SetInside(b)
		else
			b.backdrop:SetOutside(icon)
		end
		icon:SetParent(b.backdrop)
	end
	b.isSkinned = true
end

local function SkinScrollBar(frame)
	if _G[frame:GetName().."BG"] then _G[frame:GetName().."BG"]:SetTexture(nil) end
	if _G[frame:GetName().."Track"] then _G[frame:GetName().."Track"]:SetTexture(nil) end

	if _G[frame:GetName().."Top"] then
		_G[frame:GetName().."Top"]:SetTexture(nil)
	end
	
	if _G[frame:GetName().."Bottom"] then
		_G[frame:GetName().."Bottom"]:SetTexture(nil)
	end
	
	if _G[frame:GetName().."Middle"] then
		_G[frame:GetName().."Middle"]:SetTexture(nil)
	end

	if _G[frame:GetName().."ScrollUpButton"] and _G[frame:GetName().."ScrollDownButton"] then
		StripTextures(_G[frame:GetName().."ScrollUpButton"])
		SetTemplate(_G[frame:GetName().."ScrollUpButton"], "Default", true)
		if not _G[frame:GetName().."ScrollUpButton"].texture then
			_G[frame:GetName().."ScrollUpButton"].texture = _G[frame:GetName().."ScrollUpButton"]:CreateTexture(nil, "OVERLAY")
			Point(_G[frame:GetName().."ScrollUpButton"].texture, "TOPLEFT", 2, -2)
			Point(_G[frame:GetName().."ScrollUpButton"].texture, "BOTTOMRIGHT", -2, 2)
			_G[frame:GetName().."ScrollUpButton"].texture:SetTexture([[Interface\AddOns\Tukui\medias\textures\arrowup.tga]])
			_G[frame:GetName().."ScrollUpButton"].texture:SetVertexColor(unpack(C["media"].bordercolor))
		end	
		
		StripTextures(_G[frame:GetName().."ScrollDownButton"])
		SetTemplate(_G[frame:GetName().."ScrollDownButton"], "Default", true)
	
		if not _G[frame:GetName().."ScrollDownButton"].texture then
			_G[frame:GetName().."ScrollDownButton"].texture = _G[frame:GetName().."ScrollDownButton"]:CreateTexture(nil, "OVERLAY")
			Point(_G[frame:GetName().."ScrollDownButton"].texture, "TOPLEFT", 2, -2)
			Point(_G[frame:GetName().."ScrollDownButton"].texture, "BOTTOMRIGHT", -2, 2)
			_G[frame:GetName().."ScrollDownButton"].texture:SetTexture([[Interface\AddOns\Tukui\medias\textures\arrowdown.tga]])
			_G[frame:GetName().."ScrollDownButton"].texture:SetVertexColor(unpack(C["media"].bordercolor))
		end				
		
		if not frame.trackbg then
			frame.trackbg = CreateFrame("Frame", nil, frame)
			Point(frame.trackbg, "TOPLEFT", _G[frame:GetName().."ScrollUpButton"], "BOTTOMLEFT", 0, -1)
			Point(frame.trackbg, "BOTTOMRIGHT", _G[frame:GetName().."ScrollDownButton"], "TOPRIGHT", 0, 1)
			SetTemplate(frame.trackbg, "Transparent")
		end
		
		if frame:GetThumbTexture() then
			if not thumbTrim then thumbTrim = 3 end
			frame:GetThumbTexture():SetTexture(nil)
			if not frame.thumbbg then
				frame.thumbbg = CreateFrame("Frame", nil, frame)
				Point(frame.thumbbg, "TOPLEFT", frame:GetThumbTexture(), "TOPLEFT", 2, -thumbTrim)
				Point(frame.thumbbg, "BOTTOMRIGHT", frame:GetThumbTexture(), "BOTTOMRIGHT", -2, thumbTrim)
				SetTemplate(frame.thumbbg, "Default", true)
				if frame.trackbg then
					frame.thumbbg:SetFrameLevel(frame.trackbg:GetFrameLevel())
				end
			end
		end	
	end	
end
T.SkinScrollBar = SkinScrollBar -- for t14 and less addons/plugins

--Tab Regions
local tabs = {
	"LeftDisabled",
	"MiddleDisabled",
	"RightDisabled",
	"Left",
	"Middle",
	"Right",
}

local function SkinTab(tab)
	if not tab then return end
	for _, object in pairs(tabs) do
		local tex = _G[tab:GetName()..object]
		if tex then
			tex:SetTexture(nil)
		end
	end
	
	if tab.GetHighlightTexture and tab:GetHighlightTexture() then
		tab:GetHighlightTexture():SetTexture(nil)
	else
		StripTextures(tab)
	end
	
	tab.backdrop = CreateFrame("Frame", nil, tab)
	SetTemplate(tab.backdrop, "Default")
	tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
	Point(tab.backdrop, "TOPLEFT", 10, -3)
	Point(tab.backdrop, "BOTTOMRIGHT", -10, 3)				
end
T.SkinTab = SkinTab -- for t14 and less addons/plugins

local function SkinNextPrevButton(btn, horizonal)
	SetTemplate(btn, "Default")
	Size(btn, btn:GetWidth() - 7, btn:GetHeight() - 7)	
	
	if horizonal then
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
		btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)	
	else
		btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
		if btn:GetPushedTexture() then
			btn:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end
		if btn:GetDisabledTexture() then
			btn:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end
	
	btn:GetNormalTexture():ClearAllPoints()
	Point(btn:GetNormalTexture(), "TOPLEFT", 2, -2)
	Point(btn:GetNormalTexture(), "BOTTOMRIGHT", -2, 2)
	if btn:GetDisabledTexture() then
		btn:GetDisabledTexture():SetAllPoints(btn:GetNormalTexture())
	end
	if btn:GetPushedTexture() then
		btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())
	end
	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end
T.SkinNextPrevButton = SkinNextPrevButton -- for t14 and less addons/plugins

local function SkinRotateButton(btn)
	SetTemplate(btn, "Default")
	Size(btn, btn:GetWidth() - 14, btn:GetHeight() - 14)	
	
	btn:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)
	btn:GetPushedTexture():SetTexCoord(0.3, 0.29, 0.3, 0.65, 0.69, 0.29, 0.69, 0.65)	
	
	btn:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	
	btn:GetNormalTexture():ClearAllPoints()
	Point(btn:GetNormalTexture(), "TOPLEFT", 2, -2)
	Point(btn:GetNormalTexture(), "BOTTOMRIGHT", -2, 2)
	btn:GetPushedTexture():SetAllPoints(btn:GetNormalTexture())	
	btn:GetHighlightTexture():SetAllPoints(btn:GetNormalTexture())
end
T.SkinRotateButton = SkinRotateButton -- for t14 and less addons/plugins

local function SkinEditBox(frame)
	if _G[frame:GetName().."Left"] then Kill(_G[frame:GetName().."Left"]) end
	if _G[frame:GetName().."Middle"] then Kill(_G[frame:GetName().."Middle"]) end
	if _G[frame:GetName().."Right"] then Kill(_G[frame:GetName().."Right"]) end
	if _G[frame:GetName().."Mid"] then Kill(_G[frame:GetName().."Mid"]) end
	CreateBackdrop(frame, "Default")
	
	if frame:GetName() and frame:GetName():find("Silver") or frame:GetName():find("Copper") then
		Point(frame.backdrop, "BOTTOMRIGHT", -12, -2)
	end
end
T.SkinEditBox = SkinEditBox -- for t14 and less addons/plugins

local function SkinDropDownBox(frame, width)
	local button = _G[frame:GetName().."Button"]
	if not width then width = 155 end
	
	StripTextures(frame)
	Width(frame, width)
	
	_G[frame:GetName().."Text"]:ClearAllPoints()
	Point(_G[frame:GetName().."Text"], "RIGHT", button, "LEFT", -2, 0)

	button:ClearAllPoints()
	Point(button, "RIGHT", frame, "RIGHT", -10, 3)
	button.SetPoint = T.dummy
	
	SkinNextPrevButton(button, true)
	
	CreateBackdrop(frame, "Default")
	Point(frame.backdrop, "TOPLEFT", 20, -2)
	Point(frame.backdrop, "BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
end
T.SkinDropDownBox = SkinDropDownBox -- for t14 and less addons/plugins

local function SkinCheckBox(frame)
	StripTextures(frame)
	CreateBackdrop(frame, "Default")
	Point(frame.backdrop, "TOPLEFT", 4, -4)
	Point(frame.backdrop, "BOTTOMRIGHT", -4, 4)
	
	if frame.SetCheckedTexture then
		frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end
	
	if frame.SetDisabledCheckedTexture then
		frame:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	end
	
	-- why does the disabled texture is always displayed as checked ?
	frame:HookScript('OnDisable', function(self)
		if not self.SetDisabledTexture then return end
		if self:GetChecked() then
			self:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		else
			self:SetDisabledTexture("")
		end
	end)
	
	frame.SetNormalTexture = T.dummy
	frame.SetPushedTexture = T.dummy
	frame.SetHighlightTexture = T.dummy
end
T.SkinCheckBox = SkinCheckBox -- for t14 and less addons/plugins

local function SkinCloseButton(f, point)	
	if point then
		Point(f, "TOPRIGHT", point, "TOPRIGHT", 2, 2)
	end
	
	f:SetNormalTexture("")
	f:SetPushedTexture("")
	f:SetHighlightTexture("")
	f:SetDisabledTexture("")

	f.t = f:CreateFontString(nil, "OVERLAY")
	f.t:SetFont(C.media.pixelfont, 12, "OUTLINE")
	f.t:SetPoint("CENTER", 0, 1)
	f.t:SetText("x")
end
T.SkinCloseButton = SkinCloseButton -- for t14 and less addons/plugins

local function SkinSlideBar(frame, height, movetext)
	frame:SetTemplate( "Default" )
	frame:SetBackdropColor( 0, 0, 0, .8 )

	if not height then
		height = frame:GetHeight()
	end

	if movetext then
		if(_G[frame:GetName() .. "Low"]) then _G[frame:GetName() .. "Low"]:Point("BOTTOM", 0, -18) end
		if(_G[frame:GetName() .. "High"]) then _G[frame:GetName() .. "High"]:Point("BOTTOM", 0, -18) end
		if(_G[frame:GetName() .. "Text"]) then _G[frame:GetName() .. "Text"]:Point("TOP", 0, 19) end
	end

	_G[frame:GetName()]:SetThumbTexture( [[Interface\AddOns\Tukui\medias\textures\blank.tga]] )
	_G[frame:GetName()]:GetThumbTexture():SetVertexColor(unpack( C["media"].bordercolor))
	if( frame:GetWidth() < frame:GetHeight() ) then
		frame:Width(height)
		_G[frame:GetName()]:GetThumbTexture():Size(frame:GetWidth(), frame:GetWidth() + 4)
	else
		frame:Height(height)
		_G[frame:GetName()]:GetThumbTexture():Size(height + 4, height)
	end
end
T.SkinSlideBar = SkinSlideBar -- for t14 and less addons/plugins

---------------------------------------------------
-- TUKUI API STOP HERE
---------------------------------------------------

---------------------------------------------------
-- MERGE TUKUI API WITH WOW API
---------------------------------------------------

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.Size then mt.Size = Size end
	if not object.Point then mt.Point = Point end
	if not object.SetOutside then mt.SetOutside = SetOutside end
	if not object.SetInside then mt.SetInside = SetInside end
	if not object.SetTemplate then mt.SetTemplate = SetTemplate end
	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
	if not object.StripTextures then mt.StripTextures = StripTextures end
	if not object.CreateShadow then mt.CreateShadow = CreateShadow end
	if not object.Kill then mt.Kill = Kill end
	if not object.StyleButton then mt.StyleButton = StyleButton end
	if not object.Width then mt.Width = Width end
	if not object.Height then mt.Height = Height end
	if not object.FontString then mt.FontString = FontString end
	if not object.HighlightUnit then mt.HighlightUnit = HighlightUnit end
	if not object.SkinButton then mt.SkinButton = SkinButton end
	if not object.SkinIconButton then mt.SkinIconButton = SkinIconButton end
	if not object.SkinScrollBar then mt.SkinScrollBar = SkinScrollBar end
	if not object.SkinTab then mt.SkinTab = SkinTab end
	if not object.SkinNextPrevButton then mt.SkinNextPrevButton = SkinNextPrevButton end
	if not object.SkinRotateButton then mt.SkinRotateButton = SkinRotateButton end
	if not object.SkinEditBox then mt.SkinEditBox = SkinEditBox end
	if not object.SkinDropDownBox then mt.SkinDropDownBox = SkinDropDownBox end
	if not object.SkinCheckBox then mt.SkinCheckBox = SkinCheckBox end
	if not object.SkinCloseButton then mt.SkinCloseButton = SkinCloseButton end
	if not object.SkinSlideBar then mt.SkinSlideBar = SkinSlideBar end
	if not object.HideInsets then mt.HideInsets = HideInsets end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end