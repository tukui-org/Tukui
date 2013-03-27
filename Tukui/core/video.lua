local T, C, L, G = unpack(select(2, ...))

--------------------------------------------------------
-- detect if high, low or eyefinity version
--------------------------------------------------------

if T.screenwidth < 1600 then
		if C.general.overridelowtohigh == true then
			C["general"].autoscale = false
			T.lowversion = false
		else
			T.lowversion = true
		end
elseif (T.screenwidth > 3840) or (UIParent:GetWidth() + 1 > T.screenwidth) then
	local width = T.screenwidth
	local height = T.screenheight
	
	-- because some user enable bezel compensation, we need to find the real width of a single monitor.
	-- I don't know how it really work, but i'm assuming they add pixel to width to compensate the bezel. :P
	
	-- HQ resolution
	if width >= 9840 then width = 3280 end                   	                -- WQSXGA
	if width >= 7680 and width < 9840 then width = 2560 end                     -- WQXGA
	if width >= 5760 and width < 7680 then width = 1920 end 	                -- WUXGA & HDTV
	if width >= 5040 and width < 5760 then width = 1680 end 	                -- WSXGA+
	
	-- adding height condition here to be sure it work with bezel compensation because WSXGA+ and UXGA/HD+ got approx same width
	if width >= 4800 and width < 5760 and height == 900 then width = 1600 end   -- UXGA & HD+
	
	-- low resolution screen
	if width >= 4320 and width < 4800 then width = 1440 end 	                -- WSXGA
	if width >= 4080 and width < 4320 then width = 1360 end 	                -- WXGA
	if width >= 3840 and width < 4080 then width = 1224 end 	                -- SXGA & SXGA (UVGA) & WXGA & HDTV
	
	-- yep, now set Tukui to lower reso if screen #1 width < 1600
	if width < 1600 and not C.general.overridelowtohigh then
		T.lowversion = true
	end
	
	-- register a constant, we will need it later for launch.lua
	T.eyefinity = width
end

-- raid scale according to which version we use
if T.lowversion then
	T.raidscale = 0.8
else
	T.raidscale = 1
end

--------------------------------------------------------
-- Auto Scale UI (Overwrite Settings and Blizzard)
--------------------------------------------------------

-- autoscale
if C["general"].autoscale == true then
	C["general"].uiscale = min(2, max(.64, 768/string.match(T.resolution, "%d+x(%d+)")))
end
	
--------------------------------------------------------
-- Graphics Settings
--------------------------------------------------------

-- the ui doesn't reload if ratio stay the same, we need to force reload if it happen.
local function NeedReloadUI()
	local resolution = Graphics_ResolutionDropDown
	local x, y = resolution:getValues()
	local oldratio = T.screenwidth / T.screenheight
	local newratio = x / y
	local oldreso = T.resolution
	local newreso = x.."x"..y
	
	if (oldratio == newratio) and (oldreso ~= newreso) then
		ReloadUI()
	end
end

local Graphic = CreateFrame("Frame")
Graphic:RegisterEvent("PLAYER_ENTERING_WORLD")
Graphic:SetScript("OnEvent", function(self, event)
	-- always enable uiscale for Tukui (needed)
	local useUiScale = GetCVar("useUiScale")
	if useUiScale ~= "1" then
		SetCVar("useUiScale", 1)
	end

	-- Multisample need to be at 1 for pixel perfectness
	local gxMultisample = GetCVar("gxMultisample")
	if C["general"].multisampleprotect == true and gxMultisample ~= "1" then
		SetMultisampleFormat(1)
	end

	-- uiscale security
	if C["general"].uiscale > 1.1 then C["general"].uiscale = 1.1 end
	if C["general"].uiscale < 0.64 then C["general"].uiscale = 0.64 end

	-- set our new uiscale now if it doesn't match Blizzard saved uiScale.
	if format("%.2f", GetCVar("uiScale")) ~= format("%.2f", C["general"].uiscale) then
		-- if we set an uiscale, it broke quest when opening full size map in combat
		T.FullMapQuestTaintFix = true
		
		-- set new ui scale
		SetCVar("uiScale", C["general"].uiscale)
	end

	-- we adjust UIParent to screen #1 if Eyefinity is found
	if T.eyefinity then
		local width = T.eyefinity
		local height = T.screenheight
		
		-- if autoscale is off, find a new width value of UIParent for screen #1.
		if not C.general.autoscale or height > 1200 then
			local h = UIParent:GetHeight()
			local ratio = T.screenheight / h
			local w = T.eyefinity / ratio
			
			width = w
			height = h			
		end
		
		UIParent:SetSize(width, height)
		UIParent:ClearAllPoints()
		UIParent:SetPoint("CENTER")		
	end

	-- require a reload when graphics option changes, even if Standard Blizzard UI doesn't really need it.
	VideoOptionsFrameOkay:HookScript("OnClick", NeedReloadUI)
	VideoOptionsFrameApply:HookScript("OnClick", NeedReloadUI)
	
	-- unload
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)