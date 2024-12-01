local M = {
	"hrsh7th/nvim-cmp",
	lazy = false,
	priority = 100,
	dependencies = {
		"mini.icons",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",
	},
}

function M.config()
	require("snippets")

	local utils = require("user.utils")

	vim.opt.completeopt = { "menu", "menuone", "noselect" }
	vim.opt.shortmess:append("c")

	local sources = {
		nvim_lsp = "[LSP]",
		luasnip = "[Snip]",
		buffer = "[Buff]",
		path = "[Path]",
		-- supermaven = "[AI]",
		["cmp-dbee"] = "[DB]",
	}

	local border = require("user.border")

	local cmp = require("cmp")

	local cmp_sources = {
		{ name = "nvim_lsp" },
	}

	-- local ok, supermaven = pcall(require, "supermaven-nvim")
	-- if ok then
	-- 	require("supermaven-nvim.completion_preview")
	--
	-- 	if supermaven.config.disable_inline_completion then
	-- 		cmp_sources = utils.merge_lists(cmp_sources, {
	-- 			{ name = "supermaven" },
	-- 		})
	-- 	end
	-- end

	cmp_sources = utils.merge_lists(cmp_sources, {
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	})

	cmp.setup({
		sources = cmp_sources,
		--- @diagnostic disable: missing-fields
		sorting = {
			priority_weight = 2,
		},
		--- @diagnostic disable: missing-fields
        --- Reference: https://github.com/echasnovski/mini.nvim/issues/1007#issuecomment-2258929830
		formatting = {
			format = function(_, item)
                local icon, hl = MiniIcons.get("lsp", item.kind)
                item.kind = icon .. " " .. item.kind
                item.kind_hl_group = hl
                return item
            end,
		},
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-y>"] = cmp.mapping(
				cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				{ "i", "c" }
			),
		},
		snippet = {
			expand = function(args)
				vim.snippet.expand(args.body)
			end,
		},
		window = {
			completion = {
				border = border,
			},
			documentation = {
				border = border,
			},
		},
	})

	-- Setup dbee sql completion
	-- cmp.setup.filetype({ "sql" }, {
	-- 	sources = {
	-- 		{ name = "cmp-dbee" },
	-- 		{ name = "buffer" },
	-- 	},
	-- })
end

return M
