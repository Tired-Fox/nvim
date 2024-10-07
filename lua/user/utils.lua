local M = {}

--- Parse the filename from path string
---
--- @param path string path to file
--- @return string filename without extension
M.get_filename = function(path)
	local start, _ = path:find("[^/\\]+.lua$")
	return path:sub(start, #path - 4)
end

--- Merge lists together into a new single list
---
--- @param ... table<integer, any>
--- @return table<integer, any>
M.merge_lists = function(...)
	local result = {}
	for _, list in ipairs({ ... }) do
		for _, item in ipairs(list) do
			if not vim.tbl_contains(result, function(v)
				return vim.deep_equal(v, item)
			end) then
				table.insert(result, item)
			end
		end
	end

	return result
end

return M
