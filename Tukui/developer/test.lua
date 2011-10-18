local T, C, L = unpack(select(2, ...))

-- these are just random tool or command for PTR for testing various stuff.

function popit()
	ExtraActionBarFrame:Show()
	ExtraActionBarFrame:SetAlpha(1)
	ExtraActionButton1:Show() 
	ExtraActionButton1:SetAlpha(1)
	ExtraActionButton1.icon:SetTexture("Interface\\Icons\\INV_Jewelry_TrinketPVP_02")
	ExtraActionButton1.icon:Show()
	ExtraActionButton1.icon:SetAlpha(1)
end

function ctex()
	if ExtraActionButton1.style:GetTexture() == "Interface\\UnitPowerBarAlt\\SpellPush-Frame" then
		ExtraActionButton1.style:SetTexture("Interface\\UnitPowerBarAlt\\SpellPush-Frame-Ysera")
	else
		ExtraActionButton1.style:SetTexture("Interface\\UnitPowerBarAlt\\SpellPush-Frame")
	end
end

SLASH_EXTRABUTTON1 = "/extrabutton"
SlashCmdList["EXTRABUTTON"] = function(arg)
	if arg == "texture" then
		ctex()
	elseif arg == "hide" then
		ExtraActionBarFrame:Hide()
	else
		popit()
	end
end