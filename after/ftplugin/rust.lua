local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>la", function()
	vim.cmd.RustLsp("codeAction")
end, { silent = true, buffer = bufnr, desc = "Code Action" })
vim.keymap.set("n", "K", function()
	vim.cmd.RustLsp("hover", "actions")
end, { silent = true, buffer = bufnr, desc = "Hover Actions" })

vim.keymap.set(
	"v",
	"<leader>lj",
	"<cmd>'<,'>RustLsp joinLines<cr>",
	{ silent = true, buffer = bufnr, desc = "Join Lines" }
)

vim.keymap.set({ "n", "v" }, "<leader>lc", function()
	vim.cmd.RustLsp("openCargo")
end, { silent = true, buffer = bufnr, desc = "Open Cargo.toml" })
