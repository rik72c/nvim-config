-- nvim-dap is a Debug Adapter Protocol client implementation for Neovim.
-- https://github.com/mfussenegger/nvim-dap

return {
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require('dapui').setup()
            require('neodev').setup({
                library = { plugins = { "nvim-dap-ui" }, types = true}
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