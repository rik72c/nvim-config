-- return	{
--		"bluz71/vim-nightfly-guicolors",
--		name = "nightfly",
--		lazy = false,
--		priority = 1000,
--		config = function()
--			vim.cmd([[colorscheme nightfly]])
--		end,
--	}
return {
    'navarasu/onedark.nvim',
    name = onedark,
    lazy = false,
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
