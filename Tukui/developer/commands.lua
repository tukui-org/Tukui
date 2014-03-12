--enable lua error by command
function SlashCmdList.LUAERROR(msg, editbox)
	if (msg == 'on') then
		SetCVar("scriptErrors", 1)
		--because sometime we need to /rl to show an error on login.
		ReloadUI()
	elseif (msg == 'off') then
		SetCVar("scriptErrors", 0)
	else
		print("/luaerror on - /luaerror off")
	end
end
SLASH_LUAERROR1 = '/luaerror'

local TestUI = function(msg)
	if not Tukui[2].unitframes.enable then return end
	if msg == "" then msg = "all" end
	
    if msg == "all" or msg == "arena" then
		for i = 1, 3 do
			_G["TukuiArena"..i]:Show(); _G["TukuiArena"..i].Hide = function() end; _G["TukuiArena"..i].unit = "player"
			_G["TukuiArena"..i].Trinket.Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Necklace_37")
		end
	end
	
    if msg == "all" or msg == "boss" then
		for i = 1, 3 do
			_G["TukuiBoss"..i]:Show(); _G["TukuiBoss"..i].Hide = function() end; _G["TukuiBoss"..i].unit = "player"
		end
	end
	
	if msg == "all" or msg == "pet" then
		TukuiPet:Show(); TukuiPet.Hide = function() end; TukuiPet.unit = "player"
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"