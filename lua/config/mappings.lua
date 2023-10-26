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
vim.api.nvim_set_keymap('n', '<F3>', ':FloatermToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<F3>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })

which_key.register({
    ['<F3>'] = { "<Cmd>FloatermToggle<CR>", 'Toggle Floaterm' },
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
    -- ['e'] = { '<cmd>NvimTreeToggle<CR>', 'Explorer' },
    ['e'] = { "<CMD>Neotree toggle<CR>", "Toggle Exploere"},
    ['<Tab>'] = { '<C-^>', "Toggle last buffer"},

    n = {
        name = "Text Case",
        a = {
            name = "Text Case Adjust (Current Word)",
            u = {"<cmd>lua require('textcase').current_word('to_upper_case')<CR>", "To Upper Case"},
            l = {"<cmd>lua require('textcase').current_word('to_lower_case')<CR>", "To Lower Case"},
            s = {"<cmd>lua require('textcase').current_word('to_snake_case')<CR>", "To Snake Case"},
            d = {"<cmd>lua require('textcase').current_word('to_dot_case')<CR>", "To Dot Case"},
            n = {"<cmd>lua require('textcase').current_word('to_constant_case')<CR>", "To Constant Case"},
            a = {"<cmd>lua require('textcase').current_word('to_phrase_case')<CR>", "To Phrase Case"},
            c = {"<cmd>lua require('textcase').current_word('to_camel_case')<CR>", "To Camel Case"},
            p = {"<cmd>lua require('textcase').current_word('to_pascal_case')<CR>", "To Pascal Case"},
            t = {"<cmd>lua require('textcase').current_word('to_title_case')<CR>", "To Title Case"},
            f = {"<cmd>lua require('textcase').current_word('to_path_case')<CR>", "To Path Case"},
        },
        e = {
            name = "Text Case Adjust (Operator)",
            u = {"<cmd>lua require('textcase').operator('to_upper_case')<CR>", "To Upper Case"},
            l = {"<cmd>lua require('textcase').operator('to_lower_case')<CR>", "To Lower Case"},
            s = {"<cmd>lua require('textcase').operator('to_snake_case')<CR>", "To Snake Case"},
            d = {"<cmd>lua require('textcase').operator('to_dot_case')<CR>", "To Dot Case"},
            n = {"<cmd>lua require('textcase').operator('to_constant_case')<CR>", "To Constant Case"},
            a = {"<cmd>lua require('textcase').operator('to_phrase_case')<CR>", "To Phrase Case"},
            c = {"<cmd>lua require('textcase').operator('to_camel_case')<CR>", "To Camel Case"},
            p = {"<cmd>lua require('textcase').operator('to_pascal_case')<CR>", "To Pascal Case"},
            t = {"<cmd>lua require('textcase').operator('to_title_case')<CR>", "To Title Case"},
            f = {"<cmd>lua require('textcase').operator('to_path_case')<CR>", "To Path Case"},
        },
    },
    -- search
    s = {
        name = "Search",
        f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = true})<CR>", "Search Files" },
        -- F = { "<Cmd>lua require('utils.func').find_file_for_float()<CR>", "Search Files (Float)"},
        g = { require('telescope.builtin').live_grep, "Live Grep"},
        b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", "Buffers"},
        t = { "<CMD>FloatermNew broot<CR>", "Search using Broot"},

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
        f = { "<CMD>lua vim.cmd('!w')<CR><CMD>lua require('core.helpers').format_by_lang()<CR>", "Format File" },
        d = { "<CMD>lua format_by_lang(true)<CR>", "Format File Preview"},
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

    l = {
        name = "LSP",
        n = { "<CMD>lua require'utils.php'.create_new_php_file()<CR>","Create New File"}
    },

    -- other
    w = {
        name = "Others",
        t = { '<cmd>lua require("telescope.builtin").colorscheme()<CR>', "Change Theme"},
        n = { "<CMD>lua require('utils.php').generate_namespace()<CR>", "PHP:Generate Namespace"},
        d = { "<CMD>lua require('utils.func').pick_folder_in_project()<CR>", "Pick Directory"}
    },
}

which_key.register(mappings, opts)