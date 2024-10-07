local M = {
	"kndndrj/nvim-dbee",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{ "MattiasMTS/cmp-dbee", ft = "sql" },
	},
	build = function()
		-- Install tries to automatically detect the install method.
		-- if it fails, try calling it with one of these parameters:
		--    "curl", "wget", "bitsadmin", "go"
		require("dbee").install("wget")
	end,
}

function M.config()
	require("dbee").setup(--[[optional config]])
	vim.keymap.set("n", "<space>D", function()
		require("dbee").toggle()
	end, { desc = "Toggle Dbee" })
end

return M
