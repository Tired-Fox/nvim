local M = {
	"echasnovski/mini.bufremove",
	version = "*",
}

function M.config()
	require("mini.bufremove").setup({})
	vim.keymap.set("n", "<leader>q", function()
		require("mini.bufremove").wipeout(0)
	end, { desc = "Close Buffer" })
end

return M
