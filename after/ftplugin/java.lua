vim.opt_local.colorcolumn = '120'
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true

-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/site/java/workspace-root/' .. project_name
vim.fn.mkdir(workspace_dir, 'p')

-- validate operating system
if not (vim.fn.has 'mac' == 1 or vim.fn.has 'unix' == 1 or vim.fn.has 'win32' == 1) then
  vim.notify('jdtls: Could not detect valid OS', vim.log.levels.ERROR)
end

local jdt_config_path = vim.fn.stdpath 'config' .. '/.java.settings.prefs'

local config = {
  name = "jdtls",
  cmd = {
    -- java-path
    vim.fn.expand '~/Java/openjdk-21.0.5/bin/java.exe',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. vim.fn.expand '$MASON/share/jdtls/lombok.jar',
    '-jar',
    vim.fn.expand '$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration',
    vim.fn.expand '$MASON/share/jdtls/config',
    '-data',
    workspace_dir,
  },
  root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', '.project' }),
  settings = {
    java = {
      settings = {
        url = jdt_config_path,
      },
      eclipse = { downloadSources = true },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = 'JavaSE-1.8',
            -- java-path
            path = vim.fn.expand '~/Java/openjdk-8u432',
          },
          {
            name = 'JavaSE-21',
            -- java-path
            path = vim.fn.expand '~/Java/openjdk-21.0.5',
            default = true,
          },
        },
      },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      inlayHints = { parameterNames = { enabled = 'all' } },
      format = {
        settings = {
          url = vim.fn.stdpath 'config' .. '/CodeStyle.xml',
        },
      },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.mockito.Mockito.*',
        },
        importOrder = {
          'java',
          'javax',
          'jakarta',
          'com',
          'de',
          'feign',
          'io',
          'lombok',
          'net',
          'nz',
          'okio',
          'okhttp3',
          'org',
          'reactor',
          'redis',
          'com.menards',
          '*',
        },
        guessMethodArguments = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
  init_options = {
    bundles = {
      vim.fn.expand '$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar',
      -- unpack remaining bundles
      (table.unpack or unpack)(vim.split(vim.fn.glob '$MASON/share/java-test/*.jar', '\n', {})),
      (table.unpack or unpack)(
        vim.split(vim.fn.glob(vim.fn.expand('~/scoop/persist') .. '/vscode/data/extensions/vscjava.vscode-java-test-*/server/*.jar'), '\n', {})
      ),
    },
  },
  -- handlers = {
  --   ['$/progress'] = function() end, -- disable progress updates.
  -- },
  filetypes = { 'java' },
  on_attach = function()
    require('jdtls').setup_dap { hotcodereplace = 'auto' }
  end,
}

require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<C-A>o', function()
  require('jdtls').organize_imports()
end, { desc = 'Open Cargo.toml', buffer = vim.api.nvim_get_current_buf() })

local overrides = {
    -- This puts the java arguments in an arguments file: Only for java versions 9+
    shortenCommandLine = "argfile",
    -- This creates a jar manifest that contains the classpath and java arguments works with most if not all  java versions
    -- shortenCommandLine = 'jarmanifest',
}

vim.keymap.set('n', '<space>tm', function()
    vim.print 'Testing nearest test method'
    require('jdtls').test_nearest_method {
        config_overrides = overrides,
    }
end, { buffer = 0, desc = 'Test nearest method' })
vim.keymap.set('n', '<space>tc', function()
    vim.print 'Running tests for the entire test class'
    require('jdtls').test_class {
        config_overrides = overrides,
    }
end, { buffer = 0, desc = 'Test class' })
