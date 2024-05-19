return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Better lua vim completions
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Display lsp logs in fancy output at bottom right
			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			require("user.lsp")
		end,
	},
}
