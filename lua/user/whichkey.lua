local mappings = {
	-- q = { "<cmd>confirm q<CR>", "Quit" },
	["."] = { "<cmd>nohlsearch<CR>", "NOHL" },
	d = { name = "Debug" },
	h = { name = "Hunk" },
	f = { name = "Find" },
	g = { name = "Git" },
	l = { name = "LSP" },
	t = { name = "Test" },
}

local which_key = require("which-key")
which_key.setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = false,
			nav = false,
			z = false,
			g = false,
		},
	},
	window = {
		border = "rounded",
		position = "bottom",
		padding = { 2, 2, 2, 2 },
	},
	-- Don't pull in keymaps unless they are registered with which-key
	ignore_missing = false,
	show_help = false,
	show_keys = false,
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
})

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
}

which_key.register(mappings, opts)
which_key.register(mappings, { mode = "v", prefix = "<leader>" })
