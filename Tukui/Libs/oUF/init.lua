local parent, ns = ...
ns.oUF = {}
ns.oUF.Private = {}

local Interface = select(4, GetBuildInfo())

ns.oUF.Interface = Interface
ns.oUF.isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
ns.oUF.isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
ns.oUF.isBCC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) or (Interface >= 20000 and Interface < 30000)
ns.oUF.isWotLK = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) or (Interface >= 30000 and Interface < 40000)
ns.oUF.isDF = (Interface >= 100000 and Interface < 110000)
