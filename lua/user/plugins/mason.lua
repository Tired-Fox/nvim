-- Installer for LSP, DAP, Formatters, etc...
local M = {
  "williamboman/mason-lspconfig.nvim",
	dependencies = {
    "williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

return M
