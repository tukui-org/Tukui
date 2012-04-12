local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if C.unitframes.enable ~= true then return end

local _NAME, _NS = ...
local oUF = _NS.oUF or oUF

assert(oUF, "oUF_MovableFrames was unable to locate oUF install.")

local _DB
local _DBNAME = GetAddOnMetadata(_NAME, 'X-SavedVariables')
local _LOCK
local _TITLE = GetAddOnMetadata(_NAME, 'title')

-- I could use the title field in the TOC, but people tend to put color and
-- other shit there, so we'll just use the folder name:
local slashGlobal = _NAME:gsub('%s+', '_'):gsub('[^%a%d_]+', ''):upper()
slashGlobal = slashGlobal .. '_OMF'

local print_fmt = string.format('|cff33ff99%s:|r', _TITLE)
local print = function(...)
	return print(print_fmt, ...)
end

local backdropPool = {}

local getPoint = function(obj, anchor)
	if(not anchor) then
		local UIx, UIy = UIParent:GetCenter()
		local Ox, Oy = obj:GetCenter()

		-- Frame doesn't really have a positon yet.
		if(not Ox) then return end

		local OS = obj:GetScale()
		Ox, Oy = Ox * OS, Oy * OS

		local UIWidth, UIHeight = UIParent:GetRight(), UIParent:GetTop()

		local LEFT = UIWidth / 3
		local RIGHT = UIWidth * 2 / 3

		local point, x, y
		if(Ox >= RIGHT) then
			point = 'RIGHT'
			x = obj:GetRight() - UIWidth
		elseif(Ox <= LEFT) then
			point = 'LEFT'
			x = obj:GetLeft()
		else
			x = Ox - UIx
		end

		local BOTTOM = UIHeight / 3
		local TOP = UIHeight * 2 / 3

		if(Oy >= TOP) then
			point = 'TOP' .. (point or '')
			y = obj:GetTop() - UIHeight
		elseif(Oy <= BOTTOM) then
			point = 'BOTTOM' .. (point or '')
			y = obj:GetBottom()
		else
			if(not point) then point = 'CENTER' end
			y = Oy - UIy
		end

		return string.format(
			'%s\031%s\031%d\031%d\031\%.3f',
			point, 'UIParent', x,  y, OS
		)
	else
		local point, parent, _, x, y = anchor:GetPoint()

		return string.format(
			'%s\031%s\031%d\031%d\031\%.3f',
			point, 'UIParent', x, y, obj:GetScale()
		)
	end
end

local getObjectInformation  = function(obj)
	-- This won't be set if we're dealing with oUF <1.3.22. Due to this we're just
	-- setting it to Unknown. It will only break if the user has multiple layouts
	-- spawning the same unit or change between layouts.
	local style = obj.style or 'Unknown'
	local identifier = obj:GetName() or obj.unit

	-- Are we dealing with header units?
	local isHeader
	local parent = obj:GetParent()

	if(parent) then
		if(parent:GetAttribute'initialConfigFunction' and parent.style) then
			isHeader = parent

			identifier = parent:GetName()
		elseif(parent:GetAttribute'oUF-onlyProcessChildren') then
			isHeader = parent:GetParent()

			identifier = isHeader:GetName()
		end
	end

	return style, identifier, isHeader
end

local restoreDefaultPosition = function(style, identifier)
	-- We've not saved any default position for this style.
	if(not _DB.__INITIAL or not _DB.__INITIAL[style] or not _DB.__INITIAL[style][identifier]) then return end

	local obj, isHeader
	for _, frame in next, oUF.objects do
		local fStyle, fIdentifier, fIsHeader = getObjectInformation(frame)
		if(fStyle == style and fIdentifier == identifier) then
			obj = frame
			isHeader = fIsHeader

			break
		end
	end

	if(obj) then
		local target = isHeader or obj

		target:ClearAllPoints()
		local point, parentName, x, y, scale = string.split('\031', _DB.__INITIAL[style][identifier])
		if(not scale) then scale = 1 end

		target:_SetScale(scale)
		target:_SetPoint(point, parentName, point, x, y)

		local backdrop = backdropPool[target]
		if(backdrop) then
			backdrop:ClearAllPoints()
			backdrop:SetAllPoints(target)
		end

		-- We don't need this anymore
		_DB.__INITIAL[style][identifier] = nil
		if(not next(_DB.__INITIAL[style])) then
			_DB[style] = nil
		end
	end
end

local function restorePosition(obj)
	if(InCombatLockdown()) then return end
	local style, identifier, isHeader = getObjectInformation(obj)
	-- We've not saved any custom position for this style.
	if(not _DB[style] or not _DB[style][identifier]) then return end

	local target = isHeader or obj
	if(not target._SetPoint) then
		target._SetPoint = target.SetPoint
		target.SetPoint = restorePosition
		target._SetScale = target.SetScale
		target.SetScale = restorePosition
	end
	target:ClearAllPoints()

	-- damn it Blizzard, _how_ did you manage to get the input of this function
	-- reversed. Any sane person would implement this as: split(str, dlm, lim);
	local point, parentName, x, y, scale = string.split('\031', _DB[style][identifier])
	if(not scale) then
		scale = 1
	end

	if(scale) then
		target:_SetScale(scale)
	else
		scale = target:GetScale()
	end
	target:_SetPoint(point, parentName, point, x / scale, y / scale)
end

local restoreCustomPosition = function(style, ident)
	for _, obj in next, oUF.objects do
		local objStyle, objIdent = getObjectInformation(obj)
		if(objStyle == style and objIdent == ident) then
			return restorePosition(obj)
		end
	end
end

local saveDefaultPosition = function(obj)
	local style, identifier, isHeader = getObjectInformation(obj)
	if(not _DB.__INITIAL) then
		_DB.__INITIAL = {}
	end

	if(not _DB.__INITIAL[style]) then
		_DB.__INITIAL[style] = {}
	end

	if(not _DB.__INITIAL[style][identifier]) then
		local point
		if(isHeader) then
			point = getPoint(isHeader)
		else
			point = getPoint(obj)
		end

		_DB.__INITIAL[style][identifier] = point
	end
end

local savePosition = function(obj, anchor)
	local style, identifier, isHeader = getObjectInformation(obj)
	if(not _DB[style]) then _DB[style] = {} end

	_DB[style][identifier] = getPoint(isHeader or obj, anchor)
end

local saveCustomPosition = function(style, ident, point, x, y, scale)
	-- Shouldn't really be the case, but you never know!
	if(not _DB[style]) then _DB[style] = {} end

	_DB[style][ident] = string.format(
		'%s\031%s\031%d\031%d\031\%.3f',
		point, 'UIParent', x,  y, scale
	)
end

-- Attempt to figure out a more sane name to dispaly.
local smartName
do
	local nameCache = {}
	local validNames = {
		'player',
		'target',
		'focus',
		'raid',
		'pet',
		'party',
		'maintank',
		'mainassist',
		'arena',
	}

	local rewrite = {
		mt = 'maintank',
		mtt = 'maintanktarget',

		ma = 'mainassist',
		mat = 'mainassisttarget',
	}

	local validName = function(smartName)
		-- Not really a valid name, but we'll accept it for simplicities sake.
		if(tonumber(smartName)) then
			return smartName
		end

		if(type(smartName) == 'string') then
			-- strip away trailing s from pets, but don't touch boss/focus.
			smartName = smartName:gsub('([^us])s$', '%1')

			if(rewrite[smartName]) then
				return rewrite[smartName]
			end

			for _, v in next, validNames do
				if(v == smartName) then
					return smartName
				end
			end

			if(
				smartName:match'^party%d?$' or
				smartName:match'^arena%d?$' or
				smartName:match'^boss%d?$' or
				smartName:match'^partypet%d?$' or
				smartName:match'^raid%d?%d?$' or
				smartName:match'%w+target$' or
				smartName:match'%w+pet$'
				) then
				return smartName
			end
		end
	end

	local function guessName(...)
		local name = validName(select(1, ...))

		local n = select('#', ...)
		if(n > 1) then
			for i=2, n do
				local inp = validName(select(i, ...))
				if(inp) then
					name = (name or '') .. inp
				end
			end
		end

		return name
	end

	local smartString = function(name)
		if(nameCache[name]) then
			return nameCache[name]
		end

		-- Here comes the substitute train!
		local n = name
			:gsub('ToT', 'targettarget')
			:gsub('(%l)(%u)', '%1_%2')
			:gsub('([%l%u])(%d)', '%1_%2_')
			:gsub('Main_', 'Main')
			:lower()

		n = guessName(string.split('_', n))
		if(n) then
			nameCache[name] = n
			return n
		end

		return name
	end

	smartName = function(obj, header)
		if(type(obj) == 'string') then
			return smartString(obj)
		elseif(header) then
			return smartString(header:GetName())
		else
			local name = obj:GetName()
			if(name) then
				return smartString(name)
			end

			return obj.unit or '<unknown>'
		end
	end
end

do
	local frame = CreateFrame"Frame"
	frame:SetScript("OnEvent", function(self, event)
		return self[event](self)
	end)

	function frame:VARIABLES_LOADED()
		-- I honestly don't trust the load order of SVs.
		if (TukuiDataPerChar == nil) then TukuiDataPerChar = {} end
		_DB = TukuiDataPerChar.ufpos or {}
		TukuiDataPerChar.ufpos = _DB
		
		-- Got to catch them all!
		for _, obj in next, oUF.objects do
			restorePosition(obj)
		end

		oUF:RegisterInitCallback(restorePosition)
		self:UnregisterEvent"VARIABLES_LOADED"
	end
	frame:RegisterEvent"VARIABLES_LOADED"

	function frame:PLAYER_REGEN_DISABLED()
		if(_LOCK) then
			for k, bdrop in next, backdropPool do
				bdrop:Hide()
			end
			_LOCK = nil
		end
	end
	frame:RegisterEvent"PLAYER_REGEN_DISABLED"
end

local getBackdrop
do
	local OnShow = function(self)
		return self.name:SetText(smartName(self.obj, self.header))
	end

	local OnHide = function(self)
		if(self.dirtyMinHeight) then
			self:SetAttribute('minHeight', nil)
		end

		if(self.dirtyMinWidth) then
			self:SetAttribute('minWidth', nil)
		end
	end

	local OnDragStart = function(self)
		saveDefaultPosition(self.obj)
		self:StartMoving()

		local frame = self.header or self.obj
		frame:ClearAllPoints();
		frame:SetAllPoints(self);
	end

	local OnDragStop = function(self)
		self:StopMovingOrSizing()
		savePosition(self.obj, self)

		-- Restore the initial anchoring, so the anchor follows the frame when we
		-- edit positions through the UI.
		restorePosition(self.obj)
		self:ClearAllPoints()
		self:SetAllPoints(self.header or self.obj)
	end

	local OnMouseDown = function(self)
		local anchor = self:GetParent()
		saveDefaultPosition(anchor.obj)
		anchor:StartSizing('BOTTOMRIGHT')

		local frame = anchor.header or anchor.obj
		frame:ClearAllPoints()
		frame:SetAllPoints(anchor)

		self:SetButtonState("PUSHED", true)
	end

	local OnMouseUp = function(self)
		local anchor = self:GetParent()
		self:SetButtonState("NORMAL", false)

		anchor:StopMovingOrSizing()
		savePosition(anchor.obj, anchor)
	end

	local OnSizeChanged = function(self, width, height)
		local baseWidth, baseHeight = self.baseWidth, self.baseHeight

		local scale = width / baseWidth

		-- This is damn tiny!
		if(scale <= .3) then
			scale = .3
		end

		self:SetSize(scale * baseWidth, scale * baseHeight)
		local target = self. target;
		(target._SetScale or target.SetScale) (target, scale)
	end

	getBackdrop = function(obj, isHeader)
		local target = isHeader or obj
		if(not target:GetCenter()) then return end
		if(backdropPool[target]) then return backdropPool[target] end

		local backdrop = CreateFrame"Frame"
		backdrop:SetParent(UIParent)
		backdrop:Hide()

		backdrop:SetTemplate("Default")
		backdrop:SetFrameStrata("MEDIUM")
		backdrop:SetFrameLevel(20)
		backdrop:SetAllPoints(target)

		backdrop:EnableMouse(true)
		backdrop:SetMovable(true)
		backdrop:SetResizable(true)
		backdrop:RegisterForDrag"LeftButton"

		local name = backdrop:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		name:SetPoint"CENTER"
		name:SetJustifyH"CENTER"
		name:SetFont(C.media.uffont, 12)
		name:SetTextColor(1, 1, 1)

		local scale = CreateFrame('Button', nil, backdrop)
		scale:SetPoint'BOTTOMRIGHT'
		scale:SetSize(16, 16)

		scale:SetNormalTexture[[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Up]]
		scale:SetHighlightTexture[[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Highlight]]
		scale:SetPushedTexture[[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Down]]

		scale:SetScript('OnMouseDown', OnMouseDown)
		scale:SetScript('OnMouseUp', OnMouseUp)

		backdrop.name = name
		backdrop.obj = obj
		backdrop.header = isHeader
		backdrop.target = target

		backdrop:SetBackdropBorderColor(1, 0, 0)

		backdrop.baseWidth, backdrop.baseHeight = obj:GetSize()

		-- We have to define a minHeight on the header if it doesn't have one. The
		-- reason for this is that the header frame will have an height of 0.1 when
		-- it doesn't have any frames visible.
		if(
			isHeader and
			(
				not isHeader:GetAttribute'minHeight' and math.floor(isHeader:GetHeight()) == 0 or
				not isHeader:GetAttribute'minWidth' and math.floor(isHeader:GetWidth()) == 0
			)
		) then
			isHeader:SetHeight(obj:GetHeight())
			isHeader:SetWidth(obj:GetWidth())

			if(not isHeader:GetAttribute'minHeight') then
				isHeader.dirtyMinHeight = true
				isHeader:SetAttribute('minHeight', obj:GetHeight())
			end

			if(not isHeader:GetAttribute'minWidth') then
				isHeader.dirtyMinWidth = true
				isHeader:SetAttribute('minWidth', obj:GetWidth())
			end
		elseif(isHeader) then
			backdrop.baseWidth, backdrop.baseHeight = isHeader:GetSize()
		end

		backdrop:SetScript("OnShow", OnShow)
		backdrop:SetScript('OnHide', OnHide)

		backdrop:SetScript("OnDragStart", OnDragStart)
		backdrop:SetScript("OnDragStop", OnDragStop)

		backdrop:SetScript('OnSizeChanged', OnSizeChanged)

		backdropPool[target] = backdrop

		return backdrop
	end
end

-- reset data
local function RESETUF()
	TukuiDataPerChar.ufpos = {}
	ReloadUI()
end
SLASH_RESETUF1 = "/resetuf"
SlashCmdList["RESETUF"] = RESETUF

T.MoveUnitFrames = function(inp)
	if(InCombatLockdown()) then
		return
	end

	if(not _LOCK) then
		for k, obj in next, oUF.objects do
			local style, identifier, isHeader = getObjectInformation(obj)
			local backdrop = getBackdrop(obj, isHeader)
			if(backdrop) then backdrop:Show() end
		end

		_LOCK = true
	else
		for k, bdrop in next, backdropPool do
			bdrop:Hide()
		end

		_LOCK = nil
	end
end
-- It's not in your best interest to disconnect me. Someone could get hurt.