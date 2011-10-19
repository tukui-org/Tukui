local T, C, L = unpack(select(2, ...))
if T.toc >= 40300 then return end

local function LoadSkin()
	local buttons = {
		"RaidFrameRaidBrowserButton",
		"RaidFrameRaidInfoButton",
		"RaidFrameReadyCheckButton",
	}

	for i = 1, #buttons do
		T.SkinButton(_G[buttons[i]])
	end

	local StripAllTextures = {
		"RaidGroup1",
		"RaidGroup2",
		"RaidGroup3",
		"RaidGroup4",
		"RaidGroup5",
		"RaidGroup6",
		"RaidGroup7",
		"RaidGroup8",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local function raidskinupdate()
		nummembers = GetNumRaidMembers();

		for i=1,nummembers do
			T.SkinButton(_G["RaidGroupButton"..i])
		end
	end
	raidskinupdate()
	RaidFrame:HookScript("OnShow", raidskinupdate)
	hooksecurefunc("RaidGroupFrame_OnEvent", raidskinupdate)

	for i=1,8 do
		for j=1,5 do
			_G["RaidGroup"..i.."Slot"..j]:StripTextures()
			_G["RaidGroup"..i.."Slot"..j]:SetTemplate("Default")
		end
	end
end

T.SkinFuncs["Blizzard_RaidUI"] = LoadSkin