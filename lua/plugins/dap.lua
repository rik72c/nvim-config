-- nvim-dap is a Debug Adapter Protocol client implementation for Neovim.
-- https://github.com/mfussenegger/nvim-dap

return {
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        dependencies = "mfussenegger/nvim-dap",
        config = function(_, opts)
            require("dap-go").setup(opts)
            -- require("config.dap.go").load_mappings('dap_go')
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require('neodev').setup({
                library = { plugins = { "nvim-dap-ui" }, types = true}
            })
            require('dapui').setup({
                floating = {
                    border = "single",
                    mappings = {
                        close = { "q", "<Esc>", "<F2>" }
                    }
                },
                layouts = {
                    -- {
                    --     elements = {
                    --         -- { id = "scopes", size = 0 },
                    --         -- { id = "breakpoints", size = 0.15 },
                    --         -- { id = "stacks", size = 0.2 },
                    -- { id = "repl", size = 0.7 },
                    --         { id = "watches", size = 1 }
                    --     },
                    --     position = "right",
                    --     size = 40
                    -- },
                    {
                        elements = {
                            { id = "repl", size = 0.5 },
                            { id = "watches", size = 0.3 },
                            { id = "breakpoints", size = 0.2 },
                        },
                        position = "bottom",
                        size = 12
                    },
                    -- {
                    --     elements = {
                    --         { id = "watches", size = 0.5 },
                    --     },
                    --     position = "bottom",
                    --     size = 8,
                    -- },
                    -- {
                    --     elements = {
                    --         { id = "breakpoints", size = 0.3 },
                    --         { id = "stacks", size = 0.7 },
                    --     },
                    --     position = "right",
                    --     size = 25,
                    -- },

                },
            })
        end,
        dependencies = {
            {
                "mfussenegger/nvim-dap",
                enabled = true,
                dependencies = {
                    {
                        "theHamsta/nvim-dap-virtual-text",
                        config = function()
                            require("nvim-dap-virtual-text").setup()
                        end,
                    },
                    "nvim-telescope/telescope-dap.nvim",
                }
            },
            { 'folke/neodev.nvim' , opts = {} },
        }
    },
    {
        'rcarriga/cmp-dap',
    }

}
