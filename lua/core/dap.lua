local dap = require('dap')

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { os.getenv("HOME").."/vscode-php-debug/out/phpDebug.js"},
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for xdebug',
        port = '9003',
        -- log = true,
        pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}"
        }
    },
}

require("nvim-dap-virtual-text").setup()
require("dapui").setup()