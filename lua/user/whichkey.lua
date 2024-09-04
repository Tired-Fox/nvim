local mappings = {
	-- q = { "<cmd>confirm q<CR>", "Quit" },
	{ "<leader>.", "<cmd>nohlsearch<CR>", desc = "NOHL" },
	{ "<leader>d>", group = "Debug" },
	{ "<leader>h", group = "Hunk" },
	{ "<leader>f", group = "Find" },
	{ "<leader>g", group = "Git" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>t", group = "Test" },
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
	win = {
		title = false,
		border = "rounded",
		padding = { 2, 2 },
	},
	-- Don't pull in keymaps unless they are registered with which-key
	-- ignore_missing = false,
	-- show_help = false,
	-- show_keys = false,
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
})

which_key.add({ mappings, mode = "n" })
which_key.add({ mappings, mode = "v" })
