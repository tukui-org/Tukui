local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if C["chat"].enable ~= true then return end

-- /tt - tell your current target.
for i=1, NUM_CHAT_WINDOWS do
	local editbox = _G["ChatFrame"..i.."EditBox"]
	editbox:HookScript("OnTextChanged", function(self)
		local text = self:GetText()
		if text:len() < 5 then
			if text:sub(1, 4) == "/tt " then
				local unitname, realm
				unitname, realm = UnitName("target")
				if unitname then unitname = gsub(unitname, " ", "") end
				if unitname and not UnitIsSameServer("player", "target") then
					unitname = unitname .. "-" .. gsub(realm, " ", "")
				end
				ChatFrame_SendTell((unitname or L.chat_invalidtarget), ChatFrame1)
			end
		end
	end)
end

-- slash command for macro's

SLASH_TELLTARGET1 = "/tt"
SLASH_TELLTARGET2 = "/telltarget"
SlashCmdList.TELLTARGET = function(msg)
	local unitname, realm
	unitname, realm = UnitName("target")
	if not unitname then return end
	if unitname then unitname = gsub(unitname, " ", "") end
	if unitname and not UnitIsSameServer("player", "target") then
		unitname = unitname .. "-" .. gsub(realm, " ", "")
	end
	SendChatMessage(msg, "WHISPER", nil, unitname)
end
