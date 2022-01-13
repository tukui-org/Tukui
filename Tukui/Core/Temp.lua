----------------------------------
-- Temporary code in this file! --
----------------------------------

local T, C, L = select(2, ...):unpack()

local Temp = CreateFrame("Frame", nil, UIParent)

-- TEMP for bg popup taint bug
function Temp:Enable()
	if T.Retail or T.BCC or T.Classic then
		return
	end
	
	local Battleground = CreateFrame("Frame", nil, UIParent)
	Battleground:SetFrameStrata("HIGH")
	Battleground:SetSize(400, 60)
	Battleground:CreateBackdrop()
	Battleground:CreateShadow()
	Battleground:SetPoint("TOP", 0, -29)
	Battleground:Hide()
	Battleground:SetBorderColor(1.00, 0.95, 0.32)

	Battleground.Text1 = Battleground:CreateFontString(nil, "OVERLAY")
	Battleground.Text1:SetFontTemplate(C.Medias.Font, 16)
	Battleground.Text1:SetPoint("TOP", 0, -10)
	Battleground.Text1:SetTextColor(1.00, 0.95, 0.32)

	Battleground.Text2 = Battleground:CreateFontString(nil, "OVERLAY")
	Battleground.Text2:SetFontTemplate(C.Medias.Font, 16)
	Battleground.Text2:SetPoint("BOTTOM", 0, 10)
	Battleground.Text2:SetTextColor(1.00, 0.95, 0.32)
	Battleground.Text2:SetText("Right-click on minimap battleground button to enter")

	local Animation = Battleground:CreateAnimationGroup()
	Animation:SetLooping("BOUNCE")

	local FadeOut = Animation:CreateAnimation("Alpha")
	FadeOut:SetFromAlpha(1)
	FadeOut:SetToAlpha(0.8)
	FadeOut:SetDuration(0.2)
	FadeOut:SetSmoothing("IN_OUT")

	local function OnEvent()
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local Status, Map, InstanceID = GetBattlefieldStatus(i)

			if Status == "confirm" then
				local String = StaticPopup1Text:GetText()
				local Text = string.gsub(String, ",.*", "")

				StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY")

				Battleground.Text1:SetText(Text)
				Battleground:Show()

				Animation:Play()

				T.Print(Text)

				return
			end
		end

		Battleground:Hide()
		Animation:Stop()
	end

	Battleground:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
	Battleground:SetScript("OnEvent", OnEvent)
end

Temp:RegisterEvent("PLAYER_LOGIN")
Temp:SetScript("OnEvent", Temp.Enable)