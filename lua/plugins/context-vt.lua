return {
    'andersevenrud/nvim_context_vt',
    enabled = false,
    config = function()
        vim.cmd[[highlight CustomContextVt guifg=#393939]]
        require('nvim_context_vt').setup({
            highlight = 'CustomContextVt'
        })
    end
}
