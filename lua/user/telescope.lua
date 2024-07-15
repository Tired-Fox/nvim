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
	},
	extensions = {
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
		grep_string = {
			theme = "dropdown",
		},
		live_grep = {
			theme = "dropdown",
		},
		oldfiles = {
			theme = "dropdown",
		},
	},
})

-- pcall(require("telescope").load_extension, "fzy_native")
pcall(require("telescope").load_extension, "frecency")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<space>ff", function()
	require("telescope").extensions.frecency.frecency(
		require("telescope.themes").get_dropdown({ previewer = false, prompt_title = "Find Files", workspace = "CWD" })
	)
end, { desc = "Find Files" })
-- vim.keymap.set("n", "<space>ff", builtin.find_files)
vim.keymap.set("n", "<space>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<space>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, { desc = "Current Buffer Fuzzy Find" })
vim.keymap.set("n", "<space>?", builtin.oldfiles, { desc = "Old Files" })

vim.keymap.set("n", "<space>gw", builtin.grep_string, { desc = "Grep String" })

-- vim.keymap.set("n", "<space>fa", function()
-- 	builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
-- end, { desc = "Find Nvim Data Files" })

-- vim.keymap.set("n", "<space>en", function()
-- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
-- end, { desc = "Find Nvim Config Files" })
