local M = {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	tag = "0.1.8",
	name = "telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Use fzf from the system
		"nvim-telescope/telescope-fzy-native.nvim",
		-- Search files based on file access frequency and pattern match
		"nvim-telescope/telescope-frecency.nvim",
		-- Use telescop in place of built-in nvim select menu
		"nvim-telescope/telescope-ui-select.nvim",
	},
	cmd = "Telescope",
}

function M.config()
	local open_with_trouble = function(bufnr)
		require("trouble.sources.telescope").open(bufnr, {
			focus = true,
			preview = {
				type = "split",
				relative = "win",
				position = "right",
				size = 0.4,
			},
		})
	end

	require("telescope").setup({
		defaults = {
			mappings = {
				i = { ["<c-t>"] = open_with_trouble },
				n = { ["<c-t>"] = open_with_trouble },
			},
			-- path_display = { truncate = 13 },
			-- path_display = { "smart" },
			path_display = {
				shorten = {
					len = 3,
					exclude = { 1, -1 },
				},
			},

			prompt_prefix = "   ",
			selection_caret = " ",
			entry_prefix = " ",
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
				},
				width = 0.87,
				height = 0.80,
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
			frecency = {
				workspaces = {
					["conf"] = vim.fn.stdpath("config"),
					["data"] = vim.fn.stdpath("data"),
				},
				ignore_patterns = {
					"*.git/*",
					"*.git\\*",
				},
				db_safe_mode = false,
				auto_validate = true,
			},
		},
		pickers = {
			frecency = {
				theme = "dropdown",
			},
			find_files = {
				theme = "dropdown",
				previewer = false,
			},
			current_buffer_fuzzy_find = {
				theme = "dropdown",
			},
			oldfiles = {
				theme = "dropdown",
			},
		},
	})

	pcall(require("telescope").load_extension, "frecency")
	pcall(require("telescope").load_extension, "ui-select")

	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "<space>ff", function()
		require("telescope").extensions.frecency.frecency(require("telescope.themes").get_dropdown({
			previewer = false,
			prompt_title = "Find Files",
			workspace = "CWD",
		}))
	end, { desc = "Find Files" })
	vim.keymap.set("n", "<space>fh", builtin.help_tags, { desc = "Help Tags" })
	vim.keymap.set("n", "<space>fg", builtin.live_grep, { desc = "Live Grep" })
	vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, { desc = "Current Buffer Fuzzy Find" })
	vim.keymap.set("n", "<space>?", builtin.oldfiles, { desc = "Old Files" })

	vim.keymap.set("n", "<space>gw", builtin.grep_string, { desc = "Grep String" })
end

return M
