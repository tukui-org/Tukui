local T, C = select(2, ...):unpack()

--[[
	Execute an animation;
		frame:SetAnimation("AnimType", ...)
	
	Set a callback function when the animation is done;
		frame:AnimOnFinished("AnimType", function(self, ...)
			
		end)
		
		arguments; self, and all the args fed into the "Animation" function for the frame
	
	Animation types;
	
	"FadeIn" & "FadeOut";
		arg1: fade time    (number)
		arg2: start alpha  (number)
		arg3: end alpha    (number)
	
	"Move";
		arg1: direction (string - "Vertical" or "Horizontal")
		arg2: distance  (number)
		arg3: speed     (number)
		
	"Width" & "Height";
		arg1: width or height (number)
		arg2: speed           (number)
		
	"Expand";
		arg1: width   (number)
		arg2: height  (number)
		arg3: speed   (number)
--]]

local Frame = CreateFrame("Frame")
local strlower = string.lower
local select = select
local unpack = unpack
local modf = math.modf
local UIFrameFadeIn = UIFrameFadeIn
local UIFrameFadeOut = UIFrameFadeOut

-- Localize some frame methods
local Show = Frame.Show
local Hide = Frame.Hide
local GetPoint = Frame.GetPoint
local GetWidth = Frame.GetWidth
local GetHeight = Frame.GetHeight

-- Vertical frame movement
local OnUpdateVerticalMove = function(self)
	local Point, RelativeTo, RelativePoint, XOfs, YOfs = GetPoint(self)
	
	if (self.MoveType == "Positive") then
		if (YOfs + self.MoveSpeed > self.EndY) then
			self:SetPoint(Point, RelativeTo, RelativePoint, XOfs, YOfs + 1)
		else
			self:SetPoint(Point, RelativeTo, RelativePoint, XOfs, YOfs + self.MoveSpeed)
		end
		
		if (YOfs >= self.EndY) then
			self:SetScript("OnUpdate", nil)
			self:Point(Point, RelativeTo, RelativePoint, XOfs, self.EndY)
			self.IsMoving = false

			self:AnimCallback("move", self.MoveDirection, self.ValueY, self.MoveSpeed)
		end
	else
		if (YOfs - self.MoveSpeed < self.EndY) then
			self:SetPoint(Point, RelativeTo, RelativePoint, XOfs, YOfs - 1)
		else
			self:SetPoint(Point, RelativeTo, RelativePoint, XOfs, YOfs - self.MoveSpeed)
		end
		
		if (YOfs <= self.EndY) then
			self:SetScript("OnUpdate", nil)
			self:Point(Point, RelativeTo, RelativePoint, XOfs, self.EndY)
			self.IsMoving = false

			self:AnimCallback("move", self.MoveDirection, self.ValueY, self.MoveSpeed)
		end
	end
end

-- Horizontal frame movement
local OnUpdateHorizontalMove = function(self)
	local Point, RelativeTo, RelativePoint, XOfs, YOfs = GetPoint(self)
	
	if (self.MoveType == "Positive") then
		if (XOfs + self.MoveSpeed > self.EndX) then
			self:SetPoint(Point, RelativeTo, RelativePoint, XOfs + 1, YOfs)
		else
			self:SetPoint(Point, RelativeTo, RelativePoint, XOfs + self.MoveSpeed, YOfs)
		end
		
		if (XOfs >= self.EndX) then
			self:SetScript("OnUpdate", nil)
			self:Point(Point, RelativeTo, RelativePoint, self.EndX, YOfs)
			self.IsMoving = false
			
			self:AnimCallback("move", self.MoveDirection, self.ValueX, self.MoveSpeed)
		end
	else
		if (XOfs - self.MoveSpeed < self.EndX) then
			self:SetPoint(Point, RelativeTo, RelativePoint, XOfs - 1, YOfs)
		else
			self:SetPoint(Point, RelativeTo, RelativePoint, XOfs - self.MoveSpeed, YOfs)
		end
		
		if (XOfs <= self.EndX) then
			self:SetScript("OnUpdate", nil)
			self:Point(Point, RelativeTo, RelativePoint, self.EndX, YOfs)
			self.IsMoving = false
			
			self:AnimCallback("move", self.MoveDirection, self.ValueX, self.MoveSpeed)
		end
	end
end

local MoveFrameVertical = function(self, y, speed)
	if self.IsMoving then
		return
	end
	
	self.MoveSpeed = speed
	
	if (y < 0) then
		self.MoveType = "Negative"
	else
		self.MoveType = "Positive"
	end
	
	self.ValueY = y
	self.EndY = select(5, GetPoint(self)) + y
	self:SetScript("OnUpdate", OnUpdateVerticalMove)
end

local MoveFrameHorizontal = function(self, x, speed)
	if self.IsMoving then
		return
	end
	
	self.MoveSpeed = speed
	
	if (x < 0) then
		self.MoveType = "Negative"
	else
		self.MoveType = "Positive"
	end
	
	self.ValueX = x
	self.EndX = select(4, GetPoint(self)) + x
	self:SetScript("OnUpdate", OnUpdateHorizontalMove)
end

-- Frame movement controller
local MoveFrame = function(self, direction, offset, speed)
	if (not direction) then
		direction = "horizontal"
	end
	
	if (strlower(direction) == "vertical") then
		MoveFrameVertical(self, offset or 100, speed or 6)
	else
		MoveFrameHorizontal(self, offset or 100, speed or 6)
	end
	
	self.MoveDirection = direction
end

local OnFinishedHeight = function(self)
	self:SetScript("OnUpdate", nil)
	--self.HeightSizing = false
	self:Height(self.EndHeight)
	self:AnimCallback("height", self.HeightValue, self.HeightSpeed)
end

local OnUpdateHeight = function(self)
	local Height = GetHeight(self)
	
	if (self.HeightType == "Negative") then
		if (Height - self.HeightSpeed <= self.EndHeight) then
			self:SetHeight(Height - 1)
		else
			self:SetHeight(Height - self.HeightSpeed)
		end

		if (Height <= self.EndHeight) then
			OnFinishedHeight(self)
		end
	else
		if (Height + self.HeightSpeed >= self.EndHeight) then
			self:SetHeight(Height + 1)
		else
			self:SetHeight(Height + self.HeightSpeed)
		end

		if (Height >= self.EndHeight) then
			OnFinishedHeight(self)
		end
	end
end

-- Height
local Height = function(self, height, speed)
	--if self.HeightSizing then
		--return
	--end
	
	self.HeightValue = height
	self.EndHeight = height or GetHeight(self) + 100
	self.HeightSpeed = speed or 4
	
	if (self.EndHeight > GetHeight(self)) then
		self.HeightType = "Positive"
	else
		self.HeightType = "Negative"
	end
	
	self:SetScript("OnUpdate", OnUpdateHeight)
	--self.HeightSizing = true
end

local OnFinishedWidth = function(self)
	self:SetScript("OnUpdate", nil)
	--self.WidthSizing = false
	self:Width(self.EndWidth)
	self:AnimCallback("width", self.WidthValue, self.WidthSpeed)
end

local OnUpdateWidth = function(self) -- BROKEN, SEE NOTE BELOW
	-- This is tainting when we /rl and when we are in combat
	if InCombatLockdown() then
		return
	end
	
	local Width = GetWidth(self)
	
	if (self.WidthType == "Negative") then
		if (Width - self.WidthSpeed <= self.EndWidth) then
			self:SetWidth(Width - 1)
		else
			self:SetWidth(Width - self.WidthSpeed)
		end
		
		if (Width <= self.EndWidth) then
			OnFinishedWidth(self)
		end
	else
		if (Width + self.WidthSpeed >= self.EndWidth) then
			self:SetWidth(Width + 1)
		else
			self:SetWidth(Width + self.WidthSpeed)
		end
		
		if (Width >= self.EndWidth) then
			OnFinishedWidth(self)
		end
	end
end

-- Width
local Width = function(self, width, speed)
	--if self.WidthSizing then
		--return
	--end
	
	self.WidthValue = width
	self.EndWidth = width or GetWidth(self) + 100 
	self.WidthSpeed = speed or 4
	
	if (self.EndWidth >= GetWidth(self)) then
		self.WidthType = "Positive"
	else
		self.WidthType = "Negative"
	end
	
	self:SetScript("OnUpdate", OnUpdateWidth)
	--self.WidthSizing = true
end

-- Expand/Collapse frames
local OnExpandFinished = function(self)
	self:SetScript("OnUpdate", nil)
	--self.ExpandSizing = false
	self:Height(self.ExpandEndHeight)
	self:Width(self.ExpandEndWidth)
	self:AnimCallback("expand", self.WidthValue, self.HeightValue, self.ExpandSpeed)
end

local Expand = function(self)
	local CurHeight = GetHeight(self)
	local MaxHeight = self.ExpandEndHeight
	
	local CurWidth = GetWidth(self)
	local MaxWidth = self.ExpandEndWidth
	
	if (CurWidth < MaxWidth) then
		if (CurWidth + self.ExpandSpeed > MaxWidth) then
			self:SetWidth(CurWidth + 1)
		else
			self:SetWidth(CurWidth + self.ExpandSpeed)
		end
	else
		if (CurHeight < MaxHeight) then
			if (CurHeight + self.ExpandSpeed > MaxHeight) then
				self:SetHeight(CurHeight + 1)
			else
				self:SetHeight(CurHeight + self.ExpandSpeed)
			end
		else
			OnExpandFinished(self)
		end
	end
end

local Collapse = function(self)
	local CurHeight = GetHeight(self)
	local MaxHeight = self.ExpandEndHeight
	
	local CurWidth = GetWidth(self)
	local MaxWidth = self.ExpandEndWidth
	
	if (CurHeight > MaxHeight) then
		if (CurHeight - self.ExpandSpeed < 1) then
			self:SetHeight(CurHeight - 1)
		else
			self:SetHeight(CurHeight - self.ExpandSpeed)
		end
	else
		if (CurWidth > MaxWidth) then
			if (CurWidth - self.ExpandSpeed < 1) then
				self:SetWidth(CurWidth - 1)
			else
				self:SetWidth(CurWidth - self.ExpandSpeed)
			end
		else
			OnExpandFinished(self)
		end
	end
end

local ExpandFrame = function(self, width, height, speed)
	--if self.ExpandSizing then
		--return
	--end
	
	self.WidthValue = width
	self.HeightValue = height
	self.ExpandEndWidth = width or GetWidth(self) + 100
	self.ExpandEndHeight = height or GetHeight(self) + 100
	self.ExpandSpeed = speed or 8
	--self.ExpandSizing = true
	
	if (self.ExpandEndWidth > GetWidth(self) or self.ExpandEndHeight > GetHeight(self)) then
		self:SetScript("OnUpdate", Expand)
	else
		self:SetScript("OnUpdate", Collapse)
	end
end

local CombatTaintFix = function(self)
	if InCombatLockdown() then
		self.Show = function() end
		self.Hide = function() end
	else
		self.Show = Show
		self.Hide = Hide
	end
end

local HookAlpha = function(self, alpha)
	if (self.FadeType == "in") then
		if (alpha == self.EndAlpha and not self.FadeInComplete) then
			self.FadeInComplete = true
			self:AnimCallback("fadein", self.FadeTime, self.StartAlpha, self.EndAlpha)
		end
	else
		if (alpha == self.EndAlpha and not self.FadeOutComplete) then
			self.FadeOutComplete = true
			self:AnimCallback("fadeout", self.FadeTime, self.StartAlpha, self.EndAlpha)
		end
	end
end

local FadeIn = function(self, fadeTime, startAlpha, endAlpha)
	CombatTaintFix(self)
	self.FadeInComplete = false
	self.FadeType = "in"
	self.FadeTime = fadeTime or 0.6
	self.StartAlpha = startAlpha or self:GetAlpha()
	self.EndAlpha = endAlpha or 1
	
	UIFrameFadeIn(self, self.FadeTime, self.StartAlpha, self.EndAlpha)

	if (not self.AlphaIsHooked) then
		hooksecurefunc(self, "SetAlpha", HookAlpha)
		self.AlphaIsHooked = true
	end
end

local FadeOut = function(self, fadeTime, startAlpha, endAlpha)
	CombatTaintFix(self)
	self.FadeOutComplete = false
	self.FadeType = "out"
	self.FadeTime = fadeTime or 0.6
	self.StartAlpha = startAlpha or self:GetAlpha()
	self.EndAlpha = endAlpha or 0
	
	UIFrameFadeOut(self, self.FadeTime, self.StartAlpha, self.EndAlpha)

	if (not self.AlphaIsHooked) then
		hooksecurefunc(self, "SetAlpha", HookAlpha)
		self.AlphaIsHooked = true
	end
end

-- Gradient Animation
local ColorGradient = function(a, b, ...)
	local perc
	
	if (b == 0) then
		perc = 0
	else
		perc = a / b
	end
	
	if (perc >= 1) then
		local r, g, b = select(select("#", ...) - 2, ...)
		
		return r, g, b
	elseif (perc <= 0) then
		local r, g, b = ...
		
		return r, g, b
	end
	
	local num = select("#", ...) / 3
	local segment, relperc = modf(perc * (num - 1))
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)

	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
end

local GradientOnUpdate = function(self, ela)
	self.GradientMin = self.GradientMin + ela
	
	local r, g, b = ColorGradient(self.GradientMin, self.GradientMax, self.GradientStart.r, self.GradientStart.g, self.GradientStart.b, self.GradientEnd.r, self.GradientEnd.g, self.GradientEnd.b)
	
	if (self.GradientType == "backdrop") then
		self:SetBackdropColor(r, g, b)
	elseif (self.GradientType == "border") then
		self:SetBackdropBorderColor(r, g, b)
	elseif (self.GradientType == "text") then
		if self.CustomFunc then
			self.Text:CustomSetTextColor(r, g, b)
		else
			self.Text:SetTextColor(r, g, b)
		end
	elseif (self.GradientType == "texture") then
		self.Texture:SetTexture(r, g, b)
	end
	
	if (self.GradientMin >= self.GradientMax) then
		self:SetScript("OnUpdate", nil)
		self:AnimCallback("gradient", self.GradientType, self.GradientMin, self.GradientMax, self.GradientEnd.r, self.GradientEnd.g, self.GradientEnd.b)
	end
end

-- Save memory by adjusting the table instead of creating new ones
local SetStart = function(self, r, g, b)
	if self.GradientStart then
		self.GradientStart.r = r
		self.GradientStart.g = g
		self.GradientStart.b = b
	else
		self.GradientStart = {r = r, g = g, b = b}
	end
end

local SetEnd = function(self, r, g, b)
	if self.GradientEnd then
		self.GradientEnd.r = r
		self.GradientEnd.g = g
		self.GradientEnd.b = b
	else
		self.GradientEnd = {r = r, g = g, b = b}
	end
end

local Gradient = function(self, part, start, finish, r, g, b, customFunc, r2, g2, b2)
	self.GradientType = string.lower(part)
	self.GradientMin = start
	self.GradientMax = finish
	SetEnd(self, r, g, b)
	local TextEnable
	local TextureEnable
	
	if (self.GradientType == "backdrop") then
		local r, g, b = self:GetBackdropColor()
		
		SetStart(self, r, g, b)
	elseif (self.GradientType == "border") then
		local r, g, b = self:GetBackdropBorderColor()
		
		SetStart(self, r, g, b)
	elseif (self.GradientType == "statusbar") then
		local r, g, b = self:GetStatusBarColor()

		SetStart(self, r, g, b)
	elseif (self.GradientType == "text") then
		TextEnable = CreateFrame("Frame", nil, UIParent)
		SetEnd(TextEnable, r, g, b)
	
		local r, g, b = self:GetTextColor()

		TextEnable.GradientType = string.lower(part)
		TextEnable.GradientMin = start
		TextEnable.GradientMax = finish
		SetStart(TextEnable, r, g, b)
		
		TextEnable.Text = self
		
		if customFunc then
			TextEnable.Text.CustomSetTextColor = self.SetTextColor
			TextEnable.Text.SetTextColor = function() end
			TextEnable.CustomFunc = true
		end
	elseif (self.GradientType == "texture") then
		if (not r2) then
			return
		end
		
		TextureEnable = CreateFrame("Frame", nil, UIParent)
		SetEnd(TextureEnable, r, g, b)
		
		TextureEnable.GradientType = string.lower(part)
		TextureEnable.GradientMin = start
		TextureEnable.GradientMax = finish
		SetStart(TextureEnable, r2, g2, b2)
		
		TextureEnable.Texture = self
	end
	
	if TextEnable then
		TextEnable:SetScript("OnUpdate", GradientOnUpdate)
	elseif TextureEnable then
		TextureEnable:SetScript("OnUpdate", GradientOnUpdate)
	else
		self:SetScript("OnUpdate", GradientOnUpdate)
	end
end

local Functions = {
	["fadein"] = FadeIn,
	["fadeout"] = FadeOut,
	["move"] = MoveFrame,
	["expand"] = ExpandFrame,
	["width"] = Width,
	["height"] = Height,
	["gradient"] = Gradient,
}

local Callbacks = {
	["fadein"] = {},
	["fadeout"] = {},
	["move"] = {},
	["expand"] = {},
	["width"] = {},
	["height"] = {},
	["gradient"] = {},
}

local AnimCallback = function(self, handler, ...)
	local Function = Callbacks[handler][self]
	
	if Function then
		Function(self, ...)
	end
end

local AnimOnFinished = function(self, handler, func)
	if (type(handler) ~= "string" or type(func) ~= "function") then
		return
	end
	
	Callbacks[strlower(handler)][self] = func
end

local SetAnimation = function(self, handler, ...)
	local Function = Functions[strlower(handler)]
	
	if Function then
		Function(self, ...)
	else
		return T.Print("Invalid 'SetAnimation' handler: " .. handler)
	end
end

local AddAPI = function(object)
	local MetaTable = getmetatable(object).__index
	
	if not object.SetAnimation then MetaTable.SetAnimation = SetAnimation end
	if not object.AnimCallback then MetaTable.AnimCallback = AnimCallback end
	if not object.AnimOnFinished then MetaTable.AnimOnFinished = AnimOnFinished end
end

local Handled = {["Frame"] = true}
local Object = CreateFrame("Frame")

AddAPI(Object)
AddAPI(Object:CreateTexture())
AddAPI(Object:CreateFontString())

Object = EnumerateFrames()

while Object do
	if (not Handled[Object:GetObjectType()]) then
		AddAPI(Object)
		Handled[Object:GetObjectType()] = true
	end

	Object = EnumerateFrames(Object)
end