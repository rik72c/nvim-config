--!strict
--
local M = {}

local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local Job = require('plenary.job')

M.toggle_transparency = function()
    if vim.g.background_transparency then
        -- Set to non-transparent background
        vim.cmd("hi Normal guibg=#000000")
        vim.g.background_transparency = false
    else
        -- Set to transparent background
        vim.cmd("hi Normal guibg=NONE")
        vim.g.background_transparency = true
    end
end

M.pick_folder_in_project = function(callback, search_dir, title)

    -- ignore directories
    local ignore_dirs = { './vendor', './.git' }
    local root = search_dir or '.'

    -- construct arguments
    local args = { root , '-type', 'd' }
    for _, dir in pairs(ignore_dirs) do
        table.insert(args, '-not')
        table.insert(args, '-path')
        table.insert(args, dir)
        table.insert(args, '-not')
        table.insert(args, '-path')
        table.insert(args, dir .. '/*')
    end

    Job:new({
        command = 'find',
        args = args,
        on_exit = function(j)
            vim.schedule(function()
                local raw_dir_list = j:result()
                local dir_list = {}
                for _, dir in pairs(raw_dir_list) do
                    table.insert(dir_list, (string.gsub(dir, "^%./", "")))
                end
                pickers.new({}, {
                    prompt_title = title or 'Search Directories',
                    finder = finders.new_table({
                        results = dir_list,
                    }),
                    sorter = sorters.get_fuzzy_file(),
                    attach_mappings = function(_, map)
                        map('i', '<CR>', function(prompt_bufnr)
                            local selection = require('telescope.actions.state').get_selected_entry().value
                            actions.close(prompt_bufnr)
                            callback(selection)
                        end)
                        return true
                    end,
                }):find()
            end)
        end,
    }):start()
end


M.goto_handler_or_command = function()
    local word = vim.fn.expand('<cword>')
    local target_file = ""
    local prompt_title = ""

    if string.match(word, 'Command$') or string.match(word, 'Query$') then
        target_file = word .. 'Handler.php'
        prompt_title = "Find Handler for "..word
    elseif string.match(word, 'CommandHandler$') then
        target_file = string.gsub(word, 'Handler$', '') .. '.php'
        prompt_title = "Find Command for "..word
    else
        vim.notify('No matched for '.. word)
        return
    end

    require('telescope.builtin').find_files(
        require('telescope.themes').get_dropdown({
            prompt_title = prompt_title,
            default_text = target_file,
            previewer = false,
        })
    )
end

return M
