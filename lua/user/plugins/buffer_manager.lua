local M = {
	"j-morano/buffer_manager.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local bufman = require("buffer_manager")
	local ui = require("buffer_manager.ui")

	bufman.setup({
		select_menu_item_commands = {
			v = {
				key = "<C-v>",
				command = "vsplit",
			},
			h = {
				key = "<C-h>",
				command = "split",
			},
		},
	})

	vim.keymap.set("n", "]b", ui.nav_next, { desc = "Next Buffer" })
	vim.keymap.set("n", "[b", ui.nav_prev, { desc = "Previous Buffer" })
	vim.keymap.set("n", "<space>b", ui.toggle_quick_menu, { desc = "Toggle Buffer Manager" })
end

return M
