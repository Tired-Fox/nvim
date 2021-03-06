local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>AerialToggle<cr>", "Aerial" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["c"] = { "<cmd>Bdelete!<cr>" , "Close" },
  ["D"] = { "<cmd>lua require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Diagnostics" },
  ["d"] = { "<cmd>lua require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown{previewer = false, bufnr = 0})<cr>", "Diagnostics" },
  ["e"] = {"<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["F"] = { "<cmd>Telescope find_files<cr>", "Files" },
  ["f"] = { "<cmd>lua require('telescope.builtin').live_grep{ search_dirs={\"%:P\"}}<cr>", "find" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No HL" },
  ["n"] = { "<cmd>enew<cr>", "New Blank Buff" },
  ["s"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
  ["q"] = { "<cmd>q!<cr>", "Quit" },
  ["w"] = { "<cmd>w!<cr>", "Save" },
  ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  g = {
    name = "git",
    l = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
  },
  t = {
    name = "Terminal",
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    b = { "<cmd>lua _BOTTOM_TOGGLE()<cr>", "Bottom" },
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  T = {
    name = "Telescope",
    --t = { "<cmd>", "tags" },
    f = { "<cmd>Telescope filetypes theme=dropdown<cr>", "File Types" },
    k = { "<cmd>Telescope keymaps<cr>", "Key Maps" },
    c = { "<cmd>Telescope colorscheme theme=dropdown<cr>", "Color Schemes" },
    m = { "<cmd>Telescope man_pages<cr>", "Manpages" },
    p = { "<cmd>Telescope planets<cr>", "Planets" },
  },
  L = {
    name = "LSP",
    I = { "<cmd>LspInstallInfo<cr>", "Lsp Installer" },
    i = { "<cmd>LspInfo<cr>", "Lsp Info" },
  }
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
  s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
