return {
    "nvim-neotest/neotest",
    -- lazy = true,
    dependencies = {
        {
        "olimorris/neotest-phpunit",
            filter_dirs = { "vendor" }
        }
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-phpunit")
            },
        })
    end
}