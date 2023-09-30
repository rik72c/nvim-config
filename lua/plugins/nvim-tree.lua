local function tree_on_attach(bufnr)
    local api = require "nvim-tree.api"
    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', '<leader>]',	api.tree.change_root_to_node,	opts("Change to Root"))
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    enabled = true,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup{
            view = {
                width = 80,
                side = "right",
                number = true,
                -- float = {
                --     enable = true,
                --     quit_on_focus_loss = true,
                --     open_win_config = {
                --         border = "rounded",
                --         width = 100,
                --     }
                -- }
            },
            git = {
                enable = true
            },
            update_focused_file = {
                enable = true,
                update_root = true,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                }
            },
            filters = {
                dotfiles = true
            },
            on_attach = tree_on_attach
        }
    end,
}