return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup({
            patterns = { ".git", ".project", "lazy-lock.json", "composer.json" },
            silent_chdir = true,
        })

        require("telescope").load_extension("projects")

        local which_key = require("which-key")
        which_key.register({
            p = { "<CMD>ProjectDir<CR>", "Change Project" },
        }, { prefix = "<leader>q" })
    end,
}

