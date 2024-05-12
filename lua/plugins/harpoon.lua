return {
    "ThePrimeagen/harpoon",
    enabled = true,
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        local whichkey = require('which-key')

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        whichkey.register({
            h = {
                name = "Harpoon",
                {
                    h = {
                        function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                        "List"
                    },
                    a = {
                        function() harpoon:list():add() end,
                        "Add"
                    }
                }
            }
        }, {
                mode = "n",
                prefix = "<leader>",
                silent = true,
                noremap = true,
                nowait = true,
            })
    end,
}
