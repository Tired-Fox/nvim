-- [[ Basic Keymaps ]]

vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

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

vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- note: neovim v0.10 this is defaulted to <c-w>d
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>E", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Open diagnostics list" })

vim.keymap.set("n", "<leader>cc", "<cmd>bwipeout<cr>", { desc = "Close current" })
vim.keymap.set("n", "<leader>ce", "<cmd>%bd|e#<cr>", { desc = "Close all but current" })
vim.keymap.set("n", "<leader>ca", "<cmd>%bd<cr>", { desc = "Close all" })

vim.keymap.set("t", "<ESC>", "<C-\\><C-N>", { desc = "Close all" })
vim.keymap.set("t", "<C-Left>", "<C-\\><C-N><C-w>h", { desc = "Close all" })
vim.keymap.set("t", "<C-Right>", "<C-\\><C-N><C-w>l", { desc = "Close all" })
vim.keymap.set("t", "<C-Up>", "<C-\\><C-N><C-w>k", { desc = "Close all" })
vim.keymap.set("t", "<C-Down>", "<C-\\><C-N><C-w>j", { desc = "Close all" })
