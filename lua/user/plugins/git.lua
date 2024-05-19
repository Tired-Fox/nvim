return {
	{
		"lewis6991/gitsigns.nvim",
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
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"telescope",
		},
		config = true,
	},
}
