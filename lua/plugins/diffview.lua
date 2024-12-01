local M = {
	"sindrets/diffview.nvim",
	name = "diffview",
	cmd = "DiffviewOpen",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	require("diffview").setup({
		view = {
			merge_tool = {
				layout = "diff3_mixed",
				disable_diagnostics = true,
				winbar_info = true,
			},
		},
		hooks = {},
	})
end

return M
