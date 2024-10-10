local T, C, L = unpack((select(2, ...)))

local UnitFrames = T["UnitFrames"]

local Count = 0
local Widgets = {}


-- Rebuild the index for insert or remove.
local function rebuildIndex(changedWidget)
	if Widgets[changedWidget.index] then
		-- insert case: start at end, shift right
		for index = Count, changedWidget.index, -1 do
			local newIndex = index + 1
			Widgets[newIndex] = Widgets[index]
			Widgets[newIndex].index = newIndex
		end
		Widgets[changedWidget.index] = changedWidget
		Count = Count + 1
	else
		-- remove case: start at index, shift left
		for index = changedWidget.index, Count do
			local nextIndex = index + 1
			Widgets[index] = Widgets[nextIndex]
			Widgets[index].index = index
		end
		Count = Count - 1
	end
end

-- Creates a new Widget storing the parameters as key value pairs.
local function Widget(index, name, widget, config)
	return {
		index = index,
		name = name,
		func = widget,
		config = config
	}
end

local WidgetManager = {}

-- Returns the number of registered widgets.
function WidgetManager:getCount()
	return Count
end

-- Add a new widget.
-- Returs the index it was added at or false if already existing.
function WidgetManager:add(name, func, config)
	-- name must not be a number, to not interfere with the index
	if type(name) == "string" and not Widgets[name] then
		Count = Count + 1
		local widget = Widget(Count, name, func, config)
		Widgets[Count] = widget
		Widgets[name] = widget
		return widget.index
	end
	return false
end

-- Returns the registered widget or nil.
-- Supports name or index to retrieve the widget.
function WidgetManager:get(nameOrIndex)
	local widget = Widgets[nameOrIndex]
	return widget.index, widget.name, widget.func, widget.config
end

-- Update an already registered widget.
-- Returns the index and name of the updated widget or nil if not found.
function WidgetManager:update(nameOrIndex, func, config)
	local widget = Widgets[nameOrIndex]
	if widget then
		widget.func = func
		widget.config = config
		return widget.index, widget.name
	end
end

-- Remove a registered widget.
-- Returns the removed widget or nil if not found.
function WidgetManager:remove(nameOrIndex)
	local widget = Widgets[nameOrIndex]
	if widget then
		Widgets[widget.index] = nil
		Widgets[widget.name] = nil

		rebuildIndex(widget)
		return widget.index, widget.name, widget.func, widget.config
	end
end

-- Insert a new widget at position "atIndex".
-- Returns the number of registered widgets or nil if failed.
function WidgetManager:insert(atIndex, name, func, config)
	-- fails if a widget of that name already exists or the index is outside the current range
	if not Widgets[name] and atIndex <= Count then
		local widget = Widget(atIndex, name, func, config)
		Widgets[name] = widget

		rebuildIndex(widget)
		return Count
	end
end

--Calls all registered widgets in order.
function WidgetManager:createWidgets(unitFrame)
	for i = 1, Count do
		local widget = Widgets[i]
		widget.func(unitFrame, widget.config)
	end
end

UnitFrames.WidgetManager = WidgetManager
