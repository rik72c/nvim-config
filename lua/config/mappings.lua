local helpers = require('core.helpers')
local phptest = require('core.config.phptest')
local php_debug = require('utils.php_debug')
local func = require('utils.func')
local dapui = require('dapui')
local requestr = require('core.requestr')

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

-- non-leader keymaps
-- vim.api.nvim_set_keymap('n', 'gh', function() func.goto_handler_or_command() end, { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F3>', ':FloatermToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<F3>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })

which_key.register({
    -- ['<F2>'] = { function() func.toggle_dapui_watches() end, "Watch (Float)"},
    ['<F3>'] = { "<Cmd>FloatermToggle<CR>", 'Toggle Floaterm' },
    ['<F5>'] = { "<Cmd>lua require('dap').continue()<CR>", 'Continue' },
    ['<F6>'] = { "<Cmd>lua require('utils.func').toggle_dapui_evaluation()<CR>", "Evaluation"},
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
    ['r'] = { "<CMD>Outline<CR>", "Toggle Outline"},
    ['<Tab>'] = { '<C-^>', "Toggle last buffer"},

    R = {
        name = "TEST",
    },

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
        g = { "<CMD>lua require('utils.func').grep_in_folder_or_global()<CR>", "Live Grep"},
        b = { "<CMD>ReachOpen buffers<CR>", "Buffers"},
        m = { "<CMD>ReachOpen marks<CR>", "Marks"},
        t = { "<CMD>Telescope buffers<CR>", "List Tabs"},


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
        w = {
            name = "Workspace",
        }
    },

    -- debug
    d = {
        name = "Debug",
        l = { function() php_debug.run_selected_test(true) end, "Debug Test" },
        t = { function() php_debug.run_selected_test() end, "List Tests"},
        d = { "<cmd>lua require('dapui').toggle()<CR>", "Open Debug Session"},
        r = { php_debug.rerun_test, "Repeat previous test"},
        i = { "<CMD>lua require('dapui').toggle()<CR>", "Toggle DAP-UI"},

        h = { function() requestr.prompt_and_request() end, "Run HTTP Request"},
        u = { function() requestr.repeat_last_request() end, "Re-Run HTTP Request"},

        a = {
            name= "Neotest (POC)",
            a = { "<CMD>lua require('neotest').run.run({suite=true})<CR>"},
            s = { "<CMD>lua require('neotest').summary()<CR>", "Toggle Summary"}
        }
    },

    D = {
        name = "HTTP Request",
        r = { function() vim.inspect(require('app.autoload').loadModule('ArtisanRouteFactory').createCollectionFromArtisan()) end, "Test" }, 
    },
    -- formatter
    f = {
        name = "Formater",
        f = { "<CMD>lua vim.cmd('silent w!')<CR><CMD>lua require('core.helpers').format_by_lang()<CR>", "Format File" },
        d = { "<CMD>lua vim.cmd('silent w!')<CR><CMD>lua require('core.helpers').format_by_lang(true)<CR>", "Format File Preview"},
        o = { "<CMD>PHPDocBlocks<CR>", "Create DocBlock"},
    },

    -- open
    o = {
        name = "Open",
        d = { "<CMD>DBUIToggle<CR>", "Database"},
        t = { '<cmd>FloatermNew --title=tasks --height=0.8 --width=0.5 taskwarrior-tui<CR>', "Tasks"},
        j = {
            name = "Jira",
            m = { '<CMD>FloatermNew --title=my-task --height=0.8 --width=0.8 jira issue list -a$(jira me)<CR>', "Assigned to Me"}
        },
    },

    -- terminal
    t = {
        name = "Terminal",
        t = { '<cmd>FloatermNew --title=terminal<CR>', "New Terminal" },
        i = { '<CMD>FloatermNew --title=directory --cmd="cd %:p:h"<CR>', "Open Current Directory"},
        d = { '<cmd>FloatermNew --title=docker --height=0.9 --width=1.0 lazydocker<CR>', "Docker" },
        c = { function() require('utils.docker').exec_in_container() end, "Terminal in Container"}
    },

    -- notes
    N = {
        name = "Notes (Obsidian)",
        t = { '<CMD>ObsidianToday<CR>', "Today Note"},
    },

    -- git
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        g = { "<cmd>LazyGit<CR>", "LazyGit" },
        b = { "<cmd>Git blame<CR>", "Git Blame"},
        l = {
            name = "GitLab",
            n = { "<CMD>lua require('gitlab').create_mr()<CR>", "New Merge Request"},
            a = {
                name = "Add",
                a = { "<CMD>lua require('gitlab').add_assignee()<CR>", "Add Assignee"},
                r = { "<CMD>lua require('gitlab').add_reviewer()<CR>", "Add Reviewer"},
            },
            r = { "<CMD>lua require('gitlab').review()<CR>", "Code Review"},
            s = { "<CMD>lua require('gitlab').summary()<CR>", "Summary"},
            b = { "<CMD>lua require('gitlab').open_in_browser()<CR>", "Open in Browser"}
        }
    },

    -- testing
    z = { function() vim.lsp.codelens.display() end, "test codelens" },

    l = {
        name = "Lookup",
        -- l = { function() require("browse").browse({ bookmarks = bookmarks }) end, "LookUp"},
        t = {
            name = "Task",
            m = { '<CMD>FloatermNew --title=tasks --height=0.7 --width=0.7 task<CR>', "My Task"}
        }
    },

    -- other
    w = {
        name = "Others",
        c = { '<cmd>ReachOpen colorschemes<CR>', "Change Theme"},
        n = { "<CMD>lua require'utils.php'.create_new_php_file()<CR>","Create New File"},
        m = { "<CMD>lua require('utils.php').generate_namespace()<CR>", "PHP:Generate Namespace"},
        d = { "<CMD>lua require('utils.func').pick_folder_in_project()<CR>", "Pick Directory"}
    },

    a = {
        name = "Otherss",
        t = { "<CMD>lua require('utils.func').toggle_transparency()<CR>", "Toggle Transparency" },
    }
}

which_key.register(mappings, opts)
