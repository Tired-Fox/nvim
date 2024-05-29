local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<space>la", function()
	vim.cmd.RustLsp("codeAction")
end, { silent = true, buffer = bufnr, desc = "Code Action" })
