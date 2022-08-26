local parent, ns = ...
local Toc = select(4, GetBuildInfo())
ns.oUF = {}
ns.oUF.Private = {}

ns.oUF.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
ns.oUF.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
ns.oUF.isTBC = Toc >= 20500 and Toc < 30000
ns.oUF.isWotLK = Toc >= 30400 and Toc < 40000 
