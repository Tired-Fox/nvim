-- Autoformatting Setup
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		html = { "prettierd", "prettier" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		require("conform").format({
			bufnr = args.buf,
			lsp_fallback = false,
			quiet = true,
		})
	end,
})
