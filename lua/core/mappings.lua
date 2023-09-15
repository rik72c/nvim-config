local helpers = require('core/helpers')
local phptest = require('core/config/phptest')

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
    ["e"] = { "<cmd>NvimTreeToggle<CR>", "[E]xplorer" },

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


    -- debug
    d = {
        name = "[D]ebug",
        b = { function() require('dap').toggle_breakpoint() end, "Toggle [B]reakpoint"},
        l = { phptest.show_phpunit_tests, "[L]ist Unit Tests"},
        r = { phptest.rerun_last_test, "[R]epeat last test"},
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
        c = { phptest.open_docker_terminal, "Terminal in [C]ontainer"},
    },

    -- git
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        g = { "<cmd>LazyGit<CR>", "[G]it" },
    }
}

which_key.register(mappings, opts)