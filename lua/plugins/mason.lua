-- Installer for LSP, DAP, Formatters, etc...
local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"mason-org/mason-registry",
		"jay-babu/mason-nvim-dap.nvim",
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

local inlays_by_filetype = {
	rust = {
		inlayHints = false,
	},
}

local disable_semantic_tokens = {
	lua = true,
}

local servers = {
	bashls = true,
	pyright = true,
	lua_ls = true,

	-- Needed for nvim-jdtls
	jdtls = "install",
	lemminx = true,

	cssls = true,
	eslint = true,
	volar = true,
	ts_ls = true,
	jsonls = true,
	yamlls = true,
	clangd = true,

	zls = "setup",
}

local tools = {
	"stylua",
	"codelldb",
	"delve",
	"javadbg",
	"javatest",
}

local utils = require("user.utils")

local function setup_diagnostics()
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
end

local function setup_tools()
	local lspconfig = require("lspconfig")

	local capabilities = nil
	if pcall(require, "cmp_nvim_lsp") then
		capabilities = require("cmp_nvim_lsp").default_capabilities()
	end

	local server_configs = {}
	--- Load in configs from other files and append to list of configs
	for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/servers/*.lua", true)) do
		local name = utils.get_filename(ft_path)

		-- Only load the config if the server is setup to be installed + configured
		if servers[name] == true or servers[name] == "setup" then
			local ok, c = pcall(require, "servers." .. name)
			if ok then
				server_configs[name] = c
			else
				vim.notify(c, vim.log.levels.ERROR)
			end
		end
	end

	-- install servers and tools
	require("mason-tool-installer").setup({
		ensure_installed = utils.merge_lists(
			utils.tbl_keys(utils.filter(function(_, value)
				return value == true or value == "install"
			end, servers)),
			tools
		),
	})

	-- configure and enable lsp servers
	for name, value in pairs(servers) do
		if value == true or value == "setup" then
			local conf = {
				capabilities = capabilities,
			}

			-- TODO: Load in config from file
			if server_configs[name] ~= nil then
				conf = vim.tbl_deep_extend("force", {}, conf, server_configs[name])
			end

			lspconfig[name].setup(conf)
		end
	end
end

vim.cmd.highlight("default link LspInlayHint Comment")
local setup_inlay_hints = function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)

	if
		client ~= nil and (client.supports_method("textDocument/inlayHint") or client.capabilities.inlayHintProvider)
	then
		-- Setup commands
		vim.api.nvim_buf_create_user_command(args.buf, "InlayHintsToggle", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
		end, {})
		vim.api.nvim_buf_create_user_command(args.buf, "InlayHintsEnabled", function()
			vim.print(vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
		end, {})

		vim.keymap.set("n", "<space>lh", "<cmd>InlayHintsToggle<cr>", { silent = true, desc = "Toggle inlay hints" })

		if inlays_by_filetype[vim.bo.filetype] then
			vim.lsp.inlay_hint.enable(inlays_by_filetype[vim.bo.filetype].inlayHints or false, { bufnr = args.buf })
		end
	end
end

M.config = function()
	setup_diagnostics()

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

	setup_tools()

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
end

return M
