local T, C, L = select(2, ...):unpack()

local TukuiError = CreateFrame("Frame")
local Miscellaneous = T["Miscellaneous"]

-- Set messages to blacklist
TukuiError.Filter = {
	[ERR_NO_ATTACK_TARGET] = true,
	[OUT_OF_ENERGY] = true,
	[ERR_ABILITY_COOLDOWN] = true,
	[SPELL_FAILED_NO_COMBO_POINTS] = true,
	[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
	[ERR_SPELL_COOLDOWN] = true,
	[SPELL_FAILED_BAD_TARGETS] = true,
}

function TukuiError:OnEvent(event, id, msg)
	if not self.Filter[msg] then
		UIErrorsFrame:AddMessage(msg, 1, 0, 0)
	end
end

function TukuiError:Enable()
	UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	TukuiError:RegisterEvent("UI_ERROR_MESSAGE")
	TukuiError:SetScript("OnEvent", TukuiError.OnEvent)
end

Miscellaneous.ErrorFilter = TukuiError
