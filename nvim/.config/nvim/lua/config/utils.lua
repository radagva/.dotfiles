local M = {}

function M.spread(template)
	local result = {}
	for key, value in pairs(template) do
		result[key] = value
	end

	return function(table)
		for key, value in pairs(table) do
			result[key] = value
		end

		return result
	end
end

function M.merge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" and type(t1[k] or false) == "table" then
			M.merge(t1[k], v)
		else
			t1[k] = v
		end
	end
	return t1
end

M.github = function(repo)
	return "https://github.com/" .. repo
end

M.highlights = function(hl, _)
	hl.Pmenu = { bg = "none", fg = "none" }

	hl.BlinkCmpKind = { link = "Special" }
	hl.BlinkCmpKindFunction = { link = "@function" }
	hl.BlinkCmpKindVariable = { link = "@variable" }
	hl.BlinkCmpKindKeyword = { link = "@keyword" }
	hl.BlinkCmpKindText = { link = "@text" }
	hl.BlinkCmpKindMethod = { link = "@method" }
	hl.BlinkCmpKindConstructor = { link = "@constructor" }
	hl.BlinkCmpKindClass = { link = "@type" }
	hl.BlinkCmpKindInterface = { link = "@type" }
	hl.BlinkCmpKindStruct = { link = "@type" }
	hl.BlinkCmpKindModule = { link = "@namespace" }
	hl.BlinkCmpKindProperty = { link = "@property" }
	hl.BlinkCmpKindUnit = { link = "@number" }
	hl.BlinkCmpKindValue = { link = "@string" }
	hl.BlinkCmpKindEnum = { link = "@type" }
	hl.BlinkCmpKindField = { link = "@field" }
	hl.BlinkCmpKindTypeParameter = { link = "@type" }
	hl.BlinkCmpKindConstant = { link = "@constant" }
	hl.BlinkCmpKindSnippet = { link = "@markup.raw" }
	hl.BlinkCmpKindFile = { link = "@text.uri" }
	hl.BlinkCmpKindFolder = { link = "@text.uri" }
	hl.BlinkCmpKindColor = { link = "@string.special" }
	hl.BlinkCmpKindReference = { link = "@text.reference" }
	hl.BlinkCmpKindOperator = { link = "@operator" }

	hl.PmenuThumb = { bg = "#5b6078" }
	hl.BlinkCmpMenuBorder = { fg = "", bg = "none" }

	hl.NormalFloat = { bg = "none" }
	hl.Float = { bg = "none" }
	hl.FloatBorder = { bg = "none" }
	hl.FloatTitle = { bg = "none" }

	hl.WinBar = { bg = "none" }
	hl.WinBarNC = { bg = "none" }
	hl.TabLineFill = { bg = "none", fg = "none" }

	hl.StatusLine = { bg = "none" }
	hl.StatusLineNC = { bg = "none" }

	hl.GitSignsCurrentLineBlame = { fg = "#5b6078" }
	hl["@lsp.type.class.python"] = { fg = "#E0A363" }
	hl["@lsp.typemod.class.definition.python"] = { fg = "#C38282" }

	return hl
end

return M
