return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	name = "telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-smart-history.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("user.telescope")
	end,
}
