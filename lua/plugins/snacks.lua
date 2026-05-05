return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    { '<leader>sf', function() Snacks.picker.files({ layout='vscode' }) end, desc="[S]earch [F]iles" },
    { '<leader>si', function() Snacks.picker.icons() end, desc="[S]earch [I]cons" },
    { '<leader>sm', function() Snacks.picker.marks() end, desc="[S]earch [M]arks" },
    { '<leader>/', function() Snacks.picker.grep({ layout='vertical' }) end, desc="Search Grep" },
    { '<leader>e', function() Snacks.explorer() end, desc="[E]xplorer" },

    { '<leader>gor', function() Snacks.gitbrowse({ what='repo' }) end, desc="[G]it [Open] [R]epo" },
    { '<leader>gob', function() Snacks.gitbrowse({ what='branch' }) end, desc="[G]it [Open] [B]ranch" },
    { '<leader>goB', function() Snacks.input({ prompt='Branch'}, function(text) Snacks.gitbrowse({ what='branch', branch=text }) end) end, desc="[G]it [Open] [B]ranch (Input)" },
    { '<leader>gof', function() Snacks.gitbrowse({ what='file' }) end, desc="[G]it [Open] [F]ile" },
    { '<leader>goF', function() Snacks.input({ prompt='Branch'}, function(text) Snacks.gitbrowse({ what='file', branch=text }) end) end, desc="[G]it [Open] [F]ile (Input)" },

    { '<leader>.', function() Snacks.scratch() end, desc="Toggle Scratch Buffer" },
    { '<leader>ss', function() Snacks.scratch.select() end, desc="[S]elect [S]ratch" },

    { '<leader>t', function() Snacks.terminal.toggle() end, desc="[T]erminal" },
    { '<leader>r', function()
        Snacks.input({ prompt='CMD' }, function(text) Snacks.terminal.toggle(text, { auto_close=false, win={style='split'} }) end)
    end, desc="[R]un Command" },
  },
  opts = {
    indent = {
      char = "│",
      animate = { enabled = false }
    },
    gitbrowse = {
        remote_patterns = {
            { "^ssh://git@git.menards.net:7999/([^/]+)/([^/]+).git", "https://git.menards.net/projects/%1/repos/%2" }
        },
        url_patterns = {
            ['git.menards.net'] = {
                repo = '/browse',
                branch = '/browse?at={branch}',
                file = '/browse/{file}?at={branch}#{line_start}-{line_end}',
                commit = '/browse/{file}?until={commit}&untilPath={file}&at={branch}'
            }
        },
    },
    picker = {
      formatters = {
        file = {
            filename_first = true,
            truncate = 'center',
        }
      }
    },
    statuscolumn = {
        left = { "mark", "sign" },
        right = { "fold", "git" },
        folds = {
            open = false,
            git_hl = false,
        },
        refresh = 50,
    },
    terminal = {
        shell = { "pwsh", '-NoLogo' }
    }
  }
}
