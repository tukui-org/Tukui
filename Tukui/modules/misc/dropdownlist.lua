local T, C, L, G = unpack(select(2, ...))

-- Skin all DropDownList[i]
local function SkinDropDownList(level, index)
	for i = 1, UIDROPDOWNMENU_MAXLEVELS do
		local menubackdrop = _G["DropDownList"..i.."MenuBackdrop"]
		if menubackdrop and not menubackdrop.isSkinned then
			menubackdrop:SetTemplate("Default")
			menubackdrop.isSkinned = true
		end
		
		local backdrop = _G["DropDownList"..i.."Backdrop"]
		if backdrop and not backdrop.isSkinned then
			backdrop:SetTemplate("Default")
			backdrop.isSkinned = true
		end
	end
end
hooksecurefunc("UIDropDownMenu_CreateFrames", SkinDropDownList)

-- chat menu dropdown
local ChatMenus = {
	"ChatMenu",
	"EmoteMenu",
	"LanguageMenu",
	"VoiceMacroMenu",		
}

for i = 1, getn(ChatMenus) do
	if _G[ChatMenus[i]] == _G["ChatMenu"] then
		_G[ChatMenus[i]]:HookScript("OnShow", function(self) self:SetTemplate("Default", true) self:SetBackdropColor(unpack(C["media"].backdropcolor)) self:ClearAllPoints() self:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, T.Scale(30)) end)
	else
		_G[ChatMenus[i]]:HookScript("OnShow", function(self) self:SetTemplate("Default", true) self:SetBackdropColor(unpack(C["media"].backdropcolor)) end)
	end
end