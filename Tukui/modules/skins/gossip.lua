local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	local StripAllTextures = {
		"GossipFrameGreetingPanel",
	}			

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local KillTextures = {
		"GossipFramePortrait",
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local buttons = {
		"GossipFrameGreetingGoodbyeButton",
	}

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end

	for i = 1, NUMGOSSIPBUTTONS do
		obj = select(3,_G["GossipTitleButton"..i]:GetRegions())
		obj:SetTextColor(1,1,1)
	end

	GossipGreetingText:SetTextColor(1,1,1)
	GossipFrame:StripTextures()
	GossipFrameInset:StripTextures()
	GossipFrame:CreateBackdrop("Default")
	GossipFrameCloseButton:SkinCloseButton(GossipFrame.backdrop)
	GossipGreetingScrollFrameScrollBar:SkinScrollBar()
	GossipGreetingScrollFrame:StripTextures()

	--Extreme hackage, blizzard makes button text on quest frame use hex color codes for some reason
	hooksecurefunc("GossipFrameUpdate", function()
		for i=1, NUMGOSSIPBUTTONS do
			local button = _G["GossipTitleButton"..i]
			
			if button:GetFontString() then
				if button:GetFontString():GetText() and button:GetFontString():GetText():find("|cff000000") then
					button:GetFontString():SetText(string.gsub(button:GetFontString():GetText(), "|cff000000", "|cffFFFF00"))
				end
			end
		end
	end)

	NPCFriendshipStatusBar:StripTextures()
	NPCFriendshipStatusBar:SetStatusBarTexture(C.media.normTex)
	NPCFriendshipStatusBar:CreateBackdrop('Default')
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)