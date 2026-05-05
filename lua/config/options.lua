local Options = {
  g = {
    mapleader = " ",
    maplocalleader = "\\",
    zig_fmt_autosave = 0,
  },
  opt = {
    foldcolumn = '1', -- '0' is not bad
    foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
    foldlevelstart = 99,
    foldenable = true,
    fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
    -- conceallevel = 3,
    -- Alwasy use spaces for tabs
    expandtab = true,
    -- Set tab look
    tabstop = 4,
    shiftwidth = 4,
    autoindent = true,
    smartindent = true,
    -- cindent = true,
    -- set number line width {defaults to 4}
    numberwidth = 3,
    backup = false,
    undofile = true, -- enable persistent undo
    swapfile = false,
    writebackup = false,
    splitright = true,
    splitbelow = true,

    list = true,
    listchars = {
        tab = '» ',
        trail = '·',
        nbsp = '␣'
    },
    inccommand = 'split',
    scrolloff = 10,

    fileformat = 'unix',
    foldmethod = 'expr',
    foldexpr = 'v:lua.vim.treesitter.foldexpr()',
    foldtext = 'v:lua.vim.treesitter.foldtext()',
  },
  -- Like writing `:setglobal`
  -- go = {},
  -- Like writing `:set`
  o = {
    winborder = "rounded",
    cmdheight = 1,
    -- Set highlight on search
    hlsearch = false,
    -- Enable mouse mode
    mouse = 'a',
    relativenumber = false,
    -- Enable break indent
    breakindent = true,
    -- Save undo history
    undofile = true,
    -- Case-insensitive searching UNLESS \C or capital in search
    ignorecase = true,
    smartcase = true,
    -- Decrease update time
    updatetime = 250,
    timeout = true,
    timeoutlen = 1000,
    -- Set completeopt to have a better completion experience
    completeopt = 'menuone,noselect',
    -- NOTE: You should make sure your terminal supports this
    termguicolors = true,
    clipboard = "unnamedplus",
  },
  -- Window scoped options
  wo = {
    -- Make line numbers default
    number = true,
    -- Keep signcolumn on by default
    signcolumn = 'yes',
  },
}

for scope, options in pairs(Options) do
  for name, value in pairs(options) do
    vim[scope][name] = value
  end
end
