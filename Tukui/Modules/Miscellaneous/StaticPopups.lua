local T, C, L = select(2, ...):unpack()

local Miscellaneous = T["Miscellaneous"]
local StaticPopups = CreateFrame("Frame")

StaticPopups.Popups = {
	StaticPopup1,
	StaticPopup2,
	StaticPopup3,
	StaticPopup4,
}

function StaticPopups:Skin()
	local Name = self:GetName()
	
	if T.Retail then
		_G[Name].Border:SetAlpha(0)
	end

	_G[Name]:StripTextures()
	_G[Name]:CreateBackdrop("Transparent")
	_G[Name]:CreateShadow()
	_G[Name.."Button1"]:SkinButton()
	_G[Name.."Button2"]:SkinButton()
	_G[Name.."Button3"]:SkinButton()
	_G[Name.."Button4"]:SkinButton()
	_G[Name.."EditBox"]:SkinEditBox()
	_G[Name.."EditBox"].Backdrop:ClearAllPoints()
	_G[Name.."EditBox"].Backdrop:SetPoint("TOPLEFT", _G[Name.."EditBox"], -4, -5)
	_G[Name.."EditBox"].Backdrop:SetPoint("BOTTOMRIGHT", _G[Name.."EditBox"], 4, 6)
	_G[Name.."MoneyInputFrameGold"]:SkinEditBox()
	_G[Name.."MoneyInputFrameSilver"]:SkinEditBox()
	_G[Name.."MoneyInputFrameCopper"]:SkinEditBox()
	_G[Name.."MoneyInputFrameGold"].Backdrop:SetBackdropBorderColor(0, 0, 0, 0)
	_G[Name.."MoneyInputFrameSilver"].Backdrop:SetBackdropBorderColor(0, 0, 0, 0)
	_G[Name.."MoneyInputFrameCopper"].Backdrop:SetBackdropBorderColor(0, 0, 0, 0)
	_G[Name.."EditBox"].Backdrop:SetPoint("TOPLEFT", -2, -4)
	_G[Name.."EditBox"].Backdrop:SetPoint("BOTTOMRIGHT", 2, 4)
	_G[Name.."ItemFrameNameFrame"]:Kill()
	_G[Name.."ItemFrame"]:GetNormalTexture():Kill()
	_G[Name.."ItemFrame"]:CreateBackdrop("Default")
	_G[Name.."ItemFrame"]:StyleButton()
	_G[Name.."ItemFrameIconTexture"]:SetTexCoord(.08, .92, .08, .92)
	_G[Name.."ItemFrameIconTexture"]:ClearAllPoints()
	_G[Name.."ItemFrameIconTexture"]:SetPoint("TOPLEFT", 2, -2)
	_G[Name.."ItemFrameIconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)
	_G[Name.."CloseButton"]:SkinCloseButton()
	_G[Name.."CloseButton"].SetNormalTexture = function() end
	_G[Name.."CloseButton"].SetPushedTexture = function() end
end

function StaticPopups:Enable()
	if not AddOnSkins then
		for _, Frame in pairs(StaticPopups.Popups) do
			self.Skin(Frame)
		end
	end
end

Miscellaneous.StaticPopups = StaticPopups
