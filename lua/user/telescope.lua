require("telescope").setup({
	extensions = {
		frecency = {
			workspaces = {
				["nconf"] = vim.fn.stdpath("config"),
				["ndata"] = vim.fn.stdpath("data"),
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
end)
-- vim.keymap.set("n", "<space>ff", builtin.find_files)
vim.keymap.set("n", "<space>fh", builtin.help_tags)
vim.keymap.set("n", "<space>fg", builtin.live_grep)
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<space>?", builtin.oldfiles)

vim.keymap.set("n", "<space>gw", builtin.grep_string)

vim.keymap.set("n", "<space>fa", function()
	builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end)

vim.keymap.set("n", "<space>en", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)
