local cmp = require('cmp')
local luasnip = require('luasnip')
local loggr = require('core.loggr')

cmp.setup{
    completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
    experimental = { native_menu = false, ghost_text = false },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
    end,
    window = {
        completion = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = "[Buffer]",
                luasnip = "[Snip]",
                nvim_lua = "[Lua]",
                treesitter = "[Treesitter]",
                intelephense = "󰌟",
                copilot = ""
            })[entry.source.name]
            return vim_item
        end,
    },
    mapping = cmp.mapping.preset.insert({

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = function()
            cmp.mapping(function(fallback)
                -- loggr.debug('tab pressed', cmp.visible())
                if cmp.visible() then
                    cmp.select_next_item()
                    -- elseif luasnip.expand_or_locally_jumpable() then
                    --     luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' })
        end,
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                -- elseif luasnip.locally_jumpable(-1) then
                --     luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'copilot', max_item_count = 3 },
        { name = 'intelephense', max_item_count = 5 },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path', max_item_count = 3 },
        { name = 'buffer', max_item_count = 3 },
    },
    filetype = {
        { "dap-repl", "dapui_watches" }, {
            sources = {
                { name = "dap" },
            }
        }
    }
}

