return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    enabled = true,
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = false,  -- This enables inline text
            signs = true,         -- This enables signs in the sign column
            underline = false,     -- This enables underlining the problematic text
        })

    end,
}
