local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here

	-- General
	use({ "wbthomason/packer.nvim", commit = "0dbe2c76a5a08dc8451ac4c369d45b18122f743e" }) -- Have packer manage itself
	use({ 'marko-cerovac/material.nvim', commit = '3a7cca9f3908fd7b344f3fd07e957efbff32d893' })
  use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
  use({ "akinsho/toggleterm.nvim", commit = "c9579f5bb4ad249fc484147c04d9b7a5b8878876" })
  use({ "folke/which-key.nvim" })

  -- Buffers
  use({ "akinsho/bufferline.nvim", commit = "8bfe81da99984de947ad27d23e32352b5b9a4416" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })

  -- NvimTree
  use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
	use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim", commit = "b79cd6c88b3d96b0f49cb7d240807cd59b610cd8" }) --

  -- IntelliSense
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end,
    commits = "67bddeca28c476731ed5da64876b7f71d01190d1"
  }
  use({
		"nvim-treesitter/nvim-treesitter",
		commit = "3bd228781bf4a927c5ceaf7a4687fed9f96d12b5",
	})
  -- Lsp & cmp
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" }) -- simple to use language server installer

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
