local util = require("lspconfig.util")

local global_ts = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"

--- Get the server path, either a local typescript server path exists or use the defined global
--- @param root_dir string root directory to search for typescript/lib
local function get_typescript_server_path(root_dir)
	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

return {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git", "node_modules"),
	init_options = {
		vue = {
			hybridMode = false,
		},
		typescript = {
			tsdk = "",
		},
	},
	on_new_config = function(new_config, new_root_dir)
		if
			new_config.init_options
			and new_config.init_options.typescript
			and new_config.init_options.typescript.tsdk == ""
		then
			new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
		end
	end,
}
