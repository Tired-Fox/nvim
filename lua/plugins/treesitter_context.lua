local M = {
	"nvim-treesitter/nvim-treesitter-context",
}

function M.config()
	require("treesitter-context").setup({
		enable = false,
		max_lines = 4, -- max lines the window should span
		min_window_height = 0, -- min editor window height
		line_numbers = true, -- show line numbers
		multiline_threshold = 20, -- max lines for single context
		trim_scope = "outer", -- trim scope lines if max_lines is exceeded
		mode = "cursor", -- Line used to calc context
		seperator = nil, -- separator between context and content
		zindex = 20, -- zindex of the floating window
		on_attach = nil,
	})
end

return M
