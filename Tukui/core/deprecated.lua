--[[	
		In computer software or authoring programs standards and documentation, 
		the term deprecation is applied to software features that are superseded 
		and should be avoided. Although deprecated features remain in the current 
		version, their use may raise warning messages recommending alternative practices, 
		and deprecation may indicate that the feature will be removed in the future. 
		Features are deprecated—rather than being removed—in order to provide 
		backward compatibility and give programmers who have used the feature time to 
		bring their code into compliance with the new standard.
--]]

local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- pixel perfect script of custom ui scale.
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/C["general"].uiscale
local scale = function(x)
    return mult*math.floor(x/mult+.5)
end

T.Scale = function(x) return scale(x) end
T.mult = mult

--[[
		You have 1 month after r13 release to make changes to your addons with Tukui API.
		All these functions will disapear from Tukui at the start of marsh 2011
		See Docs/API.txt for more informations.
--]]

T.CreatePanel = function(f, w, h, a1, p, a2, x, y)
	local sh = scale(h)
	local sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
	  bgFile = C["media"].blank, 
	  edgeFile = C["media"].blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(C["media"].backdropcolor))
	f:SetBackdropBorderColor(unpack(C["media"].bordercolor))
end

T.CreateTransparentPanel = function(f, w, h, a1, p, a2, x, y)
	if t == "Tukui" then
		local sh = Scale(h)
		local sw = Scale(w)
		f:SetFrameLevel(1)
		f:SetHeight(sh)
		f:SetWidth(sw)
		f:SetFrameStrata("BACKGROUND")
		f:SetPoint(a1, p, a2, x, y)
		f:SetBackdrop({
		  bgFile = C["media"].blank,
		  edgeFile = C["media"].blank,
		  tile = false, tileSize = 0, edgeSize = mult,
		  insets = { left = T.Scale(2), right = T.Scale(2), top = T.Scale(2), bottom = T.Scale(2)}
		})
		f:SetBackdropColor(.075,.075,.075,.8) -- (red, green, blue, alpha)
		f:SetBackdropBorderColor(unpack(C["media"].bordercolor))

		local border = CreateFrame("Frame", nil, f)
		border:SetFrameLevel(0)
		border:SetPoint("TOPLEFT", f, "TOPLEFT", T.Scale(-1), T.Scale(1))
		border:SetFrameStrata("BACKGROUND")
		border:SetBackdrop {
			edgeFile = C["media"].blank, edgeSize = T.Scale(3),
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		}
		border:SetBackdropColor(unpack(C["media"].backdropcolor))
		border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
		border:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", T.Scale(1), T.Scale(-1))
	end
end

T.SetTemplate = function(f)
	f:SetBackdrop({
	  bgFile = C["media"].blank, 
	  edgeFile = C["media"].blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(C["media"].backdropcolor))
	f:SetBackdropBorderColor(unpack(C["media"].bordercolor))
end

T.CreateShadow = function(f)
	if f.shadow then return end -- we seriously don't want to create shadow 2 times in a row on the same frame.
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", T.Scale(-4), T.Scale(4))
	shadow:SetPoint("BOTTOMLEFT", T.Scale(-4), T.Scale(-4))
	shadow:SetPoint("TOPRIGHT", T.Scale(4), T.Scale(4))
	shadow:SetPoint("BOTTOMRIGHT", T.Scale(4), T.Scale(-4))
	shadow:SetBackdrop( { 
		edgeFile = C["media"].glowTex, edgeSize = T.Scale(3),
		insets = {left = T.Scale(5), right = T.Scale(5), top = T.Scale(5), bottom = T.Scale(5)},
	})
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.5)
	f.shadow = shadow
end

T.Kill = function(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = T.dummy
	object:Hide()
end

-- styleButton function authors are Chiril & Karudon.
T.StyleButton = function(b, checked) 
    local name = b:GetName()
 
    local button          = _G[name]
    local icon            = _G[name.."Icon"]
    local count           = _G[name.."Count"]
    local border          = _G[name.."Border"]
    local hotkey          = _G[name.."HotKey"]
    local cooldown        = _G[name.."Cooldown"]
    local nametext        = _G[name.."Name"]
    local flash           = _G[name.."Flash"]
    local normaltexture   = _G[name.."NormalTexture"]
	local icontexture     = _G[name.."IconTexture"]

	local hover = b:CreateTexture("frame", nil, self) -- hover
	hover:SetTexture(1,1,1,0.3)
	hover:SetHeight(button:GetHeight())
	hover:SetWidth(button:GetWidth())
	hover:Point("TOPLEFT",button,2,-2)
	hover:Point("BOTTOMRIGHT",button,-2,2)
	button:SetHighlightTexture(hover)

	local pushed = b:CreateTexture("frame", nil, self) -- pushed
	pushed:SetTexture(0.9,0.8,0.1,0.3)
	pushed:SetHeight(button:GetHeight())
	pushed:SetWidth(button:GetWidth())
	pushed:Point("TOPLEFT",button,2,-2)
	pushed:Point("BOTTOMRIGHT",button,-2,2)
	button:SetPushedTexture(pushed)
 
	if checked then
		local checked = b:CreateTexture("frame", nil, self) -- checked
		checked:SetTexture(0,1,0,0.3)
		checked:SetHeight(button:GetHeight())
		checked:SetWidth(button:GetWidth())
		checked:Point("TOPLEFT",button,2,-2)
		checked:Point("BOTTOMRIGHT",button,-2,2)
		button:SetCheckedTexture(checked)
	end
end