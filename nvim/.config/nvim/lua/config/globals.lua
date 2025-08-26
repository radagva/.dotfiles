Dprint = function(v)
	print(vim.inspect(v))
	return v
end

Reload = function(...)
	return require("plenary.reload").reload_module(...)
end

Run = function(name)
	Reload(name)
	return require(name)
end
