local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

T.dummy = function() return end
T.myname = select(1, UnitName("player"))
T.myclass = select(2, UnitClass("player"))
T.myrace = select(2, UnitRace("player"))
T.client = GetLocale() 
T.resolution = GetCVar("gxResolution")
T.getscreenheight = tonumber(string.match(T.resolution, "%d+x(%d+)"))
T.getscreenwidth = tonumber(string.match(T.resolution, "(%d+)x+%d"))
T.version = GetAddOnMetadata("Tukui", "Version")
T.versionnumber = tonumber(T.version)
T.incombat = UnitAffectingCombat("player")
T.patch, T.build, T.releasedate, T.toc = GetBuildInfo()
T.level = UnitLevel("player")
T.myrealm = GetRealmName()
T.InfoLeftRightWidth = 370