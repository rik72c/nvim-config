return {
    'navarasu/onedark.nvim',
    enabled = true,
    priority = 1000,
    config = function()
      require("onedark").setup{
        transparent = true,
        lualine = {
            transparent = true
        }
      }
      vim.cmd.colorscheme 'onedark'
    end,
  }
