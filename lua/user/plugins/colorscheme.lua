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
				integrations = {
					treesitter = true,
					cmp = true,
					diffview = true,
					fidget = true,
					harpoon = true,
					neogit = true,
					dap = true,
					dap_ui = true,
					telescope = {
						enabled = true,
					},
					-- lsp_trouble = true,
					gitsigns = true,
					-- which_key = true,
					mason = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
							ok = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
							ok = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
				},
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
