local M = {
	"windwp/nvim-ts-autotag",
}

M.config = function()
	require("nvim-ts-autotag").setup({
		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = false,
		},
		per_filetype = {
			-- ["html"] = {
			-- 	enable_close = false
			-- }
		},
	})

	-- Update on insert
	-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	-- 	underline = true,
	-- 	virtual_text = {
	-- 		spacing = 5,
	-- 		severity_limit = "Warning",
	-- 	},
	-- 	update_in_insert = true,
	-- })
end

return M
