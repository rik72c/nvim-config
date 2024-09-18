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
                -- local f = vim.fn.getenv('INTELEPHENSE_LICENSE') or ''
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



require('config.diagnostic')
require('config.cmp')
