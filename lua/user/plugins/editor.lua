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

			vim.keymap.set("n", "]b", ui.nav_next)
			vim.keymap.set("n", "[b", ui.nav_prev)
			vim.keymap.set("n", "<space>b", ui.toggle_quick_menu)
		end,
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup({})
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<space>.", function()
				ui.toggle_quick_menu()
			end)
			vim.keymap.set("n", "<space>ha", function()
				ui.add_file()
			end)
			vim.keymap.set("n", "<A-1>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<A-2>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<A-3>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<A-4>", function()
				ui.nav_file(4)
			end)
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
					-- todo:
					FIX = {
						icon = " ", -- icon used for the sign, and in search results
						color = "error", -- can be a hex color, or a named color (see below)
						alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fixme", "bug", "fixit", "issue" }, -- a set of other keywords that all map to this FIX keywords
						-- signs = false,
						-- configure signs for some keywords individually
					},
					TODO = { icon = " ", color = "info", alt = { "TODO", "todo" } },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warning", "warn", "xxx" } },
					PERF = {
						icon = " ",
						alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "optim", "performance", "optimize" },
					},
					NOTE = { icon = "󰌶 ", color = "hint", alt = { "INFO", "info" } },
					TEST = {
						icon = "",
						color = "test",
						alt = { "TESTING", "PASSED", "FAILED", "test", "testing", "passed", "failed" },
					},
				},
			})

			vim.keymap.set("n", "]t", function()
				tc.jump_next({ keywords = { "TODO", "FIX", "TEST" } })
			end)
			vim.keymap.set("n", "[t", function()
				tc.jump_prev({ keywords = { "TODO", "FIX", "TEST" } })
			end)
			vim.keymap.set("n", "<space>ft", "<cmd>TodoTelescope<cr>")
		end,
	},
}
