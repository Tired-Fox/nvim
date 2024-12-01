local M = {
	"folke/which-key.nvim",
	name = "whichkey",
	event = "VeryLazy",
}

function M.config()
	local mappings = {
		{ "<space>.", "<cmd>nohlsearch<CR>", desc = "NOHL" },
		{ "<space>d", group = "Debug" },
		{ "<space>lD", group = "Diagnostics (Workspace)" },
		{ "<space>ld", group = "Diagnostics (Buffer)" },
		{ "<space>h", group = "Harpoon" },
		{ "<space>c", group = "Close" },
		{ "<space>f", group = "Find" },
		{ "<space>g", group = "Git" },
		{ "<space>l", group = "LSP" },
		{ "<space>t", group = "Test" },
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
end

return M
