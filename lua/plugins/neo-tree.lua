vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function ()
        require('neo-tree').setup({
            window = {
                position = 'right',
                mappings = {
                    ["<space>"] = {
                        function()
                            vim.cmd('WhichKey <leader>')
                        end,
                        nowait = true
                    },
                    ["P"] = { "toggle_preview", config = { use_float = true}},
                }
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                use_libuv_file_watcher = true
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        require('neo-tree.command').execute({ action = 'close' })
                    end
                }
            }
        })
        vim.keymap.set('n', '<leader>e', "<CMD>NeoTree toggle<CR>", {})
    end,
}
