local helpers = require('core/helpers')
local phptest = require('core/config/phptest')
local php_debug = require('utils.php_debug')

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    -- ['e'] = { "<cmd>:Telescope file_browser<CR>", "File Browser"},
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "[E]xplorer" },
    -- ["e"] = {  function(...)
    --     if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0), false) end
    -- end
    -- , "[E]xplorer" },

    -- search
    s = {
        name = "[S]earch",
        f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = true})<CR>", "[S]earch Files" },
        g = { require('telescope.builtin').live_grep, "[G]rep"},
        b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>", "[B]uffers"},
        -- g = { "<cmd>Telescope live_grep theme=ivy<cr>", "[S]earch Grep" },

        ["/"] = { function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = true,
            })
        end, "[/]Fuzzy Find"},
    },

    -- session
    q = {
        name = "Session",
        s = { require('resession').save, "Save Session" },
        l = { require('resession').load, "Load Session" },
        d = { require('resession').delete, "Delete Session" },
    },

    -- debug
    ["b"] = { function() require('dap').toggle_breakpoint() end, "Toggle Breakpoint"},
    d = {
        name = "[D]ebug",
        l = { function() require('utils.php_debug').run_selected_test() end, "[L]ist Unit Tests"},
        -- d = { "<cmd>lua require('dapui').toggle()<CR>", "Open Debug Session"},
        r = { php_debug.rerun_test, "Repeat previous test"},
        a = { phptest.run_all_test, "Run [A]ll tests"},
    },

    f = {
        name = "[F]ormater",
        f = { helpers.format_by_lang, "[F]ormat File" },
    },

    -- terminal
    t = {
        name = "[T]erminal",
        t = { '<cmd>FloatermNew --title=terminal<CR>', "New [T]erminal" },
        d = { '<cmd>FloatermNew --title=docker --height=0.9 --width=0.9 lazydocker<CR>', "[D]ocker" },
        -- c = { phptest.open_docker_terminal, "Terminal in [C]ontainer"},
        c = { function() require('utils.docker').exec_in_container() end, "Terminal in Container"}
    },

    -- git
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        g = { "<cmd>LazyGit<CR>", "LazyGit" },
        b = { "<cmd>Git blame<CR>", "Git Blame"}
    },

    -- other
    w = {
        name = "Others",
        t = { '<cmd>lua require("telescope.builtin").colorscheme()<CR>', "Change Theme"}
    },
}

which_key.register(mappings, opts)