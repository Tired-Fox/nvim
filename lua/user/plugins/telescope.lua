return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	name = "telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-telescope/telescope-frecency.nvim",
	},
	cmd = "Telescope",
	keys = {
		{
			"<space>ff",
			function()
				require("telescope").extensions.frecency.frecency(require("telescope.themes").get_dropdown({
					previewer = false,
					prompt_title = "Find Files",
					workspace = "CWD",
				}))
			end,
			desc = "Find Files",
		},
		-- { "<space>ff", "<cmd>Telescope find_files<cr>", desc="Find Files" },
		--telescope.builtin
		{ "<space>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<space>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<space>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current Buffer Fuzzy Find" },
		{ "<space>?", "<cmd>Telescope oldfiles<cr>", desc = "Old Files" },

		{ "<space>gw", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
	},
	config = function()
		require("user.telescope")
	end,
}
