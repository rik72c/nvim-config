return {
    {
        "zbirenbaum/copilot-cmp",
        dependencies = {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
                require("copilot").setup(
                    {
                        suggestion = {
                            enabled = false,
                            auto_trigger = true,
                            debounce = 50,
                        },
                        panel = {
                            enabled = false,
                            auto_refresh = true,

                        },
                        filetypes = {
                            lua = true,
                            javascript = true,
                            -- php = true,
                        }
                    }
                )
                vim.cmd(":Copilot disable")
            end,
        },

        config = function ()
            require('copilot_cmp').setup()

            local cmp = require("cmp")
            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
            end
            -- cmp.setup({
            --     mapping = {
            --         ["<Tab>"] = vim.schedule_wrap(function(fallback)
            --             if cmp.visible() and has_words_before() then
            --                 cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            --             else
            --                 fallback()
            --             end
            --         end),
            --     },
            -- })

        end
    },
    {
        'AndreM222/copilot-lualine',
        config = function()
            local lualine = require('lualine')
            lualine.setup({
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff',
                        {
                            'diagnostics',
                            sources = { "nvim_diagnostic" },
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
                        }
                    },
                    lualine_c = { 'filename' },
                    lualine_x = { 'copilot' ,'encoding', 'fileformat', 'filetype' }, -- I added copilot here
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                }
            })
        end
    }
}
