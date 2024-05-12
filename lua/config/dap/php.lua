local M = {}

M.setup = function()

    local dap = require('dap')

    dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { os.getenv("HOME").."/vscode-php-debug/out/phpDebug.js"},
    }

    dap.configurations.php = {
        {
            name = 'Listen for xdebug',
            type = 'php',
            request = 'launch',
            port = '9003',
            pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}"
            },
            xdebugSettings = {
                max_depth = 3
            }
        },
    }

    local dapui = require('dapui')
    local whichkey = require('which-key')

    local function map_debug_keys()
        local debug_float_window = nil
        whichkey.register({
            x = {
                name = "Dap-UI",
                {
                    e = {
                        function()
                            debug_float_window = { width=100, height=30, enter=false, position=nil }
                            dapui.eval(nil, debug_float_window)
                        end, "Evaluation"
                    },
                    s = {
                        function()
                            debug_float_window = { width=100, height=30, enter=false, position="center" }
                            dapui.float_element('stacks', debug_float_window)
                        end, "Stacks"
                    },
                    r = {
                        function()
                            debug_float_window = { width=150, height=50, enter=true, position="center" }
                            dapui.float_element('repl', debug_float_window)
                        end, "Control"
                    },
                    w = {
                        function()
                            debug_float_window = { width=150, height=50, enter=true, position="center" }
                            dapui.float_element('watches', debug_float_window)
                        end, "Watch (Float)"},
                    x = { function() dapui.close() dap.disconnect() end, "Stop Debug"}
                }
            } 
        }, { prefix = '<leader>'})
    end

    local function unmap_debug_keys()
    end

    dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
        map_debug_keys()
    end

    dap.listeners.before.disconnect['dapui_config'] = function()
        dapui.close()
        unmap_debug_keys()
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
        -- dapui.close()
        unmap_debug_keys()
    end
end


return M
