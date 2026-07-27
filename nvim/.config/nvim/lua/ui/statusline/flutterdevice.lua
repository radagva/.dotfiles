local theme = require("ui.statusline.theme")

-- Matched on a prefix, because `flutter devices` reports platforms as
-- "android-arm64", "darwin-x64", "web-javascript" and friends.
local icons = {
	android = "\u{f17b}",
	ios = "\u{f179}",
	darwin = "\u{f179}",
	macos = "\u{f179}",
	chrome = "\u{f268}",
	web = "\u{f0ac}",
	linux = "\u{f17c}",
	windows = "\u{f17a}",
}

local FALLBACK = "\u{f10b}" -- a generic handset, for anything unrecognised

local function icon_for(platform)
	for prefix, icon in pairs(icons) do
		if platform:find(prefix, 1, true) == 1 then
			return icon
		end
	end
	return FALLBACK
end

return function()
	local decorations = vim.g.flutter_tools_decorations
	local device = decorations and decorations.device

	if not device or not device.name then
		return ""
	end

	-- flutter-tools records the device when an app starts but never clears it on
	-- shutdown, so ask the runner whether that app is still up. Safe to require
	-- here: a device in the decorations means the plugin has already started.
	if not require("flutter-tools.commands").is_running() then
		return ""
	end

	return theme.accent("flutterdevice", "device", icon_for(device.platform or "") .. " ") .. device.name
end
