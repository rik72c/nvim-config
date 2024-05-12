-- https://github.com/m4xshen/autoclose.nvim
-- A minimalist Neovim plugin that auto pairs & closes brackets written in 100% Lua.

return {
    'm4xshen/autoclose.nvim',
    enabled = true,
    config = function()
        require('autoclose').setup({
            options = {
                disabled_filetypes = { 'TelescopePrompt', 'text' }
            }
        })
    end,
}
