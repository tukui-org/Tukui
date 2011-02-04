local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local AchievementHolder = CreateFrame("Frame", "TukuiAchievementHolder", UIParent)
AchievementHolder:Width(180)
AchievementHolder:Height(20)
AchievementHolder:SetPoint("CENTER", UIParent, "CENTER", 0, 170)
AchievementHolder:SetTemplate("Default")
AchievementHolder:SetBackdropBorderColor(1, 0, 0)
AchievementHolder:SetClampedToScreen(true)
AchievementHolder:SetMovable(true)
AchievementHolder:SetAlpha(0)
AchievementHolder.text = T.SetFontString(AchievementHolder, C.media.uffont, 12)
AchievementHolder.text:SetPoint("CENTER")
AchievementHolder.text:SetText(L.move_achievements)

local pos = "TOP"

function T.AchievementMove(self, event, ...)
	local previousFrame
	for i=1, MAX_ACHIEVEMENT_ALERTS do
		local aFrame = _G["AchievementAlertFrame"..i]
		if ( aFrame ) then
			aFrame:ClearAllPoints()
			if pos == "TOP" then
				if ( previousFrame and previousFrame:IsShown() ) then
					aFrame:SetPoint("TOP", previousFrame, "BOTTOM", 0, -10)
				else
					aFrame:SetPoint("TOP", AchievementHolder, "BOTTOM")
				end
			else
				if ( previousFrame and previousFrame:IsShown() ) then
					aFrame:SetPoint("BOTTOM", previousFrame, "TOP", 0, 10)
				else
					aFrame:SetPoint("BOTTOM", AchievementHolder, "TOP")	
				end			
			end
			
			previousFrame = aFrame
		end		
	end
	
end
hooksecurefunc("AchievementAlertFrame_FixAnchors", T.AchievementMove)

hooksecurefunc("DungeonCompletionAlertFrame_FixAnchors", function()
	for i=MAX_ACHIEVEMENT_ALERTS, 1, -1 do
		local aFrame = _G["AchievementAlertFrame"..i]
		if ( aFrame and aFrame:IsShown() ) then
			DungeonCompletionAlertFrame1:ClearAllPoints()
			if pos == "TOP" then
				DungeonCompletionAlertFrame1:SetPoint("TOP", aFrame, "BOTTOM", 0, -10)
			else
				DungeonCompletionAlertFrame1:SetPoint("BOTTOM", aFrame, "TOP", 0, 10)
			end
			
			return
		end
		
		DungeonCompletionAlertFrame1:ClearAllPoints()	
		if pos == "TOP" then
			DungeonCompletionAlertFrame1:SetPoint("TOP", AchievementHolder, "BOTTOM")
		else
			DungeonCompletionAlertFrame1:SetPoint("BOTTOM", AchievementHolder, "TOP")
		end
	end
end)

function T.PostAchievementMove(frame)
	local point = select(1, frame:GetPoint())

	if string.find(point, "TOP") or point == "CENTER" or point == "LEFT" or point == "RIGHT" then
		pos = "TOP"
	else
		pos = "BOTTOM"
	end
	T.AchievementMove()
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ACHIEVEMENT_EARNED")
frame:SetScript("OnEvent", function(self, event, ...) T.AchievementMove(self, event, ...) end)