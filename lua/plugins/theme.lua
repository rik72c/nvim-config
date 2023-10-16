-- return {
--     'navarasu/onedark.nvim',
--     name = "onedark",
--     lazy = false,
--     enabled = true,
--     priority = 1000,
--     config = function()
--         require('onedark').setup{
--             style = "warmer",
--             transparent = true,
--             lualine = {
--                 transparent = true
--             },
--             diagnostics = {
--                 darker = false,
--                 undercurl = true,
--                 background = false
--             }
--         }
--         vim.cmd.colorscheme 'onedark'
--     end,
-- }
return {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme 'moonfly'
    end,
}
-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--     config = function()
--         require("catppuccin").setup({
--             flavour = "mocha", -- latte, frappe, macchiato, mocha
--             background = { -- :h background
--                 light = "latte",
--                 dark = "mocha",
--             },
--             transparent_background = false, -- disables setting the background color.
--             show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
--             term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--             dim_inactive = {
--                 enabled = false, -- dims the background color of inactive window
--                 shade = "dark",
--                 percentage = 0.15, -- percentage of the shade to apply to the inactive window
--             },
--             no_italic = false, -- Force no italic
--             no_bold = false, -- Force no bold
--             no_underline = false, -- Force no underline
--             styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--                 comments = { "italic" }, -- Change the style of comments
--                 conditionals = { "italic" },
--                 loops = {},
--                 functions = {},
--                 keywords = {},
--                 strings = {},
--                 variables = {},
--                 numbers = {},
--                 booleans = {},
--                 properties = {},
--                 types = {},
--                 operators = {},
--             },
--             color_overrides = {},
--             custom_highlights = {},
--             integrations = {
--                 cmp = true,
--                 gitsigns = true,
--                 nvimtree = true,
--                 treesitter = true,
--                 notify = false,
--                 mini = false,
--                 -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--             },
--         })
--
--         -- setup must be called before loading
--         vim.cmd.colorscheme "catppuccin"
--     end,
-- }