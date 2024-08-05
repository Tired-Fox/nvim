local lspconfig = require("lspconfig")

local vue_ls_path = "C:\\Users\\zboehm\\AppData\\Local\\Yarn\\Data\\global\\node_modules\\@vue\\language-server"

return {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git", "node_modules"),
	init_options = {
		plugins = {
			-- https://github.com/vuejs/language-tools Under `neovim/nvim-lspconfig`. This allows volar to have completion, go to, and more...
			{
				name = "@vue/typescript-plugin",
				location = vue_ls_path,
				languages = { "vue" },
			},
		},
	},
}
