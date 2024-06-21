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
			vim.keymap.set("n", "<space>b", ui.toggle_quick_menu, { desc = "Toggle Buffer Manager" })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		keys = {
			{
				"<space>hh",
				function()
					require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
				end,
				desc = "Toggle Harpoon Quick Menu",
			},
			{
				"<space>ha",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Add Buffer to Harpoon",
			},
			{
				"<A-1>",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Select Harppon 1",
			},
			{
				"<A-2>",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Select Harpoon 2",
			},
			{
				"<A-3>",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Select Harpoon 3",
			},
			{
				"<A-4>",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Select Harpoon 4",
			},
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon.setup({})
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
			vim.keymap.set("n", "<space>c", function()
				require("mini.bufremove").wipeout(0)
			end, { desc = "Close Buffer" })
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
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<space>ld",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<space>lD",
				"<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<space>ls",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<space>ll",
				"<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<space>L",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<space>Q",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		opts = {
			auto_close = true,
			-- focus = true,
			-- preview = {
			-- 	type = "split",
			-- 	scratch = true,
			-- },
		}, -- for default options, refer to the configuration section for custom setup.
	},
	{
		"mrjones2014/smart-splits.nvim",
		config = function()
			-- recommended mappings
			-- resizing splits
			-- these keymaps will also accept a range,
			-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
			vim.keymap.set("n", "<C-A-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<C-A-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<C-A-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<C-A-l>", require("smart-splits").resize_right)
			-- moving between splits
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
			vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
			-- swapping buffers between windows
			vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
			vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
			vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
			vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
		end,
	},
}
