-- using fugitive
return {
    "FabijanZulj/blame.nvim",
    enabled = false,
    config = function()
        require('blame').setup({
            date_format = "%y/%m/%d",
            virtual_style = "float",
            merge_consecutive = true
        })
    end,
}