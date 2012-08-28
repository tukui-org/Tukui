local T, C, L, G = unpack(select(2, ...)) 
-----------------------------------------------------------------------------
-- Copy on chatframes feature
-----------------------------------------------------------------------------

if C["chat"].enable ~= true then return end

local lines = {}
local frame = nil
local editBox = nil
local isf = nil

local function CreateCopyFrame()
	frame = CreateFrame("Frame", "TukuiChatCopyFrame", UIParent)
	frame:SetTemplate("Default")
	if T.lowversion then
		frame:Width(TukuiBar1:GetWidth() + 10)
	else
		frame:Width((TukuiBar1:GetWidth() * 2) + 20)
	end
	frame:Height(250)
	frame:SetScale(1)
	frame:Point("BOTTOM", UIParent, "BOTTOM", 0, 10)
	frame:Hide()
	frame:SetFrameStrata("DIALOG")

	local scrollArea = CreateFrame("ScrollFrame", "TukuiChatCopyScroll", frame, "UIPanelScrollFrameTemplate")
	scrollArea:Point("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:Point("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)

	editBox = CreateFrame("EditBox", "TukuiChatCopyEditBox", frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	if T.lowversion then
		editBox:Width(TukuiBar1:GetWidth() + 10)
	else
		editBox:Width((TukuiBar1:GetWidth() * 2) + 20)
	end
	editBox:Height(250)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)

	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame("Button", "CopyCloseButton", frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
	close:SkinCloseButton()
	TukuiChatCopyScrollScrollBar:SkinScrollBar()

	isf = true
end

local function GetLines(...)
	--[[		Grab all those lines		]]--
	local ct = 1
	for i = select("#", ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == "FontString" then
			lines[ct] = tostring(region:GetText())
			ct = ct + 1
		end
	end
	return ct - 1
end

local function Copy(cf)
	local _, size = cf:GetFont()
	FCF_SetChatWindowFontSize(cf, cf, 0.01)
	local lineCt = GetLines(cf:GetRegions())
	local text = table.concat(lines, "\n", 1, lineCt)
	FCF_SetChatWindowFontSize(cf, cf, size)
	if not isf then CreateCopyFrame() end
	if frame:IsShown() then frame:Hide() return end
	frame:Show()
	editBox:SetText(text)
end

for i = 1, NUM_CHAT_WINDOWS do
	local cf = _G[format("ChatFrame%d",  i)]
	local button = CreateFrame("Button", format("TukuiButtonCF%d", i), cf)
	button:SetPoint("TOPRIGHT", 0, 0)
	button:Height(20)
	button:Width(20)
	button:SetNormalTexture(C.media.copyicon)
	button:SetAlpha(0)
	button:SetTemplate("Default")

	button:SetScript("OnMouseUp", function(self)
		Copy(cf)
	end)
	button:SetScript("OnEnter", function() 
		button:SetAlpha(1) 
	end)
	button:SetScript("OnLeave", function() button:SetAlpha(0) end)
	
	G.Chat["ChatFrame"..i].Copy = button
end

-- little fix for RealID text copy/paste (real name bug)
for i=1, NUM_CHAT_WINDOWS do
	local editbox = _G["ChatFrame"..i.."EditBox"]
	editbox:HookScript("OnTextChanged", function(self)
		local text = self:GetText()
		
		local new, found = gsub(text, "|Kf(%S+)|k(%S+)%s(%S+)k:%s", "%2 %3: ")
		
		if found > 0 then
			new = new:gsub('|', '')
			self:SetText(new)
		end
	end)
end