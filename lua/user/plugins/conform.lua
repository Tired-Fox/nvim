-- Autoformatting
local M = {
	"stevearc/conform.nvim",
	name = "conform",
}

local formatters = {
	lua = { "stylua" },
	html = { "prettierd", "prettier" },
	zig = { "zigfmt" },
}

local ignore = {
	"zig",
}

function M.config()
	require("conform").setup({
		formatters_by_ft = formatters,
		format_on_save = function(bufnr)
			-- Disable autoformat on certain filetypes
			if
				vim.g.disable_autoformat
				or vim.b[bufnr].disable_autoformat
				or not formatters[vim.bo[bufnr].filetype]
				or vim.tbl_contains(ignore, vim.bo[bufnr].filetype)
			then
				return
			end

			-- Disable autoformat for files in a certain path
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end

			-- ...additional logic...
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	})

	vim.api.nvim_create_user_command("Format", function(args)
		local range = nil
		if args.count ~= -1 then
			local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
			range = {
				start = { args.line1, 0 },
				["end"] = { args.line2, end_line:len() },
			}
		end
		require("conform").format({ async = true, lsp_format = "fallback", range = range })
	end, { range = true })

	vim.keymap.set("n", "<leader>lf", "<cmd>Format<cr>", { desc = "Format" })
end

return M
