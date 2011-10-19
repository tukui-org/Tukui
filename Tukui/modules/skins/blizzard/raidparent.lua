local T, C, L = unpack(select(2, ...))
if T.toc < 40300 then return end

local function LoadSkin()
	local StripAllTextures = {
		"RaidParentFrame",
		"RaidParentFrameInset",
		"RaidFinderFrameRoleInset",
		"RaidFinderQueueFrameScrollFrame",
		"RaidFinderQueueFrame",
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
	
	for i=1, 2 do
		local tab = _G["RaidParentFrameTab"..i]
		if tab then
			T.SkinTab(tab)	
		end
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)