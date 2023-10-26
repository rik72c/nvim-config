-- nvim-dap is a Debug Adapter Protocol client implementation for Neovim.
-- https://github.com/mfussenegger/nvim-dap

return {
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require('neodev').setup({
                library = { plugins = { "nvim-dap-ui" }, types = true}
            })
            require('dapui').setup({
                layouts = {
                    -- {
                    --     elements = {
                    --         -- { id = "scopes", size = 0 },
                    --         -- { id = "breakpoints", size = 0.15 },
                    --         -- { id = "stacks", size = 0.2 },
                    --         { id = "watches", size = 1 }
                    --     },
                    --     position = "right",
                    --     size = 40
                    -- },
                    {
                        elements = {
                            { id = "repl", size = 0.7 },
                            { id = "watches", size = 0.3 }
                        },
                        position = "bottom",
                        size = 15
                    }
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
}