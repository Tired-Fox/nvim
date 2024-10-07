vim.cmd.colorscheme("catppuccin")

function GetTelescopeHighlights()
	local colorscheme = vim.g.colors_name
	if string.sub(colorscheme, 1, 10) == "catppuccin" then
		local colors = require("catppuccin.palettes").get_palette()
		return {
			TelescopeMatching = { fg = colors.flamingo },
			TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

			TelescopePromptPrefix = { bg = colors.surface0 },
			TelescopePromptNormal = { bg = colors.surface0 },
			TelescopeResultsNormal = { bg = colors.mantle },
			TelescopePreviewNormal = { bg = colors.mantle },
			TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
			TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
			TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
			TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
			TelescopeResultsTitle = { fg = colors.mantle },
			TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
		}
	elseif string.sub(colorscheme, 1, 3) == "ayu" then
		local colors = require("ayu.colors")
		return {
			TelescopeMatching = { fg = colors.accent },
			TelescopeSelection = { fg = colors.fg, bg = colors.selection_bg },

			TelescopePromptPrefix = { bg = colors.fg_idle },
			TelescopePromptNormal = { bg = colors.fg_idle },
			TelescopeResultsNormal = { bg = colors.panel_shadow },
			TelescopePreviewNormal = { bg = colors.panel_shadow },
			TelescopePromptBorder = { bg = colors.fg_idle, fg = colors.fg_idle },
			TelescopeResultsBorder = { bg = colors.panel_shadow, fg = colors.panel_shadow },
			TelescopePreviewBorder = { bg = colors.panel_shadow, fg = colors.panel_shadow },
			TelescopePromptTitle = { bg = colors.vcs_removed, fg = colors.panel_shadow },
			TelescopeResultsTitle = { fg = colors.panel_shadow },
			TelescopePreviewTitle = { bg = colors.vcs_added, fg = colors.panel_shadow },
		}
	elseif colorscheme == "everforest" then
		local colors = require("everforest.colours").generate_palette(require("everforest").config, vim.o.background)
		return {
			TelescopeMatching = { fg = colors.red },
			TelescopeSelection = { fg = colors.fg, bg = colors.bg0 },

			TelescopePromptPrefix = { bg = colors.bg2 },
			TelescopePromptNormal = { bg = colors.bg2 },
			TelescopeResultsNormal = { bg = colors.bg_dim },
			TelescopePreviewNormal = { bg = colors.bg_dim },
			TelescopePromptBorder = { bg = colors.bg2, fg = colors.bg2 },
			TelescopeResultsBorder = { bg = colors.bg_dim, fg = colors.bg_dim },
			TelescopePreviewBorder = { bg = colors.bg_dim, fg = colors.bg_dim },
			TelescopePromptTitle = { bg = colors.yellow, fg = colors.bg_dim },
			TelescopeResultsTitle = { fg = colors.bg_dim },
			TelescopePreviewTitle = { bg = colors.aqua, fg = colors.bg_dim },
		}
	else
		return {}
	end
end

function SetTelescopeHighlights()
	for hl, col in pairs(GetTelescopeHighlights()) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		SetTelescopeHighlights()
	end,
})

SetTelescopeHighlights()
