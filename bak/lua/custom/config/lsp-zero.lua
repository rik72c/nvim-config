local lsp = require("lsp-zero")

lsp.preset("recommended")

local get_intelephense_license = function ()
	local f = assert(io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb"))
	local content = f:read("*a")
	f:close()
	return string.gsub(content, "%s+", "")
end

local on_attach = function ()
	local opts = {buffer = 0}
	vim.diagnostic.config({
		virtual_text = true,
	})

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader>df", "<cmd>Telescope diagnostics<cr>", opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, opts)
end

lsp.ensure_installed({
	"intelephense",
})

lsp.configure("intelephense", {
	on_attach = on_attach,
	init_options = {
		licenceKey = get_intelephense_license()
	}
})

lsp.setup()

-- setup cmp
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	sources = {
		{name = 'cmp_tabnine'},
		{name = 'intelephense'},
		{name = 'nvim_lsp'},
		{name = 'buffer'},
		{name = 'luasnip'},
	},
	mapping = {

		-- 'Enter' key to confirm completion
		['<CR>'] = cmp.mapping.confirm({select = false}),

		-- 'Ctrl+Space' to trigger completion
		-- ['<C-Space>'] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),
	}
})
