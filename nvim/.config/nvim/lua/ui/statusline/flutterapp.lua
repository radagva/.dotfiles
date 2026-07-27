local theme = require("ui.statusline.theme")

-- The app version flutter-tools reads off pubspec.yaml. The decorations global
-- only exists once the plugin has woken up in a dart buffer, so this stays
-- empty everywhere else without needing a filetype check.
return function()
	local decorations = vim.g.flutter_tools_decorations
	local version = decorations and decorations.app_version

	if not version or version == "" then
		return ""
	end

	return theme.accent("flutterapp", "dart", "\u{e798} ") .. vim.trim(version)
end
