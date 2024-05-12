return {
    'VidocqH/lsp-lens.nvim',
    enabled = false,
    config = function()
        require'lsp-lens'.setup({
            enable = true,
            include_declaration = true,      -- Reference include declaration
            sections = {                      -- Enable / Disable specific request
                definition = true,
                references = true,
                implements = true,
            },
            ignore_filetype = {
                -- "prisma",
            },
        })
    end
}
