local M = {
  'stevearc/oil.nvim',
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  }
}

function M.config()
  require('oil').setup({
    columns = {
      "icon",
      "permissions",
    }
  })

  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

return M
