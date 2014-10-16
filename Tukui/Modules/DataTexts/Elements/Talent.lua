local T, C, L = select(2, ...):unpack()

local DataText = T["DataTexts"]
local format = format

local Update = function(self)
	if (not GetSpecialization()) then
		self.Text:SetText(L.DataText.NoTalent) 
	else
		local Tree = GetSpecialization()
		local Spec = select(2, GetSpecializationInfo(Tree)) or ""
		
		self.Text:SetText(DataText.NameColor.."S:|r "..DataText.ValueColor..Spec.."|r")
	end
end

local OnMouseDown = function()
	local Group = GetActiveSpecGroup(false, false)
	
	SetActiveSpecGroup(Group == 1 and 2 or 1)
end

local Enable = function(self)
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:RegisterEvent("CONFIRM_TALENT_WIPE")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnMouseDown", OnMouseDown)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText("")
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)
	self:SetScript("OnMouseDown", nil)
end

DataText:Register(L.DataText.Talents, Enable, Disable, Update)