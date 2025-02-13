local M = {
  'mfussenegger/nvim-jdtls',
  ft = { 'java' },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
}

function M.config(...)
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values

  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local jdtls = require 'jdtls'

  --- Pick a java runtime from jdtls and set it as the active runtime
  --- @reference: https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#introduction
  function JavaRuntimes(opts)
    opts = opts or {}
    pickers
      .new(opts, {
        prompt_title = 'Java Runtimes',
        finder = finders.new_dynamic {
          entry_maker = opts.entry_maker or function(entry)
            local pretty = entry:gsub('-', ' '):gsub('SE', '')
            return {
              value = entry,
              display = pretty,
              ordinal = pretty,
            }
          end,
          fn = function()
            local runtimes = jdtls._complete_set_runtime()
            if type(runtimes) ~= 'table' then
              local _runtimes = {}
              for runtime in runtimes:gmatch '[^\r\n]+' do
                table.insert(_runtimes, runtime)
              end
              runtimes = _runtimes
            end
            return runtimes
          end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.notify('Setting jdtls java runtime to ' .. selection.value, vim.log.levels.INFO)
            jdtls.set_runtime(selection.value)
          end)
          return true
        end,
      })
      :find()
  end

  -- to execute the function
  -- JavaRuntimes(require("telescope.themes").get_dropdown({}))

  local overrides = {
    -- This puts the java arguments in an arguments file: Only for java versions 9+
    -- shortenCommandLine = "argfile",
    -- This creates a jar manifest that contains the classpath and java arguments works with most if not all  java versions
    shortenCommandLine = 'jarmanifest',
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    pattern = '*.java',
    callback = function()
      vim.keymap.set('n', '<space>tm', function()
        vim.print 'Testing nearest test method'
        jdtls.test_nearest_method {
          config_overrides = overrides,
        }
      end, { buffer = 0, desc = 'Test nearest method' })
      vim.keymap.set('n', '<space>tc', function()
        vim.print 'Testing entire test class'
        jdtls.test_class {
          config_overrides = overrides,
        }
      end, { buffer = 0, desc = 'Test class' })
    end,
  })

  -- create autocmd to load main class configs on LspAttach.
  -- This ensures that the LSP is fully attached.
  -- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
  vim.api.nvim_create_autocmd('LspAttach', {
    pattern = '*.java',
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      -- ensure that only the jdtls client is activated
      if client.name == 'jdtls' then
        require('jdtls.dap').setup_dap_main_class_configs()
      end
    end,
  })
end

return M
