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

--- Filter a table with a predicate given a key value pair.
---
--- Retains both the key and the value.
---
--- @param table table
--- @param table
M.filter = function(func, t)
	local result = {}
	for key, value in pairs(t) do
		if func(key, value) then
			result[key] = value
		end
	end
	return result
end

--- Get only the table keys as a list
---
--- @param table table<string, any>
--- @param { [number]: string }
M.tbl_keys = function(tbl)
	local result = {}
	for key, list in pairs(tbl) do
		table.insert(result, key)
	end
	return result
end

M.path = {}

--- Expands path segments like `~` and `$HOME` in a platform agnostic way
---
--- @param path string The path to expand.
function M.path.expand(path)
	local HOME = vim.uv.os_uname().sysname:find("Windows") and vim.env.HOMEDRIVE .. vim.env.HOMEPATH or vim.env.HOME
	return path:gsub("~", HOME):gsub("\\$HOME", HOME)
end

return M
