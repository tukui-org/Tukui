local T, C, L = select(2, ...):unpack()

local UnitFrames = T["UnitFrames"]

UnitFrames.DebuffsTracking = {}

------------------------------------------------------------------------------------
-- Locales functions and tables
------------------------------------------------------------------------------------

local function Defaults(priorityOverride)
	return {["enable"] = true, ["priority"] = priorityOverride or 0, ["stackThreshold"] = 0}
end

------------------------------------------------------------------------------------
-- RAID DEBUFFS (TRACKING LIST)
------------------------------------------------------------------------------------

UnitFrames.DebuffsTracking["RaidDebuffs"] = {
	["type"] = "Whitelist",
	["spells"] = {
		[23402] = Defaults(), -- Corrupted Healing Nefarian
	},
}

------------------------------------------------------------------------------------
-- CC DEBUFFS (TRACKING LIST)
------------------------------------------------------------------------------------

UnitFrames.DebuffsTracking["CCDebuffs"] = {
	-- BROKEN: Need to build a new classic cc debuffs list
	-- EXAMPLE: See comment in spells table

	["type"] = "Whitelist",
	["spells"] = {
		-- [107079] = Defaults(4), -- Quaking Palm
	},
}
