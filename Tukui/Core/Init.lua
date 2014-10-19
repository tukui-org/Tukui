----------------------------------------------------------------
-- Initiation of Tukui engine
----------------------------------------------------------------

-- [[ Build the engine ]] --
local AddOn, Engine = ...

Engine[1] = CreateFrame("Frame")
Engine[2] = {}
Engine[3] = {}
Engine[4] = {}

function Engine:unpack()
	return self[1], self[2], self[3], self[4]
end

Engine[1].Resolution = GetCVar("gxResolution")
Engine[1].ScreenHeight = tonumber(string.match(Engine[1].Resolution, "%d+x(%d+)"))
Engine[1].ScreenWidth = tonumber(string.match(Engine[1].Resolution, "(%d+)x+%d"))
Engine[1].MyClass = select(2, UnitClass("player"))
Engine[1].MyLevel = UnitLevel("player")
Engine[1].Version = GetAddOnMetadata(AddOn, "Version")
Engine[1].VersionNumber = tonumber(Engine[1].Version)
Engine[1].WoWPatch, Engine[1].WoWBuild, Engine[1].WoWPatchReleaseDate, Engine[1].TocVersion = GetBuildInfo()

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

Tukui = Engine

DisableAddOn("Tukui_ConfigUI")