local M = {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = {
    { 'echasnovski/mini.icons', opts = {} },
  },
}

function M.config()
  require('oil').setup {}

  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
end

return M
