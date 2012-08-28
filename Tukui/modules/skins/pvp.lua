local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	--Freaking gay Cancel Button created 2 times in a row in blizz code. Can't access the first one with global.
	for i=1, PVPBannerFrame:GetNumChildren() do
		local child = select(i, PVPBannerFrame:GetChildren())
		if child:GetObjectType() == "Button" then
			local name = child:GetName()
			if name ~= "PVPBannerFrameCloseButton" then child:SkinButton() end
		end
	end

	local buttons = {
		"PVPFrameLeftButton",
		"PVPFrameRightButton",
		"PVPColorPickerButton1",
		"PVPColorPickerButton2",
		"PVPColorPickerButton3",
		"PVPBannerFrameAcceptButton",
	}

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		_G[buttons[i]]:SkinButton()
	end

	local KillTextures = {
		"PVPHonorFrameBGTex",
		"PVPHonorFrameInfoScrollFrameScrollBar",
		"PVPConquestFrameInfoButtonInfoBG",
		"PVPConquestFrameInfoButtonInfoBGOff",
		"PVPTeamManagementFrameFlag2GlowBG",
		"PVPTeamManagementFrameFlag3GlowBG",
		"PVPTeamManagementFrameFlag5GlowBG",
		"PVPTeamManagementFrameFlag2HeaderSelected",
		"PVPTeamManagementFrameFlag3HeaderSelected",
		"PVPTeamManagementFrameFlag5HeaderSelected",
		"PVPTeamManagementFrameFlag2Header",
		"PVPTeamManagementFrameFlag3Header",
		"PVPTeamManagementFrameFlag5Header",
		"PVPTeamManagementFrameWeeklyDisplayLeft",
		"PVPTeamManagementFrameWeeklyDisplayRight",
		"PVPTeamManagementFrameWeeklyDisplayMiddle",
		"PVPBannerFramePortrait",
		"PVPBannerFramePortraitFrame",
		"PVPBannerFrameInset",
		"PVPBannerFrameEditBoxLeft",
		"PVPBannerFrameEditBoxRight",
		"PVPBannerFrameEditBoxMiddle",
		"PVPBannerFrameCancelButton_LeftSeparator",
	}

	for _, texture in pairs(KillTextures) do
		_G[texture]:Kill()
	end

	local StripAllTextures = {
		"PVPFrame",
		"PVPFrameInset",
		"PVPHonorFrame",
		"PVPConquestFrame",
		"PVPTeamManagementFrame",
		"PVPHonorFrameTypeScrollFrame",
		"PVPFrameTopInset",
		"PVPTeamManagementFrameInvalidTeamFrame",
		"PVPBannerFrame",
		"PVPBannerFrameCustomization1",
		"PVPBannerFrameCustomization2",
		"PVPBannerFrameCustomizationFrame",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	local function ArenaHeader(self, first, i)
		local button = _G["PVPTeamManagementFrameHeader"..i]

		if first then
			button:StripTextures()
		end
	end

	for i=1, 4 do
		ArenaHeader(nil, true, i)
	end	

	PVPBannerFrameEditBox:CreateBackdrop("Default")
	PVPBannerFrameEditBox.backdrop:Point( "TOPLEFT", PVPBannerFrameEditBox, "TOPLEFT" ,-5,-5)
	PVPBannerFrameEditBox.backdrop:Point( "BOTTOMRIGHT", PVPBannerFrameEditBox, "BOTTOMRIGHT",5,5)
	PVPHonorFrameInfoScrollFrameChildFrameDescription:SetTextColor(1,1,1)
	PVPHonorFrameInfoScrollFrameChildFrameRewardsInfo.description:SetTextColor(1,1,1)
	PVPTeamManagementFrameInvalidTeamFrame:CreateBackdrop("Default")
	PVPTeamManagementFrameInvalidTeamFrame:SetFrameLevel(PVPTeamManagementFrameInvalidTeamFrame:GetFrameLevel()+1)
	PVPTeamManagementFrameInvalidTeamFrame.backdrop:Point( "TOPLEFT", PVPTeamManagementFrameInvalidTeamFrame, "TOPLEFT")
	PVPTeamManagementFrameInvalidTeamFrame.backdrop:Point( "BOTTOMRIGHT", PVPTeamManagementFrameInvalidTeamFrame, "BOTTOMRIGHT")
	PVPTeamManagementFrameInvalidTeamFrame.backdrop:SetFrameLevel(PVPTeamManagementFrameInvalidTeamFrame:GetFrameLevel())

	PVPFrameConquestBar:StripTextures()
	PVPFrameConquestBar.progress:SetTexture(C["media"].normTex)
	PVPFrameConquestBar:CreateBackdrop("Default")
	PVPFrameConquestBar.backdrop:Point("TOPLEFT", PVPFrameConquestBar, "TOPLEFT", -2, -1)
	PVPFrameConquestBar.backdrop:Point("BOTTOMRIGHT", PVPFrameConquestBar, "BOTTOMRIGHT", 2, 1)

	PVPBannerFrame:CreateBackdrop("Default")
	PVPBannerFrame.backdrop:Point( "TOPLEFT", PVPBannerFrame, "TOPLEFT")
	PVPBannerFrame.backdrop:Point( "BOTTOMRIGHT", PVPBannerFrame, "BOTTOMRIGHT")
	PVPBannerFrameCustomization1:CreateBackdrop("Default")
	PVPBannerFrameCustomization1.backdrop:Point( "TOPLEFT", PVPBannerFrameCustomization1LeftButton, "TOPRIGHT" ,2,0)
	PVPBannerFrameCustomization1.backdrop:Point( "BOTTOMRIGHT", PVPBannerFrameCustomization1RightButton, "BOTTOMLEFT",-2,0)
	PVPBannerFrameCustomization2:CreateBackdrop("Default")
	PVPBannerFrameCustomization2.backdrop:Point( "TOPLEFT", PVPBannerFrameCustomization2LeftButton, "TOPRIGHT",2,0)
	PVPBannerFrameCustomization2.backdrop:Point( "BOTTOMRIGHT", PVPBannerFrameCustomization2RightButton, "BOTTOMLEFT",-2,0)
	PVPBannerFrameCloseButton:SkinCloseButton(PVPBannerFrame)
	PVPBannerFrameCustomization1LeftButton:SkinNextPrevButton()
	PVPBannerFrameCustomization1LeftButton:Height(PVPBannerFrameCustomization1:GetHeight())
	PVPBannerFrameCustomization1RightButton:SkinNextPrevButton()
	PVPBannerFrameCustomization1RightButton:Height(PVPBannerFrameCustomization1:GetHeight())
	PVPBannerFrameCustomization2LeftButton:SkinNextPrevButton()
	PVPBannerFrameCustomization2LeftButton:Height(PVPBannerFrameCustomization1:GetHeight())
	PVPBannerFrameCustomization2RightButton:SkinNextPrevButton()
	PVPBannerFrameCustomization2RightButton:Height(PVPBannerFrameCustomization1:GetHeight())
	PVPFrame:CreateBackdrop("Default")
	PVPFrame.backdrop:Point( "TOPLEFT", PVPFrame, "TOPLEFT")
	PVPFrame.backdrop:Point( "BOTTOMRIGHT", PVPFrame, "BOTTOMRIGHT")
	PVPFrameCloseButton:SkinCloseButton(PVPFrame)
	PVPTeamManagementFrameWeeklyToggleLeft:SkinNextPrevButton()
	PVPTeamManagementFrameWeeklyToggleRight:SkinNextPrevButton()
	PVPColorPickerButton1:Height(PVPColorPickerButton1:GetHeight()-5)
	PVPColorPickerButton2:Height(PVPColorPickerButton1:GetHeight())
	PVPColorPickerButton3:Height(PVPColorPickerButton1:GetHeight())
	PVPHonorFrameTypeScrollFrameScrollBar:SkinScrollBar()

	--War Games
	WarGamesFrame:StripTextures()
	WarGamesFrameScrollFrameScrollBar:SkinScrollBar()
	
	WarGameStartButton:ClearAllPoints()
	WarGameStartButton:Point("LEFT", PVPFrameLeftButton, "RIGHT", 2, 0)
	WarGamesFrameDescription:SetTextColor(1, 1, 1)

	--Bottom Tabs
	for i=1,4 do
		_G["PVPFrameTab"..i]:SkinTab()
	end
	
	WarGameStartButton:StripTextures()
	WarGameStartButton:SkinButton()
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)