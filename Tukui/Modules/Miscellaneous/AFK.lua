local T, C, L = select(2, ...):unpack()
local AFK = CreateFrame("Frame")
local Miscellaneous = T["Miscellaneous"]

-- Lib Globals
local select = select
local unpack = unpack
local floor = math.floor
local format = format

-- Locals
AFK.Minutes = 0
AFK.Seconds = 0

function AFK:UpdateTime(Value)
	local Minutes = AFK.Minutes
	local Seconds = AFK.Seconds

	if (Value >= 60) then
		Minutes = floor(Value/60)
		Seconds = Value - Minutes*60
	else
		Minutes = 0
		Seconds = Value
	end

	self.Time:SetText("|cffffffff" .. format("%.2d", Minutes) .. ":" .. format("%.2d", Seconds) .. "|r")

	AFK.Minutes = Minutes
	AFK.Seconds = Seconds
end

function AFK:OnUpdate(Elapsed)
	self.Update = (self.Update or 0) + Elapsed

	if (self.Update > 1.0) then
		self.Total = (self.Total or 0) + 1

		self.LocalDate:SetFormattedText("%s", date( "%A |cffffffff%B %d|r"))

		if C.DataTexts.Hour24 then
			self.LocalTime:SetFormattedText("%s", date( "|cffffffff%H:%M:%S|r"))
		else
			self.LocalTime:SetFormattedText("%s", date( "|cffffffff%I:%M:%S|r %p"))
		end

		AFK:UpdateTime(self.Total)

		self.Update = 0
	end
end

function AFK:SetAFK(status)
	if (status) then
		ShowUIPanel(WorldMapFrame) -- Avoid Lua errors on M keypress

		UIParent:Hide()
		UIFrameFadeIn(self.Frame, 1, self.Frame:GetAlpha(), 1)

		self:SetScript("OnUpdate", self.OnUpdate)

		self.IsAFK = true
	elseif (self.IsAFK) then
		self.Total = 0

		HideUIPanel(WorldMapFrame) -- Avoid Lua errors on M keypress

		UIFrameFadeOut(self.Frame, 0.5, self.Frame:GetAlpha(), 0)
		UIParent:Show()

		self:SetScript("OnUpdate", nil)

		self.IsAFK = false
	end
end

function AFK:OnEvent(event, ...)
	if (event == "PLAYER_REGEN_DISABLED" or event == "LFG_PROPOSAL_SHOW" or event == "UPDATE_BATTLEFIELD_STATUS") then
		if (event == "UPDATE_BATTLEFIELD_STATUS") then
			local status = GetBattlefieldStatus(...)
			if (status == "confirm") then
				self:SetAFK(false)
			end
		else
			self:SetAFK(false)
		end

		if (event == "PLAYER_REGEN_DISABLED") then
			self:RegisterEvent("PLAYER_REGEN_ENABLED", AFK.OnEvent)
		end

		return
	end
	
	if (event == "ZONE_CHANGED") then
		self:SetAFK(false)
		
		return
	end

	if (event == "PLAYER_REGEN_ENABLED") then
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	end

	if InCombatLockdown() or CinematicFrame:IsShown() or MovieFrame:IsShown() then return end

	if (UnitIsAFK("player")) then
		self:SetAFK(true)
	else
		self:SetAFK(false)
	end
end

function AFK:Create()
	local Font = C.Medias.Font

	local Frame = CreateFrame("Frame", nil)
	Frame:SetFrameLevel(5)
	Frame:SetScale(UIParent:GetScale())
	Frame:SetAllPoints(UIParent)
	Frame:SetAlpha(0)

	local TopPanel = CreateFrame("Frame", nil, Frame)
	TopPanel:SetFrameLevel(Frame:GetFrameLevel() - 1)
	TopPanel:SetSize(UIParent:GetWidth()+8, 42)
	TopPanel:SetPoint("TOP", Frame, 0, 2)
	TopPanel:CreateBackdrop()
	TopPanel:CreateShadow()

	local BottomPanel = CreateFrame("Frame", nil, Frame)
	BottomPanel:SetFrameLevel(Frame:GetFrameLevel() - 1)
	BottomPanel:SetSize(UIParent:GetWidth()+12, 84)
	BottomPanel:SetPoint("BOTTOM", Frame, 0, -4)
	BottomPanel:CreateBackdrop()
	BottomPanel:CreateShadow()

	local Class = select(2, UnitClass("player"))
	local CustomClassColor = T.Colors.class[Class]

	local LocalTime = Frame:CreateFontString(nil, "OVERLAY")
	LocalTime:SetPoint("RIGHT", TopPanel, -28, -2)
	LocalTime:SetFontTemplate(Font, 14, 3, 3)
	LocalTime:SetTextColor(unpack(CustomClassColor))

	local LocalDate = Frame:CreateFontString(nil, "OVERLAY")
	LocalDate:SetPoint("LEFT", TopPanel, 28, -2)
	LocalDate:SetFontTemplate(Font, 14, 3, 3)
	LocalDate:SetTextColor(unpack(CustomClassColor))

	local Time = Frame:CreateFontString(nil, "OVERLAY")
	Time:SetPoint("CENTER", TopPanel, 0, -2)
	Time:SetFontTemplate(Font, 16, 3, 3)
	Time:SetTextColor(unpack(CustomClassColor))

	local Name = Frame:CreateTexture(nil, "OVERLAY")
	Name:SetSize(128, 128)
	Name:SetTexture(C.Medias.Logo)
	Name:SetPoint("CENTER", BottomPanel, 0, 60)

	local Version = Frame:CreateFontString(nil, "OVERLAY")
	Version:SetPoint("CENTER", BottomPanel, 0, -18)
	Version:SetFontTemplate(Font, 24, 3, 3)
	Version:SetText("Version " .. T.Version)

	self:RegisterEvent("PLAYER_FLAGS_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("ZONE_CHANGED")
	self:SetScript("OnEvent", self.OnEvent)

	UIParent:HookScript("OnShow", function(self) if UnitIsAFK("player") then SendChatMessage("", "AFK") AFK:SetAFK(false) end end)

	self.Frame = Frame
	self.PanelTop = TopPanel
	self.BottomPanel = BottomPanel
	self.LocalTime = LocalTime
	self.LocalDate = LocalDate
	self.Time = Time
	self.Name = Name
	self.Version = Version
end

function AFK:Enable()
	if not C.Misc.AFKSaver then
		return
	end

	if not (self.IsCreated) then
		self:Create()
		self.IsCreated = true
	end
end

Miscellaneous.AFK = AFK
