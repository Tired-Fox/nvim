local lspconfig = require("lspconfig")

local mason_registry = require("mason-registry")
local vue_ls_path = mason_registry.get_package("vue-language-server"):get_install_path()
	.. "/node_modules/@vue/language-server"

return {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git", "node_modules"),
	init_options = {
		plugins = {
			-- https://github.com/vuejs/language-tools Under `neovim/nvim-lspconfig`. This allows volar to have completion, go to, and more...
			-- WARNING: Make sure that @vue/typescript-plugin is installed
			{
				name = "@vue/typescript-plugin",
				location = vue_ls_path,
				languages = { "vue" },
			},
		},
	},
}
