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
        g = { "<cmd>Telescope live_grep theme=ivy<cr>", "[S]earch Grep" }
    },

    f = {
        name = "[F]ormater",
        f = { "<cmd>normal mzgg=G`z<CR>", "[F]ormat File" },
    },

    -- terminal
    t = {
        name = "[T]erminal",
        t = { '<cmd>FloatermNew --title=terminal<CR>', "New [T]erminal" },
        d = { '<cmd>FloatermNew --title=docker --height=0.9 --width=0.9 lazydocker<CR>', "[D]ocker" },
        g = { "<cmd>LazyGit<CR>", "[G]it" },
    },

    -- git
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    }
}

which_key.register(mappings, opts)
