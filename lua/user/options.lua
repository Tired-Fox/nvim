-- [[ Configure options ]]
local configuration = {
  g = {
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
    listchars = { tab = '» ', trail = '·', nbsp = '␣' },
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
    timeoutlen = 300,
    -- Set completeopt to have a better completion experience
    completeopt = 'menuone,noselect',
    -- NOTE: You should make sure your terminal supports this
    termguicolors = true,
  },
  -- Window scoped options
  wo = {
    -- Make line numbers default
    number = true,
    -- Keep signcolumn on by default
    signcolumn = 'yes',
  },
}

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- [[ Set options ]]
-- Options are automatically built
for category, cvalue in pairs(configuration) do
  -- This outer iteration is the opt, o, and wo which equals vim.opt, etc...
  for option, value in pairs(cvalue) do
    -- This inner iteration is each option per option
    vim[category][option] = value
  end
end
