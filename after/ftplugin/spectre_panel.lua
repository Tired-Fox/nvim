vim.keymap.set("n", "<space>sw", function()
	require("spectre").open_visual({ select_word = true })
end, {
	desc = "Search current word",
	buffer = true,
})
vim.keymap.set("v", "<space>sw", require("spectre").open_visual, {
	desc = "Search current word",
	buffer = true,
})
vim.keymap.set("n", "<space>sp", function()
	require("spectre").open_file_search({ select_word = true })
end, {
	desc = "Search on current file",
	buffer = true,
})
