return {
	"tpope/vim-sleuth",
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "┆" },
			scope = {
				enabled = false,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			require("user.treesitter")
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"j-morano/buffer_manager.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local bufman = require("buffer_manager")
			local ui = require("buffer_manager.ui")

			bufman.setup({
				select_menu_item_commands = {
					v = {
						key = "<C-v>",
						command = "vsplit",
					},
					h = {
						key = "<C-h>",
						command = "split",
					},
				},
			})

			vim.keymap.set("n", "]b", ui.nav_next, { desc = "Next Buffer" })
			vim.keymap.set("n", "[b", ui.nav_prev, { desc = "Previous Buffer" })
			vim.keymap.set("n", "<space>bb", ui.toggle_quick_menu, { desc = "Toggle Buffer Manager" })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		config = function()
			local harpoon = require("harpoon")
			harpoon.setup({})

			vim.keymap.set("n", "<space>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Toggle Harpoon Quick Menu" })
			vim.keymap.set("n", "<space>ha", function()
				harpoon:list():add()
			end, { desc = "Add Buffer to Harpoon" })
			vim.keymap.set("n", "<A-1>", function()
				harpoon:list():select(1)
			end, { desc = "Select Harppon 1" })
			vim.keymap.set("n", "<A-2>", function()
				harpoon:list():select(2)
			end, { desc = "Select Harpoon 2" })
			vim.keymap.set("n", "<A-3>", function()
				harpoon:list():select(3)
			end, { desc = "Select Harpoon 3" })
			vim.keymap.set("n", "<A-4>", function()
				harpoon:list():select(4)
			end, { desc = "Select Harpoon 4" })
		end,
	},
	"kevinhwang91/nvim-bqf",
	{
		"yorickpeterse/nvim-pqf",
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local tc = require("todo-comments")

			tc.setup({
				keywords = {
					-- TODO:
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false,
						-- configure signs for some keywords individually FIX this so TODO comments are not highlighted where they are a BUG
					},
					TODO = { icon = " ", color = "info", alt = { "TODO" } },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = {
						icon = " ",
						alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
					},
					NOTE = { icon = "󰌶 ", color = "hint", alt = { "INFO" } },
					TEST = {
						icon = "",
						color = "test",
						alt = { "TESTING", "PASSED", "FAILED" },
					},
				},
				highlight = {
					before = "fg",
					comments_only = true,
					pattern = [[-- <(KEYWORDS)\s*:]],
				},
			})

			vim.keymap.set("n", "]t", function()
				tc.jump_next({ keywords = { "TODO", "FIX", "TEST" } })
			end, { desc = "Next Todo" })
			vim.keymap.set("n", "[t", function()
				tc.jump_prev({ keywords = { "TODO", "FIX", "TEST" } })
			end, { desc = "Previous Todo" })
			vim.keymap.set("n", "<space>ft", "<cmd>TodoTelescope<cr>", { desc = "Todo Telescope" })
		end,
	},
	{
		"echasnovski/mini.bufremove",
		version = "*",
		config = function()
			require("mini.bufremove").setup({})
			vim.keymap.set("n", "<space>bc", function()
				require("mini.bufremove").wipeout(0)
			end, { desc = "Close buffer" })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("user.lualine")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("user.whichkey")
		end,
	},
}
