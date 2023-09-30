-- https://github.com/navarasu/onedark.nvim

return {
    'navarasu/onedark.nvim',
    name = "onedark",
    lazy = false,
    enabled = true,
    priority = 1000,
    config = function()
        require('onedark').setup{
            style = "warmer",
            transparent = true,
            lualine = {
                transparent = true
            },
            diagnostics = {
                darker = false,
                undercurl = true,
                background = false
            }
        }
        vim.cmd.colorscheme 'onedark'
    end,
}