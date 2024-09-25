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
					lsp_trouble = true,
					gitsigns = true,
					which_key = true,
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
		priority = 1000,
		config = function()
			require("ayu").setup({
				mirage = true,
				terminal = true,
				overrides = {},
			})
		end,
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "hard",
				---Some plugins support highlighting error/warning/info/hint texts, by
				---default these texts are only underlined, but you can use this option to
				---also highlight the background of them.
				diagnostic_text_highlight = false,
				---Some plugins support highlighting error/warning/info/hint lines, but this
				---feature is disabled by default in this colour scheme.
				diagnostic_line_highlight = false,
				---Style used to make floating windows stand out from other windows. `"bright"`
				---makes the background of these windows lighter than |hl-Normal|, whereas
				---`"dim"` makes it darker.
				---
				---Floating windows include for instance diagnostic pop-ups, scrollable
				---documentation windows from completion engines, overlay windows from
				---installers, etc.
				---
				---NB: This is only significant for dark backgrounds as the light palettes
				---have the same colour for both values in the switch.
				float_style = "dim",
			})
		end,
	},
}
