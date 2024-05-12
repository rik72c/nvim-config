local M = {}

local dap = require('dap')
local dapui = require('dapui')
local whichkey = require('which-key')

M.map_debug_keys = function()

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
                        debug_float_window = { width=150, height=50, enter=false, position="center" }
                        dapui.float_element('stacks', debug_float_window)
                    end, "Stacks"
                },
                b = {
                    function()
                        debug_float_window = { width=150, height=50, enter=false, position="center" }
                        dapui.float_element('breakpoints', debug_float_window)
                    end, "Breakpoints"
                },
                r = {
                    function()
                        debug_float_window = { width=150, height=50, enter=false, position="center" }
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
    M.map_debug_keys()
end

dap.listeners.before.disconnect['dapui_config'] = function()
    dapui.close()
    unmap_debug_keys()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
    -- dapui.close()
    unmap_debug_keys()
end

return M
