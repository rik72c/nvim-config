return {
    "harrisoncramer/gitlab.nvim",
    lazy=false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
        "nvim-tree/nvim-web-devicons" -- Recommended but not required. Icons in discussion tree.
    },
    enabled = true,
    build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
    config = function()
        require("gitlab").setup({
            config_path = "/Users/rik/Documents/scripts/gitlab.nvim",
            popup = {
                perform_action = "<leader>S",
                perform_linewise_action = "<leader>L",
            }
        })
    end,
}
