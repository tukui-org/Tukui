local T, C, L = unpack(select(2, ...))

local function LoadSkin()
	GuildRegistrarFrame:StripTextures(true)
	GuildRegistrarFrame:SetTemplate("Default")
	GuildRegistrarGreetingFrame:StripTextures()
	T.SkinButton(GuildRegistrarFrameGoodbyeButton)
	T.SkinButton(GuildRegistrarFrameCancelButton)
	T.SkinButton(GuildRegistrarFramePurchaseButton)
	T.SkinCloseButton(GuildRegistrarFrameCloseButton)
	T.SkinEditBox(GuildRegistrarFrameEditBox)
	for i=1, GuildRegistrarFrameEditBox:GetNumRegions() do
		local region = select(i, GuildRegistrarFrameEditBox:GetRegions())
		if region:GetObjectType() == "Texture" then
			if region:GetTexture() == "Interface\\ChatFrame\\UI-ChatInputBorder-Left" or region:GetTexture() == "Interface\\ChatFrame\\UI-ChatInputBorder-Right" then
				region:Kill()
			end
		end
	end

	GuildRegistrarFrameEditBox:Height(20)

	for i=1, 2 do
		_G["GuildRegistrarButton"..i]:GetFontString():SetTextColor(1, 1, 1)
	end

	GuildRegistrarPurchaseText:SetTextColor(1, 1, 1)
	AvailableServicesText:SetTextColor(1, 1, 0)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)