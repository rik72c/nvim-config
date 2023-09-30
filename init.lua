
require('config.config')

require('core.lazy')
require('core.treesitter')
require('core.highlight-yank')
require('core.lsp-config')

require('config/mappings')
-- require("core/autoformat")
-- require('core/config/phptest')

vim.cmd [[
autocmd FileType php lua require('config.dap.php').setup()
]]