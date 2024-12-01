local function todo(item)
	return vim.tbl_contains({ "TODO", "TEST", "PERF" }, item.item.tag)
end

local function error(item)
	return vim.tbl_contains({ vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN }, item.item.severity)
end

local M = {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{
			"<space>lDa",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<space>lDe",
			function()
				require("trouble").open({
					mode = "diagnostics",
					focus = true,
					filter = {
						error,
					},
				})
			end,
			desc = "Error Diagnostics (Trouble)",
		},
		{
			"<space>lda",
			"<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<space>lde",
			function()
				require("trouble").open({
					mode = "diagnostics",
					focus = true,
					filter = {
						buf = 0,
						error,
					},
				})
			end,
			desc = "Buffer Error Diagnostics (Trouble)",
		},

		{
			"<space>lt",
			function()
				require("trouble").open({
					mode = "todo",
					focus = true,
					filter = {
						todo,
					},
				})
			end,
			desc = "Error Diagnostics (Trouble)",
		},
		{
			"<space>ln",
			function()
				require("trouble").open({
					mode = "todo",
					focus = true,
					filter = {
						["not"] = {
							todo,
						},
					},
				})
			end,
			desc = "Error Diagnostics (Trouble)",
		},
		{
			"<space>lda",
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
	},
}

return M
