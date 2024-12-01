local M = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
}

function M.config()
	require("catppuccin").setup({
		background = { -- :h background
			light = "latte",
			dark = "macchiato",
		},
		integrations = {
			cmp = true,
			gitsigns = true,
			treesitter = true,
			notify = false,
			-- mini = {
			--     enabled = true,
			--     indentscope_color = "",
			-- },
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	})

	vim.cmd.colorscheme("catppuccin")
end

return M
