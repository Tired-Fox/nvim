local M = {
	"saecki/crates.nvim",
	tag = "stable",
	event = { "BufRead Cargo.toml" },
	-- dependencies = { "whichkey" },
}

function M.config()
	local crates = require("crates")
	crates.setup({
		popup = {
			autofocus = true,
			border = "rounded",
		},
	})

	local wok, which_key = pcall(require, "which-key")
	if wok then
		which_key.add({ { { "<leader>c", group = "Crates" } }, mode = "n" })
	end

	vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Toggle", silent = true })
	vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload", silent = true })

	vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Show Version", silent = true })
	vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show Features", silent = true })
	vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Show Dependencies", silent = true })

	vim.keymap.set("n", "<leader>cu", crates.update_crate, { desc = "Update Crate", silent = true })
	vim.keymap.set("v", "<leader>cu", crates.update_crates, { desc = "Update Crates", silent = true })
	vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, { desc = "Update All Crates", silent = true })

	vim.keymap.set(
		"n",
		"<leader>cx",
		crates.expand_plain_crate_to_inline_table,
		{ desc = "Expand into inline table", silent = true }
	)
	vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, { desc = "Extract into table", silent = true })

	vim.keymap.set("n", "<leader>cH", crates.open_homepage, { desc = "Homepage", silent = true })
	vim.keymap.set("n", "<leader>cR", crates.open_repository, { desc = "Repository", silent = true })
	vim.keymap.set("n", "<leader>cD", crates.open_documentation, { desc = "Documentation", silent = true })
	vim.keymap.set("n", "<leader>cC", crates.open_crates_io, { desc = "Crates.io", silent = true })
	vim.keymap.set("n", "<leader>cL", crates.open_lib_rs, { desc = "Lib.rs", silent = true })
end

return M
