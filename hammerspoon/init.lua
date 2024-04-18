hs.loadSpoon("ControlEscape"):start() -- Load Hammerspoon bits from https://github.com/jasonrudolph/ControlEscape.spoon

-- Use control + hjkl to move around
local function pressFn(mods, key)
	if key == nil then
		key = mods
		mods = {}
	end

	return function()
		hs.eventtap.keyStroke(mods, key, 1000)
	end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end

local function enableHotkeyForApp(appName, hotkey)
	local filter = hs.window.filter.new(appName)
	filter:subscribe(hs.window.filter.windowFocused, function()
		hotkey:enable()
	end)
	filter:subscribe(hs.window.filter.windowUnfocused, function()
		hotkey:disable()
	end)
end

remap({ "ctrl" }, "h", pressFn("left"))
remap({ "ctrl" }, "j", pressFn("down"))
remap({ "ctrl" }, "k", pressFn("up"))
remap({ "ctrl" }, "l", pressFn("right"))

local ghosttyHotkey1 = hs.hotkey.new({ "cmd" }, "j", function()
	hs.eventtap.keyStroke({ "alt" }, "6", 1000)
end)
local ghosttyHotkey2 = hs.hotkey.new({ "cmd" }, "k", function()
	hs.eventtap.keyStroke({ "alt" }, "7", 1000)
end)
local ghosttyHotkey3 = hs.hotkey.new({ "cmd" }, "l", function()
	hs.eventtap.keyStroke({ "alt" }, "8", 1000)
end)
local ghosttyHotkey4 = hs.hotkey.new({ "cmd" }, ";", function()
	hs.eventtap.keyStroke({ "alt" }, "9", 1000)
end)

enableHotkeyForApp("Ghostty", ghosttyHotkey1)
enableHotkeyForApp("Ghostty", ghosttyHotkey2)
enableHotkeyForApp("Ghostty", ghosttyHotkey3)
enableHotkeyForApp("Ghostty", ghosttyHotkey4)
