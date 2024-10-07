local M = {

	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{
			"<space>lD",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<space>ld",
			"<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<space>ls",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<space>ll",
			"<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<space>L",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<space>Q",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
	opts = {
		auto_close = true,
		-- focus = true,
		-- preview = {
		-- 	type = "split",
		-- 	scratch = true,
		-- },
	}, -- for default options, refer to the configuration section for custom setup.
}
return M
