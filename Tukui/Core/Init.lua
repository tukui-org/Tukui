----------------------------------------------------------------
-- Initiation of Tukui engine
----------------------------------------------------------------

-- [[ Build the engine ]] --
local AddOn, Engine = ...
local Resolution = select(1, GetPhysicalScreenSize()).."x"..select(2, GetPhysicalScreenSize())
local Windowed = Display_DisplayModeDropDown:windowedmode()
local Fullscreen = Display_DisplayModeDropDown:fullscreenmode()
local Toc = select(4, GetBuildInfo())

Engine[1] = CreateFrame("Frame")
Engine[2] = {}
Engine[3] = {}
Engine[4] = {}

function Engine:unpack()
	return self[1], self[2], self[3], self[4]
end

Engine[1].Retail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
Engine[1].BCC = Toc >= 20000 and Toc < 30000
Engine[1].Classic = Toc >= 10000 and Toc < 20000
Engine[1].WotLK = Toc >= 30000 and Toc < 40000
Engine[1].WindowedMode = Windowed
Engine[1].FullscreenMode = Fullscreen
Engine[1].Resolution = Resolution or (Windowed and GetCVar("gxWindowedResolution")) or GetCVar("gxFullscreenResolution")
Engine[1].ScreenHeight = select(2, GetPhysicalScreenSize())
Engine[1].ScreenWidth = select(1, GetPhysicalScreenSize())
Engine[1].PerfectScale = min(1, max(0.3, 768 / string.match(Resolution, "%d+x(%d+)")))
Engine[1].MyName = UnitName("player")
Engine[1].MyClass = select(2, UnitClass("player"))
Engine[1].MyLevel = UnitLevel("player")
Engine[1].MyFaction = select(2, UnitFactionGroup("player"))
Engine[1].MyRace = select(2, UnitRace("player"))
Engine[1].MyRealm = GetRealmName()
Engine[1].Version = GetAddOnMetadata(AddOn, "Version")
Engine[1].VersionNumber = tonumber(Engine[1].Version)
Engine[1].WoWPatch, Engine[1].WoWBuild, Engine[1].WoWPatchReleaseDate, Engine[1].TocVersion = GetBuildInfo()
Engine[1].WoWBuild = tonumber(Engine[1].WoWBuild)
Engine[1].Hider = CreateFrame("Frame", nil, UIParent)
Engine[1].PetHider = CreateFrame("Frame", "TukuiPetHider", UIParent, "SecureHandlerStateTemplate")

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

Tukui = Engine
