local M = {}

_G.docker_active_container = nil

-- require plugins
local Job = require('plenary.job')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
-- local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

local function execute_command(cmd, title)
    title = vim.fn.shellescape(title) or "container"
    local exec_cmd = string.format("FloatermNew --title=%s --wintype=float --width=0.9 --height=0.9 --position=center --autoclose=0 %s",title:gsub(" ", "\\ "), cmd)
    vim.cmd(exec_cmd)
end

local function debug_test(container_id, test_cmd)
    local filterValue = string.match(test_cmd, "--filter=([%w]+)")
    require('dap').configurations.php = {
        {
            name = 'Listen for xdebug',
            type = 'php',
            request = 'launch',
            port = '9003',
            program = '/Users/navaritcharoenlarp/run_test_in_docker.sh',
            runtimeExecutable = 'sh',
            args = { container_id, require('utils.php_debug').get_php_tester(), filterValue},
            pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}"
            },
            xdebugSettings = {
                max_depth = 7,
                max_data = 10
            }
        }
    }
    require('dap').continue()
end

M.run_in_docker_container = function(docker_cmd, title, debug)
    local output = {}

    if _G.docker_active_container then
        local cmd = string.format("docker exec -it %s %s", _G.docker_active_container.id, docker_cmd)
        if debug then
            debug_test(_G.docker_active_container.id, cmd)
        else
            execute_command(cmd, title)
        end
        return true
    end

    Job:new({
        command = 'docker',
        args = {'ps', '--format', '{{.ID}} - {{.Names}}'},
        on_stdout = function(_, line)
            local id, name = string.match(line, "([^%s]+) %- ([^%s]+)")
            table.insert(output, { id = id, name = name, display = line })
        end,
        on_exit = function()
            vim.schedule(function()
                pickers.new({}, {
                    prompt_title = 'Docker Containers',
                    finder = finders.new_table({
                        results = output,
                        entry_maker = function(entry)
                            return {
                                value = entry,
                                display = entry.display,
                                ordinal = entry.display
                            }
                        end,
                    }),
                    sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
                    attach_mappings = function(_, map)
                        map('i', '<CR>', function(prompt_bufnr)
                            local selection = require('telescope.actions.state').get_selected_entry().value
                            actions.close(prompt_bufnr)

                            vim.notify('attaching to container ' .. selection.name)
                            local cmd = string.format("docker exec -it %s %s", selection.id, docker_cmd)
                            _G.docker_active_container = selection
                            if debug == true then
                                debug_test(selection.id, cmd)
                            else
                                execute_command(cmd, title)
                            end
                        end)
                        return true
                    end,
                }):find()
            end)
        end,
    }):start()
end

M.exec_in_container = function()
    M.run_in_docker_container("bash")
end

return M