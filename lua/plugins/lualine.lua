local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	local icons = require("user.icons")
	local ll = require("lualine")

	local mode = {
		"mode",
		fmt = function(str)
			return str:sub(1, 1)
		end,
	}

	local diff = {
		"diff",
		colored = false,
		symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
	}

	local diagnostics = {
		"diagnostics",
		sections = { "error", "warn" },
		colored = false, -- Displays diagnostics status in color if set to true.
		-- always_visible = true, -- Show diagnostics even if there are none.
	}

	ll.setup({
		options = {
			theme = "auto",
			icons_enabled = true,
			-- component_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			-- section_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "oil", "term" },
				winbar = {},
			},
			always_divide_middle = true,
			refresh = {
				statusline = 1000,
			},
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { "branch" },
			lualine_c = { diff, diagnostics, "filename" },
			lualine_x = { "filetype" },
			lualine_y = {},
			lualine_z = { "progress" },
		},
		extensions = { "nvim-dap-ui", "trouble", "toggleterm" },
	})
end

return M
