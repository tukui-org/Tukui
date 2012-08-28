local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	-- always scale it at the same value as UIParent
	ScriptErrorsFrame:SetParent(UIParent)
	
	local noscalemult = T.mult * C["general"].uiscale
	local bg = {
	  bgFile = C["media"].blank, 
	  edgeFile = C["media"].blank, 
	  tile = false, tileSize = 0, edgeSize = noscalemult, 
	  insets = { left = -noscalemult, right = -noscalemult, top = -noscalemult, bottom = -noscalemult}
	}
	
	ScriptErrorsFrame:SetBackdrop(bg)
	ScriptErrorsFrame:SetBackdropColor(unpack(C.media.backdropcolor))
	ScriptErrorsFrame:SetBackdropBorderColor(unpack(C.media.bordercolor))	

	EventTraceFrame:SetTemplate("Default")
	
	local texs = {
		"TopLeft",
		"TopRight",
		"Top",
		"BottomLeft",
		"BottomRight",
		"Bottom",
		"Left",
		"Right",
		"TitleBG",
		"DialogBG",
	}
	
	for i=1, #texs do
		_G["ScriptErrorsFrame"..texs[i]]:SetTexture(nil)
		_G["EventTraceFrame"..texs[i]]:SetTexture(nil)
	end
	
	local bg = {
	  bgFile = C["media"].normTex, 
	  edgeFile = C["media"].blank, 
	  tile = false, tileSize = 0, edgeSize = noscalemult, 
	  insets = { left = -noscalemult, right = -noscalemult, top = -noscalemult, bottom = -noscalemult}
	}
	
	for i=1, ScriptErrorsFrame:GetNumChildren() do
		local child = select(i, ScriptErrorsFrame:GetChildren())
		if child:GetObjectType() == "Button" and not child:GetName() then
			
			child:SkinButton()
			child:SetBackdrop(bg)
			child:SetBackdropColor(unpack(C.media.backdropcolor))
			child:SetBackdropBorderColor(unpack(C.media.bordercolor))	
		end
	end
	
	ScriptErrorsFrameClose:SkinCloseButton()
	ScriptErrorsFrameScrollFrameScrollBar:SkinScrollBar()
	EventTraceFrameScrollBG:SetTexture(nil)
	ScriptErrorsFrameScrollFrameScrollBar:ClearAllPoints()
	ScriptErrorsFrameScrollFrameScrollBar:SetPoint("TOPRIGHT", 50, 14)
	ScriptErrorsFrameScrollFrameScrollBar:SetPoint("BOTTOMRIGHT", 50, -20)
	EventTraceFrameCloseButton:SkinCloseButton()
end

T.SkinFuncs["Blizzard_DebugTools"] = LoadSkin