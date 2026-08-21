-- Codicon glyphs: debug_pause (execution halted) / debug_continue (running) /
-- debug (session active, state unclear yet).
local icons = {
	stopped = "\u{ead1}",
	running = "\u{eacf}",
}
local FALLBACK = "\u{ead8}"

return function()
	local dap = require("dap")
	local status = dap.status()
	if status == "" then
		return ""
	end

	local session = dap.session()
	local icon = FALLBACK
	if session then
		icon = session.stopped_thread_id and icons.stopped or icons.running
	end

	return icon .. "  " .. status
end
