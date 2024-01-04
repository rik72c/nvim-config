return {
    'zaldih/themery.nvim',
    config = function()
        require("themery").setup({
            themes = {
                {
                    name = 'oxocarbon',
                    colorscheme = 'oxocarbon',
                },
                {
                    name = 'midnight',
                    colorscheme =  'midnight',
                },
                {
                    name = 'catppuccin - latte',
                    colorscheme = 'catppuccin-latte',
                },
                {
                    name = 'catppuccin - frappe',
                    colorscheme = 'catppuccin-frappe',
                },{
                    name = 'catppuccin - macchiato',
                    colorscheme = 'catppuccin-macchiato'
                },
                {
                    name = 'moonfly',
                    colorscheme = 'moonfly',
                },
                {
                    name = 'onedark',
                    colorscheme = 'onedark',
                },
                {
                    name = "kanagawa - lotus",
                    colorscheme = "kanagawa-lotus",
                },
                {
                    name = "kanagawa - dragon",
                    colorscheme = "kanagawa-dragon",
                },
                {
                    name = "kanagawa - wave",
                    colorscheme = 'kanagawa-wave',
                },
            },
            themeConfigFile = '~/.config/nvim/theme.lua',
            livePreview = true,
        })
    end,
}
