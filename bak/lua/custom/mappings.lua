local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["e"] = { "<cmd>NvimTreeToggle<CR>", "[E]xplorer" },
	-- ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	-- ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	-- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	-- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

	-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
	-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
	-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
	-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
	-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
	-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
	-- --Telescope
	-- s = {
	--   name = "Search",
	--   b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
	--   c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
	--   h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
	--   M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
	--   r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	--   R = { "<cmd>Telescope registers<cr>", "Registers" },
	--   k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
	--   C = { "<cmd>Telescope commands<cr>", "Commands" },
	-- },

	-- Folding
	o = {
		name = "F[O]lding",
		m = { "<cmd>set foldmethod=manual<CR>", "[M]anual"},
		i = { "<cmd>set foldmethod=indent<CR>", "[I]ndent"},
		s = { "<cmd>set foldmethod=syntax<CR>", "[S]yntax"},
		u = { "<cmd>normal! zO<CR>", "[U]nfold"},
	},

	-- Buffer
	b = {
		name = "[B]uffer",
		l = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Buffers [L]ist",
		}
	},

	-- Search
	s = {
		name = "[S]earch",
		f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = true})<CR>", "[S]earch Files" },
		g = { "<cmd>Telescope live_grep theme=ivy<cr>", "[S]earch Grep" }
	},

	f = {
		name = "[F]ormat",
		f = { "<cmd>normal mzgg=G`z<CR>", "[F]ormat File" },
		s = { "<cmd>lua vim.api.nvim_exec('! /Applications/PhpStorm.app/Contents/bin/format.sh -s ~/codeStyle.xml ' .. vim.fn.expand('%:p'), false)<cr>", "Format with Php[S]torm" },
	},

	-- Packer
	-- p = {
	--   name = "Packer",
	--   c = { "<cmd>PackerCompile<cr>", "Compile" },
	--   i = { "<cmd>PackerInstall<cr>", "Install" },
	--   s = { "<cmd>PackerSync<cr>", "Sync" },
	--   S = { "<cmd>PackerStatus<cr>", "Status" },
	--   u = { "<cmd>PackerUpdate<cr>", "Update" },
	-- },

	-- Git
	--  g = {
	--    name = "Git",
	--   g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
	--  j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
	--   k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
	--    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
	--    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
	--    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
	--    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
	--    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
	--    u = {
	--      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
	--      "Undo Stage Hunk",
	--    },
	--    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
	--   b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
	--  c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
	--    d = {
	--      "<cmd>Gitsigns diffthis HEAD<cr>",
	--      "Diff",
	--    },
	--  },
	-- Language Server Protocol (LSP)
	-- l = {
	--   name = "LSP",
	--   a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	--   d = {
	--     "<cmd>Telescope diagnostics bufnr=0<cr>",
	--     "Document Diagnostics",
	--   },
	--   w = {
	--     "<cmd>Telescope diagnostics<cr>",
	--     "Workspace Diagnostics",
	--   },
	--   f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
	--   i = { "<cmd>LspInfo<cr>", "Info" },
	--   I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
	--   j = {
	--     "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
	--     "Next Diagnostic",
	--   },
	--   k = {
	--     "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
	--     "Prev Diagnostic",
	--   },
	--   l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
	--   q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
	--   r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	--   s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
	--   S = {
	--     "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
	--     "Workspace Symbols",
	--   },
	-- },
	-- Terminal
	-- t = {
	--   name = "Terminal",
	--   n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
	--   u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
	--   t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
	--   p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
	--   f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
	--   h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
	--   v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	-- },
	t = {
		name = "[T]erminal",
		f = { '<cmd>FloatermNew --title=terminal<CR>', "New [F]loat Terminal" },
	},

	-- Git
	g = {
		name = "Git",
		g = { "<cmd>LazyGit<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
	}

}

which_key.register(mappings, opts)

-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--  -- You can pass additional configuration to telescope to change theme, layout, etc.
--  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--    winblend = 10,
--    previewer = false,
--  })
-- end, { desc = '[/] Fuzzily search in current buffer' })
