--------------------------------------------------
-- How to Import Engine
--------------------------------------------------

-- Add the line below at the top of every created .lua file:	
-- local T, C, L, M = unpack(Tukui)

----------------------------------------------------------------
-- Initiation of Tukui engine
----------------------------------------------------------------

local addon, engine = ...
engine[1] = {} -- T, functions, constants, variables
engine[2] = {} -- C, config
engine[3] = {} -- L, localization
engine[4] = {} -- G, globals (Optionnal)

Tukui = engine -- Allow other addons to use Engine

--------------------------------------------------
-- We need this as soon we begin loading Tukui
--------------------------------------------------

local T, C, L, G = unpack(select(2, ...))

-- functions, constants, variables
T.dummy = function() return end
T.myname = select(1, UnitName("player"))
T.myclass = select(2, UnitClass("player"))
T.myrace = select(2, UnitRace("player"))
T.myfaction = UnitFactionGroup("player")
T.client = GetLocale() 
T.resolution = GetCVar("gxResolution")
T.screenheight = tonumber(string.match(T.resolution, "%d+x(%d+)"))
T.screenwidth = tonumber(string.match(T.resolution, "(%d+)x+%d"))
T.version = GetAddOnMetadata("Tukui", "Version")
T.versionnumber = tonumber(T.version)
T.incombat = UnitAffectingCombat("player")
T.patch, T.buildtext, T.releasedate, T.toc = GetBuildInfo()
T.build = tonumber(T.buildtext)
T.level = UnitLevel("player")
T.myrealm = GetRealmName()
T.InfoLeftRightWidth = 370

-- Modules
G.ActionBars = {}
G.Bags = {}
G.Auras = {}
G.Chat = {}
G.DataText = {}
G.Loot = {}
G.Maps = {}
G.Misc = {}
G.NamePlates = {}
G.Panels = {}
G.Skins = {}
G.Tooltips = {}
G.UnitFrames = {}
G.Install = {}

-- Hider
local UIHider = CreateFrame("Frame", "TukuiUIHider", UIParent)
UIHider:Hide()
G.Misc.UIHider = UIHider

-- Hider Secure (mostly used to hide stuff while in pet battle)
local PetBattleHider = CreateFrame("Frame", "TukuiPetBattleHider", UIParent, "SecureHandlerStateTemplate");
PetBattleHider:SetAllPoints(UIParent)
RegisterStateDriver(PetBattleHider, "visibility", "[petbattle] hide; show")

-- Credits is important! (please do not edit this, thank you!)
T.Credits = {
	"Azilroka",
	"Caith",
	"Ishtara",
	"Hungtar",
	"Tulla",
	"P3lim",
	"Alza",
	"Roth",
	"Tekkub",
	"Shestak",
	"Caellian",
	"Haleth",
	"Nightcracker",
	"Haste",
	"Hydra",
	"Elv",
}