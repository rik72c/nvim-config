
vim.cmd[[autocmd VimEnter * hi FloatermBorder guifg=none guibg=none]]

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- make definition window go away after selection
vim.cmd [[ autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR> ]]

-- require dap when using php
vim.cmd [[
autocmd FileType php lua require('config.dap.php').setup()
]]

vim.cmd [[highlight debugPC guibg=#26402F]]
-- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")jjjjjjjj


vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
vim.cmd [[highlight TelescopeBorder guibg=none]]
vim.cmd [[highlight TelescopeTitle guibg=none]]

-- get blade file type from php
vim.cmd [[au BufRead,BufNewFile *.blade.php setlocal filetype=blade]]

