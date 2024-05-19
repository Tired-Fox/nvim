-- Set keymap leader
vim.g.maplocalleader = ","
vim.g.mapleader = ","

-- Setup Lazy.nvim for plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "user/plugins" }, {
	change_detection = {
		notify = false,
	},
})

require("user.options")
require("user.keymaps")
require("user.autocmds")
