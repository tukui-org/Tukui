local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

--[[ 	
		original code by alza, edited by tukz for tukui
--]]

local menuFrame = CreateFrame("Frame", "TukuiMarkingFrame", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = L.symbol_CLEAR,
    func = function() SetRaidTarget("target", 0) end},
    {text = L.symbol_SKULL,
    func = function() SetRaidTarget("target", 8) end},
    {text = "|cffff0000"..L.symbol_CROSS.."|r",
    func = function() SetRaidTarget("target", 7) end},
    {text = "|cff00ffff"..L.symbol_SQUARE.."|r",
    func = function() SetRaidTarget("target", 6) end},
    {text = "|cffC7C7C7"..L.symbol_MOON.."|r",
    func = function() SetRaidTarget("target", 5) end},
    {text = "|cff00ff00"..L.symbol_TRIANGLE.."|r",
    func = function() SetRaidTarget("target", 4) end},
    {text = "|cff912CEE"..L.symbol_DIAMOND.."|r",
    func = function() SetRaidTarget("target", 3) end},
    {text = "|cffFF8000"..L.symbol_CIRCLE.."|r",
    func = function() SetRaidTarget("target", 2) end},
    {text = "|cffffff00"..L.symbol_STAR.."|r",
    func = function() SetRaidTarget("target", 1) end},
}

WorldFrame:HookScript("OnMouseDown", function(self, button)
    if(button=="LeftButton" and IsShiftKeyDown() and IsControlKeyDown() and UnitExists("mouseover")) then 
        local inParty = (GetNumPartyMembers() > 0)
        local inRaid = (GetNumRaidMembers() > 0)
        if(inRaid and (IsRaidLeader() or IsRaidOfficer()) or (inParty and not inRaid)) then
            EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 1)
        end
    end
end)
