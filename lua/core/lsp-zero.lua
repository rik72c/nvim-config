local lsp = require('lsp-zero').preset({})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.ensure_installed({
    'intelephense'
})

local on_attach = function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({buffer = bufnr})
end

local get_intelephense_license = function ()
    local f = assert(io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb"))
    local content = f:read("*a")
    f:close()
    return string.gsub(content, "%s+", "")
end

lsp.configure('intelephense', {
    on_attach = on_attach,
    init_options = {
        licenseKey = get_intelephense_license()
    }
})

lsp.setup()


-- [nvim-cmp]
local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    sources = {
        { name = 'intelephense' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- elseif luasnip.expand_or_locally_jumpable() then
                --     luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                -- elseif luasnip.locally_jumpable(-1) then
                --     luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['intelephense'].setup {
    capabilities = capabilities
}

