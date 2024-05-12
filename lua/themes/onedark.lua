return {
    'navarasu/onedark.nvim',
    name = "onedark",
    config = function()
        require('onedark').setup{
            style = "warmer",
            transparent = false,
            lualine = {
                transparent = true
            },
            diagnostics = {
                darker = false,
                undercurl = true,
                background = false
            }
        }
        -- vim.cmd.colorscheme 'onedark'
    end,
}
