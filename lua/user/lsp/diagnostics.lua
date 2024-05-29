local border = require("user").border
local icons = require("user").icons

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

-- Change diagnostic symbols
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostic.BoldError,
			[vim.diagnostic.severity.WARN] = icons.diagnostic.BoldWarning,
			[vim.diagnostic.severity.HINT] = icons.diagnostic.BoldHint,
			[vim.diagnostic.severity.INFO] = icons.diagnostic.BoldInformation,
		},
	},
	virtual_text = false,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "",
	},
})
