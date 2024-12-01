local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = {
		{
			"<space>hh",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "Toggle Harpoon Quick Menu",
		},
		{
			"<space>ha",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add Buffer to Harpoon",
		},
		{
			"<A-1>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Select Harppon 1",
		},
		{
			"<A-2>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Select Harpoon 2",
		},
		{
			"<A-3>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Select Harpoon 3",
		},
		{
			"<A-4>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Select Harpoon 4",
		},
	},
}

function M.config()
	local harpoon = require("harpoon")
	harpoon.setup({})
end

return M
