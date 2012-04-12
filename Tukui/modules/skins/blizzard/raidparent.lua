local T, C, L = unpack(select(2, ...))
if T.toc < 40300 then return end

local function LoadSkin()
	local StripAllTextures = {
		"RaidParentFrame",
		"RaidParentFrameInset",
		"RaidFinderFrameRoleInset",
		"RaidFinderQueueFrameScrollFrame",
		"RaidFinderQueueFrame",
		"RaidFinderQueueFrameIneligibleFrame",
	}

	local buttons = {
		"RaidFinderFrameFindRaidButton",
		"RaidFinderFrameCancelButton",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for i = 1, #buttons do
		_G[buttons[i]]:StripTextures()
		T.SkinButton(_G[buttons[i]])
	end
	
	RaidParentFrame:SetTemplate("Default")
	T.SkinCloseButton(RaidParentFrameCloseButton)
	T.SkinDropDownBox(RaidFinderQueueFrameSelectionDropDown)
	RaidFinderQueueFrameSelectionDropDown:ClearAllPoints()
	RaidFinderQueueFrameSelectionDropDown:SetPoint("TOPRIGHT", -4, -112)
	RaidFinderQueueFrameIneligibleFrame:SetTemplate("Default")
	RaidFinderQueueFrameIneligibleFrame:SetBackdropBorderColor(unpack(C.media.backdropcolor))
	
	for i=1, 3 do
		local tab = _G["RaidParentFrameTab"..i]
		if tab then
			T.SkinTab(tab)	
		end
	end
	
	local checkButtons = {
		"RaidFinderQueueFrameRoleButtonTank",
		"RaidFinderQueueFrameRoleButtonHealer",
		"RaidFinderQueueFrameRoleButtonDPS",
		"RaidFinderQueueFrameRoleButtonLeader",
	}

	for _, object in pairs(checkButtons) do
		_G[object].checkButton:SetFrameLevel(_G[object].checkButton:GetFrameLevel() + 2)
		T.SkinCheckBox(_G[object].checkButton)
	end
end

local function LoadRaidSkin()
	local groups = {
		"RaidGroup1",
		"RaidGroup2",
		"RaidGroup3",
		"RaidGroup4",
		"RaidGroup5",
		"RaidGroup6",
		"RaidGroup7",
		"RaidGroup8",
	}

	T.SkinButton(RaidFrameReadyCheckButton)
	for _, object in pairs(groups) do
		_G[object]:StripTextures()
	end
	
	for i=1,8 do
		for j=1,5 do
			_G["RaidGroup"..i.."Slot"..j]:StripTextures()
		end
	end
	
	for i=1,40 do
		_G["RaidGroupButton"..i]:StripTextures()
		_G["RaidGroupButton"..i]:SetTemplate("Default")
		_G["RaidGroupButton"..i]:SetBackdropBorderColor(0, 0, 0, 0)
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)
T.SkinFuncs["Blizzard_RaidUI"] = LoadRaidSkin