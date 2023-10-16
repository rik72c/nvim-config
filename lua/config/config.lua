
-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

vim.o.termguicolors = true

vim.cmd[[autocmd VimEnter * hi FloatermBorder guifg=none]]

-- tab characters in your file to appear 4 character cells wide
vim.opt.tabstop = 4
-- If your code requires use of actual tab characters these settings prevent unintentional insertion of spaces (these are the defaults, but you may want to set them defensively):
vim.opt.softtabstop=0
vim.opt.expandtab = true
-- If you also want to use tabs for indentation, you should also set shiftwidth to be the same as tabstop:
vim.opt.shiftwidth = 4

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`

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