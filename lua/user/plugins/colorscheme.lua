return {
	{
		-- that is what she said
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				background = {
					dark = "macchiato",
					light = "latte",
				},
				custom_highlights = function(colors)
					return {
						LspInlayHint = { bg = colors.base, style = { "italic" } },
					}
				end,
			})
		end,
	},
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				mirage = false,
				terminal = true,
				overrides = {},
			})
		end,
	},
}
