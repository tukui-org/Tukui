local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local Popups = T["Popups"]
local Miscellaneous = T.Miscellaneous

local OnMouseDown = function()
	local MicroMenu = Miscellaneous.MicroMenu
	
	if MicroMenu:IsShown() then
		MicroMenu:Hide()
		
		UpdateMicroButtonsParent(T.Hider)
		
		for i = 1, #MICRO_BUTTONS do
			local Button = _G[MICRO_BUTTONS[i]]
			
			if Button.Backdrop then
				Button.Backdrop:Hide()
			end
		end
	else
		MicroMenu:Show()
		
		for i = 1, #MICRO_BUTTONS do
			local Button = _G[MICRO_BUTTONS[i]]
			
			if Button.Backdrop then
				Button.Backdrop:Show()
			end
		end
		
		UpdateMicroButtonsParent(T.PetHider)
	end
end

local Enable = function(self)
	self:SetScript("OnMouseDown", OnMouseDown)
	self.Text:SetFormattedText("%s", DataText.NameColor .. "Micro Menu|r")
end

local Disable = function(self)
	self:SetScript("OnMouseDown", nil)
end

DataText:Register("MicroMenu", Enable, Disable, Update)
