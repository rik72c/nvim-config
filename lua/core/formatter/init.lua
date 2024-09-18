M = {}

M.format_by_lang = function(dryrun)

    local fileType = vim.bo.filetype
    local filePath = vim.fn.expand('%:p')

    if not filepath then
        return
    end

    if fileType == "php" then
        require'utils.php'.format_php_file(filePath, dryrun)
    elseif fileType == "blade" then
        local formatCommand = string.format('blade-formatter --write --config ~/Documents/scripts/.bladeformatterrc.json %s', filepath)
        os.execute(formatCommand.. " > /dev/null 2>&1")
    elseif fileType == "go" then
        local formatCommand = string.format("gofumpt -l -w %s", filepath)
        os.execute(formatCommand.. " > /dev/null 2>&1")
        local removeUnusedCommand = string.format("goimports -w %s", filepath)
        os.execute(removeUnusedCommand.. " > /dev/null 2>&1")
    else
        vim.cmd("normal mzgg=G`z")
    end

    vim.cmd('silent edit')
end

function M.format_json(string)
    return require('core.formatter.json').format_json(string)
end

return M
