return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-registry",
		{ "mason-org/mason-lspconfig.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"lua_ls",
				"jdtls",
				"java-debug-adapter",
				"java-test",
				"stylua",
				"prettier",
				"eslint_d",
				"cspell",
				"stylelint",
				"vue_ls",
				"ts_ls",
			},
			integrations = {
				["mason-null-ls"] = false,
				["mason-lspconfig"] = true,
				["mason-nvim-dap"] = true,
			},
		})

		vim.lsp.config("ts_ls", {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vim.fn.expand(
							"$MASON/packages/vue-language-server/node_modules/@vue/language-server"
						),
						languages = { "typescript", "javascript", "vue" },
					},
				},
			},
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			settings = {
				typescript = {
					tssserver = {
						useSyntaxServer = false,
					},
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		})

		vim.lsp.config("vue_ls", {
			root_dir = vim.fs.root(0, {
				"vue.config.js",
				"vvue.config.ts",
				"nuxt.config.js",
				"nuxt.config.ts",
				"package.json",
			}),
			init_options = {
				vue = {
					-- Splits between vue lsp and typescript lsp
					hybridMode = true,
				},
			},
			filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
		})
	end,
}
