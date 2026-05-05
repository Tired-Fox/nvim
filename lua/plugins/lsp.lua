return {
	{
		"rachartier/tiny-code-action.nvim",
		opts = {
			backend = "vim",
			picker = "snacks",
			-- picker = {
			-- 	"buffer",
			-- 	opts = {
			-- 		hotkeys = true, -- Enable hotkeys for quick selection of actions
			-- 		hotkeys_mode = "text_diff_based", -- Modes for generating hotkeys
			-- 		auto_preview = false, -- Enable or disable automatic preview
			-- 		auto_accept = false, -- Automatically accept the selected action (with hotkeys)
			-- 		position = "cursor", -- Position of the picker window
			-- 		winborder = "single", -- Border style for picker and preview windows
			-- 		keymaps = {
			-- 			preview = "K", -- Key to show preview
			-- 			close = { "q", "<Esc>" }, -- Keys to close the window (can be string or table)
			-- 			select = "<CR>", -- Keys to select action (can be string or table)
			-- 			preview_close = { "q", "<Esc>" }, -- Keys to return from preview to main window (can be string or table)
			-- 		},
			-- 		custom_keys = {
			-- 			{ key = "m", pattern = "Fill match arms" },
			-- 			{ key = "r", pattern = "Rename.*" }, -- Lua pattern matching
			-- 		},
			-- 		group_icon = " └",
			-- 	},
			-- },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "wezterm-types", mod = { "wezterm" } },
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "Fildo7525/pretty_hover" },
		version = "1.*",
		build = "cargo build --release",
		opts = {
			keymap = {
				preset = "default",
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = {
					draw = function(opts)
						if opts.item and opts.item.documentation and opts.item.documentation.value then
							local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
							opts.item.documentation.value = out:string()
						end

						opts.default_implementation(opts)
					end,
				},
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "lazydev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = {
			"sources.default",
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {
			multi_server = true,
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^8",
		lazy = false,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.config").setup({
				prefer_git = true,
				highlight = { enable = true },
				incremental_selection = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"rust",
					"java",
					"javascript",
					"typescript",
					"css",
					"lua",
					"zig",
				},
			})
		end,
	},
}
