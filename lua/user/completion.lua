require("user.snippets")

local merge_lists = require("user").merge_lists

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local sources = {
	nvim_lsp = "[LSP]",
	luasnip = "[Snip]",
	buffer = "[Buff]",
	path = "[Path]",
	supermaven = "[AI]",
	["cmp-dbee"] = "[DB]",
}

local icons = require("user").icons
local borderstyle = require("user").borderstyle

local lspkind = require("lspkind")
local cmp = require("cmp")

local cmp_sources = {
	{ name = "nvim_lsp" },
}

local ok, supermaven = pcall(require, "supermaven-nvim")
if ok then
	require("supermaven-nvim.completion_preview")

	if supermaven.config.disable_inline_completion then
		cmp_sources = merge_lists(cmp_sources, {
			{ name = "supermaven" },
		})
	end
end

cmp_sources = merge_lists(cmp_sources, {
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
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "",
			show_labelDetails = false,
			symbol_map = icons.kind,
			before = function(entry, vim_item)
				if sources[entry.source.name] ~= nil then
					vim_item.menu = sources[entry.source.name]
				else
					vim.print("CMP missing source map for " .. entry.source.name)
				end

				if entry.source.name == "cmp-dbee" then
					vim_item.kind = vim_item.kind:sub(1, 1):upper() .. vim_item.kind:sub(2):lower()
				end
				return vim_item
			end,
		}),
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
		completion = borderstyle,
		documentation = borderstyle,
	},
})

-- Setup dbee sql completion
cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "cmp-dbee" },
		{ name = "buffer" },
	},
})
