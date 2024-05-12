local M = {}

local telescope = require('telescope')
local func = require('utils.func')

local function get_project_root_folder()
    local handle = io.popen('pwd')
    local result = handle:read('*a')
    handle:close()

    return string.gsub(result, '\n', '')
end

-- test
M.openInPhpStorm = function()
    local file_path = vim.fn.expand('%:p') -- Get the full path of the current file
    local line = vim.api.nvim_win_get_cursor(0)[1] -- Get the current line number
    local command = 'pstorm "' .. file_path .. '":' .. line
    os.execute(command)
end

M.open_in_phpstorm = function(file, line)
    -- vim.error('todo: this is still in progress')
    local command = "phpstorm --line " .. line .. " " .. file
    os.execute(command)
end

M.format_php_file = function(file_path, dry_run)

    local format_string = "php-cs-fixer fix %s --using-cache=no --config=$HOME/Projects/.php-cs-fixer.php"
    if dry_run then

        local temp_file = "/tmp/php_cs_fixer_diff.txt"
        -- delete the temporary file if it exists
        vim.fn.delete(temp_file)

        -- generate diff into temp file
        local format_cmd = string.format(format_string .. " --dry-run --diff > %s", file_path, temp_file)
        vim.cmd(format_cmd)

        -- read the temporary file
        local lines = vim.fn.readfile(temp_file)

        if #lines > 2 then  -- Changed to 1 because an empty file still contains 1 empty line
            vim.cmd(string.format("e %s", temp_file))
            vim.cmd("setfiletype diff")
            print("Review the diff and press Y to apply changes or N to cancel.")
            local answer = vim.fn.input("Apply changes? [Y/n]: ")
            if answer:lower() == "y" then
                format_cmd = string.format(format_string .. " --quiet", filepath)
                vim.cmd(format_cmd)
            end
            vim.cmd("bd!")
        else
            print("It's already look good to me.")
        end
    else
        local format_cmd = string.format(format_string .. " --quiet  > /dev/null 2>&1", file_path)

        os.execute(format_cmd)
        -- todo: remove this if php formatting has no problem execute from os.execute()
        -- vim.cmd(format_cmd)
    end
end

local function create_file(file_path, failed_if_existed)
    local file = io.open(file_path, "r")
    if file then
        if failed_if_existed or false then
            error(file_path .. ' is existed')
        else
            return file
        end
    else
        vim.notify(file_path .. ' is created')
        return io.open(file_path, "w")
    end
end

local function generate_namespace(dir)
    print("generating namespace from '"..dir.."'")

    local handle = io.popen('pwd')
    local result = handle:read('*a')
    handle:close()

    local pwd = string.gsub(result, '\n', '')
    local handle = io.open(pwd .. "/composer.json", "r")

    if not handle then
        error('could not generate namespace')
    end
    local content = handle:read("*all")

    handle:close()
    local json = vim.fn.json_decode(content)

    local full_path = vim.fn.expand('%:p')
    print("`current_file_path`:", full_path)

    local project_file_path = dir or full_path:sub(#pwd + 2)
    -- print("`project_file_path`=", project_file_path)

    if json["autoload"] and json["autoload"]["psr-4"] then
        for namespace, path in pairs(json["autoload"]["psr-4"]) do
            -- print("`namespace`:", namespace, "`path`:", path)

            -- Check if project_file_path starts with path from composer.json
            if project_file_path:find("^" .. path) then
                local relative_path = project_file_path:sub(#path + 1)
                local pieces = vim.split(relative_path, "/")

                -- Convert first character of each piece to uppercase
                local ns_pieces = vim.tbl_map(function(item)
                    return string.gsub(item, "^%l", string.upper)
                end, pieces)

                -- Concatenate to form full namespace
                local full_ns = namespace .. table.concat(ns_pieces, "\\")

                -- Remove `.php` from the last piece and remove trailing backslashes
                full_ns = full_ns:gsub("\\%w+%.php$", ""):gsub("\\*$", "")

                -- -- vim.api.nvim_out_write("Generated Namespace: " .. full_ns .. "\n")
                -- vim.api.nvim_buf_set_lines(0, 0, 0, false, {"<?php", "", "namespace " .. full_ns .. ";", ""})
                --
                -- -- add classname out of file name
                -- local class_name = vim.fn.expand('%:t:r')  -- Filename without extension
                -- vim.api.nvim_buf_set_lines(0, 4, 4, false, {"class " .. class_name .. " {", "}"})
                return full_ns
            end
        end
        return nil
    end
end

local function create_folder_from_root(dir)
    local folderPath = string.format('%s/%s', get_project_root_folder(), dir)
    print("creating folder in '"..folderPath.."'")
    os.execute('mkdir -p ' .. folderPath)
    return folderPath
end

local function create_class(dir)  
    local className = vim.fn.input(string.format("Enter name: %s/", dir))
    if className == "" then
        print("File creation cancelled")
        return
    end


    local nameSpace = generate_namespace(
        string.format(
            '%s',
            dir
        )
    )
    print("Namespace is '"..nameSpace.."'")
    local dirPath = create_folder_from_root(dir)
    local filePath = string.format('%s/%s.php', dirPath, className)

    local file = create_file(filePath)
    file:write("<?php\n\n")
    file:write(string.format("namespace %s;\n\n", nameSpace))
    file:write("class " .. className .. " {\n\n")
    file:write("public function __construct(){}\n\n")
    file:write("}\n")
    file:close()
    M.format_php_file(file)

    vim.cmd('e '.. filePath)
end

local function create_blank_file(dir)
    local file_name = vim.fn.input(string.format("Enter name: %s/", dir))
    local file_path = string.format("%s/%s", dir, file_name)
    create_file(file_path, false)
    vim.cmd('e '..file_path)
end

local function create_command_query(type, dir)
    local hoveredText = vim.fn.expand('<cword>')
    local dirName = hoveredText and hoveredText:gsub("^%l", string.upper) or ''
    hoveredText = hoveredText and hoveredText:gsub("^%l", string.upper)..type:gsub("^%l", string.upper) or ''

    local className = vim.fn.input(string.format("Enter %s Name: ", type), hoveredText)
    if className == "" then
        print("File creation cancelled")
        return
    end

    local groupDir = (type == "query" and "Queries") or "Commands"

    local cqhFolder = string.format('%s/%s/%s/%s', get_project_root_folder(), dir, groupDir, dirName)
    os.execute('mkdir -p ' .. cqhFolder)

    local nameSpace = generate_namespace(
        string.format(
            "%s/%s/%s",
            dir,
            groupDir,
            className
        )
    )

    local cqName = className
    local cqPath = string.format(
        '%s/%s.php',
        cqhFolder,
        cqName
    )
    local cqFile = create_file(cqPath)
    cqFile:write("<?php\n\n")
    cqFile:write(string.format("namespace %s;\n\n", nameSpace))
    cqFile:write("class " .. cqName .. " {\n\n")
    cqFile:write("public function __construct(){}\n\n")
    cqFile:write("}\n")
    cqFile:close()
    M.format_php_file(cqPath)

    local hName = className.."Handler"
    local hPath = string.format(
        '%s/%s.php',
        cqhFolder,
        hName
    )

    local hFile = create_file(hPath)
    hFile:write("<?php\n\n")
    hFile:write(string.format("namespace %s;\n\n", nameSpace))
    hFile:write(string.format("use %s\\%s;\n\n", nameSpace,cqName))
    hFile:write("class " .. className .. "Handler {\n\n")
    hFile:write(string.format(
        "public function __invoke(%s $%s)// todo: declare return type\n{\n// todo: handler command\nreturn;\n}",
        cqName,
        type
    ))
    hFile:write("\n}\n")
    hFile:close()
    M.format_php_file(hPath)

    vim.cmd('e '.. cqPath)
end


M.create_new_php_file = function()
    local choices = {
        'class',
        'query',
        'command',
        'blank file'
        -- 'trait',
    }

    vim.ui.select(choices, {
        prompt = 'What type of file do you want to create?',
        format_item = function(item)
            return item
        end,
    }, function(_, choice)
            if not choice then
                print("Invalid choice. Exiting.")
                return
            end



            local file_type = choices[choice]
            local focus_dir = ("query" == file_type or "command" == file_type) and './app/Domain' or nil

            func.pick_folder_in_project(
                function(dir)
                    if "query" == file_type or "command" == file_type then
                        create_command_query(file_type, dir)
                    elseif "class" == file_type then
                        create_class(dir)
                    elseif "blank file" then
                        create_blank_file(dir)
                    end
                    -- print(string.format("creating %s in %s with namespace %s", file_type, dir, generate_namespace(dir)))
                end,
                focus_dir,
                string.format("Directory to create %s", file_type)
            )

        end)
end


return M
