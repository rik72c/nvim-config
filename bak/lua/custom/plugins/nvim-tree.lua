vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.opt.termguicolors = true

local function tree_on_attach(bufnr)

    local api = require "nvim-tree.api"
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    -- vim.keymap.set('n', '<C-t>',	api.tree.change_root_to_parent,	opts('Up'))
    -- vim.keymap.set('n', '?',	api.tree.toggle_help,		opts('help'))

end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup{
            view = {
                side = "right",
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                }
            },
            on_attach = tree_on_attach
        }
    end,
}
