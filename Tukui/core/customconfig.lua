----------------------------------------------------------------------------
-- This Module loads custom settings for edited package
----------------------------------------------------------------------------

--[[
		To add your own custom config into your edited version,
		You need to create the addon Tukui_EditedDefaultConfig and add
		your custom configuration into it.
		
		A guide (example) can be downloaded at:
		http://www.tukui.org/downloads/Tukui_EditedDefaultConfig.zip
		
		Don't forget to add in the .toc, in your edited Tukui version: Tukui_CustomConfig
		If no new option group, Add it to: ## OptionalDeps
		If new option group, Add it to: ## RequiredDeps

		That's it! That's all!
--]]

local T, C, L = unpack(select(2, ...))

if not TukuiEditedDefaultConfig then return end

local settings = TukuiEditedDefaultConfig

-- add our new options and update default
for group, options in pairs(settings) do
	-- create a new group of option if not found on Tukui
	if not C[group] then
		C[group] = {}
	end
	
	-- set all the options
	for option, value in pairs(options) do
		if group ~= "media" then
			C[group][option] = value
		end
	end
end