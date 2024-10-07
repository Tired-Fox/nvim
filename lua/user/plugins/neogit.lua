local M = {
	"NeogitOrg/neogit",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"diffview", -- optional - Diff integration
		"telescope",
	},
	keys = {
		{ "<space>g", "<cmd>Neogit<cr>", "Neogit" },
	},
	config = true,
}

return M
