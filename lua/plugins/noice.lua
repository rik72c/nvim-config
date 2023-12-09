return {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true
        }
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        {
            "rcarriga/nvim-notify",
            config = function()
                require("notify").setup({
                    background_colour = "#000000",
                    render = "compact",
                    top_down = false,
                })
            end,
        },
    }
}
