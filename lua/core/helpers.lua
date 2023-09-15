local M = {}
M.format_by_lang = function()
    -- close cmp window if exists
    require'cmp'.close() -- todo: not working yet

    local ft = vim.bo.filetype
    local filepath = vim.fn.expand('%:p')
    local temp_file = "/tmp/php_cs_fixer_diff.txt"

    -- Delete the temporary file if it exists
    vim.fn.delete(temp_file)

    if ft == "php" then
        vim.cmd(string.format("!php-cs-fixer fix %s --rules=@PSR12 --dry-run --diff > %s", filepath, temp_file))

        -- Read the temporary file
        local lines = vim.fn.readfile(temp_file)

        if #lines > 2 then  -- Changed to 1 because an empty file still contains 1 empty line
            vim.cmd(string.format("e %s", temp_file))
            vim.cmd("setfiletype diff")
            print("Review the diff and press Y to apply changes or N to cancel.")
            local answer = vim.fn.input("Apply changes? [Y/n]: ")
            if answer:lower() == "y" then
                vim.cmd(string.format("!php-cs-fixer fix %s --rules=@PSR12", filepath))
            end
            vim.cmd("bd!")
        else
            print("No changes to apply.")
        end

        -- vim.cmd(string.format("!php-cs-fixer fix %s --rules=@PSR12 --using-cache=no", filepath))

        -- local filepath = vim.fn.expand('%:p')
        -- vim.cmd(string.format("!php-cs-fixer fix %s --rules=@PSR12 --dry-run --diff", filepath))
        -- elseif ft == "javascript" then
        -- your js formatter
        -- elseif ft == "python" then
        -- your python formatter
    else
        vim.cmd("normal mzgg=G`z")
    end
end

M.show_phpunit_tests = function()
      local actions = require('telescope.actions')
      require('telescope').setup{}

      require('telescope.builtin').find_files({
    prompt_title = 'PHPUnit Tests',
    cwd = './tests',
    file_ignore_patterns = { "TestCase.php$" },
    attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
        local selection = require('telescope.actions.state').get_selected_entry()
        actions.close(prompt_bufnr)
        local test_file = selection.value
        vim.cmd(string.format(":!./vendor/bin/phpunit %s", test_file))
      end)
          return true
            end
  })
end

return M