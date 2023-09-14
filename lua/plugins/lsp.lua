-- return {
--     "VonHeikemen/lsp-zero.nvim",
--     branch = 'v2.x',
--     dependencies = {
--         -- LSP Support
--         {"neovim/nvim-lspconfig",
--             dependencies = {
--                 'folke/neodev.nvim',
--                 config = function()
--                     require("neodev").setup({})
--                 end,
--             }
--         },
--         {"williamboman/mason.nvim", config = true},
--         {"williamboman/mason-lspconfig.nvim"},
--
--         -- Autocompletion
--         {
--             "hrsh7th/nvim-cmp",
--             "saadparwaiz1/cmp_luasnip",
--             "hrsh7th/cmp-nvim-lsp",
--             "rafamadriz/friendly-snippets",
--             "L3MON4D3/LuaSnip",
--         },
--         {"hrsh7th/cmp-buffer"},
--         {"hrsh7th/cmp-path"},
--         {"hrsh7th/cmp-nvim-lua"},
--     }
-- }
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
        {'saadparwaiz1/cmp_luasnip'}
    }
}
