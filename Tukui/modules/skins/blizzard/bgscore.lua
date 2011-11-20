local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	WorldStateScoreScrollFrame:StripTextures()
	T.SkinScrollBar(WorldStateScoreScrollFrameScrollBar)
	WorldStateScoreFrame:StripTextures()
	WorldStateScoreFrame:SetTemplate("Default")
	T.SkinCloseButton(WorldStateScoreFrameCloseButton)
	WorldStateScoreFrameInset:Kill()
	T.SkinButton(WorldStateScoreFrameLeaveButton)

	for i = 1, WorldStateScoreScrollFrameScrollChildFrame:GetNumChildren() do
		local b = _G["WorldStateScoreButton"..i]
		b:StripTextures()
		b:StyleButton(false)
		b:SetTemplate("Default", true)
	end

	for i = 1, 3 do 
		T.SkinTab(_G["WorldStateScoreFrameTab"..i])
	end
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)