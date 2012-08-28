local T, C, L, G = unpack(select(2, ...))

local function LoadSkin()
	WorldStateScoreScrollFrame:StripTextures()
	WorldStateScoreScrollFrameScrollBar:SkinScrollBar()
	WorldStateScoreFrame:StripTextures()
	WorldStateScoreFrameInset:StripTextures()
	WorldStateScoreFrame:SetTemplate("Default")
	WorldStateScoreFrameCloseButton:SkinCloseButton()
	WorldStateScoreFrameInset:Kill()
	WorldStateScoreFrameLeaveButton:SkinButton()

	for i = 1, WorldStateScoreScrollFrameScrollChildFrame:GetNumChildren() do
		local b = _G["WorldStateScoreButton"..i]
		b:StripTextures()
		b:StyleButton(false)
		b:SetTemplate("Default", true)
	end

	for i = 1, 3 do 
		_G["WorldStateScoreFrameTab"..i]:SkinTab()
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)