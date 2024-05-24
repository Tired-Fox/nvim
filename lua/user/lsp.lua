require("neodev").setup({
	-- library = {
	--   plugins = { "nvim-dap-ui" },
	--   types = true,
	-- },
})

local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
	capabilities = require("cmp_nvim_lsp").default_capabilities()
end

local lspconfig = require("lspconfig")

local servers = {
	bashls = true,
	gopls = true,
	lua_ls = true,
	cssls = true,
	eslint = true,
	vuels = {
		filetypes = { "typescript", "javascript", "vue", "json" },
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	},
	zls = {
		filetypes = { "zig", "zon" },
	},
	-- Probably want to disable formatting for this lang server
	tsserver = {
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
	clangd = {
		-- TODO: Could include cmd, but not sure those were all relevant flags.
		--    looks like something i would have added while i was floundering
		init_options = { clangdFileStatus = true },
		filetypes = { "c" },
	},
}

local servers_to_install = vim.tbl_filter(function(key)
	local t = servers[key]
	if type(t) == "table" then
		return not t.manual_install
	else
		return t
	end
end, vim.tbl_keys(servers))

require("mason").setup()
local ensure_installed = {
	"stylua",
	"lua_ls",
	"delve",
	-- "tailwind-language-server",
}

vim.list_extend(ensure_installed, servers_to_install)
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

for name, config in pairs(servers) do
	if config == true then
		config = {}
	end
	config = vim.tbl_deep_extend("force", {}, {
		capabilities = capabilities,
	}, config)

	-- print(name)
	if name == "volar" then
		vim.tbl_deep_extend("force", config, {
			init_options = {
				typescript = {
					tsdk = vim.fs.normalize("D:\\scoop\\persist\\nodejs\\bin\\node_modules\\typescript\\lib"),
				},
			},
		})
		lspconfig.volar.setup(config)
	end
	lspconfig[name].setup(config)
end

local disable_semantic_tokens = {
	lua = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
		vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
		-- note: neovim v0.10 this is default
		-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

		vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

		local filetype = vim.bo[bufnr].filetype
		if disable_semantic_tokens[filetype] then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

-- Autoformatting Setup
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		require("conform").format({
			bufnr = args.buf,
			lsp_fallback = true,
			quiet = true,
		})
	end,
})

local lspui_ok, lspui = pcall(require, "lspconfig.ui.windows")
if not lspui_ok then
	return
end

lspui.default_options.border = "rounded"
