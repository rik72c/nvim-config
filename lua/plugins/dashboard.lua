return {
    'glepnir/dashboard-nvim',
    enabled = false,
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                packages = { enabled = false },
                shortcut = {
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        desc = ' Git',
                        group = 'Tools',
                        action = "LazyGit",
                        key = 'g',
                    },
                    {
                        desc = '󰡨 Docker',
                        group = 'Tools',
                        action = 'FloatermNew --title=docker --height=0.9 --width=0.9 lazydocker',
                        key = 'd',
                    },
                },
            },
        }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
