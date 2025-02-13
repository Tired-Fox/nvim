-- REFERENCE: https://github.com/pmizio/typescript-tools.nvim
local M = {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
}

function M.config()
  require('typescript-tools').setup {
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',

      'vue',
    },
    settings = {
      tsserver_plugins = {
        -- NOTE: Ensure this is installed globally
        '@vue/typescript-plugin',
      },
    },
  }
end

return M
