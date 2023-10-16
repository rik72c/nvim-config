return {
    'rmagatti/goto-preview',
    config = function()
        require('goto-preview').setup({
            default_mappings = true,
            width = 100,
            height = 30,
            border = {"╭", "─" ,"╮", "│", "╯", "─", "╰", "│"},
            opacity = 10,
        })
    end,
}