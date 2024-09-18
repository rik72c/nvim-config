return {
    "Pocco81/auto-save.nvim",
    enabled = false,
    config = function()
        require("auto-save").setup({
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")

                -- local status_ok, harpoon_mark = pcall(require, "harpoon.mark")
                -- if status_ok and harpoon_mark and harpoon_mark.get_current_index() ~= nil then
                --     return false -- Harpoon is active, don't auto-save
                -- end

                if
                    fn.getbufvar(buf, "&modifiable") == 1 and
                    utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
                    return true -- met condition(s), can save
                end
                return false -- can't save
            end,		 })
    end,
}
