return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 100,
		dependencies = {
			-- Fancy icons for completions
			"onsails/lspkind.nvim",
			-- LSP completions
			"hrsh7th/cmp-nvim-lsp",
			-- Path completions
			"hrsh7th/cmp-path",
			-- Buffer completions
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			-- Luasnip completion
			"saadparwaiz1/cmp_luasnip",
			-- Database completion
		},
		config = function()
			require("user.completion")
		end,
	},
	{
		"MattiasMTS/cmp-dbee",
		-- commit = "0feabc1",
		dependencies = {
			"kndndrj/nvim-dbee",
		},
		ft = "sql",
		config = function()
			require("cmp-dbee").setup({})
		end,
	},
	{
		"supermaven-inc/supermaven-nvim",
		cmd = "BufNew",
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
