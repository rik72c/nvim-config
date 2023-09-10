-- return {
-- 	'codota/tabnine-nvim',
-- 	build = "./dl_binaries.sh",
-- 	config = function()
-- 		require('tabnine').setup({
-- 			disable_auto_comment=true,
-- 			accept_keymap="<Tab>",
-- 			dismiss_keymap = "<C-]>",
-- 			debounce_ms = 800,
-- 			suggestion_color = {gui = "#808080", cterm = 244},
-- 			exclude_filetypes = {"TelescopePrompt"},
-- 			log_file_path = '/Users/navaritcharoenlarp/Documents/logs/tabnine'
-- 		})
-- 	end,
-- }
-- return
-- 	{
-- 		{
-- 			'codota/tabnine-nvim',
-- 			build = "./dl_binaries.sh",
-- 			config = function()
-- 				require('tabnine').setup({
-- 					disable_auto_comment=true,
-- 					accept_keymap="<Tab>",
-- 					dismiss_keymap = "<C-]>",
-- 					debounce_ms = 800,
-- 					suggestion_color = {gui = "#808080", cterm = 244},
-- 					exclude_filetypes = {"TelescopePrompt"},
-- 					log_file_path = '/Users/navaritcharoenlarp/Documents/logs/tabnine'
-- 				})
-- 			end,
-- 		},
-- 		{
-- 			'tzachar/cmp-tabnine',
-- 			build = './install.sh',
-- 			dependencies = {
-- 				'hrsh7th/nvim-cmp',
-- 			},
-- 		}
-- 	}
return {
	{
		'codota/tabnine-nvim',
		build = "./dl_binaries.sh",
		config = function()
			require('tabnine').setup({
				disable_auto_comment=true,
				accept_keymap="<Tab>",
				dismiss_keymap = "<C-]>",
				debounce_ms = 800,
				suggestion_color = {gui = "#808080", cterm = 244},
				exclude_filetypes = {"TelescopePrompt"},
				log_file_path = '/Users/navaritcharoenlarp/Documents/logs/tabnine'
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = {
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "cmp_tabnine" },
			},
		},
		dependencies = {
			{
				"tzachar/cmp-tabnine",
				build = "./install.sh",
				config = function()
					local tabnine = require "cmp_tabnine.config"
					tabnine:setup {} -- put your options here
				end,
			},
		},
	}
}
