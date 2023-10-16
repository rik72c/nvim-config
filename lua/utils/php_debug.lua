local M = {}

_G.php_tester = nil
_G.latest_test = nil

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local docker = require('utils.docker')

local function get_tests_from_php()
    local handle = io.popen("grep -E '@test|class|function' -r ./tests")
    if handle == nil then
        vim.notify("Test not found", vim.log.levels.WARN)
        return {}
    end

    local result = handle:read("*a")
    handle:close()

    local className = ""
    local isTest = false
    local tests = {}

    tests['@@all'] = "@@ All"
    for line in result:gmatch("[^\r\n]+") do
        local classMatch = line:match("class (%w+)")
        local testMatch = line:match("function (%w+)")

            if classMatch then
                className = classMatch
                local displayName = className:gsub("(%u)", " %1"):gsub("^%s*(.-)%s*$", "%1"):lower()
                tests[className] = '@'..displayName:gsub("^%l", string.upper)
                isTest = false
            elseif line:match("@test") then
                isTest = true
            elseif isTest and testMatch then
                if className ~= "" then
                    local displayName = testMatch:gsub("(%u)", " %1"):gsub("^%s*(.-)%s*$", "%1"):lower()
                    local fullDisplayName = tests[className]:gsub("@", "") .. " - " .. displayName:gsub("^%l", string.upper)
                    tests[testMatch] = fullDisplayName
                end
                isTest = false
            end
        end

        return tests
    end

    M.get_php_tester = function()

        if _G.php_tester then
            return _G.php_tester
        end

        local options = {"O.cancel", "1.artisan", "2.phpunit"}
        local choice = vim.fn.inputlist(options)
        if choice == 1 then
            _G.php_tester = "php artisan test"
        elseif choice == 2 then
            _G.php_tester = "./bin/phpunit"
        else
            return nil
        end
        return _G.php_tester
    end

    M.run_selected_test = function(debug)
        local tests = get_tests_from_php()

        local displayTests = {}
        for key, value in pairs(tests) do
            table.insert(displayTests, { key = key, display = value })
        end

        pickers.new({}, {
            prompt_title = 'PHPUnit Tests',
            finder = finders.new_table {
                results = displayTests,
                entry_maker = function(entry)
                    return {
                        value = entry.key,
                        display = entry.display,
                        ordinal = entry.display,
                    }
                end
            },
            sorter = sorters.get_fzy_sorter(),
            attach_mappings = function(_, map)
                map('i', '<CR>', function(prompt_bufnr)
                    local selection = require('telescope.actions.state').get_selected_entry()
                    actions.close(prompt_bufnr)

                    local test = selection.value

                    local cmd = ''
                    if test == "@@all" then
                        cmd = string.format("%s", M.get_php_tester())
                    else
                        cmd = string.format("%s --filter=%s", M.get_php_tester(), test)
                    end

                    _G.latest_test = {
                        cmd = cmd,
                        display = selection.display,
                        debug = debug or false
                    }

                        docker.run_in_docker_container(cmd, selection.display, debug)
                end)

                return true
            end
        }):find()
    end

    M.rerun_test = function()
        if not _G.latest_test then
            vim.notify("No tests have been run yet")
            return
        end

        docker.run_in_docker_container(
        _G.latest_test.cmd,
        _G.latest_test.display,
        _G.latest_test.debug
        ) 
    end

    return M