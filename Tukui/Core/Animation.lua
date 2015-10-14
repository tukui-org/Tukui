-- LibAnim 2.0 by Hydra
local Version = 2.0

if (_LibAnim and _LibAnim >= Version) then
	return
end

local pairs = pairs
local floor = floor
local tinsert = tinsert
local tremove = tremove
local strlower = strlower
local MoveFrames = CreateFrame("Frame")
local AlphaFrames = CreateFrame("Frame")
local HeightFrames = CreateFrame("Frame")
local WidthFrames = CreateFrame("Frame")
local ColorFrames = CreateFrame("StatusBar")
local ProgressFrames = CreateFrame("Frame")
local SleepFrames = CreateFrame("Frame")
local NumberFrames = CreateFrame("Frame")
local MoveAnim, FadeAnim, HeightAnim, WidthAnim, ColorAnim, ProgressAnim, SleepAnim, NumberAnim
local Texture = ColorFrames:CreateTexture()
local Text = ColorFrames:CreateFontString()
local AnimTypes = {}
local Callbacks = {["OnPlay"] = {}, ["OnPause"] = {}, ["OnResume"] = {}, ["OnStop"] = {}, ["OnFinished"] = {}}

-- Get the update frame by type
local UpdateFrames = {
	["move"] = MoveFrames,
	["fade"] = AlphaFrames,
	["height"] = HeightFrames,
	["width"] = WidthFrames,
	["color"] = ColorFrames,
	["progress"] = ProgressFrames,
	["sleep"] = SleepFrames,
	["number"] = NumberFrames,
}

local GetColor = function(t, r1, g1, b1, r2, g2, b2)
	return r1 + (r2 - r1) * t, g1 + (g2 - g1) * t, b1 + (b2 - b1) * t
end

local Set = {
	["backdrop"] = ColorFrames.SetBackdropColor,
	["border"] = ColorFrames.SetBackdropBorderColor,
	["statusbar"] = ColorFrames.SetStatusBarColor,
	["text"] = Text.SetTextColor,
	["texture"] = Texture.SetTexture,
	["vertex"] = Texture.SetVertexColor,
}

local Get = {
	["backdrop"] = ColorFrames.GetBackdropColor,
	["border"] = ColorFrames.GetBackdropBorderColor,
	["statusbar"] = ColorFrames.GetStatusBarColor,
	["text"] = Text.GetTextColor,
	["texture"] = Texture.GetVertexColor,
	["vertex"] = Texture.GetVertexColor,
}

local Smoothing = {
	["none"] = function(t, b, c, d)
		return c * t / d + b
	end,
	
	["in"] = function(t, b, c, d)
		t = t / d
		
		return c * t * t + b
	end,
	
	["out"] = function(t, b, c, d)
		t = t / d
		
		return -c * t * (t - 2) + b
	end,
	
	["inout"] = function(t, b, c, d)
		t = t / (d / 2)
		
		if (t < 1) then
			return c / 2 * t * t + b
		end
		
		t = t - 1
		return -c / 2 * (t * (t - 2) - 1) + b
	end,
	
	["bounce"] = function(t, b, c, d)
		t = t / d
		
		if (t < (1 / 2.75)) then
			return c * (7.5625 * t * t) + b
		elseif (t < (2 / 2.75)) then
			t = t - (1.5 / 2.75)
			
			return c * (7.5625 * t * t + 0.75) + b
		elseif (t < (2.5 / 2.75)) then
			t = t - (2.25 / 2.75)
			
			return c * (7.5625 * t * t + 0.9375) + b
		else
			t = t - (2.625 / 2.75)
			
			return c * (7.5625 * (t) * t + 0.984375) + b
		end
	end,
}

local AnimMethods = {
	All = {
		Play = function(self)
			if (not self.Paused) then
				AnimTypes[self.Type](self)
				self:Callback("OnPlay")
			else
				self:Callback("OnResume")
			end
			
			self.Playing = true
			self.Paused = false
			self.Stopped = false
		end,
		
		IsPlaying = function(self)
			return self.Playing
		end,
		
		Pause = function(self)
			self.Playing = false
			self.Paused = true
			self.Stopped = false
			self:Callback("OnPause")
		end,
		
		IsPaused = function(self)
			return self.Paused
		end,
		
		Stop = function(self)
			local UpdateFrame = UpdateFrames[self.Type]
			
			for i = 1, #UpdateFrame do
				if (UpdateFrame[i] == self) then
					tremove(UpdateFrame, i)
					
					break
				end
			end
			
			self.Playing = false
			self.Paused = false
			self.Stopped = true
			self:Callback("OnStop")
		end,
		
		IsStopped = function(self)
			return self.Stopped
		end,
		
		SetSmoothing = function(self, smoothType)
			smoothType = strlower(smoothType)
			
			self.Smoothing = Smoothing[smoothType] and smoothType or "none"
		end,
		
		GetSmoothing = function(self)
			return self.Smoothing
		end,
		
		SetDuration = function(self, duration)
			self.Duration = duration or 0
		end,
		
		GetDuration = function(self)
			return self.Duration
		end,
		
		SetLooping = function(self, shouldLoop)
			self.Looping = shouldLoop
		end,
		
		GetLooping = function(self)
			return self.Looping
		end,
		
		SetOrder = function(self, order)
			self.Order = order or 1
			
			if (order > self.Group.MaxOrder) then
				self.Group.MaxOrder = order
			end
		end,
		
		GetOrder = function(self)
			return self.Order
		end,
		
		SetScript = function(self, handler, func)
			if (not Callbacks[handler]) then
				return
			end
			
			Callbacks[handler][self] = func
		end,
		
		Callback = function(self, handler)
			if Callbacks[handler][self] then
				Callbacks[handler][self](self.Owner, handler)
			end
		end,
	},
	
	move = {
		SetOffset = function(self, x, y)
			self.XSetting  = x or 0
			self.YSetting  = y or 0
		end,
		
		GetOffset = function(self)
			return self.XSetting, self.YSetting
		end,
		
		GetProgress = function(self)
			return self.XOffset, self.YOffset
		end,
	},
	
	fade = {
		SetChange = function(self, alpha)
			self.EndAlphaSetting = alpha or 0
		end,
		
		GetChange = function(self)
			return self.EndAlphaSetting
		end,
		
		GetProgress = function(self)
			return self.AlphaOffset
		end,
	},
	
	height = {
		SetChange = function(self, height)
			self.EndHeightSetting = height or 0
		end,
		
		GetChange = function(self)
			return self.EndHeightSetting
		end,
		
		GetProgress = function(self)
			return self.HeightOffset
		end,
	},
	
	width = {
		SetChange = function(self, width)
			self.EndWidthSetting = width or 0
		end,
		
		GetChange = function(self)
			return self.EndWidthSetting
		end,
		
		GetProgress = function(self)
			return self.WidthOffset
		end,
	},
	
	color = {
		SetChange = function(self, r, g, b)
			self.EndRSetting = r or 1
			self.EndGSetting = g or 1
			self.EndBSetting = b or 1
		end,
		
		GetChange = function(self)
			return self.EndRSetting, self.EndGSetting, self.EndBSetting
		end,
		
		SetColorType = function(self, type)
			type = strlower(type)
			
			self.ColorType = Set[type] and type or "border"
		end,
		
		GetColorType = function(self)
			return self.ColorType
		end,
		
		GetProgress = function(self)
			return self.ColorOffset
		end,
	},
	
	progress = {
		SetChange = function(self, value)
			self.EndValueSetting = value or 0
		end,
		
		GetChange = function(self)
			return self.EndValueSetting
		end,
		
		GetProgress = function(self)
			return self.ValueOffset
		end,
	},
	
	sleep = {
		GetProgress = function(self)
			return self.SleepTimer
		end,
	},
	
	number = {
		SetChange = function(self, value)
			self.EndNumberSetting = value or 0
		end,
		
		GetChange = function(self)
			return self.EndNumberSetting
		end,
		
		SetPrefix = function(self, text)
			self.Prefix = text or ""
		end,
		
		GetPrefix = function(self)
			return self.Prefix
		end,
		
		SetPostfix = function(self, text)
			self.Postfix = text or ""
		end,
		
		GetPostfix = function(self)
			return self.Postfix
		end,
		
		GetProgress = function(self)
			return self.NumberOffset
		end,
	},
}

local GroupMethods = {
	Play = function(self)
		-- Play!
		for i = 1, #self.Animations do
			if (self.Animations[i].Order == self.Order) then
				self.Animations[i]:Play()
			end
		end
		
		self.Playing = true
		self.Paused = false
		self.Stopped = false
	end,
	
	IsPlaying = function(self)
		return self.Playing
	end,
	
	Pause = function(self)
		-- BUG?, only pause current order
		for i = 1, #self.Animations do
			if (self.Animations[i].Order == self.Order) then
				self.Animations[i]:Pause()
			end
		end
		
		self.Playing = false
		self.Paused = true
		self.Stopped = false
	end,
	
	IsPaused = function(self)
		return self.Paused
	end,
	
	Stop = function(self)
		for i = 1, #self.Animations do
			self.Animations[i]:Stop()
		end
		
		self.Playing = false
		self.Paused = false
		self.Stopped = true
	end,
	
	IsStopped = function(self)
		return self.Stopped
	end,
	
	SetLooping = function(self, shouldLoop)
		self.Looping = shouldLoop
	end,
	
	GetLooping = function(self)
		return self.Looping
	end,
	
	CheckOrder = function(self)
		-- Check if we're done all animations at the current order, then proceed to the next order.
		local NumAtOrder = 0
		local NumDoneAtOrder = 0
		
		for i = 1, #self.Animations do
			if (self.Animations[i].Order == self.Order) then
				NumAtOrder = NumAtOrder + 1
				
				if (not self.Animations[i].Playing) then
					NumDoneAtOrder = NumDoneAtOrder + 1
				end
			end
		end
		
		-- All the animations at x order finished, go to next order
		if (NumAtOrder == NumDoneAtOrder) then
			self.Order = self.Order + 1
			
			-- We exceeded max order, reset to 1 and bail the function, or restart if we're looping
			if (self.Order > self.MaxOrder) then
				self.Order = 1
				
				if (self.Stopped or not self.Looping) then
					self.Playing = false
					
					return
				end
			end
			
			-- Play!
			for i = 1, #self.Animations do
				if (self.Animations[i].Order == self.Order) then
					self.Animations[i]:Play()
				end
			end
		end
	end,
	
	CreateAnimation = function(self, type)
		type = strlower(type)
		
		if (not AnimTypes[type]) then
			return
		end
		
		local Animation = {}
		
		-- General methods
		for key, func in pairs(AnimMethods.All) do
			Animation[key] = func
		end
		
		-- Animation specific methods
		for key, func in pairs(AnimMethods[type]) do
			Animation[key] = func
		end
		
		-- Some attributes, set some defaults
		Animation.Paused = false
		Animation.Playing = false
		Animation.Stopped = false
		Animation.Looping = false
		Animation.Type = type
		Animation.Group = self
		Animation.Owner = self.Owner
		Animation.Order = 1
		Animation.Smoothing = "none"
		
		tinsert(self.Animations, Animation)
		
		return Animation
	end,
}

CreateAnimationGroup = function(self, name)
	local Group = {Animations = {}}
	
	-- Add methods to the group
	for key, func in pairs(GroupMethods) do
		Group[key] = func
	end
	
	Group.Owner = self
	Group.Playing = false
	Group.Paused = false
	Group.Stopped = false
	Group.Order = 1
	Group.MaxOrder = 1
	
	return Group
end

-- Movement
local MoveOnUpdate = function(self, elapsed)
	for i = 1, #self do
		MoveAnim = self[i]
		
		if (MoveAnim and (not MoveAnim.Paused)) then
			MoveAnim.MoveTimer = MoveAnim.MoveTimer + elapsed
			MoveAnim.XOffset = Smoothing[MoveAnim.Smoothing](MoveAnim.MoveTimer, MoveAnim.StartX, MoveAnim.XChange, MoveAnim.Duration)
			MoveAnim.YOffset = Smoothing[MoveAnim.Smoothing](MoveAnim.MoveTimer, MoveAnim.StartY, MoveAnim.YChange, MoveAnim.Duration)
			MoveAnim.Owner:SetPoint(MoveAnim.A1, MoveAnim.P, MoveAnim.A2, (MoveAnim.EndX ~= 0 and MoveAnim.XOffset or MoveAnim.StartX), (MoveAnim.EndY ~= 0 and MoveAnim.YOffset or MoveAnim.StartY))
			
			if (MoveAnim.MoveTimer >= MoveAnim.Duration) then
				tremove(self, i)
				MoveAnim.Owner:SetPoint(MoveAnim.A1, MoveAnim.P, MoveAnim.A2, MoveAnim.EndX, MoveAnim.EndY)
				MoveAnim.Playing = false
				MoveAnim:Callback("OnFinished")
				MoveAnim.Group:CheckOrder()
			end
		end
	end
	
	if (#self == 0) then
		self:SetScript("OnUpdate", nil)
	end
end

local Move = function(self)
	if self:IsPlaying() then
		return
	end
	
	local A1, P, A2, X, Y = self.Owner:GetPoint()
	
	self.MoveTimer = 0
	self.A1 = A1
	self.P = P
	self.A2 = A2
	self.StartX = X
	self.EndX = X + self.XSetting
	self.StartY = Y
	self.EndY = Y + self.YSetting
	self.XChange = self.EndX - self.StartX
	self.YChange = self.EndY - self.StartY
	
	tinsert(MoveFrames, self)
	
	if (not MoveFrames:GetScript("OnUpdate")) then
		MoveFrames:SetScript("OnUpdate", MoveOnUpdate)
	end
end

-- Fade
local FadeOnUpdate = function(self, elapsed)
	for i = 1, #self do
		FadeAnim = self[i]
		
		if (FadeAnim and (not FadeAnim.Paused)) then
			FadeAnim.AlphaTimer = FadeAnim.AlphaTimer + elapsed
			FadeAnim.AlphaOffset = Smoothing[FadeAnim.Smoothing](FadeAnim.AlphaTimer, FadeAnim.StartAlpha, FadeAnim.Change, FadeAnim.Duration)
			FadeAnim.Owner:SetAlpha(FadeAnim.AlphaOffset)
			
			if (FadeAnim.AlphaTimer >= FadeAnim.Duration) then
				tremove(self, i)
				FadeAnim.Owner:SetAlpha(FadeAnim.EndAlpha)
				FadeAnim.Playing = false
				FadeAnim:Callback("OnFinished")
				FadeAnim.Group:CheckOrder()
			end
		end
	end
	
	if (#self == 0) then
		self:SetScript("OnUpdate", nil)
	end
end

local Fade = function(self)
	if self:IsPlaying() then
		return
	end
	
	self.AlphaTimer = 0
	self.StartAlpha = self.Owner:GetAlpha() or 1
	self.EndAlpha = self.EndAlphaSetting or 0
	self.Change = self.EndAlpha - self.StartAlpha
	
	tinsert(AlphaFrames, self)
	
	if (not AlphaFrames:GetScript("OnUpdate")) then
		AlphaFrames:SetScript("OnUpdate", FadeOnUpdate)
	end
end

-- Height
local HeightOnUpdate = function(self, elapsed)
	for i = 1, #self do
		HeightAnim = self[i]
		
		if (HeightAnim and (not HeightAnim.Paused)) then
			HeightAnim.HeightTimer = HeightAnim.HeightTimer + elapsed
			HeightAnim.HeightOffset = Smoothing[HeightAnim.Smoothing](HeightAnim.HeightTimer, HeightAnim.StartHeight, HeightAnim.HeightChange, HeightAnim.Duration)
			HeightAnim.Owner:SetHeight(HeightAnim.HeightOffset)
			
			if (HeightAnim.HeightTimer >= HeightAnim.Duration) then
				tremove(self, i)
				HeightAnim.Owner:SetHeight(HeightAnim.EndHeight)
				HeightAnim.Playing = false
				HeightAnim:Callback("OnFinished")
				HeightAnim.Group:CheckOrder()
			end
		end
	end
	
	if (#self == 0) then
		self:SetScript("OnUpdate", nil)
	end
end

local Height = function(self)
	if self:IsPlaying() then
		return
	end
	
	self.HeightTimer = 0
	self.StartHeight = self.Owner:GetHeight() or 0
	self.EndHeight = self.EndHeightSetting or 0
	self.HeightChange = self.EndHeight - self.StartHeight
	
	tinsert(HeightFrames, self)
	
	if (not HeightFrames:GetScript("OnUpdate")) then
		HeightFrames:SetScript("OnUpdate", HeightOnUpdate)
	end
end

-- Width
local WidthOnUpdate = function(self, elapsed)
	for i = 1, #self do
		WidthAnim = self[i]
		
		if (WidthAnim and (not WidthAnim.Paused)) then
			WidthAnim.WidthTimer = WidthAnim.WidthTimer + elapsed
			WidthAnim.WidthOffset = Smoothing[WidthAnim.Smoothing](WidthAnim.WidthTimer, WidthAnim.StartWidth, WidthAnim.WidthChange, WidthAnim.Duration)
			WidthAnim.Owner:SetWidth(WidthAnim.WidthOffset)
			
			if (WidthAnim.WidthTimer >= WidthAnim.Duration) then
				tremove(self, i)
				WidthAnim.Owner:SetWidth(WidthAnim.EndWidth)
				WidthAnim.Playing = false
				WidthAnim:Callback("OnFinished")
				WidthAnim.Group:CheckOrder()
			end
		end
	end
	
	if (#self == 0) then
		self:SetScript("OnUpdate", nil)
	end
end

local Width = function(self)
	if self:IsPlaying() then
		return
	end
	
	self.WidthTimer = 0
	self.StartWidth = self.Owner:GetWidth() or 0
	self.EndWidth = self.EndWidthSetting or 0
	self.WidthChange = self.EndWidth - self.StartWidth
	
	tinsert(WidthFrames, self)
	
	if (not WidthFrames:GetScript("OnUpdate")) then
		WidthFrames:SetScript("OnUpdate", WidthOnUpdate)
	end
end

-- Color
local ColorOnUpdate = function(self, elapsed)
	for i = 1, #self do
		ColorAnim = self[i]
		
		if (ColorAnim and (not ColorAnim.Paused)) then
			ColorAnim.ColorTimer = ColorAnim.ColorTimer + elapsed
			ColorAnim.ColorOffset = Smoothing[ColorAnim.Smoothing](ColorAnim.ColorTimer, 0, ColorAnim.Duration, ColorAnim.Duration)
			Set[ColorAnim.ColorType](ColorAnim.Owner, GetColor(ColorAnim.ColorTimer / ColorAnim.Duration, ColorAnim.StartR, ColorAnim.StartG, ColorAnim.StartB, ColorAnim.EndR, ColorAnim.EndG, ColorAnim.EndB))
			
			if (ColorAnim.ColorTimer >= ColorAnim.Duration) then
				table.remove(self, i)
				Set[ColorAnim.ColorType](ColorAnim.Owner, ColorAnim.EndR, ColorAnim.EndG, ColorAnim.EndB)
				ColorAnim.Playing = false
				ColorAnim:Callback("OnFinished")
				ColorAnim.Group:CheckOrder()
			end
		end
	end
	
	if (#self == 0) then
		self:SetScript("OnUpdate", nil)
	end
end

local Color = function(self)
	self.ColorTimer = 0
	self.ColorType = self.ColorType or "backdrop"
	self.StartR, self.StartG, self.StartB = Get[self.ColorType](self.Owner)
	self.EndR = self.EndRSetting or 1
	self.EndG = self.EndGSetting or 1
	self.EndB = self.EndBSetting or 1
	
	tinsert(ColorFrames, self)
	
	if (not ColorFrames:GetScript("OnUpdate")) then
		ColorFrames:SetScript("OnUpdate", ColorOnUpdate)
	end
end

-- Progress
local ProgressOnUpdate = function(self, elapsed)
	for i = 1, #self do
		ProgressAnim = self[i]
		
		if (ProgressAnim and (not ProgressAnim.Paused)) then
			ProgressAnim.ProgressTimer = ProgressAnim.ProgressTimer + elapsed
			ProgressAnim.ValueOffset = Smoothing[ProgressAnim.Smoothing](ProgressAnim.ProgressTimer, ProgressAnim.StartValue, ProgressAnim.ProgressChange, ProgressAnim.Duration)
			ProgressAnim.Owner:SetValue(ProgressAnim.ValueOffset)
			
			if (ProgressAnim.ProgressTimer >= ProgressAnim.Duration) then
				table.remove(self, i)
				ProgressAnim.Owner:SetValue(ProgressAnim.EndValue)
				ProgressAnim.Playing = false
				ProgressAnim:Callback("OnFinished")
				ProgressAnim.Group:CheckOrder()
			end
		end
	end
	
	if (#self == 0) then
		self:SetScript("OnUpdate", nil)
	end
end

local Progress = function(self)
	self.ProgressTimer = 0
	self.StartValue = self.Owner:GetValue() or 0
	self.EndValue = self.EndValueSetting or 0
	self.ProgressChange = self.EndValue - self.StartValue
	
	tinsert(ProgressFrames, self)
	
	if (not ProgressFrames:GetScript("OnUpdate")) then
		ProgressFrames:SetScript("OnUpdate", ProgressOnUpdate)
	end
end

-- Sleep
local SleepOnUpdate = function(self, elapsed)
	for i = 1, #self do
		SleepAnim = self[i]
		
		if (SleepAnim and (not SleepAnim.Paused)) then
			SleepAnim.SleepTimer = SleepAnim.SleepTimer + elapsed
			
			if (SleepAnim.SleepTimer >= SleepAnim.Duration) then
				table.remove(self, i)
				SleepAnim.Playing = false
				SleepAnim:Callback("OnFinished")
				SleepAnim.Group:CheckOrder()
			end
		end
	end
	
	if (#self == 0) then
		self:SetScript("OnUpdate", nil)
	end
end

local Sleep = function(self)
	self.SleepTimer = 0
	
	tinsert(SleepFrames, self)
	
	if (not SleepFrames:GetScript("OnUpdate")) then
		SleepFrames:SetScript("OnUpdate", SleepOnUpdate)
	end
end

-- Number
local NumberOnUpdate = function(self, elapsed)
	for i = 1, #self do
		NumberAnim = self[i]
		
		if (NumberAnim and (not NumberAnim.Paused)) then
			NumberAnim.NumberTimer = NumberAnim.NumberTimer + elapsed
			NumberAnim.NumberOffset = Smoothing[NumberAnim.Smoothing](NumberAnim.NumberTimer, NumberAnim.StartNumber, NumberAnim.NumberChange, NumberAnim.Duration)
			NumberAnim.Owner:SetText(NumberAnim.Prefix..floor(NumberAnim.NumberOffset)..NumberAnim.Postfix)
			
			if (NumberAnim.NumberTimer >= NumberAnim.Duration) then
				table.remove(self, i)
				NumberAnim.Owner:SetText(NumberAnim.Prefix..floor(NumberAnim.EndNumber)..NumberAnim.Postfix)
				NumberAnim.Playing = false
				NumberAnim:Callback("OnFinished")
				NumberAnim.Group:CheckOrder()
			end
		end
	end
	
	if (#self == 0) then
		self:SetScript("OnUpdate", nil)
	end
end

local Number = function(self)
	self.NumberTimer = 0
	self.StartNumber = tonumber(self.Owner:GetText()) or 0
	self.EndNumber = self.EndNumberSetting or 0
	self.NumberChange = self.EndNumberSetting - self.StartNumber
	self.Prefix = self.Prefix or ""
	self.Postfix = self.Postfix or ""
	
	tinsert(NumberFrames, self)
	
	if (not NumberFrames:GetScript("OnUpdate")) then
		NumberFrames:SetScript("OnUpdate", NumberOnUpdate)
	end
end

-- Store animation functions
AnimTypes["move"] = Move
AnimTypes["fade"] = Fade
AnimTypes["height"] = Height
AnimTypes["width"] = Width
AnimTypes["color"] = Color
AnimTypes["progress"] = Progress
AnimTypes["sleep"] = Sleep
AnimTypes["number"] = Number

_G["_LibAnim"] = Version