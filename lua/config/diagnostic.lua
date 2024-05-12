-- Show line diagnostics automatically in hover window
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 0
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- styling
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
    {"╭", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╮", "FloatBorder"},
    {"│", "FloatBorder"},
    {"╯", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╰", "FloatBorder"},
    {"│", "FloatBorder"},
}

-- vim.diagnostic.config({
--     virtual_text = true,  -- This enables inline text
--     signs = true,         -- This enables signs in the sign column
--     underline = true,     -- This enables underlining the problematic text
--     update_in_insert = false, -- Update diagnostics in insert mode (set to true if needed)
--     severity_sort = true, -- Sort diagnostics by severity
-- })

-- LSP settings (for overriding per client)
-- local handlers =  {
--   ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
--   ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
-- }

-- -- Do not forget to use the on_attach function
-- require 'lspconfig'.myserver.setup { handlers=handlers }

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- require 'lspconfig'.myservertwo.setup {}
