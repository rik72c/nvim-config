return {
    {
            'neovim/nvim-lspconfig',
        },
        {
            'williamboman/mason.nvim',
            config = function()
                require('mason').setup()
            end,
        },
        {
            'williamboman/mason-lspconfig.nvim',
            -- 'phpactor/phpactor',
        },
        {
            'saadparwaiz1/cmp_luasnip',
            dependencies = {
            'L3MON4D3/LuaSnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/nvim-cmp',
            },
        },
        {
            'ckipp01/stylua-nvim'
        }
}