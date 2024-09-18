local M = {}

function M.preview_text(text, opts)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n"))

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

    vim.api.nvim_open_win(buf, true, opts)
end

return M
