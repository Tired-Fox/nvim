return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                flavour = 'mocha',
                transparent_background = true,
                ---@diagnostic disable-next-line: missing-fields
                float = {
                    transparent = true,
                },
                dim_inactive = {
                    enabled = false,
                },
                color_overrides = {
                    all = {
                        base = "#191A1C"
                    }
                },
            })

            vim.cmd.colorscheme('catppuccin')
        end
    }
}
