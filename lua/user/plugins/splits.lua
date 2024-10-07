local M = { "mrjones2014/smart-splits.nvim" }

function M.config()
	-- recommended mappings
	-- resizing splits
	-- these keymaps will also accept a range,
	-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
	vim.keymap.set("n", "<C-A-h>", require("smart-splits").resize_left)
	vim.keymap.set("n", "<C-A-j>", require("smart-splits").resize_down)
	vim.keymap.set("n", "<C-A-k>", require("smart-splits").resize_up)
	vim.keymap.set("n", "<C-A-l>", require("smart-splits").resize_right)
	-- moving between splits
	-- vim.keymap.set("n", "<C-H>", require("smart-splits").move_cursor_left)
	-- vim.keymap.set("n", "<C-J>", require("smart-splits").move_cursor_down)
	-- vim.keymap.set("n", "<C-K>", require("smart-splits").move_cursor_up)
	-- vim.keymap.set("n", "<C-L>", require("smart-splits").move_cursor_right)
	vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
	-- swapping buffers between windows
	vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
	vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
	vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
	vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
end

return M
