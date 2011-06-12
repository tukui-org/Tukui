local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	T.SkinCloseButton(WatchFrameCollapseExpandButton)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)