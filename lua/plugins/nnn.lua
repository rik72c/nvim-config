return {
    'luukvbaal/nnn.nvim',
    enabled = false,
    config = function()
        require('nnn').setup({
            explorer = {
                width = 50,
                side = "botright",
            },
            auto_open = {
                empty = true,
            }
        })
    end
}