return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    local miniclue = require('mini.clue')
    miniclue.setup({
        triggers = {
            { mode = 'x', keys = '<Leader>' },
            { mode = 'n', keys = '<Leader>' },

            { mode = 'n', keys = '[' },
            { mode = 'n', keys = ']' },

            { mode = 'i', keys = '<C-x>' },

            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            { mode = 'n', keys = "'" },
            { mode = 'x', keys = "'" },
            { mode = 'n', keys = "`" },
            { mode = 'x', keys = "`" },

            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },

            { mode = 'n', keys = '<C-w>' },

            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
        },
        clues = {
            miniclue.gen_clues.square_brackets(),
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
        }
    })

    require('mini.bufremove').setup()
    require('mini.git').setup()
    require('mini.diff').setup({
        view = {
            style = 'sign'
        }
    })

    require('mini.statusline').setup()
    vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'MiniStatuslineInactive', { bg = 'NONE' })
  end
}
