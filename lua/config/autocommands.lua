-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Lint on save
vim.api.nvim_create_autocmd({ 'BufWritePost', 'LSPAttach' }, {
  desc = 'Lint the file on write',
  group = vim.api.nvim_create_augroup('lint-on-write', { clear = true }),
  callback = function()
    local ok, lint = pcall(require, 'lint')
    if ok then
      lint.try_lint()
    end
  end,
})
