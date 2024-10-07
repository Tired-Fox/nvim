--- [[ Diagnostics ]]
local border = require("user.border")
local icons = require("user.icons")

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

--- [[ Mason and Lspconfig ]]
local lspui_ok, lspui = pcall(require, "lspconfig.ui.windows")
if lspui_ok then
	lspui.default_options.border = "rounded"
end

require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			-- The list icon to use for installed packages.
			package_installed = "◼", --"◍",
			-- The list icon to use for packages that are installing, or queued for installation.
			package_pending = "▣", --"◍",
			-- The list icon to use for packages that are not installed.
			package_uninstalled = "▢", --"◍",
		},
	},
})

require("user.lsp.servers"):setup()

--- [[ LspAttach ]]
--- @class table<K, V>: { [K]: Options }
local defaults_by_filetype = {
	rust = {
		inlayHints = false,
	},
}

vim.cmd.highlight("default link LspInlayHint Comment")
local setup_inlay_hints = function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)

	if client.supports_method("textDocument/inlayHint") or client.capabilities.inlayHintProvider then
		-- Setup commands
		vim.api.nvim_buf_create_user_command(args.buf, "InlayHintsToggle", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
		end, {})
		vim.api.nvim_buf_create_user_command(args.buf, "InlayHintsEnabled", function()
			vim.print(vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
		end, {})

		vim.keymap.set("n", "<space>lh", "<cmd>InlayHintsToggle<cr>", { silent = true, desc = "Toggle inlay hints" })

		if defaults_by_filetype[vim.bo.filetype] then
			vim.lsp.inlay_hint.enable(defaults_by_filetype[vim.bo.filetype].inlayHints or false, { bufnr = args.buf })
		end
	end
end

local disable_semantic_tokens = {
	lua = true,
}

-- Setup lsp on attach functionality
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "Go to Definition" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, desc = "Go to References" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Go to Declaration" })
		vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "Go to Type Definition" })
		-- note: neovim v0.10 this is default
		-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Hover" })

		vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, { buffer = 0, desc = "Rename" })
		vim.keymap.set("n", "<space>la", vim.lsp.buf.code_action, { buffer = 0, desc = "Code Action" })

		local filetype = vim.bo[bufnr].filetype
		if disable_semantic_tokens[filetype] then
			client.server_capabilities.semanticTokensProvider = nil
		end

		setup_inlay_hints(args)
	end,
})
