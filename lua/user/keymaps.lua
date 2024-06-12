-- [[ Basic Keymaps ]]

-- Set local leader
vim.api.nvim_set_keymap("", "<LocalLeader>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move line or selection up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { desc = "Move selection down" })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { desc = "Move selection down" })
vim.keymap.set("i", "<A-j>", "<ESC>:m .+1<cr>==gi", { desc = "Move selection down" })
vim.keymap.set("i", "<A-k>", "<ESC>:m .-2<cr>==gi", { desc = "Move selection down" })

-- Indent without loosing selection
vim.keymap.set("v", ">", ">gv", { desc = "Indent Selection" })
vim.keymap.set("v", "<", "<gv", { desc = "Dedent Selection" })

vim.keymap.set("n", "<space>q", "<cmd>q<cr>", { desc = "Quit" })

-- Diagnostic keymaps
-- note: neovim v0.10 these are defaults
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- note: neovim v0.10 this is defaulted to <c-w>d
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
