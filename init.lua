-- Set local leader
-- Set leader
vim.api.nvim_set_keymap("", "<localleader>", "<nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- Global LAZY_PLUGIN_SPEC to add plugins too.
--- NOTE: All plugins should be added prior to initializing lazy.nvim
LAZY_PLUGIN_SPEC = {
	{ "echasnovski/mini.icons", version = "*", name = "mini.icons", opts = {} },
	"nvim-lua/plenary.nvim",
	"tpope/vim-sleuth",
	"tpope/vim-abolish",
}

--- @param item string Name/path to the plugin spec file
local function spec(item)
	table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

-- Load configurations
require("user.options")
require("user.keymaps")
require("user.autocmds")

spec("plugins.catppuccin")
spec("plugins.oil")
spec("plugins.pairs")
spec("plugins.telescope")
spec("plugins.buffer_manager")
spec("plugins.harpoon")
spec("plugins.splits")
spec("plugins.trouble")

spec("plugins.treesitter")
spec("plugins.treesitter_context")
spec("plugins.autotag")
spec("plugins.mason")
spec("plugins.lspconfig")
spec("plugins.cmp")
spec("plugins.dap")
spec("plugins.conform")

spec("plugins.lazydev")
spec("plugins.rustacean")
spec("plugins.crates")
spec("plugins.jdtls")
spec("plugins.nuxt_goto")

spec("plugins.ufo")
spec("plugins.lualine")
spec("plugins.pqf")
spec("plugins.blankline")
spec("plugins.whichkey")
spec("plugins.todo")

spec("plugins.neogit")
spec("plugins.diffview")
spec("plugins.gitsigns")

spec("plugins.toggleterm")
-- TODO: DBee

-- Bootstrap and load plugins
require("user.lazy")
