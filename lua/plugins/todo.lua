local M = {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
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

	vim.keymap.set("n", "<space>ft", "<cmd>TodoTelescope<cr>", { desc = "Todo Telescope" })
end

return M
