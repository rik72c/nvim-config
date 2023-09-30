return {
    'echasnovski/mini.nvim',
    enabled = false,
    version = false,
    config = function()
        require('mini.files').setup({
            windows = {
                preview = true
            }
        })
        local files_set_cwd = function(path)
            -- Works only if cursor is on the valid file system entry
            local cur_entry_path = MiniFiles.get_fs_entry().path
            local cur_directory = vim.fs.dirname(cur_entry_path)
            vim.fn.chdir(cur_directory)
        end

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesBufferCreate',
            callback = function(args)
                vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id })
            end,
        })


    end,
}