local M = {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
}

function M.init()
	local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb"
	local this_os = vim.loop.os_uname().sysname

	if this_os:find("Windows") then
		codelldb_path = extension_path .. "adapter\\codelldb.exe"
		liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
	else
		liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
	end

	local cfg = require("rustaceanvim.config")
	vim.g.rustaceanvim = {
		tools = {
			-- code_actions = {
			-- 	ui_select_fallback = true,
			-- },
			hover_actions = {
				replace_builtin_hover = true,
				auto_focus = false,
			},
			-- ref: api-win_config
			float_win_config = {
				border = "rounded",
			},
			test_executor = "background",
		},
		server = {
			settings = function(proj_root)
				local ra = require("rustaceanvim.config.server")
				return vim.tbl_deep_extend(
					"force",
					{
						["rust-analyzer"] = {
							cargo = {
								features = "all",
							},
							checkOnSave = {
								command = "clippy",
							},
						},
					},
					ra.load_rust_analyzer_settings(proj_root, {
						settings_file_pattern = "rust-analyzer.json",
					})
				)
			end,
		},
		dap = {
			adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	}
end

return M
