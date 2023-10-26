local M = {}
M.format_by_lang = function(dry_run)
    -- close cmp window if exists
    require'cmp'.close() -- todo: cmp close is not working yet

    local ft = vim.bo.filetype
    local filepath = vim.fn.expand('%:p')

    if ft == "php" then

       require'utils.php'.format_php_file(filepath, dry_run)
        -- local format_string = "!php-cs-fixer fix %s --using-cache=no --config=$HOME/Projects/.php-cs-fixer.php"
        -- if dry_run then
        --
        --     local temp_file = "/tmp/php_cs_fixer_diff.txt"
        --     -- delete the temporary file if it exists
        --     vim.fn.delete(temp_file)
        --
        --     -- generate diff into temp file
        --     local format_cmd = string.format(format_string .. " --dry-run --diff > %s", filepath, temp_file)
        --     vim.cmd(format_cmd)
        --
        --     -- read the temporary file
        --     local lines = vim.fn.readfile(temp_file)
        --
        --     if #lines > 2 then  -- Changed to 1 because an empty file still contains 1 empty line
        --         vim.cmd(string.format("e %s", temp_file))
        --         vim.cmd("setfiletype diff")
        --         print("Review the diff and press Y to apply changes or N to cancel.")
        --         local answer = vim.fn.input("Apply changes? [Y/n]: ")
        --         if answer:lower() == "y" then
        --             local format_cmd = string.format(format_string .. " --quiet", filepath)
        --             vim.cmd(format_cmd)
        --         end
        --         vim.cmd("bd!")
        --     else
        --         print("It's already look good to me.")
        --     end
        -- else
        --     vim.cmd("normal mzgg=G`z")
        --     local format_cmd = string.format(format_string .. " --quiet", filepath)
        --     vim.cmd(format_cmd)
        -- end
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