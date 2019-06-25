local _, ns = ...
local oUF = ns.oUF or oUF

if not oUF then return end

local _, ns = ...
local oUF = ns.oUF or _G.oUF
assert(oUF, "oUF_Atonement cannot find an instance of oUF. If your oUF is embedded into a layout, it may not be embedded properly.")

local UnitBuff = UnitBuff

local function OnUpdate(self, elapsed)
	local CurrentTime = GetTime()
	local Timer = self.ExpirationTime - CurrentTime
	
	self:SetValue(Timer)
end

local function Update(self, event, ...)
	local Unit = self.unit
	
	if Unit and Unit ~= self.unit then
		return
	end

	local AtonementID = 194384
	local AtonementIDPvP = 214206

	for i = 1, 40 do
		local Buff, Icon, Count, DebuffType, Duration, ExpirationTime, UnitCaster, IsStealable, ShouldConsolidate, SpellID = UnitBuff(Unit, i)

		if not Buff then
			break
		end

		if (SpellID == AtonementID) or (SpellID == AtonementIDPvP) then
			self.Atonement.Duration = Duration
			self.Atonement.ExpirationTime = ExpirationTime
			self.Atonement:SetMinMaxValues(0, Duration)
			self.Atonement:SetScript("OnUpdate", OnUpdate)
			self.Atonement:Show()

			return
		end
	end

	self.Atonement:SetScript("OnUpdate", nil)
	self.Atonement:SetValue(0)
	self.Atonement:Hide()
end

local function CheckSpec(self, event)
	local DiscSpec = 1

	if (GetSpecialization() ~= DiscSpec) then
		self.Atonement:SetScript("OnUpdate", nil)
		self.Atonement:SetValue(0)
		self.Atonement:Hide()
		
		self:UnregisterEvent("UNIT_AURA", Update)
	else
		self:RegisterEvent("UNIT_AURA", Update)
	end
end

local function Enable(self)
	local Bar = self.Atonement
	
	if Bar then
		self:RegisterEvent("UNIT_AURA", Update)
		self:RegisterEvent("PLAYER_TALENT_UPDATE", CheckSpec, true)
		self:RegisterEvent("PLAYER_ENTERING_WORLD", CheckSpec, true)
		
		Bar:SetMinMaxValues(0, 15)
		Bar:SetValue(0)
		Bar:SetStatusBarColor(207/255, 181/255, 59/255)
		
		if not Bar.Backdrop then
			Bar.Backdrop = self.Atonement:CreateTexture(nil, "BACKGROUND")
			Bar.Backdrop:SetAllPoints()
			Bar.Backdrop:SetColorTexture(207/255 * 0.2, 181/255 * 0.2, 59/255 * 0.2)
		end

		return true
	else
		return false
	end
end

local function Disable(self)
	local Bar = self.Atonement
	
	if Bar then
		self:UnregisterEvent("UNIT_AURA", Update)
		self:UnregisterEvent("PLAYER_TALENT_UPDATE", CheckSpec)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD", CheckSpec)
	end
end

oUF:AddElement("Atonement", Update, Enable, Disable)
