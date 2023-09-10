print('configuration')
-- map leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

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
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.cmd[[autocmd VimEnter * hi FloatermBorder guifg=none]]

-- tab characters in your file to appear 4 character cells wide
vim.opt.tabstop = 4
-- If your code requires use of actual tab characters these settings prevent unintentional insertion of spaces (these are the defaults, but you may want to set them defensively):
vim.opt.softtabstop=0
vim.opt.expandtab = true
-- If you also want to use tabs for indentation, you should also set shiftwidth to be the same as tabstop:
vim.opt.shiftwidth = 4

