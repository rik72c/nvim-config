

-- map leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- configure lazy.nvim
require("lazy").setup({
    { import = "themes" },
    { import = "plugins" },
},
    {
        -- install = {
        --     colorscheme = { "onedark" }
        -- }
    }
)
require('core.lsp-config')

require('config.config')
require('config.commands')
require('config.mappings')

require('config.config-new')

vim.cmd('colorscheme midnight')
