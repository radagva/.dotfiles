return {
	{ "giuxtaposition/blink-cmp-copilot" },

	{
		"zbirenbaum/copilot.lua",
		optional = true,
		opts = function()
			require("copilot.api").status = require("copilot.status")
			require("copilot.api").filetypes = {
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
			}
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "folke/which-key.nvim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {},
	},

	{
		"yetone/avante.nvim",
		build = function()
			if vim.fn.has("win32") == 1 then
				return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			else
				return "make"
			end
		end,
		event = "VeryLazy",
		version = false,
		opts = function(_)
			local in_resize = false
			local original_cursor_win = nil
			local avante_filetypes = { "Avante", "AvanteInput", "AvanteAsk", "AvanteSelectedFiles" }

			local function is_in_avante_window()
				local win = vim.api.nvim_get_current_win()
				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.api.nvim_buf_get_option(buf, "filetype")

				for _, avante_ft in ipairs(avante_filetypes) do
					if ft == avante_ft then
						return true, win, ft
					end
				end
				return false
			end

			local function temporarily_leave_avante()
				local is_avante, avante_win, _ = is_in_avante_window()
				if is_avante and not in_resize then
					in_resize = true
					original_cursor_win = avante_win

					local target_win = nil
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						local ft = vim.api.nvim_buf_get_option(buf, "filetype")

						local is_avante_ft = false
						for _, aft in ipairs(avante_filetypes) do
							if ft == aft then
								is_avante_ft = true
								break
							end
						end

						if not is_avante_ft and vim.api.nvim_win_is_valid(win) then
							target_win = win
							break
						end
					end

					-- Switch to non-avante window if found
					if target_win then
						vim.api.nvim_set_current_win(target_win)
						return true
					end
				end
				return false
			end

			-- Restore cursor to original avante window
			local function restore_cursor_to_avante()
				if in_resize and original_cursor_win and vim.api.nvim_win_is_valid(original_cursor_win) then
					-- Small delay to ensure resize is complete
					vim.defer_fn(function()
						pcall(vim.api.nvim_set_current_win, original_cursor_win)
						in_resize = false
						original_cursor_win = nil
					end, 50)
				end
			end

			-- Prevent duplicate windows cleanup
			local function cleanup_duplicate_avante_windows()
				local seen_filetypes = {}
				local windows_to_close = {}

				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.api.nvim_buf_get_option(buf, "filetype")

					-- Special handling for Ask and Select Files panels
					if ft == "AvanteAsk" or ft == "AvanteSelectedFiles" then
						if seen_filetypes[ft] then
							-- Found duplicate, mark for closing
							table.insert(windows_to_close, win)
						else
							seen_filetypes[ft] = win
						end
					end
				end

				-- Close duplicate windows
				for _, win in ipairs(windows_to_close) do
					if vim.api.nvim_win_is_valid(win) then
						pcall(vim.api.nvim_win_close, win, true)
					end
				end
			end

			-- Create autocmd group for resize fix
			vim.api.nvim_create_augroup("AvanteResizeFix", { clear = true })

			-- Main resize handler for Resize
			vim.api.nvim_create_autocmd({ "VimResized" }, {
				group = "AvanteResizeFix",
				callback = function()
					-- Move cursor away from avante before resize processing
					local moved = temporarily_leave_avante()

					if moved then
						-- Let resize happen, then restore cursor
						vim.defer_fn(function()
							restore_cursor_to_avante()
							-- Force a clean redraw
							vim.cmd("redraw!")
						end, 100)
					end

					-- Cleanup duplicates after resize completes
					vim.defer_fn(cleanup_duplicate_avante_windows, 150)
				end,
			})

			-- Prevent avante from responding to scroll/resize events during resize
			vim.api.nvim_create_autocmd({ "WinScrolled", "WinResized" }, {
				group = "AvanteResizeFix",
				pattern = "*",
				callback = function(args)
					local buf = args.buf
					if buf and vim.api.nvim_buf_is_valid(buf) then
						local ft = vim.api.nvim_buf_get_option(buf, "filetype")

						for _, avante_ft in ipairs(avante_filetypes) do
							if ft == avante_ft then
								-- Prevent event propagation for avante buffers during resize
								if in_resize then
									return true -- This should stop the event
								end
								break
							end
						end
					end
				end,
			})

			-- Additional cleanup on focus events
			vim.api.nvim_create_autocmd("FocusGained", {
				group = "AvanteResizeFix",
				callback = function()
					-- Reset resize state on focus gain
					in_resize = false
					original_cursor_win = nil
					-- Clean up any duplicate windows
					vim.defer_fn(cleanup_duplicate_avante_windows, 100)
				end,
			})

			return {
				provider = "copilot",
				providers = {
					copilot = {},
				},
				cursor_applying_provider = "copilot",
				auto_suggestions_provider = "copilot",
				behaviour = {
					auto_suggestions = false,
					auto_set_highlight_group = true,
					auto_set_keymaps = true,
					auto_apply_diff_after_generation = false,
					support_paste_from_clipboard = false,
					enable_token_counting = false,
					auto_approve_tool_permissions = false,
					enable_fastapply = false,
				},
				file_selector = {
					provider = "snacks",
					provider_opts = {},
				},
				windows = {
					position = "right",
					wrap = true,
					width = 30,
					sidebar_header = {
						enabled = true,
						align = "center",
						rounded = false,
					},
					input = {
						prefix = "> ",
						height = 8,
					},
					edit = {
						start_insert = true,
					},
					ask = {
						floating = false,
						start_insert = true,
						---@type "ours" | "theirs"
						focus_on_apply = "ours",
					},
				},
				system_prompt = "Este GPT es un clon del usuario, un arquitecto líder frontend especializado en Angular y React, con experiencia en arquitectura limpia, arquitectura hexagonal y separación de lógica en aplicaciones escalables. Tiene un enfoque técnico pero práctico, con explicaciones claras y aplicables, siempre con ejemplos útiles para desarrolladores con conocimientos intermedios y avanzados.\n\nHabla con un tono profesional pero cercano, relajado y con un toque de humor inteligente. Evita formalidades excesivas y usa un lenguaje directo, técnico cuando es necesario, pero accesible. Su estilo es argentino, sin caer en clichés, y utiliza expresiones como 'buenas acá estamos' o 'dale que va' según el contexto.\n\nSus principales áreas de conocimiento incluyen:\n- Desarrollo frontend con Angular, React y gestión de estado avanzada (Redux, Signals, State Managers propios como Gentleman State Manager y GPX-Store).\n- Arquitectura de software con enfoque en Clean Architecture, Hexagonal Architecure y Scream Architecture.\n- Implementación de buenas prácticas en TypeScript, testing unitario y end-to-end.\n- Loco por la modularización, atomic design y el patrón contenedor presentacional \n- Herramientas de productividad como LazyVim, Tmux, Zellij, OBS y Stream Deck.\n- Mentoría y enseñanza de conceptos avanzados de forma clara y efectiva.\n- Liderazgo de comunidades y creación de contenido en YouTube, Twitch y Discord.\n\nA la hora de explicar un concepto técnico:\n1. Explica el problema que el usuario enfrenta.\n2. Propone una solución clara y directa, con ejemplos si aplica.\n3. Menciona herramientas o recursos que pueden ayudar.\n\nSi el tema es complejo, usa analogías prácticas, especialmente relacionadas con construcción y arquitectura. Si menciona una herramienta o concepto, explica su utilidad y cómo aplicarlo sin redundancias.\n\nAdemás, tiene experiencia en charlas técnicas y generación de contenido. Puede hablar sobre la importancia de la introspección, có...",
			}
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
		},
	},
}
