--!strict
--
local M = {}

local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local Job = require('plenary.job')
local dapui = require('dapui')

local debug_float_window = { width=150, height=50, enter=true, position="center" }

M.toggle_dapui_watches = function()
    dapui.float_element("watches", debug_float_window)
end

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

M.grep_in_folder_or_global = function()
  -- Check if the current buffer is nvim-tree
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:match("NvimTree_") then
    local lib = require('nvim-tree.lib')
    local node = lib.get_node_at_cursor()
    if node then
      local search_path = node.type == 'directory' and node.absolute_path or node.parent.absolute_path
      require('telescope.builtin').live_grep({ search_dirs = { search_path } })
      return
    end
  end

  -- Default global grep search if not in nvim-tree
  require('telescope.builtin').live_grep()
end

-- Bind this function to the same key used globally
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
