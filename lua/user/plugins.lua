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

  -- Colorschemes
  use "lunarvim/onedarker.nvim"
	use({ 'marko-cerovac/material.nvim', commit = '3a7cca9f3908fd7b344f3fd07e957efbff32d893' })

	-- General
	use({ "wbthomason/packer.nvim", commit = "0dbe2c76a5a08dc8451ac4c369d45b18122f743e" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
  use({ "akinsho/toggleterm.nvim", commit = "c9579f5bb4ad249fc484147c04d9b7a5b8878876" })
  use({ "folke/which-key.nvim" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
  use "folke/todo-comments.nvim"
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter

  -- Commenting
  use "numToStr/Comment.nvim"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  use({ "norcalli/nvim-colorizer.lua", commit = "35f1aad99c4d03217bcc80a2e16efe3ba74379a4" })

  -- NvimTree
  use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
	use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim", commit = "b79cd6c88b3d96b0f49cb7d240807cd59b610cd8" }) --

  -- IntelliSense
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  }
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end,
    commits = "67bddeca28c476731ed5da64876b7f71d01190d1"
  }
  use({
		"nvim-treesitter/nvim-treesitter",
		commit = "3bd228781bf4a927c5ceaf7a4687fed9f96d12b5",
	})
  -- Lsp
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" }) -- simple to use language server installer
  use "ray-x/lsp_signature.nvim"

  -- TODO Update pinned commits
  -- cmp
	use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

  -- snippets
	use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
