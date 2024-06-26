local M = {}
M.format_by_lang = function(dry_run)
    -- close cmp window if exists
    -- require'cmp'.close() -- todo: cmp close is not working yet

    local ft = vim.bo.filetype
    local filepath = vim.fn.expand('%:p')

    if not filepath then
        return
    end

    if ft == "php" then
        require'utils.php'.format_php_file(filepath, dry_run)
    elseif ft == "blade" then
        local formatCommand = string.format('blade-formatter --write --config ~/Documents/scripts/.bladeformatterrc.json %s', filepath)
        os.execute(formatCommand.. " > /dev/null 2>&1")
    elseif ft == "go" then
        local formatCommand = string.format("gofumpt -l -w %s", filepath)
        os.execute(formatCommand.. " > /dev/null 2>&1")
        local removeUnusedCommand = string.format("goimports -w %s", filepath)
        os.execute(removeUnusedCommand.. " > /dev/null 2>&1")
    else
        vim.cmd("normal mzgg=G`z")
    end

    vim.cmd('silent edit')
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
