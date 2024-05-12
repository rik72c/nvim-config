local options = {
    global = {
        incsearch = true, -- Incremental search
        hlsearch = false, -- Show highlight when searching
        mouse = 'a', -- Enable mouse mode
        clipboard = 'unnamedplus', -- Sync with system clipboard
        undofile = true, -- Save undo history
        ignorecase = true, -- Ignore case when searching
        smartcase = true, -- Smart case when searching
        updatetime = 0, -- Decrease update time
        timeoutlen = 300, -- Set timeout length
        termguicolors = true, -- Enable true colors
        completeopt = 'menu,menuone,noselect', -- Set completeopt
        number = true, -- Set line numbers
        relativenumber = true, -- Set relative line numbers
        signcolumn = 'yes', -- Set sign column
        breakindent = true, -- Enable break indent
        tabstop = 4, -- Set tabstop
        softtabstop = 0, -- Set soft tabstop
        expandtab = true, -- Expand tabs
        shiftwidth = 4, -- Set shift width
        spelllang = 'en_us', -- Set spell language
        spell = true, -- Enable spell checking
        wrap = true, -- Enable line wrapping
        swapfile = false, -- Disable swap file
        splitright = true, -- Split right
        splitbelow = true, -- Split below
    },
}

for k, v in pairs(options.global) do
    vim.opt[k] = v
end

        vim.g.loaded_netrw = 1 -- Disable netrw
        vim.g.loaded_netrwPlugin = 1 -- Disable netrw plugin
