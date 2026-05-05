return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			format_on_save = nil,
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				json = { "prettier" },
				javascript = { "prettier", stop_after_first = true },
				typescript = { "prettier", stop_after_first = true },
				vue = { "prettier", stop_after_first = true },
			},
		})

		vim.keymap.set("n", "g=", function()
			require("conform").format({ bufnr = 0 })
		end, { silent = true })
	end,
}
