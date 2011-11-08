----------------------------------------------------------------------------
-- This Module loads custom settings for edited package
----------------------------------------------------------------------------

--[[
		To add your own custom config into your edited version,
		You need to create the addon Tukui_CustomConfig and add
		your custom configuration into it.
		
		An example can be downloaded at:
		http://www.tukui.org/downloads/Tukui_CustomConfig.zip
		
		Don't forget to add in the .toc, in your edited Tukui version: Tukui_CustomConfig
		Add it to: ## RequiredDeps

		That's it! That's all!
--]]

local T, C, L = unpack(select(2, ...))

if not IsAddOnLoaded("Tukui_CustomConfig") then return end

local settings = TukuiCustomConfig

-- update the default options
for group, options in pairs(settings) do
	for option, value in pairs(options) do
		C[group][option] = value
	end
end