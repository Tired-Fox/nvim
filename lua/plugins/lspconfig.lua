local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
		-- Display lsp logs in fancy output at bottom right
		{ "j-hui/fidget.nvim", opts = {} },

		-- Schema information
		"b0o/SchemaStore.nvim",
  }
}

return M
