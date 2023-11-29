local M = {}

-- Declare a global variable to store the last test command
_G.last_test_cmd = nil

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local telescope = require('telescope')

local function get_php_tests()
    local handle = io.popen("grep -E '@test|class|function' -r ./tests")
    local result = handle:read("*a")
    handle:close()

    local className = ""
    local isTest = false
    local tests = {}

    for line in result:gmatch("[^\r\n]+") do
        local classMatch = line:match("class (%w+)")
        local testMatch = line:match("function (%w+)")

            if classMatch then
                className = classMatch
                isTest = false
            elseif line:match("@test") then
                isTest = true
            elseif isTest and testMatch then
                if className ~= "" then
                    testMatch = testMatch:gsub("(%u)", " %1"):gsub("^%s*(.-)%s*$", "%1"):lower()
                    table.insert(tests, className .. " - " .. testMatch)
                end
                isTest = false  -- Reset the flag
            end
        end

        return tests
    end

    -- Function to convert 'should be able to do something' -> 'shouldBeAbleToDoSomething'
    local function reverse_transform(str)
        return (str:gsub("^%l", string.upper):gsub(" (%a)", string.upper):gsub(" ", ""))
    end

    -- Get Docker containe name
    local function set_active_container_name()

        -- Check if container name is cached
        if not vim.g.docker_container_name then
            local container_name = vim.fn.input("Enter Docker container name or ID: ")
            vim.g.docker_container_name = container_name
        end

    end

    local function execute_debugger(cmd)

        vim.notify('executing `' .. cmd .. '`')

        -- vim.cmd("term " .. cmd)

        -- vim.cmd("let current_tab = tabpagenr()")
        -- vim.cmd("tabnew | term " .. cmd)
        -- vim.cmd("execute 'tabnext ' . current_tab")

        vim.cmd("FloatermNew --title=container --wintype=float --width=0.9 --height=0.9 --position=center " .. cmd)

    end

    local function test_with_debug(cmd)
        vim.notify('start with debug')
        set_active_container_name()

        local dap = require('dap')

        local config = {
            type = 'php',
            request = 'launch',
            name = 'Listen for XDebug',
            program = "docker",
            port = 9003,
            pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}"
            },
            xdebugSettings = {
                max_depth = 5
            },
        }
        dap.configurations.php = {config}

        dap.continue()
        require('dapui').open()
    end

    -- Run unit testing
    local function unit_test_runner(test)


        local cmd = ''

        set_active_container_name()

        if not vim.g.docker_container_name or vim.g.docker_container_name == "" then
            vim.notify('container not found')
            vim.g.docker_container_name = nil
            return
        end

        vim.notify('executing on container ' .. vim.g.docker_container_name)

        if test then
            -- Transform back to original function name
            local _, _, func_name = string.find(test, " %- (.+)$")
            local original_func_name = reverse_transform(func_name)

            -- Build the command
            cmd = string.format("docker exec -it %s %s --filter=%s", vim.g.docker_container_name, get_php_tests(), original_func_name)



        else

            cmd = string.format("docker exec -it %s %s", vim.g.docker_container_name, get_php_tests())
        end

        -- Save the command
        _G.last_test_cmd = cmd


        execute_debugger(cmd)
        -- test_with_debug(cmd)

    end


    -- Open terminal inside docker
    M.open_docker_terminal = function()
        set_active_container_name()
        cmd = string.format("docker exec -it %s bash", vim.g.docker_container_name)
        vim.cmd("FloatermNew --title=container " .. cmd)
    end

    -- Function to run all test
    M.run_all_test = function()
        unit_test_runner()
    end

    -- Function to re-run the last test
    M.rerun_last_test = function()
        if _G.last_test_cmd then
            execute_debugger(_G.last_test_cmd)
        else
            print("No test has been run yet.")
        end
    end

    M.show_phpunit_tests = function()
        local test_list = get_php_tests()

        pickers.new({}, {
            prompt_title = 'PHPUnit Tests',
            finder = finders.new_table {
                results = test_list,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry,
                        ordinal = entry,
                    }
                end
            },
            sorter = sorters.get_fzy_sorter(),
            attach_mappings = function(_, map)
                map('i', '<CR>', function(prompt_bufnr)
                    local selection = require('telescope.actions.state').get_selected_entry()
                    actions.close(prompt_bufnr)

                    -- Your PHPUnit test run command here
                    local test = selection.value
                    unit_test_runner(test)
                end)

                return true
            end
        }):find()
    end

    return M
