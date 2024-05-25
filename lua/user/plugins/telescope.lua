return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	name = "telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-telescope/telescope-frecency.nvim",
	},
	config = function()
		require("user.telescope")
	end,
}
