local M = {}

_G.docker_active_container = nil

-- require plugins
local Job = require('plenary.job')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
-- local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

local function execute_command(cmd, title, debug)
    if debug == true then
        local command, args = cmd:match("([^%s]+)%s+(.*)")
        args = args:gsub("-it%s*", "")
        local uv = vim.loop
        local handle
        handle = uv.spawn(command, {
            args = vim.fn.split(args, " "),
            stdio = {nil, nil, nil}
        }, function(code)
            vim.notify("Process exited with code: " .. code)
            handle:close()
        end)
    else
        title = vim.fn.shellescape(title) or "container"
        local exec_cmd = string.format("FloatermNew --title=%s --wintype=float --width=0.9 --height=0.9 --position=center --autoclose=0 %s",title:gsub(" ", "\\ "), cmd)
        vim.cmd(exec_cmd)
    end
end

M.run_in_docker_container = function(docker_cmd, title, debug)
    local output = {}

    if _G.docker_active_container then
        local cmd = string.format("docker exec -it %s %s", _G.docker_active_container.id, docker_cmd)
        execute_command(cmd, title, debug)
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
                            execute_command(cmd, title, debug)
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