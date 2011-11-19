local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	local StripAllTextures = {
		"RaidInfoFrame",
		"RaidInfoInstanceLabel",
		"RaidInfoIDLabel",
	}

	local KillTextures = {
		"RaidInfoScrollFrameScrollBarBG",
		"RaidInfoScrollFrameScrollBarTop",
		"RaidInfoScrollFrameScrollBarBottom",
		"RaidInfoScrollFrameScrollBarMiddle",
	}
	local buttons = {
		"RaidFrameConvertToRaidButton",
		"RaidFrameRaidInfoButton",
		"RaidInfoExtendButton",
		"RaidInfoCancelButton",
		"RaidFrameNotInRaidRaidBrowserButton",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	for i = 1, #buttons do
		if _G[buttons[i]] then T.SkinButton(_G[buttons[i]]) end
	end
	RaidInfoScrollFrame:StripTextures()
	RaidInfoFrame:CreateBackdrop("Default")
	RaidInfoFrame.backdrop:Point( "TOPLEFT", RaidInfoFrame, "TOPLEFT")
	RaidInfoFrame.backdrop:Point( "BOTTOMRIGHT", RaidInfoFrame, "BOTTOMRIGHT")
	T.SkinCloseButton(RaidInfoCloseButton,RaidInfoFrame)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)