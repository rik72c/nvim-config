-- language configuration
local servers = {
    intelephense = {
        cmd = {
            "intelephense",
            "--stdio"
        },
        filetypes = {
            "php",
            "dapui_watches",
        },
        init_options = {
            licenseKey = (function()
                -- todo: notify if license is not present
                local f = assert(io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb"))
                local content = f:read("*a")
                f:close()
                return string.gsub(content, "%s+", "")
            end)()
        }
    },
    gopls = {
        cmd = {
            "gopls"
        },
        filetypes = {
            "go",
            "gomod",
            "gowork",
            "gotmpl"
        },
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
            unusedparams = true,
        },
    },
    tsserver = {
        init_options = {
            disableSuggestions = true,
        }
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false},
            telemetry = { enable = false },
            diagnostics = {
                globals = { "vim" }
            },
        }
    },
}
---

local on_attach = function()
    local opts = {buffer = 0}

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics<cr>", opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers)
}
mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}


local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup{
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- format = function(entry, vim_item)
    --     local cmp_item = entry:get_completion_item()
    --
    --     if entry.source.name == 'nvim_lsp' then
    --         pcall(function()
    --             local lspserver_name = nil
    --             vim_item.menu = lspserver_name
    --         end)
    --     end,
    -- end,
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
    end,
    window = {
        -- completion = {
        -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        -- col_offset = -3,
        -- side_padding = 0,
        -- },
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
    }),
    sources = {
        -- { name = 'cmp_tabnine', max_item_count = 3 },
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

require('config.diagnostic')
