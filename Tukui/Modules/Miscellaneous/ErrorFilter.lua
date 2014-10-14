local T, C, L = select(2, ...):unpack()

local TukuiError = CreateFrame("Frame")
local Miscellaneous = T["Miscellaneous"]

-- Set messages to allow
TukuiError.Filter = {
	[INVENTORY_FULL] = true,
}

function TukuiError:OnEvent(event, msg)
	if self.Filter[msg] then
		UIErrorsFrame:AddMessage(msg, 1, 0, 0)
	end	
end

function TukuiError:Enable()
	UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	TukuiError:RegisterEvent("UI_ERROR_MESSAGE")
	TukuiError:SetScript("OnEvent", TukuiError.OnEvent)
end

Miscellaneous.ErrorFilter = TukuiError