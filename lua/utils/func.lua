local M = {}

local actions = require('telescope.actions')

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