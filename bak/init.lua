-- get all paths

local paths = require('paths')

require(paths.config)

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {"neovim/nvim-lspconfig",
                dependencies = {
                    'folke/neodev.nvim',
                }
            },
            {"williamboman/mason.nvim", config = true},
            {"williamboman/mason-lspconfig.nvim"},

            -- Autocompletion
            -- {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"},
            {"saadparwaiz1/cmp_luasnip"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-nvim-lua"},

            -- Snippets
            {"L3MON4D3/LuaSnip"},
            {"rafamadriz/friendly-snippets"},
        }
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = '┊',
            show_trailing_blankline_indent = false,
        },
    },
    {
        "numToStr/Comment.nvim", opts = {}, lazy = false,
    },
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    { import = paths.plugins },
},
    {
        install = { colorscheme = { "habamax" }}
    })

-- Setup neovim lua configuration calling this before lsp-config`
require('neodev').setup({})

require(paths.config_autoformat)
require(paths.config_treesitter)
require(paths.config_lspzero)

require(paths.key_mappings)
