return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 100,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("user.completion")
		end,
	},
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				-- These are just here for if inline completion is turned on
				keymaps = {
					clear_suggestion = "<c-]>",
					accept_suggestion = "<m-y>",
					accept_word = "<c-k>",
				},
				disable_inline_completion = false,
				disable_keymaps = false,
			})
		end,
	},
}
