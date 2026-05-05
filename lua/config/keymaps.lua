vim.keymap.set('n', '-', ":Oil<CR>")
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', "<leader>xc", function() MiniBufremove.delete() end)

-- Deal with word wrapping
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move line or selection up and down
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('n', '<A-j>', ':m .+1<cr>==', { desc = 'Move selection down' })
vim.keymap.set('n', '<A-k>', ':m .-2<cr>==', { desc = 'Move selection down' })
vim.keymap.set('i', '<A-j>', '<ESC>:m .+1<cr>==gi', { desc = 'Move selection down' })
vim.keymap.set('i', '<A-k>', '<ESC>:m .-2<cr>==gi', { desc = 'Move selection down' })

-- Indent without loosing selection
vim.keymap.set('v', '>', '>gv', { desc = 'Indent Selection' })
vim.keymap.set('v', '<', '<gv', { desc = 'Dedent Selection' })

vim.keymap.set('n', ']t', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Mappings related to code folding
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end)

local function allModeMap(key, action, desc)
    vim.keymap.set({ 'n', 'v', 'x' }, key, action, { desc = desc })
end

-- Debug bindings
allModeMap('<F5>', function() require('dap').continue() end, 'Debug: Start/Continue')
allModeMap('<F6>', function() require('dapui').toggle() end, 'Debug: Start/Continue')
allModeMap('<F7>', function() require('dap').step_into() end, 'Debug: Step Into')
allModeMap('<F8>', function() require('dap').step_over() end, 'Debug: Step Over')
allModeMap('<F9>', function() require('dap').step_out() end, 'Debug: Step Out')
allModeMap('<leader>db', function() require('dap').toggle_breakpoint() end, 'Debug: Toggle Breakpoint')
allModeMap('<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
    'Debug: Set Breakpoint')
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
allModeMap('<F1>', function() require('dapui').toggle() end, 'Debug: See last session result')
