local function tree_on_attach(bufnr)

    local api = require "nvim-tree.api"
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', '<leader>]',	api.tree.change_root_to_node,	opts("Change to Root"))

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
                number = true
            },
            git = {
                enable = true
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
