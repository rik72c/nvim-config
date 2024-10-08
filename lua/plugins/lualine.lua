-- https://github.com/nvim-lualine/lualine.nvim
-- See `:help lualine.txt`

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = '|',
            section_separators = '',
        },
        -- sections = {
        --     lualine_c = {
        --         {
        --             'filename',
        --             file_status = true,
        --             path = 2,
        --         },
        --     }
        -- }
    },
}
