local helpers = require('core.helpers')
local phptest = require('core.config.phptest')
local php_debug = require('utils.php_debug')
local func = require('utils.func')

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

-- non-leader keymaps
-- vim.api.nvim_set_keymap('n', 'gh', function() func.goto_handler_or_command() end, { noremap = true, silent = true })

which_key.register({
    ['<F5>'] = { "<Cmd>lua require('dap').continue()<CR>", 'Continue' },
    ['<F9>'] = { "<Cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    ['<F10>'] = { "<Cmd>lua require('dap').step_over()<CR>", 'Step Over' },
    ['<F11>'] = { "<Cmd>lua require('dap').step_into()<CR>", 'Step Into' },
    ['<F12>'] = { "<Cmd>lua require('dap').step_out()<CR>", 'Step Out' },

    ['gh'] = { function() func.goto_handler_or_command() end, 'Go to Handler' }
}, { prefix = "" })

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    ['e'] = { '<cmd>Neotree toggle<CR>', 'Explorer' },
    ['<Tab>'] = { '<C-^>', "Toggle last buffer"},

    -- search
    s = {
        name = "Search",
        f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = true})<CR>", "Search Files" },
        g = { require('telescope.builtin').live_grep, "Live Grep"},
        b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Buffers"},

        ["/"] = { function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = true,
            })
        end, "Fuzzy Find"},
    },

    -- session
    q = {
        name = "Session",
        s = { require('resession').save, "Save Session" },
        l = { require('resession').load, "Load Session" },
        d = { require('resession').delete, "Delete Session" },
    },

    -- debug
    d = {
        name = "Debug",
        l = { function() php_debug.run_selected_test(true) end, "Debug Test" },
        t = { function() php_debug.run_selected_test() end, "List Tests"},
        d = { "<cmd>lua require('dapui').toggle()<CR>", "Open Debug Session"},
        r = { php_debug.rerun_test, "Repeat previous test"},
        i = { "<CMD>lua require('dapui').toggle()<CR>", "Toggle DAP-UI"},

        a = {
            name= "Neotest (POC)",
            a = { "<CMD>lua require('neotest').run.run({suite=true})<CR>"},
            s = { "<CMD>lua require('neotest').summary()<CR>", "Toggle Summary"}
        }
    },

    -- formatter
    f = {
        name = "Formater",
        f = { function() helpers.format_by_lang() end, "Format File" },
        d = { function() helpers.format_by_lang(true) end, "Format File Preview"},
        o = { "<CMD>PHPDocBlocks<CR>", "Create DocBlock"},
    },

    -- terminal
    t = {
        name = "Terminal",
        t = { '<cmd>FloatermNew --title=terminal<CR>', "New Terminal" },
        d = { '<cmd>FloatermNew --title=docker --height=0.9 --width=0.9 lazydocker<CR>', "Docker" },
        c = { function() require('utils.docker').exec_in_container() end, "Terminal in Container"}
    },

    -- git
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        g = { "<cmd>LazyGit<CR>", "LazyGit" },
        b = { "<cmd>Git blame<CR>", "Git Blame"}
    },

    -- testing
    z = { function() vim.lsp.codelens.display() end, "test codelens" },

    -- other
    w = {
        name = "Others",
        t = { '<cmd>lua require("telescope.builtin").colorscheme()<CR>', "Change Theme"}
    },
}

which_key.register(mappings, opts)