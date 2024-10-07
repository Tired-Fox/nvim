--- Global LAZY_PLUGIN_SPEC to add plugins too.
--- NOTE: All plugins should be added prior to initializing lazy.nvim
LAZY_PLUGIN_SPEC = {}

--- @param item string Name/path to the plugin spec file
function spec(item)
	table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

-- [[ Plugin Specs ]]

-- Themes
require("user.plugins.colorschemes")
-- spec("user.plugins.catppuccin")
-- spec("user.plugins.onedark")

-- Navigation
spec("user.plugins.oil")
spec("user.plugins.telescope")
spec("user.plugins.buffer_manager")
spec("user.plugins.harpoon")
spec("user.plugins.splits")

-- Database
spec("user.plugins.dbee")

-- IntelliSense
spec("user.plugins.treesitter")
spec("user.plugins.mason")
spec("user.plugins.lspconfig")
spec("user.plugins.conform")
spec("user.plugins.dap")
spec("user.plugins.cmp")
spec("user.plugins.lazydev")
spec("user.plugins.jdtls")
spec("user.plugins.rustaceannvim")
spec("user.plugins.crates")

spec("user.plugins.pairs")
spec("user.plugins.comment")
spec("user.plugins.todo_comment")
spec("user.plugins.trouble")
spec("user.plugins.whichkey")
spec("user.plugins.sleuth")
spec("user.plugins.blankline")
spec("user.plugins.bufremove")
spec("user.plugins.pqf")
spec("user.plugins.lualine")

-- Git
spec("user.plugins.gitsigns")
spec("user.plugins.neogit")
spec("user.plugins.diffview")

-- [[ Lazy.nvim ]]

require("user.plugins.lazy")
