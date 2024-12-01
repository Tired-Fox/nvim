local M = {
  'stevearc/oil.nvim',
  dependencies = {
    "mini.icons",
  }
}

function M.config()
  require('oil').setup({
    columns = {
      "icon",
      "permissions",
    }
  })

  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil" })
end

return M
