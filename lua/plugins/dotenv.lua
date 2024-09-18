return {
    "ellisonleao/dotenv.nvim",
    enabled = false,
    config = function()
        require('dotenv').setup({
            enabled_on_load = true,
            verbose = false,
        })
    end,
}
