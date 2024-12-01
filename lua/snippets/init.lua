-- Enable luasnip expansion for nvim-cmp
local ls = require("luasnip")

vim.snippet.expand = ls.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
	filter = filter or {}
	filter.direction = filter.direction or 1

	if filter.direction == 1 then
		return ls.expand_or_jumpable()
	else
		return ls.jumpable(filter.direction)
	end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
	if direction == 1 then
		if ls.expandable() then
			return ls.expand_or_jump()
		else
			return ls.jumpable(1) and ls.jump(1)
		end
	else
		return ls.jumpable(-1) and ls.jump(-1)
	end
end

vim.snippet.stop = ls.unlink_current

-- Go forward through snippet
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true, desc = "Snippet Jump Forward" })

-- Go backward through snippet
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, { silent = true, desc = "Snippet Jump Backward" })

ls.config.set_config({
	history = false,
	updateevents = "TextChanged,TextChangedI",
	override_builtin = true,
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
	if ft_path:sub(-#"init.lua") ~= "init.lua" then
		loadfile(ft_path)()
	end
end
