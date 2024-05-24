return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			background = {
				dark = "macchiato",
				light = "latte",
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
