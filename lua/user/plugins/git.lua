return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufWinEnter",
		dependencies = {
			-- Git commands in nvim commands
			"tpope/vim-fugitive",
			-- Git url interactions
			"tpope/vim-rhubarb",
		},
		config = function()
			require("user._git")
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("diffview").setup({
				view = {
					merge_tool = {
						layout = "diff3_mixed",
						disable_diagnostics = true,
						winbar_info = true,
					},
				},
				hooks = {},
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		enabled = true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"telescope",
		},
		keys = {
			{ "<space>g", "<cmd>Neogit kind=replace<cr>", "Neogit" },
		},
		config = true,
	},
}
