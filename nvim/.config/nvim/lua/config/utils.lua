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

return M
