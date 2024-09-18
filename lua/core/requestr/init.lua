local M = {}

local last_command = nil
local previewr = require('core.previewr')
local formattr = require('core.formatter')
local loggr = require('core.loggr')

-- function M.setup()
--
-- end

local function result_in_terminal(cmd)
    -- Open a new buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Define window options
    local width = math.ceil(vim.o.columns * 0.8)
    local height = math.ceil(vim.o.lines * 0.8)
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        col = math.ceil((vim.o.columns - width) / 2),
        row = math.ceil((vim.o.lines - height) / 2),
        style = 'minimal',
        border = 'rounded'
    }

    -- Open a new floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Open a terminal in the buffer and execute the command
    vim.fn.termopen(cmd, {
        on_exit = function(_, _, _)
            -- Resize window to fit the output
            vim.api.nvim_win_set_height(win, vim.api.nvim_buf_line_count(buf))
        end
    })

    -- Set the current window to the floating window
    vim.api.nvim_set_current_win(win)

    -- Ensure the terminal buffer starts in insert mode and scrolls to the bottom
    vim.api.nvim_command('startinsert')
end

local function result_in_float(cmd)
    loggr.debug('init result_in_float', cmd)
    local handle = io.popen(cmd)
    if nil == handle then
        print("Failed to execute command")
        return
    end

    local result = handle:read("*a")
    handle:close()

    if result == nil then
        print("Failed to read command output")
        return
    end

    local formatted_json = formattr.format_json(result)
    previewr.preview_text(formatted_json)
end

local function execute_command(cmd)
    -- result_in_terminal(cmd)
    result_in_float(cmd)
end

function M.prompt_and_request()
    vim.ui.input({prompt = 'Enter HTTPie command: '}, function(input)
        if input then
            last_command = input
            execute_command(input)
        end
    end)
end

function M.repeat_last_request()
    if last_command then
        execute_command(last_command)
    else
        print("No last command")
        M.prompt_and_request()
    end
end

return M
