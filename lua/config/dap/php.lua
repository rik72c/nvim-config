local M = {}

M.setup = function()

    local dap = require('dap')
    local dapui = require('dapui')
    local whichkey = require('which-key')

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
            pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}"
            },
            xdebugSettings = {
                max_depth = 5
            }
        },
    }

    dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
    end

    -- whichkey.register(
    -- {
    --     ["d"] = {
    --         d = { function() require('dap').continue() end, "Open Debug Session" },
    --     }
    -- }
    -- )

end


return M