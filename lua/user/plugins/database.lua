return {
	{
		"kristijanhusak/vim-dadbod-ui",
		enabled = false,
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			-- vim.g.db_ui_debug = 1
		end,
	},
	{
		"kndndrj/nvim-dbee",
		lazy = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install("wget")
		end,
		config = function()
			require("dbee").setup(--[[optional config]])
			vim.keymap.set("n", "<space>D", function()
				require("dbee").toggle()
			end)
		end,
	},
}
