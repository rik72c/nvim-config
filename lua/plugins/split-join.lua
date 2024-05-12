return {
    'Wansmer/treesj',
    keys = { '<space>M', '<space>J', '<space>S' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesj').setup({--[[ your config ]]})
    end,
}
